// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Chinese (`zh`).
class AppLocalizationsZh extends AppLocalizations {
  AppLocalizationsZh([String locale = 'zh']) : super(locale);

  @override
  String get vpnDisclosure_title => '保护您的连接';

  @override
  String get vpnDisclosure_body =>
      'FuzeVPN 使用 Android 的 VPN 服务（VpnService）在此设备与 FuzeVPN 服务器之间建立加密隧道。';

  @override
  String get vpnDisclosure_dataBody =>
      'VPN 启用时，您应用的互联网流量、目标地址和 DNS 请求会通过此隧道进行连接路由，即使 FuzeVPN 在后台运行也是如此。';

  @override
  String get vpnDisclosure_statusBody =>
      '应用使用连接状态、连接时长和已传输的数据量来显示您的 VPN 连接。您可以随时停止连接。';

  @override
  String get vpnDisclosure_privacy => '隐私';

  @override
  String get vpnDisclosure_accept => '同意并继续';

  @override
  String get vpnDisclosure_decline => '暂时不用';

  @override
  String get accountRestoration_title => '账户暂时不可用';

  @override
  String get accountRestoration_message => '您的会话已保留。请重试以恢复账户；您仍可在此管理 VPN 连接。';

  @override
  String get action_retry => '重试';

  @override
  String get session_endingTitle => '正在结束会话';

  @override
  String get session_ending => '您的会话已失效。正在停止 VPN 并清除会话…';

  @override
  String get session_stopFailed => '尚未确认 VPN 已关闭。请在再次登录前重试。';

  @override
  String get session_cleanupFailed => 'VPN 已停止，但尚未确认会话已移除。请重试清理。';

  @override
  String get session_retryStop => '重试关闭';

  @override
  String get session_retryCleanup => '重试清理';

  @override
  String get appTitle => 'FuzeVPN';

  @override
  String get startup => '正在安全地准备 FuzeVPN…';

  @override
  String get nav_connection => '连接';

  @override
  String get nav_locations => '位置';

  @override
  String get nav_account => '账户';

  @override
  String get nav_devices => '设备';

  @override
  String get nav_settings => '设置';

  @override
  String get action_refresh => '刷新';

  @override
  String get auth_tab_login => '登录';

  @override
  String get auth_tab_register => '注册';

  @override
  String get auth_stepAccount => '账户';

  @override
  String get auth_stepIdentity => '身份';

  @override
  String get auth_stepAddress => '地址和协议';

  @override
  String auth_stepProgress(Object current, Object total) {
    return '第 $current 步，共 $total 步';
  }

  @override
  String get auth_tagline => '让您的 VPN 变得简单。';

  @override
  String get auth_keysLocal => '您的私有 VPN 密钥会保留在此设备上。';

  @override
  String get form_email => '电子邮件地址';

  @override
  String get form_password => '密码';

  @override
  String get form_showPassword => '显示密码';

  @override
  String get form_hidePassword => '隐藏密码';

  @override
  String get form_passwordMin => '8–72 个 UTF-8 字节。某些字符会占用多个字节。';

  @override
  String get form_firstName => '名';

  @override
  String get form_lastName => '姓';

  @override
  String get form_phone => '电话（+33612345678）';

  @override
  String get form_address => '地址';

  @override
  String get form_address2 => '地址第 2 行（可选）';

  @override
  String get form_postalCode => '邮政编码';

  @override
  String get form_city => '城市';

  @override
  String get form_country => '国家代码（例如 FR）';

  @override
  String get action_login => '登录';

  @override
  String get action_createAccount => '创建账户';

  @override
  String get action_createMyAccount => '创建我的账户';

  @override
  String get action_next => '继续';

  @override
  String get action_previous => '返回';

  @override
  String get action_forgotPassword => '忘记密码？';

  @override
  String get auth_noAccount => '还没有账户？';

  @override
  String get auth_requiredInformation => '只需三步即可创建账户。';

  @override
  String get auth_termsPrefix => '我接受';

  @override
  String get auth_termsLink => '使用条款';

  @override
  String get auth_privacyPrefix => '我接受';

  @override
  String get auth_privacyLink => '隐私政策';

  @override
  String get auth_consentRequired => '您必须同意才能创建账户。';

  @override
  String get validation_required => '此字段为必填项。';

  @override
  String get validation_email => '请输入有效的电子邮件地址。';

  @override
  String get validation_password => '密码太短：至少需要 8 个 UTF-8 字节。';

  @override
  String get validation_passwordTooLong => '密码太长：最多只能有 72 个 UTF-8 字节。';

  @override
  String get validation_phone => '请使用国际格式，例如 +33612345678。';

  @override
  String get validation_country => '请使用两位国家代码，例如 FR。';

  @override
  String get passwordReset_title => '重置密码';

  @override
  String get passwordReset_description => '请输入账户电子邮件地址以请求密码重置链接。';

  @override
  String get passwordReset_send => '发送链接';

  @override
  String get connection_title => '您的连接';

  @override
  String get connection_subtitle => '选择位置，然后开启 VPN。';

  @override
  String get connection_prepare => '准备好连接了吗？';

  @override
  String get connection_advancedOptions => '高级选项';

  @override
  String get connection_location => '位置';

  @override
  String get connection_chooseLocation => '选择位置';

  @override
  String get connection_protocol => '协议';

  @override
  String get connection_connect => '连接';

  @override
  String get connection_connecting => '正在连接…';

  @override
  String get connection_disconnect => '断开连接';

  @override
  String get connection_disconnecting => '正在断开连接';

  @override
  String get connection_locationChange => '正在更改位置…';

  @override
  String connection_unavailable(Object protocol) {
    return '$protocol 不可用';
  }

  @override
  String get connection_activeLocation => '当前活动位置';

  @override
  String get connection_duration => '持续时间';

  @override
  String get connection_received => '已接收';

  @override
  String get connection_sent => '已发送';

  @override
  String get connection_lastHandshake => '上次安全交换';

  @override
  String connection_handshakeAgo(Object duration) {
    return '$duration 前';
  }

  @override
  String get verification_title => '确认您的电子邮件地址';

  @override
  String get verification_message => '请确认您的电子邮件地址，以便在此手机上使用 VPN。';

  @override
  String get verification_resend => '重新发送电子邮件';

  @override
  String get migration_title => '更改位置';

  @override
  String get migration_draining => '正在准备更改位置…';

  @override
  String get migration_activating => '正在激活新服务器…';

  @override
  String get migration_ready => '位置已更新。';

  @override
  String get migration_blocked => '更改位置需要服务器介入。请稍后重试或联系支持人员。';

  @override
  String get migration_progress => '位置更改进度';

  @override
  String migration_retryDelay(Object seconds) {
    return '检查间隔：$seconds 秒。';
  }

  @override
  String get migration_resume => '继续更改位置';

  @override
  String get status_authorizing => '需要授权';

  @override
  String get status_authorizingDetail => '请接受 Android 请求以允许 VPN。';

  @override
  String get status_preparing => '正在准备';

  @override
  String get status_preparingDetail => '正在准备您的安全连接。';

  @override
  String get status_reconnecting => '正在重新连接…';

  @override
  String get status_reconnectingDetail => '连接已中断。VPN 正在尝试重新连接。';

  @override
  String get status_connecting => '正在连接';

  @override
  String get status_connectingDetail => '正在连接到 VPN 服务器…';

  @override
  String get status_connected => '已连接';

  @override
  String get status_connectedDetail => '您的 VPN 连接已启用。';

  @override
  String get status_disconnecting => '正在断开连接';

  @override
  String get status_disconnectingDetail => '您的 VPN 连接正在停止。';

  @override
  String get status_error => '连接不可用';

  @override
  String get status_errorDetail => '尚未确认 VPN 连接。请重试。';

  @override
  String get status_idle => '已断开连接';

  @override
  String get status_idleDetail => '连接 VPN 以保护您的连接。';

  @override
  String get trust_note => '关闭应用不会停止 VPN。如需停止，请使用“断开连接”。';

  @override
  String get locations_none => '目前没有可用的位置。';

  @override
  String get locations_available => '选择您的下一个位置。';

  @override
  String get locations_selected => '已选位置';

  @override
  String get locations_select => '选择此位置';

  @override
  String get locations_lockedTunnel => '请断开 VPN 后再更改位置。';

  @override
  String get locations_lockedMigration => '请等待位置更改完成。';

  @override
  String get devices_title => '您的设备';

  @override
  String devices_used(Object count, Object limit) {
    return '$count / $limit 台设备';
  }

  @override
  String get devices_refresh => '刷新设备';

  @override
  String get devices_empty => '尚未注册任何 VPN 设备。';

  @override
  String get devices_firstConnection => '您的手机将在首次连接时添加。';

  @override
  String get devices_thisDevice => '此设备';

  @override
  String devices_added(Object date) {
    return '添加于 $date';
  }

  @override
  String get action_remove => '移除';

  @override
  String get settings_title => '设置';

  @override
  String get settings_subtitle => '在同一处管理您的偏好设置和账户。';

  @override
  String get settings_appearance => '外观';

  @override
  String get settings_language => '语言';

  @override
  String get settings_languageDescription => '您选择的语言也会应用于 VPN 通知。';

  @override
  String get settings_account => '账户';

  @override
  String get settings_signOut => '退出登录';

  @override
  String get settings_privacy => '隐私政策';

  @override
  String get settings_terms => '使用条款';

  @override
  String get settings_security => '安全与透明度';

  @override
  String get settings_licenses => '组件许可证';

  @override
  String get settings_licensesDetail => '应用中使用的软件';

  @override
  String get settings_background => '离开应用后 VPN 仍会保持开启。如需停止，请在“连接”选项卡中使用“断开连接”。';

  @override
  String get theme_system => '跟随系统';

  @override
  String get theme_light => '浅色';

  @override
  String get theme_dark => '深色';

  @override
  String get language_system => '手机语言';

  @override
  String get language_fr => '法语';

  @override
  String get language_en => '英语';

  @override
  String get language_es => '西班牙语';

  @override
  String get language_de => '德语';

  @override
  String get dialog_removeDevice => '要移除此设备吗？';

  @override
  String get dialog_removeCurrent =>
      '此手机将断开 VPN 连接并失去访问权限。服务器确认后，此手机的 VPN 连接数据将被移除。';

  @override
  String dialog_removeOther(Object name) {
    return '将撤销“$name”的 VPN 访问权限。此操作无法撤销。';
  }

  @override
  String get dialog_signOut => '要退出登录吗？';

  @override
  String get dialog_signOutMessage =>
      'VPN 将停止，您需要重新登录。加密的 VPN 密钥会保留在此手机上，供您下次连接使用。';

  @override
  String get action_cancel => '取消';

  @override
  String get action_signOut => '退出登录';

  @override
  String get notice_close => '关闭消息';

  @override
  String get notice_sessionExpired_title => '会话已过期';

  @override
  String get notice_sessionExpired_message => '您的会话已过期。请重新登录。';

  @override
  String get notice_connectionFailed_title => '连接失败';

  @override
  String get notice_invalidCredentials_message => '电子邮件地址或密码不正确。';

  @override
  String get notice_emailVerification_title => '需要确认电子邮件';

  @override
  String get notice_emailVerification_message => '请先确认您的电子邮件地址，然后再添加 VPN 设备。';

  @override
  String get notice_rateLimited_title => '尝试次数过多';

  @override
  String get notice_deviceLimit_title => '已达到 2 台设备的上限';

  @override
  String get notice_deviceLimit_message => '请先移除现有设备，然后再添加其他设备。';

  @override
  String get notice_identityRenewal_title => '必须续订 VPN 身份';

  @override
  String get notice_identityRenewal_message => '此身份已被移除。请创建新的本地身份。';

  @override
  String get notice_migrationPending_title => '正在更改位置';

  @override
  String get notice_migrationPending_message => '位置更改已在进行中。';

  @override
  String get notice_migrationBlocked_title => '位置更改被阻止';

  @override
  String get notice_migrationBlocked_message => '更改位置需要服务器介入。请稍后重试或联系支持人员。';

  @override
  String get notice_targetUnavailable_title => '服务器暂时不可用';

  @override
  String get notice_targetUnavailable_message => '此服务器暂时不可用。';

  @override
  String get notice_networkUnavailable_title => '互联网连接不可用';

  @override
  String get notice_networkUnavailable_message => '请检查您的连接，然后重试。';

  @override
  String get notice_permissionDenied_title => 'VPN 权限被拒绝';

  @override
  String get notice_permissionDenied_message => '请重新开始连接，并接受 Android 权限请求。';

  @override
  String get notice_wireguardTimeout_title => '服务器没有响应';

  @override
  String get notice_wireguardTimeout_message => 'WireGuard 连接耗时过长。请重试或选择其他位置。';

  @override
  String get notice_tlsFailed_title => '安全连接被拒绝';

  @override
  String get notice_tlsFailed_message =>
      '服务器未接受 OpenVPN 连接。请重试。如果问题持续存在，请运行诊断。';

  @override
  String get notice_tunRejected_title => 'Android 拒绝了 VPN 接口';

  @override
  String get notice_tunRejected_message => 'Android 拒绝了 OpenVPN 请求的网络配置。';

  @override
  String get notice_openvpnStart_title => 'OpenVPN 无法启动';

  @override
  String get notice_openvpnStart_message =>
      'OpenVPN 引擎无法完成启动。请重试。如果问题仍然存在，请联系支持人员。';

  @override
  String notice_diagnosticCode(Object code) {
    return '诊断代码：$code';
  }

  @override
  String get notice_generic_title => 'VPN 连接失败';

  @override
  String get notice_generic_message => '发生错误。请稍后重试。';

  @override
  String notice_controller_title(String code) {
    String _temp0 = intl.Intl.selectLogic(code, {
      'account_created_email_unavailable': '账户已创建',
      'password_reset_sent': '已收到密码重置请求',
      'verification_email_sent': '验证邮件已发送',
      'location_migration_pending': '正在更改位置',
      'vpn_sign_in_required': '需要登录',
      'protocol_unavailable_at_location': '协议不可用',
      'vpn_permission_denied': 'VPN 权限被拒绝',
      'revoked_identity_device_limit': '已达到 2 台设备的上限',
      'tunnel_start_unexpected': 'VPN 无法启动',
      'flutter_disconnect_timeout': '未确认断开连接',
      'flutter_disconnect_unexpected': '无法断开连接',
      'device_revoked': '设备已移除',
      'revoke_unexpected': '无法移除设备',
      'identity_renewal_unexpected': '无法续订身份',
      'openvpn_renewal_unexpected': '无法续订 OpenVPN',
      'location_migration_blocked': '位置更改被阻止',
      'location_migration_slow': '位置更改仍在进行中',
      'location_migration_conflict': '位置更改需要刷新',
      'location_migration_verification_failed': '未确认位置更改',
      'location_migration_device_changed': '位置更改期间设备发生变化',
      'tunnel_stop_failed': '位置更改不可用',
      'other': '操作失败',
    });
    return '$_temp0';
  }

  @override
  String notice_controller_message(String code, String target) {
    String _temp0 = intl.Intl.selectLogic(code, {
      'account_created_email_unavailable': '账户已创建，但无法发送验证邮件。请在应用中使用重新发送功能。',
      'password_reset_sent': '已收到您的请求。如果有账户使用此地址，您可能会收到一封邮件。也请检查垃圾邮件文件夹。',
      'verification_email_sent': '新的验证邮件刚刚发送。',
      'location_migration_pending': '正在准备迁移到 $target。您可以继续迁移，无需重新创建设备。',
      'vpn_sign_in_required': '启动 VPN 前请登录您的账户。',
      'protocol_unavailable_at_location': '所选协议在此位置不可用。请刷新位置列表或选择其他协议。',
      'vpn_permission_denied': 'Android 拒绝了 VPN 权限。请重新开始连接，并接受系统请求。',
      'revoked_identity_device_limit':
          '此设备的 VPN 访问权限已被移除，并且已达到设备上限。请在“账户”→“管理我的设备”中移除一台设备。',
      'tunnel_start_unexpected': '意外错误中断了隧道准备。请查看诊断代码并重试。',
      'flutter_disconnect_timeout': 'Android 未及时确认 VPN 已停止。请再次尝试停止。',
      'flutter_disconnect_unexpected': '意外错误导致无法确认隧道已停止。',
      'device_revoked': '设备的 VPN 访问权限已被撤销，其本地密钥已移除。',
      'revoke_unexpected': '无法移除设备。请刷新列表后重试。',
      'identity_renewal_unexpected': '无法创建新的 VPN 身份。请刷新设备后重试。',
      'openvpn_renewal_unexpected': '无法续订 OpenVPN 配置文件。请重试或查看诊断代码。',
      'location_migration_blocked': '服务器目前无法完成此更改。设备及其本地身份已保留。',
      'location_migration_slow': '服务器仍在准备迁移到 $target。请稍后片刻使用“继续”。',
      'location_migration_conflict': '服务器上的设备状态发生了变化。请刷新设备，然后继续更改。',
      'location_migration_verification_failed': '服务器未确认新位置。之前的本地身份已保留。',
      'location_migration_device_changed': '服务器返回的设备与正在更改的设备不再匹配。请刷新设备后重试。',
      'tunnel_stop_failed': '建立新连接前，必须完全停止之前的隧道。',
      'other': '无法完成操作。请重试，或将诊断代码发送给支持人员。',
    });
    return '$_temp0';
  }

  @override
  String notice_api_title(String code) {
    String _temp0 = intl.Intl.selectLogic(code, {
      'unauthorized': '会话已过期',
      'invalid_credentials': '登录失败',
      'email_verification_required': '需要确认电子邮件',
      'verification_email_cooldown': '邮件已发送',
      'rate_limited': '尝试次数过多',
      'invalid_registration': '必须更正信息',
      'email_exists': '账户已存在',
      'invalid_profile': '个人资料无效',
      'invalid_device': '设备无效',
      'invalid_location': '位置不可用',
      'device_limit': '已达到设备上限',
      'device_exists': 'VPN 身份已在使用中',
      'device_identity_revoked': '必须续订 VPN 身份',
      'device_location_locked': '位置更改需要刷新',
      'location_migration_pending': '正在更改位置',
      'location_migration_blocked': '位置更改被阻止',
      'target_ca_mismatch': 'OpenVPN 服务器不兼容',
      'location_migration_conflict': '位置更改需要刷新',
      'server_full': '服务器已满',
      'capacity_unavailable': '位置暂时不可用',
      'target_unavailable': '服务器暂时不可用',
      'not_found': '未找到项目',
      'invalid_openvpn_csr': 'OpenVPN 身份无效',
      'openvpn_profile_exists': 'OpenVPN 配置文件已存在',
      'openvpn_profile_revoked': 'OpenVPN 配置文件已撤销',
      'openvpn_operation_pending': 'OpenVPN 操作正在进行中',
      'openvpn_operation_terminal': 'OpenVPN 操作已中断',
      'openvpn_address_unavailable': 'OpenVPN 地址不可用',
      'openvpn_profile_conflict': 'OpenVPN 冲突',
      'openvpn_signer_unavailable': 'OpenVPN 不可用',
      'email_delivery_unavailable': '电子邮件不可用',
      'invalid_token': '链接无效',
      'network_unavailable': '互联网连接不可用',
      'invalid_json': '请求无效',
      'invalid_api_response': '服务器响应无效',
      'ipv6_unavailable': 'IPv6 不可用',
      'invalid_ip_families': '网络配置被拒绝',
      'other': '服务不可用',
    });
    return '$_temp0';
  }

  @override
  String notice_api_message(String code) {
    String _temp0 = intl.Intl.selectLogic(code, {
      'unauthorized': '您的会话已过期。请重新登录。',
      'invalid_credentials': '电子邮件地址或密码不正确。',
      'email_verification_required': '请先确认您的电子邮件地址，然后再添加 VPN 设备。',
      'invalid_registration': '请检查所要求的信息和同意项。',
      'email_exists': '已有账户使用此电子邮件地址。',
      'invalid_profile': '请检查您的个人资料信息。',
      'invalid_device': '此设备的名称或本地身份无效。',
      'invalid_location': '请刷新位置列表后重试。',
      'device_limit': '请先移除现有设备，然后再添加其他设备。',
      'device_exists': '此 VPN 身份已关联到另一个账户。',
      'device_identity_revoked': '此身份已被移除。必须创建新的本地身份。',
      'device_location_locked': '此设备的位置刚刚更改。应用将继续进行中的更改。',
      'location_migration_pending': '位置更改已在进行中。',
      'location_migration_blocked': '更改位置需要服务器介入。请稍后重试或联系支持人员。',
      'target_ca_mismatch': '此服务器尚未与当前 OpenVPN 配置文件兼容。',
      'location_migration_conflict': '请刷新设备，然后再次尝试更改位置。',
      'server_full': '此位置已达到连接上限。请选择其他位置或稍后重试。',
      'capacity_unavailable': '我们目前无法确认此位置是否可用。请选择其他位置或稍后重试。',
      'target_unavailable': '此服务器暂时不可用。',
      'not_found': '此项目已不再属于您的账户。',
      'invalid_openvpn_csr': '请创建新的 OpenVPN 身份后重试。',
      'openvpn_profile_exists': '此设备已存在 OpenVPN 配置文件。',
      'openvpn_profile_revoked': '请续订 OpenVPN 配置文件以继续。',
      'openvpn_operation_pending': '更改仍在传播中。请稍后重试。',
      'openvpn_operation_terminal': '请创建新的 OpenVPN 身份后重试。',
      'openvpn_address_unavailable': '目前没有可用的 OpenVPN 地址。',
      'openvpn_profile_conflict': '配置文件已更改。请刷新设备后重试。',
      'openvpn_signer_unavailable': 'OpenVPN 服务暂时不可用。',
      'email_delivery_unavailable': '无法发送电子邮件。请稍后重试。',
      'invalid_token': '此链接无效或已过期。请请求新链接。',
      'network_unavailable': '请检查互联网连接后重试。',
      'invalid_json': '请检查输入的信息后重试。',
      'invalid_api_response': '服务器返回了意外响应。请稍后重试。',
      'ipv6_unavailable': '服务器目前无法启用 IPv6。请稍后重试。',
      'invalid_ip_families': '隧道配置不完整，或与已授权的地址不匹配。请从应用中重试。',
      'other': '发生服务器错误。请稍后重试。',
    });
    return '$_temp0';
  }

  @override
  String get notice_retryLater => '请过一会儿再重试。';

  @override
  String notice_retryAfter(Object seconds) {
    return '请在 $seconds 秒后重试。';
  }

  @override
  String notice_native_title(String code, String protocol) {
    String _temp0 = intl.Intl.selectLogic(code, {
      'system_vpn_resume_unavailable': '系统 VPN 恢复不可用',
      'system_vpn_resume_corrupt': '系统 VPN 恢复无效',
      'system_vpn_resume_session_invalid': 'VPN 恢复会话无效',
      'system_vpn_resume_identity_changed': 'VPN 身份已更改',
      'system_vpn_resume_identity_invalid': 'VPN 恢复身份无效',
      'system_vpn_resume_storage_failed': 'VPN 恢复存储不可用',
      'system_vpn_resume_network_timeout': 'VPN 恢复时没有网络',
      'system_vpn_resume_blocked': 'VPN 恢复被阻止',
      'system_vpn_resume_failed': 'VPN 恢复失败',
      'system_vpn_resume_error_invalid': 'VPN 恢复错误无效',
      'wireguard_identity_store_failed': 'WireGuard 身份未保存',
      'wireguard_identity_unavailable': 'WireGuard 身份不可用',
      'vpn_host_destroyed': 'Android VPN 主机已停止',
      'vpn_host_unavailable': 'Android VPN 主机不可用',
      'vpn_permission_required': '需要 VPN 权限',
      'vpn_permission_denied': 'VPN 权限被拒绝',
      'vpn_permission_request_failed': '无法请求权限',
      'wireguard_foreground_service_unavailable': 'WireGuard 服务不可用',
      'wireguard_identity_invalid': '本地 WireGuard 密钥无效',
      'wireguard_identity_in_use': 'WireGuard 身份已在使用中',
      'wireguard_configuration_invalid': 'WireGuard 配置无效',
      'wireguard_operation_pending': 'WireGuard 操作仍处于活动状态',
      'wireguard_start_failed': 'WireGuard 启动被拒绝',
      'wireguard_stop_timeout': '未确认 WireGuard 已停止',
      'wireguard_handshake_timeout': 'WireGuard 没有响应',
      'openvpn_connection_timeout': 'OpenVPN 没有响应',
      'openvpn_core_unavailable': 'OpenVPN 引擎不可用',
      'openvpn_operation_pending': 'OpenVPN 会话仍处于活动状态',
      'openvpn_stop_timeout': '未确认 OpenVPN 已停止',
      'openvpn_profile_unavailable': '缺少本地 OpenVPN 配置文件',
      'openvpn_native_failed': '原生 OpenVPN 调用已中断',
      'openvpn_key_generation_failed': '无法创建 OpenVPN P-256 密钥',
      'openvpn_csr_generation_failed': '无法创建 OpenVPN CSR',
      'openvpn_identity_store_failed': 'OpenVPN 身份未保存',
      'openvpn_identity_clear_failed': 'OpenVPN 移除不完整',
      'openvpn_identity_in_use': 'OpenVPN 身份仍在使用中',
      'openvpn_tls_verification_required': '缺少 OpenVPN TLS 验证',
      'openvpn_cipher_invalid': 'OpenVPN 加密算法无效',
      'openvpn_profile_rejected': 'OpenVPN 配置文件被拒绝',
      'openvpn_identity_inconsistent': 'OpenVPN 身份不一致',
      'tls_handshake_failed': 'OpenVPN 协商被拒绝',
      'tls_alert_unknown_ca': 'OpenVPN 客户端证书未被识别',
      'tls_alert_bad_certificate': 'OpenVPN 客户端证书被拒绝',
      'tls_alert_unsupported_certificate': '不支持的 OpenVPN 证书',
      'tls_client_certificate_required': '需要 OpenVPN 客户端证书',
      'tls_alert_misc': 'OpenVPN TLS 警报',
      'tls_signature_algorithm_rejected': '不支持的 OpenVPN 签名',
      'tls_handshake_rejected': 'OpenVPN TLS 协商被拒绝',
      'tls_version_rejected': '不兼容的 OpenVPN TLS 版本',
      'tls_certificate_expired': 'TLS 证书已过期',
      'tls_certificate_revoked': 'TLS 证书已撤销',
      'transport_failed': '无法访问 OpenVPN 服务器',
      'tun_configuration_rejected': '无法创建 OpenVPN 接口',
      'tun_setup_failed': 'OpenVPN TUN 设置失败',
      'tun_interface_create_failed': 'OpenVPN 接口创建失败',
      'tun_interface_disabled': 'OpenVPN 接口已禁用',
      'tun_halted': 'OpenVPN 接口已中断',
      'tun_already_established': 'OpenVPN 接口已经打开',
      'tun_addresses_missing': '缺少 OpenVPN 地址',
      'tun_routes_missing': '缺少 OpenVPN 路由',
      'tun_dns_missing': '缺少 OpenVPN DNS',
      'tun_permission_revoked': 'VPN 权限已撤销',
      'tun_establish_returned_null': 'Android 拒绝了 VPN 接口',
      'openvpn_service_start_failed': 'OpenVPN 服务不可用',
      'openvpn_operation_timeout': 'OpenVPN 调用超时',
      'openvpn_start_failed': 'OpenVPN 启动被拒绝',
      'openvpn_connection_failed': 'OpenVPN 连接已中断',
      'openvpn_core_status_error': 'OpenVPN Core 以错误结束',
      'openvpn_stopped_before_connected': 'OpenVPN 在连接前停止',
      'openvpn_auth_failed': 'OpenVPN 身份验证被拒绝',
      'openvpn_client_setup_failed': 'OpenVPN 客户端设置失败',
      'openvpn_client_halted': 'OpenVPN 客户端已中断',
      'openvpn_client_restart': '已请求重启 OpenVPN',
      'openvpn_inactive_timeout': 'OpenVPN 长时间未活动',
      'openvpn_session_expired': 'OpenVPN 会话已过期',
      'openvpn_credentials_required': '不支持的 OpenVPN 身份验证',
      'openvpn_proxy_failed': 'OpenVPN 中间传输失败',
      'openvpn_compression_failed': 'OpenVPN 压缩被拒绝',
      'openvpn_ntlm_crypto_unavailable': 'OpenVPN NTLM 加密不可用',
      'openvpn_feature_unsupported': '不支持的 OpenVPN 功能',
      'network_unavailable': '互联网连接不可用',
      'network_lost': '网络不可用',
      'certificate_validation_failed': '服务器证书被拒绝',
      'openvpn_certificate_expired': 'OpenVPN 证书已过期',
      'tunnel_active_for_another_account': '另一个账户的隧道仍处于活动状态',
      'tunnel_already_active': '原生隧道已处于活动状态',
      'tunnel_stop_timeout': '未确认 $protocol 已停止',
      'tunnel_disconnected': '$protocol 已中断',
      'native_bridge_unavailable': 'Android 桥接不可用',
      'native_operation_failed': 'Android 操作已中断',
      'invalid_arguments': 'VPN 参数不完整',
      'invalid_account_id': 'VPN 账户无效',
      'invalid_device_id': '设备标识符无效',
      'storage_key_not_allowed': '存储密钥被拒绝',
      'secure_storage_read_failed': '安全读取失败',
      'secure_storage_write_failed': '安全写入失败',
      'key_generation_failed': '无法生成 WireGuard 密钥',
      'csr_generation_failed': '无法生成 OpenVPN CSR',
      'other': '未分类的原生 VPN 错误',
    });
    return '$_temp0';
  }

  @override
  String notice_native_message(String code, String protocol) {
    String _temp0 = intl.Intl.selectLogic(code, {
      'system_vpn_resume_unavailable': 'Android 找不到可恢复的 VPN 会话。请在应用中开始新的连接。',
      'system_vpn_resume_corrupt': '保存的 VPN 恢复数据无效，不会使用。请开始新的连接。',
      'system_vpn_resume_session_invalid': '保存的会话无法再恢复 VPN。请在应用中重新登录。',
      'system_vpn_resume_identity_changed': '本地 VPN 身份已更改。恢复已停止；请开始新的连接。',
      'system_vpn_resume_identity_invalid': '用于恢复的身份无效。请开始新的连接。',
      'system_vpn_resume_storage_failed': 'Android 无法读取或更新加密的恢复数据。请开始新的连接。',
      'system_vpn_resume_network_timeout': 'Android 未能及时找到网络来恢复 VPN。请在网络可用时重试。',
      'system_vpn_resume_blocked': 'VPN 恢复被阻止。请检查 Android 设置，然后开始新的连接。',
      'system_vpn_resume_failed': 'Android VPN 恢复失败。请在应用中开始新的连接。',
      'system_vpn_resume_error_invalid': 'Android 返回了无法使用的恢复错误。请开始新的连接。',
      'wireguard_identity_store_failed': 'Android 无法保存此账户的加密 WireGuard 身份。',
      'wireguard_identity_unavailable': '此连接没有可用的 WireGuard 身份。',
      'vpn_host_destroyed': '托管 VPN 的 Android 组件已停止。请开始新的连接。',
      'vpn_host_unavailable': 'Android 无法创建托管 VPN 的组件。请检查 VPN 设置后重试。',
      'openvpn_renewal_required': '连接前需要在应用中对证书执行操作。',
      'openvpn_recovery_failed': '自动恢复失败。请在应用中开始新的连接。',
      'openvpn_recovery_exhausted': '自动恢复已使用过。请在应用中开始新的连接。',
      'vpn_permission_required': '启动隧道前，Android 需要新的 VPN 授权。',
      'vpn_permission_denied': '请在 Android 请求中允许 FuzeVPN 继续。',
      'vpn_permission_request_failed': 'Android 无法打开 VPN 权限页面。',
      'wireguard_foreground_service_unavailable':
          'Android 无法让 WireGuard 服务保持在前台运行。',
      'wireguard_identity_invalid': '此账户的加密 WireGuard 密钥无法读取或无效。',
      'wireguard_identity_in_use': '另一个操作仍在使用此账户的 WireGuard 密钥。',
      'wireguard_configuration_invalid': '收到的 WireGuard 地址、DNS、服务器密钥或路由无效。',
      'wireguard_operation_pending': '上一次 WireGuard 操作尚未释放其原生服务。',
      'wireguard_start_failed': 'WireGuard 引擎拒绝激活配置。',
      'wireguard_stop_timeout': 'WireGuard 服务未在规定时间内确认释放 VPN 接口。',
      'wireguard_handshake_timeout': '隧道未能及时确认与服务器的握手。',
      'openvpn_connection_timeout': 'OpenVPN 未能及时确认与服务器的连接。',
      'openvpn_core_unavailable': '此应用版本不包含可用的 OpenVPN 引擎。',
      'openvpn_operation_pending': '原生引擎仍持有之前的 OpenVPN 会话，拒绝创建第二个会话。',
      'openvpn_stop_timeout': 'OpenVPN Core 未在规定时间内确认其原生会话已停止并销毁。',
      'openvpn_profile_unavailable': '无法读取适用于此连接的已验证 OpenVPN 配置文件。',
      'openvpn_native_failed': '应用错误中断了 OpenVPN。请再次尝试连接。如果问题持续存在，请运行诊断。',
      'openvpn_key_generation_failed': 'Android 密钥库无法创建或读取不可导出的 P-256 私钥。',
      'openvpn_csr_generation_failed': 'Android 密钥库密钥无法签署 OpenVPN 证书请求。',
      'openvpn_identity_store_failed': '无法将 OpenVPN 证书或配置文件保存到加密存储中。',
      'openvpn_identity_clear_failed': 'Android 无法移除此账户的完整本地 OpenVPN 身份。',
      'openvpn_identity_in_use': '原生 OpenVPN 会话仍在使用此设备的密钥或证书。',
      'openvpn_tls_verification_required': '配置文件未明确要求验证服务器证书。',
      'openvpn_cipher_invalid': '服务器提供了不在允许列表中的加密算法。',
      'openvpn_profile_rejected': '从服务器收到的配置文件不兼容。请重新创建设备后重试。',
      'openvpn_identity_inconsistent': '证书与此手机的安全身份不匹配。未替换本地配置文件。',
      'tls_handshake_failed': '服务器拒绝了 TLS 协商。如果问题持续存在，请重新创建配置文件。',
      'tls_alert_unknown_ca': '服务器不认可此设备证书的颁发机构。必须检查 OpenVPN 服务器。',
      'tls_alert_bad_certificate': '服务器拒绝了此设备证书。请重新创建设备后重试。',
      'tls_alert_unsupported_certificate': '服务器不支持 Android 使用的安全证书类型。',
      'tls_client_certificate_required': '服务器要求客户端证书，但 OpenVPN Core 无法提供证书。',
      'tls_alert_misc': '服务器返回了不属于证书和版本类别的 TLS 警报。',
      'tls_signature_algorithm_rejected':
          '服务器拒绝了 Android 密钥库密钥的 ECDSA P-256 算法。',
      'tls_handshake_rejected': '服务器在连接前中断了 TLS 协商。',
      'tls_version_rejected': '客户端和服务器没有找到共同的 TLS 版本。',
      'tls_certificate_expired': '连接期间提供的证书已过期。',
      'tls_certificate_revoked': '连接期间提供的证书已被撤销。',
      'transport_failed': 'OpenVPN 服务器在当前网络上没有响应。请稍后重试。',
      'tun_configuration_rejected': 'Android 拒绝了 OpenVPN 请求的网络配置。',
      'tun_setup_failed': 'OpenVPN Core 在创建 Android 接口前拒绝了网络方案。',
      'tun_interface_create_failed':
          'OpenVPN Core 无法从 Android VpnService 获取 TUN 接口。',
      'tun_interface_disabled': 'Android 或 OpenVPN Core 在连接期间禁用了 TUN 接口。',
      'tun_halted': 'OpenVPN Core 收到了停止 TUN 接口的请求。',
      'tun_already_established': 'OpenVPN 在同一连接中请求了第二个接口。为安全起见，隧道已停止。',
      'tun_addresses_missing': '服务器未提供可用的隧道地址。',
      'tun_routes_missing': '服务器未提供可用的隧道路由。',
      'tun_dns_missing': '服务器未提供可用的 DNS 服务器。',
      'tun_permission_revoked': 'Android 在连接期间撤销了 VPN 权限。',
      'tun_establish_returned_null': 'Android 未创建接口，通常是因为另一个 VPN 仍处于活动状态。',
      'openvpn_service_start_failed': 'Android 无法启动 OpenVPN 前台服务。',
      'openvpn_operation_timeout': '对 OpenVPN Core 的 JNI 调用超过了最长持续时间。',
      'openvpn_start_failed': 'Android 服务已准备就绪，但 OpenVPN Core 不接受启动配置文件。',
      'openvpn_connection_failed': 'OpenVPN Core 在发出 CONNECTED 事件前停止。',
      'openvpn_core_status_error': '原生 OpenVPN 循环以错误结束，且没有更具体的终止事件。',
      'openvpn_stopped_before_connected':
          '原生 OpenVPN 循环在 CONNECTED 之前停止，Core 未报告明确错误。',
      'openvpn_auth_failed': 'OpenVPN 服务器拒绝了配置文件身份验证。',
      'openvpn_client_setup_failed': 'OpenVPN Core 无法在网络连接前初始化客户端。',
      'openvpn_client_halted': 'OpenVPN Core 收到了终止客户端的请求。',
      'openvpn_client_restart': 'OpenVPN Core 请求重启其传输会话。',
      'openvpn_inactive_timeout': 'OpenVPN Core 在无活动超时后关闭了会话。',
      'openvpn_session_expired': '服务器报告 OpenVPN 会话已过期。',
      'openvpn_credentials_required': '服务器或代理请求交互式凭据，而此证书配置文件不包含这些凭据。',
      'openvpn_proxy_failed': 'OpenVPN Core 报告配置的代理或中继失败。',
      'openvpn_compression_failed': 'OpenVPN Core 拒绝了配置文件或服务器声明的压缩模式。',
      'openvpn_ntlm_crypto_unavailable': '配置文件请求的 NTLM 加密在此版本中不可用。',
      'openvpn_feature_unsupported': '配置文件或服务器需要此 Android 客户端缺少的功能。',
      'network_unavailable': '没有可用的物理网络。',
      'network_lost': '网络丢失后隧道已停止。',
      'certificate_validation_failed': '无法验证 OpenVPN 服务器身份。',
      'openvpn_certificate_expired': '重新连接前请续订 OpenVPN 配置文件。',
      'tunnel_active_for_another_account': '属于另一个账户的隧道必须先停止，才能进行此连接。',
      'tunnel_already_active': 'Android 报告之前的 VPN 会话仍在使用此接口。',
      'tunnel_stop_timeout': '$protocol 引擎未在规定时间内确认释放 VPN 接口。',
      'tunnel_disconnected': '原生引擎报告隧道启动后意外结束。',
      'native_bridge_unavailable': '应用无法访问 Android VPN 服务。请关闭并重新打开应用，然后重试。',
      'native_operation_failed': '应用错误中断了 VPN 操作。请重试。如果问题持续存在，请运行诊断。',
      'invalid_arguments': '此 VPN 操作所需的信息不完整。请重试。如果问题持续存在，请运行诊断。',
      'invalid_account_id': '原生操作未关联有效的账户标识符。',
      'invalid_device_id': '发送给原生引擎的设备标识符缺失或无效。',
      'storage_key_not_allowed': 'Android 桥接阻止了允许存储列表之外的密钥。',
      'secure_storage_read_failed': 'Android 密钥库无法解密此账户的本地数据。',
      'secure_storage_write_failed': 'Android 密钥库无法加密或保存本地数据。',
      'key_generation_failed': 'Android 无法在安全存储中创建或读取 WireGuard 密钥。',
      'csr_generation_failed': 'Android 密钥库无法创建或签署 OpenVPN P-256 CSR。',
      'other': '未记录的原生分支失败。请将下方显示的诊断代码发送给支持人员。',
    });
    return '$_temp0';
  }

  @override
  String get notice_permissionRequestInProgress_title => '权限请求已打开';

  @override
  String get notice_permissionRequestInProgress_message =>
      'Android VPN 权限请求已显示。请完成请求后再重试。';

  @override
  String get notice_permissionRequestInterrupted_title => 'VPN 权限请求已中断';

  @override
  String get notice_permissionRequestInterrupted_message =>
      '应用收到响应前，VPN 权限页面已关闭。';

  @override
  String get notice_openvpnProofMissing_title => '未确认 OpenVPN 连接';

  @override
  String get notice_openvpnProofMissing_message =>
      '无法确认 OpenVPN 连接。为安全起见，连接已停止。请重试。';

  @override
  String get openvpnCleanup_title => 'OpenVPN 配置文件已撤销';

  @override
  String get openvpnCleanup_working => '正在停止并移除已撤销的 OpenVPN 配置文件…';

  @override
  String get openvpnCleanup_stopFailed => '尚未确认 OpenVPN 已关闭。请在创建新配置文件前重试。';

  @override
  String get openvpnCleanup_cleanupFailed => '无法完全移除已撤销的 OpenVPN 配置文件。请重试清理。';

  @override
  String get openvpnCleanup_complete => '已移除已撤销的 OpenVPN 配置文件。点击“连接”以创建新的配置文件。';

  @override
  String get network_title => '网络配置';

  @override
  String get network_ipv4Fallback => 'IPv6 暂时不可用。正在使用 IPv4 继续准备。';

  @override
  String get network_rejectedTitle => '网络配置被拒绝';

  @override
  String get network_rejectedMessage => '隧道配置不完整，或与已授权的地址不匹配。请从应用中重试。';

  @override
  String get network_unreadableTitle => '无法读取本地配置';

  @override
  String get network_unreadableMessage => '保存的 OpenVPN 网络配置无法使用。请从应用重新连接以更新配置。';

  @override
  String get network_ipv4 => 'IPv4';

  @override
  String get network_dualStack => 'IPv4 + IPv6';

  @override
  String get protection_title => '网络保护';

  @override
  String get protection_subtitle => '如果 VPN 断开连接，则阻止直接访问互联网。';

  @override
  String get protection_active => '系统保护已启用';

  @override
  String get protection_alwaysOnOnly => '始终开启 VPN 已启用；请开启 VPN 外部连接阻止功能';

  @override
  String get protection_inactive => '系统保护未启用';

  @override
  String get protection_unknown => '检查系统保护';

  @override
  String get protection_openSettings => '打开 Android 设置';

  @override
  String get protection_dialogTitle => '设置网络保护';

  @override
  String get protection_dialogMessage =>
      'Android 管理始终开启的 VPN 以及 VPN 外部的连接阻止功能。请确认已选择 FuzeVPN，并在系统设置中启用阻止功能。';

  @override
  String get protection_dialogOpen => '打开设置';

  @override
  String get session_systemProtectionNote =>
      '如果 Android 仍在阻止 VPN 外部的流量，请打开系统设置检查或更改此保护功能。';

  @override
  String get diagnostics_title => '诊断';

  @override
  String get diagnostics_settingsTitle => '应用诊断';

  @override
  String get diagnostics_automaticTitle => '发送重要错误';

  @override
  String get diagnostics_automaticDescription => '发生重要错误时分享一份简短的技术报告。';

  @override
  String get diagnostics_privacy =>
      '发送的报告会关联到已登录的账户，并保留 30 天。报告不包含浏览历史、密码或 VPN 密钥。';

  @override
  String get diagnostics_manualOpen => '运行诊断';

  @override
  String get diagnostics_localDescription => '创建应用和 VPN 状态报告。您的连接不会改变。';

  @override
  String get diagnostics_sendReport => '发送报告';

  @override
  String get diagnostics_sendHint => '取消选中此框可将报告保留在此设备上。';

  @override
  String get diagnostics_signedOut => '登录账户后即可发送报告。';

  @override
  String get diagnostics_localLifetime => '将此报告保存到手机上，以便关闭应用后仍能保留。';

  @override
  String get diagnostics_run => '运行诊断';

  @override
  String get diagnostics_rerun => '再次运行诊断';

  @override
  String get diagnostics_running => '正在检查…';

  @override
  String get diagnostics_sending => '正在发送报告…';

  @override
  String get diagnostics_prepared => '报告已在此设备上准备就绪';

  @override
  String get diagnostics_queued => '报告等待发送';

  @override
  String get diagnostics_sent => '报告已收到';

  @override
  String get diagnostics_failed => '发送失败。本地报告仍可用。';

  @override
  String get diagnostics_preparationFailed => '无法准备诊断报告。请重试。';

  @override
  String get diagnostics_authenticationRequired => '请重新登录以发送报告。';

  @override
  String get diagnostics_retry => '重试发送';

  @override
  String get diagnostics_export => '保存报告';

  @override
  String get diagnostics_exportFailed => '导出失败。请从本地报告重试。';

  @override
  String get diagnostics_preferenceFailed => '无法保存此设置。请重试。';

  @override
  String diagnostics_receipt(Object id) {
    return '参考编号：$id';
  }

  @override
  String diagnostics_received(Object date) {
    return '接收于 $date';
  }

  @override
  String diagnostics_expires(Object date) {
    return '保留至 $date';
  }

  @override
  String get diagnostics_duplicate => '此报告此前已经收到。';

  @override
  String get diagnostics_preview => '报告预览';

  @override
  String diagnostics_eventCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '附加了 $count 个技术事件',
      one: '附加了 1 个技术事件',
      zero: '没有附加技术事件',
    );
    return '$_temp0';
  }

  @override
  String get diagnostics_technical => '技术详情';

  @override
  String get diagnostics_empty => '尚未准备任何诊断报告。';

  @override
  String diagnostics_checkName(String id) {
    String _temp0 = intl.Intl.selectLogic(id, {
      'tunnel_connection': '隧道状态',
      'handshake': '连接确认',
      'certificate': 'VPN 证书',
      'kill_switch': 'Android 保护',
      'connectivity': '可用网络',
      'api_reachability': '服务访问',
      'secure_storage': '安全存储',
      'other': '本地检查',
    });
    return '$_temp0';
  }

  @override
  String diagnostics_checkResult(String result) {
    String _temp0 = intl.Intl.selectLogic(result, {
      'passed': '已检查',
      'failed': '需要处理',
      'skipped': '未测试——没有活动探针',
      'unknown': '信息不可用',
      'other': '信息不可用',
    });
    return '$_temp0';
  }

  @override
  String get auth_welcome => '欢迎使用 FuzeVPN';

  @override
  String get connection_changeLocation => '更改位置';

  @override
  String get connection_details => '连接详情';

  @override
  String get locations_searchLabel => '搜索城市或国家';

  @override
  String get locations_clearSearch => '清除搜索';

  @override
  String get locations_filterAll => '全部';

  @override
  String get locations_filterFavorites => '收藏';

  @override
  String locations_results(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count 个位置',
      one: '$count 个位置',
    );
    return '$_temp0';
  }

  @override
  String get locations_noResults => '未找到位置';

  @override
  String get locations_noResultsHint => '请尝试其他城市或国家。';

  @override
  String get locations_noFavorites => '您的收藏，触手可及';

  @override
  String get locations_noFavoritesHint => '点击位置旁边的星标即可将其保存到这里。';

  @override
  String get locations_showAll => '查看所有位置';

  @override
  String locations_addFavorite(String name) {
    return '将 $name 添加到收藏';
  }

  @override
  String locations_removeFavorite(String name) {
    return '从收藏中移除 $name';
  }

  @override
  String get locations_favoriteSaveFailed => '无法保存收藏。请重试。';

  @override
  String get locations_emptyTitle => '没有可用的位置';

  @override
  String get locations_emptyHint => '刷新列表后重试。';

  @override
  String get devices_manage => '管理我的设备';

  @override
  String get settings_personalization => '个性化设置';

  @override
  String get settings_safety => '保护';

  @override
  String get settings_help => '需要帮助？';

  @override
  String get settings_about => '关于 FuzeVPN';

  @override
  String get diagnostics_heading => '了解连接问题';

  @override
  String devices_profileStatus(String status) {
    String _temp0 = intl.Intl.selectLogic(status, {
      'active': '可用',
      'pending': '正在准备',
      'revoked': '已移除',
      'expired': '已过期',
      'other': '状态不可用',
    });
    return '$_temp0';
  }

  @override
  String get notice_preferenceSave_title => '偏好设置未保存';

  @override
  String get notice_preferenceSave_message =>
      '您的选择目前已应用，但无法保存。请重试，以便关闭应用后仍保留该选择。';

  @override
  String get connection_androidDisconnectHint =>
      '如果 Android 仍保持 VPN 活跃，请在打开的设置中关闭“始终开启的 VPN”。';

  @override
  String get protection_learnMore => '了解 Android 保护功能';

  @override
  String get protection_guideWhy =>
      '如果 VPN 断开连接，此保护功能会阻止应用直接使用互联网。它在 Android 中配置。';

  @override
  String get protection_guideAlwaysOnTitle => '始终开启的 VPN';

  @override
  String get protection_guideAlwaysOn =>
      'Android 会保持 VPN 服务运行，并可在手机重启后重新启动该服务。';

  @override
  String get protection_guideBlockTitle => '阻止无 VPN 连接';

  @override
  String get protection_guideBlock => '此设置会阻止流量绕过 VPN，包括连接中断期间的流量。';

  @override
  String get protection_guideWarning => '启用此阻止功能后，互联网访问会保持关闭，直到 VPN 连接成功。';

  @override
  String get protection_guideStepsTitle => '开启保护';

  @override
  String get protection_guideStep1 => '使用下方按钮打开 Android VPN 设置。';

  @override
  String get protection_guideStep2 => '点击 FuzeVPN 旁边的齿轮图标打开选项。';

  @override
  String get protection_guideStep3 =>
      '启用“始终开启的 VPN”，然后启用“阻止无 VPN 连接”（如果这些选项可用）。';

  @override
  String get protection_guideManufacturers =>
      '不同手机上的名称可能不同。如有需要，请在“设置”中搜索 VPN，通常位于“网络和互联网”下。';

  @override
  String get protection_guideDisableTitle => '关闭此保护功能';

  @override
  String get protection_guideDisable =>
      '在相同设置中关闭无 VPN 阻止功能，以允许在没有 VPN 时访问互联网。如果不再希望 Android 自动重启 VPN，也请关闭“始终开启的 VPN”。';

  @override
  String get protection_guideManual => '这些设置由您在 Android 中选择。FuzeVPN 不会替您更改。';

  @override
  String get locations_changeTitle => '要更改位置吗？';

  @override
  String locations_changeActive(String name) {
    return 'VPN 将断开连接，然后尝试连接到 $name。';
  }

  @override
  String locations_changeIdle(String name) {
    return 'VPN 将尝试连接到 $name。';
  }

  @override
  String get locations_confirmChange => '更改并连接';

  @override
  String get locations_changeBusy => '更改正在进行中。请等待后再选择其他位置。';

  @override
  String get locations_automaticSelection => '自动选择';

  @override
  String get locations_cities => '城市';

  @override
  String get locations_servers => '服务器';

  @override
  String locations_viewCities(String name) {
    return '查看 $name 中的城市';
  }

  @override
  String locations_viewServers(String name) {
    return '查看 $name 中的服务器';
  }

  @override
  String locations_countryCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count 个国家',
      one: '$count 个国家',
    );
    return '$_temp0';
  }

  @override
  String locations_cityCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count 个城市',
      one: '$count 个城市',
    );
    return '$_temp0';
  }

  @override
  String locations_serverCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count 台服务器',
      one: '$count 台服务器',
    );
    return '$_temp0';
  }

  @override
  String get locations_allCountries => '所有国家';

  @override
  String get locations_backToCountries => '返回国家列表';

  @override
  String locations_backToCities(String name) {
    return '返回 $name 中的城市';
  }

  @override
  String locations_chooseCountry(String name) {
    return '选择 $name';
  }

  @override
  String locations_chooseCity(String name) {
    return '选择 $name';
  }

  @override
  String get locations_noCompatibleServer => '没有可用的兼容服务器。';

  @override
  String get externalLink_failed => '无法打开此链接。您可以复制链接并在浏览器中打开。';

  @override
  String get externalLink_copy => '复制链接';

  @override
  String get externalLink_copied => '链接已复制';

  @override
  String get externalLink_copyFailed => '无法复制链接。请选择下方地址。';

  @override
  String get settings_deleteAccount => '删除我的账户';

  @override
  String get settings_deleteAccountDetail => '查看申请删除账户的流程';

  @override
  String get billing_title => 'Fuze Premium';

  @override
  String get billing_subtitle => '选择您的 VPN 订阅。';

  @override
  String get billing_subscribe => '订阅';

  @override
  String get billing_choosePlan => '选择方案以继续。';

  @override
  String get billing_monthly => '月付';

  @override
  String get billing_yearly => '年付';

  @override
  String get billing_continue => '通过 Google Play 继续';

  @override
  String get billing_restore => '恢复购买';

  @override
  String get billing_manage => '管理订阅';

  @override
  String get billing_deleteAccountWarning =>
      '如果您通过 Google Play 订阅，删除 FuzeVPN 账户不会取消该订阅的续订。请在 Google Play 中单独管理或取消续订。';

  @override
  String get billing_deleteAccountContinue => '继续申请删除账户';

  @override
  String get billing_refresh => '刷新访问权限';

  @override
  String get billing_loadingPlans => '正在加载方案…';

  @override
  String get billing_unavailable => '目前没有可用方案。请稍后重试。';

  @override
  String get billing_comingSoon => '订阅即将推出。';

  @override
  String get billing_priceDisclosure => '价格由 Google Play 提供。您确认前会显示最终金额和适用税费。';

  @override
  String get billing_renewalMonthly =>
      '除非取消，否则每月自动续订。您可以随时在 Google Play 订阅中取消。';

  @override
  String get billing_renewalYearly => '除非取消，否则每年自动续订。您可以随时在 Google Play 订阅中取消。';

  @override
  String get billing_active => '您的 Premium 访问权限已生效';

  @override
  String billing_accessUntil(String date) {
    return '可使用至 $date。';
  }

  @override
  String get billing_webManaged => '您的订阅在 FuzeVPN 网站上管理。';

  @override
  String get billing_playManaged => '您的订阅通过 Google Play 管理。';

  @override
  String get billing_inactive => '没有生效的订阅。';

  @override
  String get billing_checkingAccess => '正在检查您的访问权限…';

  @override
  String get billing_restoring => '正在恢复购买…';

  @override
  String get billing_pending => '付款待处理。确认后将开通访问权限。';

  @override
  String get billing_cancelled => '购买已取消。未开通新的订阅。';

  @override
  String get billing_verifying => '正在验证购买…';

  @override
  String get billing_success => '订阅已开通。您现在可以使用 Premium。';

  @override
  String get billing_restored => '您的购买已恢复。';

  @override
  String get billing_restoreEmpty => '此 Google Play 账号没有可恢复的购买。';

  @override
  String get billing_catalogError => '无法加载方案。请重试。';

  @override
  String get billing_purchaseError => '无法开始购买。请重试。';

  @override
  String get billing_verificationError => '购买验证暂时不可用。请恢复购买以重试。';

  @override
  String get billing_restoreError => '无法恢复购买。请重试。';

  @override
  String get billing_managementError => '无法打开订阅管理。请重试。';

  @override
  String get billing_storeUnavailable => '此设备无法使用 Google Play。';

  @override
  String get welcome_title => '您的 VPN，简单易用。';

  @override
  String get welcome_description => '保护您的连接。掌控您的隐私。';

  @override
  String get welcome_start => '开始使用';

  @override
  String get welcome_alreadyPurchased => '已购买？';

  @override
  String get welcome_noAccountRequired => '无需创建账户即可开始。';

  @override
  String get guest_accountTitle => '账户尚未关联';

  @override
  String get guest_accountDescription =>
      '使用同一个 Google Play 账户恢复购买，即可在其他设备上使用订阅。';

  @override
  String get guest_existingSubscriberSignIn => '已有订阅？登录';

  @override
  String get guest_claimTitle => '随时随地使用 FuzeVPN';

  @override
  String get guest_claimDescription => '创建账户，即可在其他设备上使用您的订阅。此步骤为可选项。';

  @override
  String get guest_skip => '稍后再说';

  @override
  String get guest_activationTitle => 'Fuze Premium 已激活';

  @override
  String get guest_activationDescription => '您的订阅已就绪。现在即可使用 VPN，并随时创建账户。';

  @override
  String get guest_useVpn => '使用我的 VPN';

  @override
  String get guest_loginRequired => '此购买已关联到一个 FuzeVPN 账户。请登录该账户以使用您的订阅。';

  @override
  String get guest_signOutWarning => '您可以通过同一个 Google Play 账户恢复购买，找回您的订阅。';

  @override
  String get guest_profileUnavailable => '您的账户已经关联。请登录以查看和管理您的信息。';

  @override
  String get billing_acceptance => '继续即表示您接受使用条款和隐私政策。';

  @override
  String get guest_verifyEmailReminder => '请确认您的电子邮件地址以保护账户安全。您可以继续使用 VPN。';

  @override
  String get guest_serviceUnavailable => '服务暂时不可用。请稍后重试。';

  @override
  String get guest_restoreError => '无法恢复您的购买。请使用购买时的 Google Play 账户重试。';

  @override
  String get guest_claimSuccess => '您的账户已创建。订阅和 VPN 使用权限均已保留。';

  @override
  String get guest_emailExists =>
      '此电子邮件地址已被使用。请选择其他地址或登录现有账户。您的购买仍可通过 Google Play 使用。';

  @override
  String get guest_claimError => '无法创建您的账户。您可以继续使用 VPN，并稍后重试。';

  @override
  String get guest_secureStorageError => '无法在此设备上安全保存您的会话。请重试。';

  @override
  String get guest_premiumRequired => '请选择订阅以激活您的 VPN。';

  @override
  String get welcome_viewPlans => '查看套餐';

  @override
  String get google_continue => '使用 Google 继续';

  @override
  String get google_or => '或';

  @override
  String get google_title => '您的 FuzeVPN 账户';

  @override
  String get google_settingUp => '完成账户创建';

  @override
  String get google_country => '居住国家或地区';

  @override
  String get google_profileDescription => '选择居住国家或地区并阅读两份文件，以创建 FuzeVPN 账户。';

  @override
  String get google_claimDescription => '将访客账户关联到 Google。订阅和设备仍归属于此账户。';

  @override
  String get google_linkTitle => '将 Google 关联到 FuzeVPN';

  @override
  String get google_linkDescription =>
      '确认您对现有 FuzeVPN 账户的访问权限。此步骤不会要求提供 Google 密码。';

  @override
  String get google_password => 'FuzeVPN 密码';

  @override
  String get google_linkAccount => '确认关联';

  @override
  String get google_requestEmail => '接收确认邮件';

  @override
  String get google_emailInstructions => '打开 FuzeVPN 邮件并输入确认码。';

  @override
  String get google_emailCode => '邮件确认码';

  @override
  String get google_confirmEmail => '确认代码';

  @override
  String get google_restart => '选择其他 Google 账户';

  @override
  String get google_resume => '检查此次尝试';

  @override
  String get google_unavailable => 'Google 登录不可用。您可以使用邮箱和密码。';

  @override
  String get google_expired => '此次尝试已过期。请取消后重新开始。';

  @override
  String get google_conflict => '此 Google 账户已关联到其他账户。当前账户和订阅将被保留。';

  @override
  String get google_error => 'Google 登录失败。请重试，当前访问权限将被保留。';

  @override
  String get google_uncertain => '无法确认结果。请检查此次尝试，或取消后重新开始。';

  @override
  String get google_cancelFailed => '无法确认取消操作。请在离开此页面前再次尝试取消。';

  @override
  String get google_cancelled => '已取消 Google 登录。';

  @override
  String get google_selecting => '请选择 Google 账户…';

  @override
  String get google_verifying => '正在检查账户…';

  @override
  String get google_emailUnavailable => '无法发送确认邮件。请稍后重试。';

  @override
  String get google_emailSent => '已发送确认邮件。请检查收件箱。';

  @override
  String get google_rateLimited => '请稍等后重试。';

  @override
  String get google_invalidPassword => 'FuzeVPN 密码不正确。当前账户将被保留。';

  @override
  String get google_invalidCode => '确认码无效或已过期。';

  @override
  String get google_accountChanged => '会话已更改。请取消此次尝试后重新开始。';

  @override
  String get google_invalidResponse => '无法验证响应。当前访问权限将被保留。';

  @override
  String get google_invalidRegistration => '请检查国家或地区及两项同意。';

  @override
  String get google_consentRequired => '选择居住国家或地区并同意两份文件后继续。';

  @override
  String get google_challengeRequired => '需要额外的安全验证。当前访问权限将被保留。';

  @override
  String get google_challengeUnavailable => '安全验证不可用。请稍后重试。';

  @override
  String get billing_trialTitle => '免费试用 Fuze Premium';

  @override
  String get billing_trialSubtitle => '从今天起保护您的连接。';

  @override
  String get billing_trialWeeks => '2 周免费试用';

  @override
  String billing_trialDays(String days) {
    return '$days 天免费试用';
  }

  @override
  String get billing_trialStart => '开始免费试用';

  @override
  String billing_trialFirstCharge(String date) {
    return '如果今天开始，首次扣款预计在 $date。';
  }

  @override
  String get billing_trialTerms =>
      '按所示价格自动续订。如需避免扣款，请在试用结束前通过 Google Play 取消订阅。';

  @override
  String billing_trialThenMonthly(String price) {
    return '之后每月 $price';
  }

  @override
  String billing_trialThenYearly(String price) {
    return '之后每年 $price';
  }

  @override
  String get billing_choosePeriod => '选择您的方案';

  @override
  String get billing_selectionHint => '请选择方案以继续。';

  @override
  String get billing_benefitConnection => '加密连接';

  @override
  String get billing_benefitPrivacy => '在线隐私';

  @override
  String get billing_benefitNoAccount => '无需强制注册';

  @override
  String get billing_cancellation => '通过 Google Play 取消';

  @override
  String get billing_premiumTitle => '让您的连接得到更好的保护。';

  @override
  String get billing_premiumSubtitle => '按您的需求保护连接。';

  @override
  String get billing_priceMonthly => '每月';

  @override
  String get billing_priceYearly => '每年';

  @override
  String get billing_trialToday => '今天无需付款';

  @override
  String get billing_trialConfirmation => '您确认前，Google Play 会确认日期、最终金额和适用税费。';

  @override
  String get billing_offerChanged => '此优惠的条件已更改。请刷新方案并重新选择。';
}

/// The translations for Chinese, using the Han script (`zh_Hans`).
class AppLocalizationsZhHans extends AppLocalizationsZh {
  AppLocalizationsZhHans() : super('zh_Hans');

  @override
  String get vpnDisclosure_title => '保护您的连接';

  @override
  String get vpnDisclosure_body =>
      'FuzeVPN 使用 Android 的 VPN 服务（VpnService）在此设备与 FuzeVPN 服务器之间建立加密隧道。';

  @override
  String get vpnDisclosure_dataBody =>
      'VPN 启用时，您应用的互联网流量、目标地址和 DNS 请求会通过此隧道进行连接路由，即使 FuzeVPN 在后台运行也是如此。';

  @override
  String get vpnDisclosure_statusBody =>
      '应用使用连接状态、连接时长和已传输的数据量来显示您的 VPN 连接。您可以随时停止连接。';

  @override
  String get vpnDisclosure_privacy => '隐私';

  @override
  String get vpnDisclosure_accept => '同意并继续';

  @override
  String get vpnDisclosure_decline => '暂时不用';

  @override
  String get accountRestoration_title => '账户暂时不可用';

  @override
  String get accountRestoration_message => '您的会话已保留。请重试以恢复账户；您仍可在此管理 VPN 连接。';

  @override
  String get action_retry => '重试';

  @override
  String get session_endingTitle => '正在结束会话';

  @override
  String get session_ending => '您的会话已失效。正在停止 VPN 并清除会话…';

  @override
  String get session_stopFailed => '尚未确认 VPN 已关闭。请在再次登录前重试。';

  @override
  String get session_cleanupFailed => 'VPN 已停止，但尚未确认会话已移除。请重试清理。';

  @override
  String get session_retryStop => '重试关闭';

  @override
  String get session_retryCleanup => '重试清理';

  @override
  String get appTitle => 'FuzeVPN';

  @override
  String get startup => '正在安全地准备 FuzeVPN…';

  @override
  String get nav_connection => '连接';

  @override
  String get nav_locations => '位置';

  @override
  String get nav_account => '账户';

  @override
  String get nav_devices => '设备';

  @override
  String get nav_settings => '设置';

  @override
  String get action_refresh => '刷新';

  @override
  String get auth_tab_login => '登录';

  @override
  String get auth_tab_register => '注册';

  @override
  String get auth_stepAccount => '账户';

  @override
  String get auth_stepIdentity => '身份';

  @override
  String get auth_stepAddress => '地址和协议';

  @override
  String auth_stepProgress(Object current, Object total) {
    return '第 $current 步，共 $total 步';
  }

  @override
  String get auth_tagline => '让您的 VPN 变得简单。';

  @override
  String get auth_keysLocal => '您的私有 VPN 密钥会保留在此设备上。';

  @override
  String get form_email => '电子邮件地址';

  @override
  String get form_password => '密码';

  @override
  String get form_showPassword => '显示密码';

  @override
  String get form_hidePassword => '隐藏密码';

  @override
  String get form_passwordMin => '8–72 个 UTF-8 字节。某些字符会占用多个字节。';

  @override
  String get form_firstName => '名';

  @override
  String get form_lastName => '姓';

  @override
  String get form_phone => '电话（+33612345678）';

  @override
  String get form_address => '地址';

  @override
  String get form_address2 => '地址第 2 行（可选）';

  @override
  String get form_postalCode => '邮政编码';

  @override
  String get form_city => '城市';

  @override
  String get form_country => '国家代码（例如 FR）';

  @override
  String get action_login => '登录';

  @override
  String get action_createAccount => '创建账户';

  @override
  String get action_createMyAccount => '创建我的账户';

  @override
  String get action_next => '继续';

  @override
  String get action_previous => '返回';

  @override
  String get action_forgotPassword => '忘记密码？';

  @override
  String get auth_noAccount => '还没有账户？';

  @override
  String get auth_requiredInformation => '只需三步即可创建账户。';

  @override
  String get auth_termsPrefix => '我接受';

  @override
  String get auth_termsLink => '使用条款';

  @override
  String get auth_privacyPrefix => '我接受';

  @override
  String get auth_privacyLink => '隐私政策';

  @override
  String get auth_consentRequired => '您必须同意才能创建账户。';

  @override
  String get validation_required => '此字段为必填项。';

  @override
  String get validation_email => '请输入有效的电子邮件地址。';

  @override
  String get validation_password => '密码太短：至少需要 8 个 UTF-8 字节。';

  @override
  String get validation_passwordTooLong => '密码太长：最多只能有 72 个 UTF-8 字节。';

  @override
  String get validation_phone => '请使用国际格式，例如 +33612345678。';

  @override
  String get validation_country => '请使用两位国家代码，例如 FR。';

  @override
  String get passwordReset_title => '重置密码';

  @override
  String get passwordReset_description => '请输入账户电子邮件地址以请求密码重置链接。';

  @override
  String get passwordReset_send => '发送链接';

  @override
  String get connection_title => '您的连接';

  @override
  String get connection_subtitle => '选择位置，然后开启 VPN。';

  @override
  String get connection_prepare => '准备好连接了吗？';

  @override
  String get connection_advancedOptions => '高级选项';

  @override
  String get connection_location => '位置';

  @override
  String get connection_chooseLocation => '选择位置';

  @override
  String get connection_protocol => '协议';

  @override
  String get connection_connect => '连接';

  @override
  String get connection_connecting => '正在连接…';

  @override
  String get connection_disconnect => '断开连接';

  @override
  String get connection_disconnecting => '正在断开连接';

  @override
  String get connection_locationChange => '正在更改位置…';

  @override
  String connection_unavailable(Object protocol) {
    return '$protocol 不可用';
  }

  @override
  String get connection_activeLocation => '当前活动位置';

  @override
  String get connection_duration => '持续时间';

  @override
  String get connection_received => '已接收';

  @override
  String get connection_sent => '已发送';

  @override
  String get connection_lastHandshake => '上次安全交换';

  @override
  String connection_handshakeAgo(Object duration) {
    return '$duration 前';
  }

  @override
  String get verification_title => '确认您的电子邮件地址';

  @override
  String get verification_message => '请确认您的电子邮件地址，以便在此手机上使用 VPN。';

  @override
  String get verification_resend => '重新发送电子邮件';

  @override
  String get migration_title => '更改位置';

  @override
  String get migration_draining => '正在准备更改位置…';

  @override
  String get migration_activating => '正在激活新服务器…';

  @override
  String get migration_ready => '位置已更新。';

  @override
  String get migration_blocked => '更改位置需要服务器介入。请稍后重试或联系支持人员。';

  @override
  String get migration_progress => '位置更改进度';

  @override
  String migration_retryDelay(Object seconds) {
    return '检查间隔：$seconds 秒。';
  }

  @override
  String get migration_resume => '继续更改位置';

  @override
  String get status_authorizing => '需要授权';

  @override
  String get status_authorizingDetail => '请接受 Android 请求以允许 VPN。';

  @override
  String get status_preparing => '正在准备';

  @override
  String get status_preparingDetail => '正在准备您的安全连接。';

  @override
  String get status_reconnecting => '正在重新连接…';

  @override
  String get status_reconnectingDetail => '连接已中断。VPN 正在尝试重新连接。';

  @override
  String get status_connecting => '正在连接';

  @override
  String get status_connectingDetail => '正在连接到 VPN 服务器…';

  @override
  String get status_connected => '已连接';

  @override
  String get status_connectedDetail => '您的 VPN 连接已启用。';

  @override
  String get status_disconnecting => '正在断开连接';

  @override
  String get status_disconnectingDetail => '您的 VPN 连接正在停止。';

  @override
  String get status_error => '连接不可用';

  @override
  String get status_errorDetail => '尚未确认 VPN 连接。请重试。';

  @override
  String get status_idle => '已断开连接';

  @override
  String get status_idleDetail => '连接 VPN 以保护您的连接。';

  @override
  String get trust_note => '关闭应用不会停止 VPN。如需停止，请使用“断开连接”。';

  @override
  String get locations_none => '目前没有可用的位置。';

  @override
  String get locations_available => '选择您的下一个位置。';

  @override
  String get locations_selected => '已选位置';

  @override
  String get locations_select => '选择此位置';

  @override
  String get locations_lockedTunnel => '请断开 VPN 后再更改位置。';

  @override
  String get locations_lockedMigration => '请等待位置更改完成。';

  @override
  String get devices_title => '您的设备';

  @override
  String devices_used(Object count, Object limit) {
    return '$count / $limit 台设备';
  }

  @override
  String get devices_refresh => '刷新设备';

  @override
  String get devices_empty => '尚未注册任何 VPN 设备。';

  @override
  String get devices_firstConnection => '您的手机将在首次连接时添加。';

  @override
  String get devices_thisDevice => '此设备';

  @override
  String devices_added(Object date) {
    return '添加于 $date';
  }

  @override
  String get action_remove => '移除';

  @override
  String get settings_title => '设置';

  @override
  String get settings_subtitle => '在同一处管理您的偏好设置和账户。';

  @override
  String get settings_appearance => '外观';

  @override
  String get settings_language => '语言';

  @override
  String get settings_languageDescription => '您选择的语言也会应用于 VPN 通知。';

  @override
  String get settings_account => '账户';

  @override
  String get settings_signOut => '退出登录';

  @override
  String get settings_privacy => '隐私政策';

  @override
  String get settings_terms => '使用条款';

  @override
  String get settings_security => '安全与透明度';

  @override
  String get settings_licenses => '组件许可证';

  @override
  String get settings_licensesDetail => '应用中使用的软件';

  @override
  String get settings_background => '离开应用后 VPN 仍会保持开启。如需停止，请在“连接”选项卡中使用“断开连接”。';

  @override
  String get theme_system => '跟随系统';

  @override
  String get theme_light => '浅色';

  @override
  String get theme_dark => '深色';

  @override
  String get language_system => '手机语言';

  @override
  String get language_fr => '法语';

  @override
  String get language_en => '英语';

  @override
  String get language_es => '西班牙语';

  @override
  String get language_de => '德语';

  @override
  String get dialog_removeDevice => '要移除此设备吗？';

  @override
  String get dialog_removeCurrent =>
      '此手机将断开 VPN 连接并失去访问权限。服务器确认后，此手机的 VPN 连接数据将被移除。';

  @override
  String dialog_removeOther(Object name) {
    return '将撤销“$name”的 VPN 访问权限。此操作无法撤销。';
  }

  @override
  String get dialog_signOut => '要退出登录吗？';

  @override
  String get dialog_signOutMessage =>
      'VPN 将停止，您需要重新登录。加密的 VPN 密钥会保留在此手机上，供您下次连接使用。';

  @override
  String get action_cancel => '取消';

  @override
  String get action_signOut => '退出登录';

  @override
  String get notice_close => '关闭消息';

  @override
  String get notice_sessionExpired_title => '会话已过期';

  @override
  String get notice_sessionExpired_message => '您的会话已过期。请重新登录。';

  @override
  String get notice_connectionFailed_title => '连接失败';

  @override
  String get notice_invalidCredentials_message => '电子邮件地址或密码不正确。';

  @override
  String get notice_emailVerification_title => '需要确认电子邮件';

  @override
  String get notice_emailVerification_message => '请先确认您的电子邮件地址，然后再添加 VPN 设备。';

  @override
  String get notice_rateLimited_title => '尝试次数过多';

  @override
  String get notice_deviceLimit_title => '已达到 2 台设备的上限';

  @override
  String get notice_deviceLimit_message => '请先移除现有设备，然后再添加其他设备。';

  @override
  String get notice_identityRenewal_title => '必须续订 VPN 身份';

  @override
  String get notice_identityRenewal_message => '此身份已被移除。请创建新的本地身份。';

  @override
  String get notice_migrationPending_title => '正在更改位置';

  @override
  String get notice_migrationPending_message => '位置更改已在进行中。';

  @override
  String get notice_migrationBlocked_title => '位置更改被阻止';

  @override
  String get notice_migrationBlocked_message => '更改位置需要服务器介入。请稍后重试或联系支持人员。';

  @override
  String get notice_targetUnavailable_title => '服务器暂时不可用';

  @override
  String get notice_targetUnavailable_message => '此服务器暂时不可用。';

  @override
  String get notice_networkUnavailable_title => '互联网连接不可用';

  @override
  String get notice_networkUnavailable_message => '请检查您的连接，然后重试。';

  @override
  String get notice_permissionDenied_title => 'VPN 权限被拒绝';

  @override
  String get notice_permissionDenied_message => '请重新开始连接，并接受 Android 权限请求。';

  @override
  String get notice_wireguardTimeout_title => '服务器没有响应';

  @override
  String get notice_wireguardTimeout_message => 'WireGuard 连接耗时过长。请重试或选择其他位置。';

  @override
  String get notice_tlsFailed_title => '安全连接被拒绝';

  @override
  String get notice_tlsFailed_message =>
      '服务器未接受 OpenVPN 连接。请重试。如果问题持续存在，请运行诊断。';

  @override
  String get notice_tunRejected_title => 'Android 拒绝了 VPN 接口';

  @override
  String get notice_tunRejected_message => 'Android 拒绝了 OpenVPN 请求的网络配置。';

  @override
  String get notice_openvpnStart_title => 'OpenVPN 无法启动';

  @override
  String get notice_openvpnStart_message =>
      'OpenVPN 引擎无法完成启动。请重试。如果问题仍然存在，请联系支持人员。';

  @override
  String notice_diagnosticCode(Object code) {
    return '诊断代码：$code';
  }

  @override
  String get notice_generic_title => 'VPN 连接失败';

  @override
  String get notice_generic_message => '发生错误。请稍后重试。';

  @override
  String notice_controller_title(String code) {
    String _temp0 = intl.Intl.selectLogic(code, {
      'account_created_email_unavailable': '账户已创建',
      'password_reset_sent': '已收到密码重置请求',
      'verification_email_sent': '验证邮件已发送',
      'location_migration_pending': '正在更改位置',
      'vpn_sign_in_required': '需要登录',
      'protocol_unavailable_at_location': '协议不可用',
      'vpn_permission_denied': 'VPN 权限被拒绝',
      'revoked_identity_device_limit': '已达到 2 台设备的上限',
      'tunnel_start_unexpected': 'VPN 无法启动',
      'flutter_disconnect_timeout': '未确认断开连接',
      'flutter_disconnect_unexpected': '无法断开连接',
      'device_revoked': '设备已移除',
      'revoke_unexpected': '无法移除设备',
      'identity_renewal_unexpected': '无法续订身份',
      'openvpn_renewal_unexpected': '无法续订 OpenVPN',
      'location_migration_blocked': '位置更改被阻止',
      'location_migration_slow': '位置更改仍在进行中',
      'location_migration_conflict': '位置更改需要刷新',
      'location_migration_verification_failed': '未确认位置更改',
      'location_migration_device_changed': '位置更改期间设备发生变化',
      'tunnel_stop_failed': '位置更改不可用',
      'other': '操作失败',
    });
    return '$_temp0';
  }

  @override
  String notice_controller_message(String code, String target) {
    String _temp0 = intl.Intl.selectLogic(code, {
      'account_created_email_unavailable': '账户已创建，但无法发送验证邮件。请在应用中使用重新发送功能。',
      'password_reset_sent': '已收到您的请求。如果有账户使用此地址，您可能会收到一封邮件。也请检查垃圾邮件文件夹。',
      'verification_email_sent': '新的验证邮件刚刚发送。',
      'location_migration_pending': '正在准备迁移到 $target。您可以继续迁移，无需重新创建设备。',
      'vpn_sign_in_required': '启动 VPN 前请登录您的账户。',
      'protocol_unavailable_at_location': '所选协议在此位置不可用。请刷新位置列表或选择其他协议。',
      'vpn_permission_denied': 'Android 拒绝了 VPN 权限。请重新开始连接，并接受系统请求。',
      'revoked_identity_device_limit':
          '此设备的 VPN 访问权限已被移除，并且已达到设备上限。请在“账户”→“管理我的设备”中移除一台设备。',
      'tunnel_start_unexpected': '意外错误中断了隧道准备。请查看诊断代码并重试。',
      'flutter_disconnect_timeout': 'Android 未及时确认 VPN 已停止。请再次尝试停止。',
      'flutter_disconnect_unexpected': '意外错误导致无法确认隧道已停止。',
      'device_revoked': '设备的 VPN 访问权限已被撤销，其本地密钥已移除。',
      'revoke_unexpected': '无法移除设备。请刷新列表后重试。',
      'identity_renewal_unexpected': '无法创建新的 VPN 身份。请刷新设备后重试。',
      'openvpn_renewal_unexpected': '无法续订 OpenVPN 配置文件。请重试或查看诊断代码。',
      'location_migration_blocked': '服务器目前无法完成此更改。设备及其本地身份已保留。',
      'location_migration_slow': '服务器仍在准备迁移到 $target。请稍后片刻使用“继续”。',
      'location_migration_conflict': '服务器上的设备状态发生了变化。请刷新设备，然后继续更改。',
      'location_migration_verification_failed': '服务器未确认新位置。之前的本地身份已保留。',
      'location_migration_device_changed': '服务器返回的设备与正在更改的设备不再匹配。请刷新设备后重试。',
      'tunnel_stop_failed': '建立新连接前，必须完全停止之前的隧道。',
      'other': '无法完成操作。请重试，或将诊断代码发送给支持人员。',
    });
    return '$_temp0';
  }

  @override
  String notice_api_title(String code) {
    String _temp0 = intl.Intl.selectLogic(code, {
      'unauthorized': '会话已过期',
      'invalid_credentials': '登录失败',
      'email_verification_required': '需要确认电子邮件',
      'verification_email_cooldown': '邮件已发送',
      'rate_limited': '尝试次数过多',
      'invalid_registration': '必须更正信息',
      'email_exists': '账户已存在',
      'invalid_profile': '个人资料无效',
      'invalid_device': '设备无效',
      'invalid_location': '位置不可用',
      'device_limit': '已达到设备上限',
      'device_exists': 'VPN 身份已在使用中',
      'device_identity_revoked': '必须续订 VPN 身份',
      'device_location_locked': '位置更改需要刷新',
      'location_migration_pending': '正在更改位置',
      'location_migration_blocked': '位置更改被阻止',
      'target_ca_mismatch': 'OpenVPN 服务器不兼容',
      'location_migration_conflict': '位置更改需要刷新',
      'server_full': '服务器已满',
      'capacity_unavailable': '位置暂时不可用',
      'target_unavailable': '服务器暂时不可用',
      'not_found': '未找到项目',
      'invalid_openvpn_csr': 'OpenVPN 身份无效',
      'openvpn_profile_exists': 'OpenVPN 配置文件已存在',
      'openvpn_profile_revoked': 'OpenVPN 配置文件已撤销',
      'openvpn_operation_pending': 'OpenVPN 操作正在进行中',
      'openvpn_operation_terminal': 'OpenVPN 操作已中断',
      'openvpn_address_unavailable': 'OpenVPN 地址不可用',
      'openvpn_profile_conflict': 'OpenVPN 冲突',
      'openvpn_signer_unavailable': 'OpenVPN 不可用',
      'email_delivery_unavailable': '电子邮件不可用',
      'invalid_token': '链接无效',
      'network_unavailable': '互联网连接不可用',
      'invalid_json': '请求无效',
      'invalid_api_response': '服务器响应无效',
      'ipv6_unavailable': 'IPv6 不可用',
      'invalid_ip_families': '网络配置被拒绝',
      'other': '服务不可用',
    });
    return '$_temp0';
  }

  @override
  String notice_api_message(String code) {
    String _temp0 = intl.Intl.selectLogic(code, {
      'unauthorized': '您的会话已过期。请重新登录。',
      'invalid_credentials': '电子邮件地址或密码不正确。',
      'email_verification_required': '请先确认您的电子邮件地址，然后再添加 VPN 设备。',
      'invalid_registration': '请检查所要求的信息和同意项。',
      'email_exists': '已有账户使用此电子邮件地址。',
      'invalid_profile': '请检查您的个人资料信息。',
      'invalid_device': '此设备的名称或本地身份无效。',
      'invalid_location': '请刷新位置列表后重试。',
      'device_limit': '请先移除现有设备，然后再添加其他设备。',
      'device_exists': '此 VPN 身份已关联到另一个账户。',
      'device_identity_revoked': '此身份已被移除。必须创建新的本地身份。',
      'device_location_locked': '此设备的位置刚刚更改。应用将继续进行中的更改。',
      'location_migration_pending': '位置更改已在进行中。',
      'location_migration_blocked': '更改位置需要服务器介入。请稍后重试或联系支持人员。',
      'target_ca_mismatch': '此服务器尚未与当前 OpenVPN 配置文件兼容。',
      'location_migration_conflict': '请刷新设备，然后再次尝试更改位置。',
      'server_full': '此位置已达到连接上限。请选择其他位置或稍后重试。',
      'capacity_unavailable': '我们目前无法确认此位置是否可用。请选择其他位置或稍后重试。',
      'target_unavailable': '此服务器暂时不可用。',
      'not_found': '此项目已不再属于您的账户。',
      'invalid_openvpn_csr': '请创建新的 OpenVPN 身份后重试。',
      'openvpn_profile_exists': '此设备已存在 OpenVPN 配置文件。',
      'openvpn_profile_revoked': '请续订 OpenVPN 配置文件以继续。',
      'openvpn_operation_pending': '更改仍在传播中。请稍后重试。',
      'openvpn_operation_terminal': '请创建新的 OpenVPN 身份后重试。',
      'openvpn_address_unavailable': '目前没有可用的 OpenVPN 地址。',
      'openvpn_profile_conflict': '配置文件已更改。请刷新设备后重试。',
      'openvpn_signer_unavailable': 'OpenVPN 服务暂时不可用。',
      'email_delivery_unavailable': '无法发送电子邮件。请稍后重试。',
      'invalid_token': '此链接无效或已过期。请请求新链接。',
      'network_unavailable': '请检查互联网连接后重试。',
      'invalid_json': '请检查输入的信息后重试。',
      'invalid_api_response': '服务器返回了意外响应。请稍后重试。',
      'ipv6_unavailable': '服务器目前无法启用 IPv6。请稍后重试。',
      'invalid_ip_families': '隧道配置不完整，或与已授权的地址不匹配。请从应用中重试。',
      'other': '发生服务器错误。请稍后重试。',
    });
    return '$_temp0';
  }

  @override
  String get notice_retryLater => '请过一会儿再重试。';

  @override
  String notice_retryAfter(Object seconds) {
    return '请在 $seconds 秒后重试。';
  }

  @override
  String notice_native_title(String code, String protocol) {
    String _temp0 = intl.Intl.selectLogic(code, {
      'system_vpn_resume_unavailable': '系统 VPN 恢复不可用',
      'system_vpn_resume_corrupt': '系统 VPN 恢复无效',
      'system_vpn_resume_session_invalid': 'VPN 恢复会话无效',
      'system_vpn_resume_identity_changed': 'VPN 身份已更改',
      'system_vpn_resume_identity_invalid': 'VPN 恢复身份无效',
      'system_vpn_resume_storage_failed': 'VPN 恢复存储不可用',
      'system_vpn_resume_network_timeout': 'VPN 恢复时没有网络',
      'system_vpn_resume_blocked': 'VPN 恢复被阻止',
      'system_vpn_resume_failed': 'VPN 恢复失败',
      'system_vpn_resume_error_invalid': 'VPN 恢复错误无效',
      'wireguard_identity_store_failed': 'WireGuard 身份未保存',
      'wireguard_identity_unavailable': 'WireGuard 身份不可用',
      'vpn_host_destroyed': 'Android VPN 主机已停止',
      'vpn_host_unavailable': 'Android VPN 主机不可用',
      'vpn_permission_required': '需要 VPN 权限',
      'vpn_permission_denied': 'VPN 权限被拒绝',
      'vpn_permission_request_failed': '无法请求权限',
      'wireguard_foreground_service_unavailable': 'WireGuard 服务不可用',
      'wireguard_identity_invalid': '本地 WireGuard 密钥无效',
      'wireguard_identity_in_use': 'WireGuard 身份已在使用中',
      'wireguard_configuration_invalid': 'WireGuard 配置无效',
      'wireguard_operation_pending': 'WireGuard 操作仍处于活动状态',
      'wireguard_start_failed': 'WireGuard 启动被拒绝',
      'wireguard_stop_timeout': '未确认 WireGuard 已停止',
      'wireguard_handshake_timeout': 'WireGuard 没有响应',
      'openvpn_connection_timeout': 'OpenVPN 没有响应',
      'openvpn_core_unavailable': 'OpenVPN 引擎不可用',
      'openvpn_operation_pending': 'OpenVPN 会话仍处于活动状态',
      'openvpn_stop_timeout': '未确认 OpenVPN 已停止',
      'openvpn_profile_unavailable': '缺少本地 OpenVPN 配置文件',
      'openvpn_native_failed': '原生 OpenVPN 调用已中断',
      'openvpn_key_generation_failed': '无法创建 OpenVPN P-256 密钥',
      'openvpn_csr_generation_failed': '无法创建 OpenVPN CSR',
      'openvpn_identity_store_failed': 'OpenVPN 身份未保存',
      'openvpn_identity_clear_failed': 'OpenVPN 移除不完整',
      'openvpn_identity_in_use': 'OpenVPN 身份仍在使用中',
      'openvpn_tls_verification_required': '缺少 OpenVPN TLS 验证',
      'openvpn_cipher_invalid': 'OpenVPN 加密算法无效',
      'openvpn_profile_rejected': 'OpenVPN 配置文件被拒绝',
      'openvpn_identity_inconsistent': 'OpenVPN 身份不一致',
      'tls_handshake_failed': 'OpenVPN 协商被拒绝',
      'tls_alert_unknown_ca': 'OpenVPN 客户端证书未被识别',
      'tls_alert_bad_certificate': 'OpenVPN 客户端证书被拒绝',
      'tls_alert_unsupported_certificate': '不支持的 OpenVPN 证书',
      'tls_client_certificate_required': '需要 OpenVPN 客户端证书',
      'tls_alert_misc': 'OpenVPN TLS 警报',
      'tls_signature_algorithm_rejected': '不支持的 OpenVPN 签名',
      'tls_handshake_rejected': 'OpenVPN TLS 协商被拒绝',
      'tls_version_rejected': '不兼容的 OpenVPN TLS 版本',
      'tls_certificate_expired': 'TLS 证书已过期',
      'tls_certificate_revoked': 'TLS 证书已撤销',
      'transport_failed': '无法访问 OpenVPN 服务器',
      'tun_configuration_rejected': '无法创建 OpenVPN 接口',
      'tun_setup_failed': 'OpenVPN TUN 设置失败',
      'tun_interface_create_failed': 'OpenVPN 接口创建失败',
      'tun_interface_disabled': 'OpenVPN 接口已禁用',
      'tun_halted': 'OpenVPN 接口已中断',
      'tun_already_established': 'OpenVPN 接口已经打开',
      'tun_addresses_missing': '缺少 OpenVPN 地址',
      'tun_routes_missing': '缺少 OpenVPN 路由',
      'tun_dns_missing': '缺少 OpenVPN DNS',
      'tun_permission_revoked': 'VPN 权限已撤销',
      'tun_establish_returned_null': 'Android 拒绝了 VPN 接口',
      'openvpn_service_start_failed': 'OpenVPN 服务不可用',
      'openvpn_operation_timeout': 'OpenVPN 调用超时',
      'openvpn_start_failed': 'OpenVPN 启动被拒绝',
      'openvpn_connection_failed': 'OpenVPN 连接已中断',
      'openvpn_core_status_error': 'OpenVPN Core 以错误结束',
      'openvpn_stopped_before_connected': 'OpenVPN 在连接前停止',
      'openvpn_auth_failed': 'OpenVPN 身份验证被拒绝',
      'openvpn_client_setup_failed': 'OpenVPN 客户端设置失败',
      'openvpn_client_halted': 'OpenVPN 客户端已中断',
      'openvpn_client_restart': '已请求重启 OpenVPN',
      'openvpn_inactive_timeout': 'OpenVPN 长时间未活动',
      'openvpn_session_expired': 'OpenVPN 会话已过期',
      'openvpn_credentials_required': '不支持的 OpenVPN 身份验证',
      'openvpn_proxy_failed': 'OpenVPN 中间传输失败',
      'openvpn_compression_failed': 'OpenVPN 压缩被拒绝',
      'openvpn_ntlm_crypto_unavailable': 'OpenVPN NTLM 加密不可用',
      'openvpn_feature_unsupported': '不支持的 OpenVPN 功能',
      'network_unavailable': '互联网连接不可用',
      'network_lost': '网络不可用',
      'certificate_validation_failed': '服务器证书被拒绝',
      'openvpn_certificate_expired': 'OpenVPN 证书已过期',
      'tunnel_active_for_another_account': '另一个账户的隧道仍处于活动状态',
      'tunnel_already_active': '原生隧道已处于活动状态',
      'tunnel_stop_timeout': '未确认 $protocol 已停止',
      'tunnel_disconnected': '$protocol 已中断',
      'native_bridge_unavailable': 'Android 桥接不可用',
      'native_operation_failed': 'Android 操作已中断',
      'invalid_arguments': 'VPN 参数不完整',
      'invalid_account_id': 'VPN 账户无效',
      'invalid_device_id': '设备标识符无效',
      'storage_key_not_allowed': '存储密钥被拒绝',
      'secure_storage_read_failed': '安全读取失败',
      'secure_storage_write_failed': '安全写入失败',
      'key_generation_failed': '无法生成 WireGuard 密钥',
      'csr_generation_failed': '无法生成 OpenVPN CSR',
      'other': '未分类的原生 VPN 错误',
    });
    return '$_temp0';
  }

  @override
  String notice_native_message(String code, String protocol) {
    String _temp0 = intl.Intl.selectLogic(code, {
      'system_vpn_resume_unavailable': 'Android 找不到可恢复的 VPN 会话。请在应用中开始新的连接。',
      'system_vpn_resume_corrupt': '保存的 VPN 恢复数据无效，不会使用。请开始新的连接。',
      'system_vpn_resume_session_invalid': '保存的会话无法再恢复 VPN。请在应用中重新登录。',
      'system_vpn_resume_identity_changed': '本地 VPN 身份已更改。恢复已停止；请开始新的连接。',
      'system_vpn_resume_identity_invalid': '用于恢复的身份无效。请开始新的连接。',
      'system_vpn_resume_storage_failed': 'Android 无法读取或更新加密的恢复数据。请开始新的连接。',
      'system_vpn_resume_network_timeout': 'Android 未能及时找到网络来恢复 VPN。请在网络可用时重试。',
      'system_vpn_resume_blocked': 'VPN 恢复被阻止。请检查 Android 设置，然后开始新的连接。',
      'system_vpn_resume_failed': 'Android VPN 恢复失败。请在应用中开始新的连接。',
      'system_vpn_resume_error_invalid': 'Android 返回了无法使用的恢复错误。请开始新的连接。',
      'wireguard_identity_store_failed': 'Android 无法保存此账户的加密 WireGuard 身份。',
      'wireguard_identity_unavailable': '此连接没有可用的 WireGuard 身份。',
      'vpn_host_destroyed': '托管 VPN 的 Android 组件已停止。请开始新的连接。',
      'vpn_host_unavailable': 'Android 无法创建托管 VPN 的组件。请检查 VPN 设置后重试。',
      'openvpn_renewal_required': '连接前需要在应用中对证书执行操作。',
      'openvpn_recovery_failed': '自动恢复失败。请在应用中开始新的连接。',
      'openvpn_recovery_exhausted': '自动恢复已使用过。请在应用中开始新的连接。',
      'vpn_permission_required': '启动隧道前，Android 需要新的 VPN 授权。',
      'vpn_permission_denied': '请在 Android 请求中允许 FuzeVPN 继续。',
      'vpn_permission_request_failed': 'Android 无法打开 VPN 权限页面。',
      'wireguard_foreground_service_unavailable':
          'Android 无法让 WireGuard 服务保持在前台运行。',
      'wireguard_identity_invalid': '此账户的加密 WireGuard 密钥无法读取或无效。',
      'wireguard_identity_in_use': '另一个操作仍在使用此账户的 WireGuard 密钥。',
      'wireguard_configuration_invalid': '收到的 WireGuard 地址、DNS、服务器密钥或路由无效。',
      'wireguard_operation_pending': '上一次 WireGuard 操作尚未释放其原生服务。',
      'wireguard_start_failed': 'WireGuard 引擎拒绝激活配置。',
      'wireguard_stop_timeout': 'WireGuard 服务未在规定时间内确认释放 VPN 接口。',
      'wireguard_handshake_timeout': '隧道未能及时确认与服务器的握手。',
      'openvpn_connection_timeout': 'OpenVPN 未能及时确认与服务器的连接。',
      'openvpn_core_unavailable': '此应用版本不包含可用的 OpenVPN 引擎。',
      'openvpn_operation_pending': '原生引擎仍持有之前的 OpenVPN 会话，拒绝创建第二个会话。',
      'openvpn_stop_timeout': 'OpenVPN Core 未在规定时间内确认其原生会话已停止并销毁。',
      'openvpn_profile_unavailable': '无法读取适用于此连接的已验证 OpenVPN 配置文件。',
      'openvpn_native_failed': '应用错误中断了 OpenVPN。请再次尝试连接。如果问题持续存在，请运行诊断。',
      'openvpn_key_generation_failed': 'Android 密钥库无法创建或读取不可导出的 P-256 私钥。',
      'openvpn_csr_generation_failed': 'Android 密钥库密钥无法签署 OpenVPN 证书请求。',
      'openvpn_identity_store_failed': '无法将 OpenVPN 证书或配置文件保存到加密存储中。',
      'openvpn_identity_clear_failed': 'Android 无法移除此账户的完整本地 OpenVPN 身份。',
      'openvpn_identity_in_use': '原生 OpenVPN 会话仍在使用此设备的密钥或证书。',
      'openvpn_tls_verification_required': '配置文件未明确要求验证服务器证书。',
      'openvpn_cipher_invalid': '服务器提供了不在允许列表中的加密算法。',
      'openvpn_profile_rejected': '从服务器收到的配置文件不兼容。请重新创建设备后重试。',
      'openvpn_identity_inconsistent': '证书与此手机的安全身份不匹配。未替换本地配置文件。',
      'tls_handshake_failed': '服务器拒绝了 TLS 协商。如果问题持续存在，请重新创建配置文件。',
      'tls_alert_unknown_ca': '服务器不认可此设备证书的颁发机构。必须检查 OpenVPN 服务器。',
      'tls_alert_bad_certificate': '服务器拒绝了此设备证书。请重新创建设备后重试。',
      'tls_alert_unsupported_certificate': '服务器不支持 Android 使用的安全证书类型。',
      'tls_client_certificate_required': '服务器要求客户端证书，但 OpenVPN Core 无法提供证书。',
      'tls_alert_misc': '服务器返回了不属于证书和版本类别的 TLS 警报。',
      'tls_signature_algorithm_rejected':
          '服务器拒绝了 Android 密钥库密钥的 ECDSA P-256 算法。',
      'tls_handshake_rejected': '服务器在连接前中断了 TLS 协商。',
      'tls_version_rejected': '客户端和服务器没有找到共同的 TLS 版本。',
      'tls_certificate_expired': '连接期间提供的证书已过期。',
      'tls_certificate_revoked': '连接期间提供的证书已被撤销。',
      'transport_failed': 'OpenVPN 服务器在当前网络上没有响应。请稍后重试。',
      'tun_configuration_rejected': 'Android 拒绝了 OpenVPN 请求的网络配置。',
      'tun_setup_failed': 'OpenVPN Core 在创建 Android 接口前拒绝了网络方案。',
      'tun_interface_create_failed':
          'OpenVPN Core 无法从 Android VpnService 获取 TUN 接口。',
      'tun_interface_disabled': 'Android 或 OpenVPN Core 在连接期间禁用了 TUN 接口。',
      'tun_halted': 'OpenVPN Core 收到了停止 TUN 接口的请求。',
      'tun_already_established': 'OpenVPN 在同一连接中请求了第二个接口。为安全起见，隧道已停止。',
      'tun_addresses_missing': '服务器未提供可用的隧道地址。',
      'tun_routes_missing': '服务器未提供可用的隧道路由。',
      'tun_dns_missing': '服务器未提供可用的 DNS 服务器。',
      'tun_permission_revoked': 'Android 在连接期间撤销了 VPN 权限。',
      'tun_establish_returned_null': 'Android 未创建接口，通常是因为另一个 VPN 仍处于活动状态。',
      'openvpn_service_start_failed': 'Android 无法启动 OpenVPN 前台服务。',
      'openvpn_operation_timeout': '对 OpenVPN Core 的 JNI 调用超过了最长持续时间。',
      'openvpn_start_failed': 'Android 服务已准备就绪，但 OpenVPN Core 不接受启动配置文件。',
      'openvpn_connection_failed': 'OpenVPN Core 在发出 CONNECTED 事件前停止。',
      'openvpn_core_status_error': '原生 OpenVPN 循环以错误结束，且没有更具体的终止事件。',
      'openvpn_stopped_before_connected':
          '原生 OpenVPN 循环在 CONNECTED 之前停止，Core 未报告明确错误。',
      'openvpn_auth_failed': 'OpenVPN 服务器拒绝了配置文件身份验证。',
      'openvpn_client_setup_failed': 'OpenVPN Core 无法在网络连接前初始化客户端。',
      'openvpn_client_halted': 'OpenVPN Core 收到了终止客户端的请求。',
      'openvpn_client_restart': 'OpenVPN Core 请求重启其传输会话。',
      'openvpn_inactive_timeout': 'OpenVPN Core 在无活动超时后关闭了会话。',
      'openvpn_session_expired': '服务器报告 OpenVPN 会话已过期。',
      'openvpn_credentials_required': '服务器或代理请求交互式凭据，而此证书配置文件不包含这些凭据。',
      'openvpn_proxy_failed': 'OpenVPN Core 报告配置的代理或中继失败。',
      'openvpn_compression_failed': 'OpenVPN Core 拒绝了配置文件或服务器声明的压缩模式。',
      'openvpn_ntlm_crypto_unavailable': '配置文件请求的 NTLM 加密在此版本中不可用。',
      'openvpn_feature_unsupported': '配置文件或服务器需要此 Android 客户端缺少的功能。',
      'network_unavailable': '没有可用的物理网络。',
      'network_lost': '网络丢失后隧道已停止。',
      'certificate_validation_failed': '无法验证 OpenVPN 服务器身份。',
      'openvpn_certificate_expired': '重新连接前请续订 OpenVPN 配置文件。',
      'tunnel_active_for_another_account': '属于另一个账户的隧道必须先停止，才能进行此连接。',
      'tunnel_already_active': 'Android 报告之前的 VPN 会话仍在使用此接口。',
      'tunnel_stop_timeout': '$protocol 引擎未在规定时间内确认释放 VPN 接口。',
      'tunnel_disconnected': '原生引擎报告隧道启动后意外结束。',
      'native_bridge_unavailable': '应用无法访问 Android VPN 服务。请关闭并重新打开应用，然后重试。',
      'native_operation_failed': '应用错误中断了 VPN 操作。请重试。如果问题持续存在，请运行诊断。',
      'invalid_arguments': '此 VPN 操作所需的信息不完整。请重试。如果问题持续存在，请运行诊断。',
      'invalid_account_id': '原生操作未关联有效的账户标识符。',
      'invalid_device_id': '发送给原生引擎的设备标识符缺失或无效。',
      'storage_key_not_allowed': 'Android 桥接阻止了允许存储列表之外的密钥。',
      'secure_storage_read_failed': 'Android 密钥库无法解密此账户的本地数据。',
      'secure_storage_write_failed': 'Android 密钥库无法加密或保存本地数据。',
      'key_generation_failed': 'Android 无法在安全存储中创建或读取 WireGuard 密钥。',
      'csr_generation_failed': 'Android 密钥库无法创建或签署 OpenVPN P-256 CSR。',
      'other': '未记录的原生分支失败。请将下方显示的诊断代码发送给支持人员。',
    });
    return '$_temp0';
  }

  @override
  String get notice_permissionRequestInProgress_title => '权限请求已打开';

  @override
  String get notice_permissionRequestInProgress_message =>
      'Android VPN 权限请求已显示。请完成请求后再重试。';

  @override
  String get notice_permissionRequestInterrupted_title => 'VPN 权限请求已中断';

  @override
  String get notice_permissionRequestInterrupted_message =>
      '应用收到响应前，VPN 权限页面已关闭。';

  @override
  String get notice_openvpnProofMissing_title => '未确认 OpenVPN 连接';

  @override
  String get notice_openvpnProofMissing_message =>
      '无法确认 OpenVPN 连接。为安全起见，连接已停止。请重试。';

  @override
  String get openvpnCleanup_title => 'OpenVPN 配置文件已撤销';

  @override
  String get openvpnCleanup_working => '正在停止并移除已撤销的 OpenVPN 配置文件…';

  @override
  String get openvpnCleanup_stopFailed => '尚未确认 OpenVPN 已关闭。请在创建新配置文件前重试。';

  @override
  String get openvpnCleanup_cleanupFailed => '无法完全移除已撤销的 OpenVPN 配置文件。请重试清理。';

  @override
  String get openvpnCleanup_complete => '已移除已撤销的 OpenVPN 配置文件。点击“连接”以创建新的配置文件。';

  @override
  String get network_title => '网络配置';

  @override
  String get network_ipv4Fallback => 'IPv6 暂时不可用。正在使用 IPv4 继续准备。';

  @override
  String get network_rejectedTitle => '网络配置被拒绝';

  @override
  String get network_rejectedMessage => '隧道配置不完整，或与已授权的地址不匹配。请从应用中重试。';

  @override
  String get network_unreadableTitle => '无法读取本地配置';

  @override
  String get network_unreadableMessage => '保存的 OpenVPN 网络配置无法使用。请从应用重新连接以更新配置。';

  @override
  String get network_ipv4 => 'IPv4';

  @override
  String get network_dualStack => 'IPv4 + IPv6';

  @override
  String get protection_title => '网络保护';

  @override
  String get protection_subtitle => '如果 VPN 断开连接，则阻止直接访问互联网。';

  @override
  String get protection_active => '系统保护已启用';

  @override
  String get protection_alwaysOnOnly => '始终开启 VPN 已启用；请开启 VPN 外部连接阻止功能';

  @override
  String get protection_inactive => '系统保护未启用';

  @override
  String get protection_unknown => '检查系统保护';

  @override
  String get protection_openSettings => '打开 Android 设置';

  @override
  String get protection_dialogTitle => '设置网络保护';

  @override
  String get protection_dialogMessage =>
      'Android 管理始终开启的 VPN 以及 VPN 外部的连接阻止功能。请确认已选择 FuzeVPN，并在系统设置中启用阻止功能。';

  @override
  String get protection_dialogOpen => '打开设置';

  @override
  String get session_systemProtectionNote =>
      '如果 Android 仍在阻止 VPN 外部的流量，请打开系统设置检查或更改此保护功能。';

  @override
  String get diagnostics_title => '诊断';

  @override
  String get diagnostics_settingsTitle => '应用诊断';

  @override
  String get diagnostics_automaticTitle => '发送重要错误';

  @override
  String get diagnostics_automaticDescription => '发生重要错误时分享一份简短的技术报告。';

  @override
  String get diagnostics_privacy =>
      '发送的报告会关联到已登录的账户，并保留 30 天。报告不包含浏览历史、密码或 VPN 密钥。';

  @override
  String get diagnostics_manualOpen => '运行诊断';

  @override
  String get diagnostics_localDescription => '创建应用和 VPN 状态报告。您的连接不会改变。';

  @override
  String get diagnostics_sendReport => '发送报告';

  @override
  String get diagnostics_sendHint => '取消选中此框可将报告保留在此设备上。';

  @override
  String get diagnostics_signedOut => '登录账户后即可发送报告。';

  @override
  String get diagnostics_localLifetime => '将此报告保存到手机上，以便关闭应用后仍能保留。';

  @override
  String get diagnostics_run => '运行诊断';

  @override
  String get diagnostics_rerun => '再次运行诊断';

  @override
  String get diagnostics_running => '正在检查…';

  @override
  String get diagnostics_sending => '正在发送报告…';

  @override
  String get diagnostics_prepared => '报告已在此设备上准备就绪';

  @override
  String get diagnostics_queued => '报告等待发送';

  @override
  String get diagnostics_sent => '报告已收到';

  @override
  String get diagnostics_failed => '发送失败。本地报告仍可用。';

  @override
  String get diagnostics_preparationFailed => '无法准备诊断报告。请重试。';

  @override
  String get diagnostics_authenticationRequired => '请重新登录以发送报告。';

  @override
  String get diagnostics_retry => '重试发送';

  @override
  String get diagnostics_export => '保存报告';

  @override
  String get diagnostics_exportFailed => '导出失败。请从本地报告重试。';

  @override
  String get diagnostics_preferenceFailed => '无法保存此设置。请重试。';

  @override
  String diagnostics_receipt(Object id) {
    return '参考编号：$id';
  }

  @override
  String diagnostics_received(Object date) {
    return '接收于 $date';
  }

  @override
  String diagnostics_expires(Object date) {
    return '保留至 $date';
  }

  @override
  String get diagnostics_duplicate => '此报告此前已经收到。';

  @override
  String get diagnostics_preview => '报告预览';

  @override
  String diagnostics_eventCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '附加了 $count 个技术事件',
      one: '附加了 1 个技术事件',
      zero: '没有附加技术事件',
    );
    return '$_temp0';
  }

  @override
  String get diagnostics_technical => '技术详情';

  @override
  String get diagnostics_empty => '尚未准备任何诊断报告。';

  @override
  String diagnostics_checkName(String id) {
    String _temp0 = intl.Intl.selectLogic(id, {
      'tunnel_connection': '隧道状态',
      'handshake': '连接确认',
      'certificate': 'VPN 证书',
      'kill_switch': 'Android 保护',
      'connectivity': '可用网络',
      'api_reachability': '服务访问',
      'secure_storage': '安全存储',
      'other': '本地检查',
    });
    return '$_temp0';
  }

  @override
  String diagnostics_checkResult(String result) {
    String _temp0 = intl.Intl.selectLogic(result, {
      'passed': '已检查',
      'failed': '需要处理',
      'skipped': '未测试——没有活动探针',
      'unknown': '信息不可用',
      'other': '信息不可用',
    });
    return '$_temp0';
  }

  @override
  String get auth_welcome => '欢迎使用 FuzeVPN';

  @override
  String get connection_changeLocation => '更改位置';

  @override
  String get connection_details => '连接详情';

  @override
  String get locations_searchLabel => '搜索城市或国家';

  @override
  String get locations_clearSearch => '清除搜索';

  @override
  String get locations_filterAll => '全部';

  @override
  String get locations_filterFavorites => '收藏';

  @override
  String locations_results(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count 个位置',
      one: '$count 个位置',
    );
    return '$_temp0';
  }

  @override
  String get locations_noResults => '未找到位置';

  @override
  String get locations_noResultsHint => '请尝试其他城市或国家。';

  @override
  String get locations_noFavorites => '您的收藏，触手可及';

  @override
  String get locations_noFavoritesHint => '点击位置旁边的星标即可将其保存到这里。';

  @override
  String get locations_showAll => '查看所有位置';

  @override
  String locations_addFavorite(String name) {
    return '将 $name 添加到收藏';
  }

  @override
  String locations_removeFavorite(String name) {
    return '从收藏中移除 $name';
  }

  @override
  String get locations_favoriteSaveFailed => '无法保存收藏。请重试。';

  @override
  String get locations_emptyTitle => '没有可用的位置';

  @override
  String get locations_emptyHint => '刷新列表后重试。';

  @override
  String get devices_manage => '管理我的设备';

  @override
  String get settings_personalization => '个性化设置';

  @override
  String get settings_safety => '保护';

  @override
  String get settings_help => '需要帮助？';

  @override
  String get settings_about => '关于 FuzeVPN';

  @override
  String get diagnostics_heading => '了解连接问题';

  @override
  String devices_profileStatus(String status) {
    String _temp0 = intl.Intl.selectLogic(status, {
      'active': '可用',
      'pending': '正在准备',
      'revoked': '已移除',
      'expired': '已过期',
      'other': '状态不可用',
    });
    return '$_temp0';
  }

  @override
  String get notice_preferenceSave_title => '偏好设置未保存';

  @override
  String get notice_preferenceSave_message =>
      '您的选择目前已应用，但无法保存。请重试，以便关闭应用后仍保留该选择。';

  @override
  String get connection_androidDisconnectHint =>
      '如果 Android 仍保持 VPN 活跃，请在打开的设置中关闭“始终开启的 VPN”。';

  @override
  String get protection_learnMore => '了解 Android 保护功能';

  @override
  String get protection_guideWhy =>
      '如果 VPN 断开连接，此保护功能会阻止应用直接使用互联网。它在 Android 中配置。';

  @override
  String get protection_guideAlwaysOnTitle => '始终开启的 VPN';

  @override
  String get protection_guideAlwaysOn =>
      'Android 会保持 VPN 服务运行，并可在手机重启后重新启动该服务。';

  @override
  String get protection_guideBlockTitle => '阻止无 VPN 连接';

  @override
  String get protection_guideBlock => '此设置会阻止流量绕过 VPN，包括连接中断期间的流量。';

  @override
  String get protection_guideWarning => '启用此阻止功能后，互联网访问会保持关闭，直到 VPN 连接成功。';

  @override
  String get protection_guideStepsTitle => '开启保护';

  @override
  String get protection_guideStep1 => '使用下方按钮打开 Android VPN 设置。';

  @override
  String get protection_guideStep2 => '点击 FuzeVPN 旁边的齿轮图标打开选项。';

  @override
  String get protection_guideStep3 =>
      '启用“始终开启的 VPN”，然后启用“阻止无 VPN 连接”（如果这些选项可用）。';

  @override
  String get protection_guideManufacturers =>
      '不同手机上的名称可能不同。如有需要，请在“设置”中搜索 VPN，通常位于“网络和互联网”下。';

  @override
  String get protection_guideDisableTitle => '关闭此保护功能';

  @override
  String get protection_guideDisable =>
      '在相同设置中关闭无 VPN 阻止功能，以允许在没有 VPN 时访问互联网。如果不再希望 Android 自动重启 VPN，也请关闭“始终开启的 VPN”。';

  @override
  String get protection_guideManual => '这些设置由您在 Android 中选择。FuzeVPN 不会替您更改。';

  @override
  String get locations_changeTitle => '要更改位置吗？';

  @override
  String locations_changeActive(String name) {
    return 'VPN 将断开连接，然后尝试连接到 $name。';
  }

  @override
  String locations_changeIdle(String name) {
    return 'VPN 将尝试连接到 $name。';
  }

  @override
  String get locations_confirmChange => '更改并连接';

  @override
  String get locations_changeBusy => '更改正在进行中。请等待后再选择其他位置。';

  @override
  String get locations_automaticSelection => '自动选择';

  @override
  String get locations_cities => '城市';

  @override
  String get locations_servers => '服务器';

  @override
  String locations_viewCities(String name) {
    return '查看 $name 中的城市';
  }

  @override
  String locations_viewServers(String name) {
    return '查看 $name 中的服务器';
  }

  @override
  String locations_countryCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count 个国家',
      one: '$count 个国家',
    );
    return '$_temp0';
  }

  @override
  String locations_cityCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count 个城市',
      one: '$count 个城市',
    );
    return '$_temp0';
  }

  @override
  String locations_serverCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count 台服务器',
      one: '$count 台服务器',
    );
    return '$_temp0';
  }

  @override
  String get locations_allCountries => '所有国家';

  @override
  String get locations_backToCountries => '返回国家列表';

  @override
  String locations_backToCities(String name) {
    return '返回 $name 中的城市';
  }

  @override
  String locations_chooseCountry(String name) {
    return '选择 $name';
  }

  @override
  String locations_chooseCity(String name) {
    return '选择 $name';
  }

  @override
  String get locations_noCompatibleServer => '没有可用的兼容服务器。';

  @override
  String get externalLink_failed => '无法打开此链接。您可以复制链接并在浏览器中打开。';

  @override
  String get externalLink_copy => '复制链接';

  @override
  String get externalLink_copied => '链接已复制';

  @override
  String get externalLink_copyFailed => '无法复制链接。请选择下方地址。';

  @override
  String get settings_deleteAccount => '删除我的账户';

  @override
  String get settings_deleteAccountDetail => '查看申请删除账户的流程';

  @override
  String get billing_title => 'Fuze Premium';

  @override
  String get billing_subtitle => '选择您的 VPN 订阅。';

  @override
  String get billing_subscribe => '订阅';

  @override
  String get billing_choosePlan => '选择方案以继续。';

  @override
  String get billing_monthly => '月付';

  @override
  String get billing_yearly => '年付';

  @override
  String get billing_continue => '通过 Google Play 继续';

  @override
  String get billing_restore => '恢复购买';

  @override
  String get billing_manage => '管理订阅';

  @override
  String get billing_deleteAccountWarning =>
      '如果您通过 Google Play 订阅，删除 FuzeVPN 账户不会取消该订阅的续订。请在 Google Play 中单独管理或取消续订。';

  @override
  String get billing_deleteAccountContinue => '继续申请删除账户';

  @override
  String get billing_refresh => '刷新访问权限';

  @override
  String get billing_loadingPlans => '正在加载方案…';

  @override
  String get billing_unavailable => '目前没有可用方案。请稍后重试。';

  @override
  String get billing_comingSoon => '订阅即将推出。';

  @override
  String get billing_priceDisclosure => '价格由 Google Play 提供。您确认前会显示最终金额和适用税费。';

  @override
  String get billing_renewalMonthly =>
      '除非取消，否则每月自动续订。您可以随时在 Google Play 订阅中取消。';

  @override
  String get billing_renewalYearly => '除非取消，否则每年自动续订。您可以随时在 Google Play 订阅中取消。';

  @override
  String get billing_active => '您的 Premium 访问权限已生效';

  @override
  String billing_accessUntil(String date) {
    return '可使用至 $date。';
  }

  @override
  String get billing_webManaged => '您的订阅在 FuzeVPN 网站上管理。';

  @override
  String get billing_playManaged => '您的订阅通过 Google Play 管理。';

  @override
  String get billing_inactive => '没有生效的订阅。';

  @override
  String get billing_checkingAccess => '正在检查您的访问权限…';

  @override
  String get billing_restoring => '正在恢复购买…';

  @override
  String get billing_pending => '付款待处理。确认后将开通访问权限。';

  @override
  String get billing_cancelled => '购买已取消。未开通新的订阅。';

  @override
  String get billing_verifying => '正在验证购买…';

  @override
  String get billing_success => '订阅已开通。您现在可以使用 Premium。';

  @override
  String get billing_restored => '您的购买已恢复。';

  @override
  String get billing_restoreEmpty => '此 Google Play 账号没有可恢复的购买。';

  @override
  String get billing_catalogError => '无法加载方案。请重试。';

  @override
  String get billing_purchaseError => '无法开始购买。请重试。';

  @override
  String get billing_verificationError => '购买验证暂时不可用。请恢复购买以重试。';

  @override
  String get billing_restoreError => '无法恢复购买。请重试。';

  @override
  String get billing_managementError => '无法打开订阅管理。请重试。';

  @override
  String get billing_storeUnavailable => '此设备无法使用 Google Play。';

  @override
  String get welcome_title => '您的 VPN，简单易用。';

  @override
  String get welcome_description => '保护您的连接。掌控您的隐私。';

  @override
  String get welcome_start => '开始使用';

  @override
  String get welcome_alreadyPurchased => '已购买？';

  @override
  String get welcome_noAccountRequired => '无需创建账户即可开始。';

  @override
  String get guest_accountTitle => '账户尚未关联';

  @override
  String get guest_accountDescription =>
      '使用同一个 Google Play 账户恢复购买，即可在其他设备上使用订阅。';

  @override
  String get guest_existingSubscriberSignIn => '已有订阅？登录';

  @override
  String get guest_claimTitle => '随时随地使用 FuzeVPN';

  @override
  String get guest_claimDescription => '创建账户，即可在其他设备上使用您的订阅。此步骤为可选项。';

  @override
  String get guest_skip => '稍后再说';

  @override
  String get guest_activationTitle => 'Fuze Premium 已激活';

  @override
  String get guest_activationDescription => '您的订阅已就绪。现在即可使用 VPN，并随时创建账户。';

  @override
  String get guest_useVpn => '使用我的 VPN';

  @override
  String get guest_loginRequired => '此购买已关联到一个 FuzeVPN 账户。请登录该账户以使用您的订阅。';

  @override
  String get guest_signOutWarning => '您可以通过同一个 Google Play 账户恢复购买，找回您的订阅。';

  @override
  String get guest_profileUnavailable => '您的账户已经关联。请登录以查看和管理您的信息。';

  @override
  String get billing_acceptance => '继续即表示您接受使用条款和隐私政策。';

  @override
  String get guest_verifyEmailReminder => '请确认您的电子邮件地址以保护账户安全。您可以继续使用 VPN。';

  @override
  String get guest_serviceUnavailable => '服务暂时不可用。请稍后重试。';

  @override
  String get guest_restoreError => '无法恢复您的购买。请使用购买时的 Google Play 账户重试。';

  @override
  String get guest_claimSuccess => '您的账户已创建。订阅和 VPN 使用权限均已保留。';

  @override
  String get guest_emailExists =>
      '此电子邮件地址已被使用。请选择其他地址或登录现有账户。您的购买仍可通过 Google Play 使用。';

  @override
  String get guest_claimError => '无法创建您的账户。您可以继续使用 VPN，并稍后重试。';

  @override
  String get guest_secureStorageError => '无法在此设备上安全保存您的会话。请重试。';

  @override
  String get guest_premiumRequired => '请选择订阅以激活您的 VPN。';

  @override
  String get welcome_viewPlans => '查看套餐';

  @override
  String get google_continue => '使用 Google 继续';

  @override
  String get google_or => '或';

  @override
  String get google_title => '您的 FuzeVPN 账户';

  @override
  String get google_settingUp => '完成账户创建';

  @override
  String get google_country => '居住国家或地区';

  @override
  String get google_profileDescription => '选择居住国家或地区并阅读两份文件，以创建 FuzeVPN 账户。';

  @override
  String get google_claimDescription => '将访客账户关联到 Google。订阅和设备仍归属于此账户。';

  @override
  String get google_linkTitle => '将 Google 关联到 FuzeVPN';

  @override
  String get google_linkDescription =>
      '确认您对现有 FuzeVPN 账户的访问权限。此步骤不会要求提供 Google 密码。';

  @override
  String get google_password => 'FuzeVPN 密码';

  @override
  String get google_linkAccount => '确认关联';

  @override
  String get google_requestEmail => '接收确认邮件';

  @override
  String get google_emailInstructions => '打开 FuzeVPN 邮件并输入确认码。';

  @override
  String get google_emailCode => '邮件确认码';

  @override
  String get google_confirmEmail => '确认代码';

  @override
  String get google_restart => '选择其他 Google 账户';

  @override
  String get google_resume => '检查此次尝试';

  @override
  String get google_unavailable => 'Google 登录不可用。您可以使用邮箱和密码。';

  @override
  String get google_expired => '此次尝试已过期。请取消后重新开始。';

  @override
  String get google_conflict => '此 Google 账户已关联到其他账户。当前账户和订阅将被保留。';

  @override
  String get google_error => 'Google 登录失败。请重试，当前访问权限将被保留。';

  @override
  String get google_uncertain => '无法确认结果。请检查此次尝试，或取消后重新开始。';

  @override
  String get google_cancelFailed => '无法确认取消操作。请在离开此页面前再次尝试取消。';

  @override
  String get google_cancelled => '已取消 Google 登录。';

  @override
  String get google_selecting => '请选择 Google 账户…';

  @override
  String get google_verifying => '正在检查账户…';

  @override
  String get google_emailUnavailable => '无法发送确认邮件。请稍后重试。';

  @override
  String get google_emailSent => '已发送确认邮件。请检查收件箱。';

  @override
  String get google_rateLimited => '请稍等后重试。';

  @override
  String get google_invalidPassword => 'FuzeVPN 密码不正确。当前账户将被保留。';

  @override
  String get google_invalidCode => '确认码无效或已过期。';

  @override
  String get google_accountChanged => '会话已更改。请取消此次尝试后重新开始。';

  @override
  String get google_invalidResponse => '无法验证响应。当前访问权限将被保留。';

  @override
  String get google_invalidRegistration => '请检查国家或地区及两项同意。';

  @override
  String get google_consentRequired => '选择居住国家或地区并同意两份文件后继续。';

  @override
  String get google_challengeRequired => '需要额外的安全验证。当前访问权限将被保留。';

  @override
  String get google_challengeUnavailable => '安全验证不可用。请稍后重试。';

  @override
  String get billing_trialTitle => '免费试用 Fuze Premium';

  @override
  String get billing_trialSubtitle => '从今天起保护您的连接。';

  @override
  String get billing_trialWeeks => '2 周免费试用';

  @override
  String billing_trialDays(String days) {
    return '$days 天免费试用';
  }

  @override
  String get billing_trialStart => '开始免费试用';

  @override
  String billing_trialFirstCharge(String date) {
    return '如果今天开始，首次扣款预计在 $date。';
  }

  @override
  String get billing_trialTerms =>
      '按所示价格自动续订。如需避免扣款，请在试用结束前通过 Google Play 取消订阅。';

  @override
  String billing_trialThenMonthly(String price) {
    return '之后每月 $price';
  }

  @override
  String billing_trialThenYearly(String price) {
    return '之后每年 $price';
  }

  @override
  String get billing_choosePeriod => '选择您的方案';

  @override
  String get billing_selectionHint => '请选择方案以继续。';

  @override
  String get billing_benefitConnection => '加密连接';

  @override
  String get billing_benefitPrivacy => '在线隐私';

  @override
  String get billing_benefitNoAccount => '无需强制注册';

  @override
  String get billing_cancellation => '通过 Google Play 取消';

  @override
  String get billing_premiumTitle => '让您的连接得到更好的保护。';

  @override
  String get billing_premiumSubtitle => '按您的需求保护连接。';

  @override
  String get billing_priceMonthly => '每月';

  @override
  String get billing_priceYearly => '每年';

  @override
  String get billing_trialToday => '今天无需付款';

  @override
  String get billing_trialConfirmation => '您确认前，Google Play 会确认日期、最终金额和适用税费。';

  @override
  String get billing_offerChanged => '此优惠的条件已更改。请刷新方案并重新选择。';
}

/// The translations for Chinese, using the Han script (`zh_Hant`).
class AppLocalizationsZhHant extends AppLocalizationsZh {
  AppLocalizationsZhHant() : super('zh_Hant');

  @override
  String get vpnDisclosure_title => '保護您的連線';

  @override
  String get vpnDisclosure_body =>
      'FuzeVPN 使用 Android 的 VPN 服務（VpnService），在此裝置與 FuzeVPN 伺服器之間建立加密通道。';

  @override
  String get vpnDisclosure_dataBody =>
      'VPN 啟用時，您應用程式的網際網路流量、目的地位址與 DNS 請求會透過此通道進行連線路由，即使 FuzeVPN 在背景執行也是如此。';

  @override
  String get vpnDisclosure_statusBody =>
      '應用程式使用連線狀態、連線時間與已傳輸的資料量來顯示您的 VPN 連線。您可以隨時停止連線。';

  @override
  String get vpnDisclosure_privacy => '隱私權';

  @override
  String get vpnDisclosure_accept => '同意並繼續';

  @override
  String get vpnDisclosure_decline => '暫時不要';

  @override
  String get accountRestoration_title => '帳戶暫時無法使用';

  @override
  String get accountRestoration_message => '您的工作階段已保留。請重試以還原帳戶；您仍可在此管理 VPN 連線。';

  @override
  String get action_retry => '重試';

  @override
  String get session_endingTitle => '正在結束工作階段';

  @override
  String get session_ending => '您的工作階段已失效。正在停止 VPN 並清除工作階段…';

  @override
  String get session_stopFailed => '尚未確認 VPN 已關閉。請在再次登入前重試。';

  @override
  String get session_cleanupFailed => 'VPN 已停止，但尚未確認工作階段已移除。請重試清除作業。';

  @override
  String get session_retryStop => '重試關閉';

  @override
  String get session_retryCleanup => '重試清除';

  @override
  String get appTitle => 'FuzeVPN';

  @override
  String get startup => '正在安全地準備 FuzeVPN…';

  @override
  String get nav_connection => '連線';

  @override
  String get nav_locations => '位置';

  @override
  String get nav_account => '帳戶';

  @override
  String get nav_devices => '裝置';

  @override
  String get nav_settings => '設定';

  @override
  String get action_refresh => '重新整理';

  @override
  String get auth_tab_login => '登入';

  @override
  String get auth_tab_register => '註冊';

  @override
  String get auth_stepAccount => '帳戶';

  @override
  String get auth_stepIdentity => '身分';

  @override
  String get auth_stepAddress => '地址與協議';

  @override
  String auth_stepProgress(Object current, Object total) {
    return '第 $current 步，共 $total 步';
  }

  @override
  String get auth_tagline => '讓您的 VPN 變得簡單。';

  @override
  String get auth_keysLocal => '您的私人 VPN 金鑰會留在此裝置上。';

  @override
  String get form_email => '電子郵件地址';

  @override
  String get form_password => '密碼';

  @override
  String get form_showPassword => '顯示密碼';

  @override
  String get form_hidePassword => '隱藏密碼';

  @override
  String get form_passwordMin => '8–72 個 UTF-8 位元組。某些字元會使用多個位元組。';

  @override
  String get form_firstName => '名字';

  @override
  String get form_lastName => '姓氏';

  @override
  String get form_phone => '電話（+33612345678）';

  @override
  String get form_address => '地址';

  @override
  String get form_address2 => '地址第 2 行（選填）';

  @override
  String get form_postalCode => '郵遞區號';

  @override
  String get form_city => '城市';

  @override
  String get form_country => '國家代碼（例如 FR）';

  @override
  String get action_login => '登入';

  @override
  String get action_createAccount => '建立帳戶';

  @override
  String get action_createMyAccount => '建立我的帳戶';

  @override
  String get action_next => '繼續';

  @override
  String get action_previous => '返回';

  @override
  String get action_forgotPassword => '忘記密碼？';

  @override
  String get auth_noAccount => '還沒有帳戶嗎？';

  @override
  String get auth_requiredInformation => '只需三個步驟即可建立帳戶。';

  @override
  String get auth_termsPrefix => '我接受';

  @override
  String get auth_termsLink => '使用條款';

  @override
  String get auth_privacyPrefix => '我接受';

  @override
  String get auth_privacyLink => '隱私權政策';

  @override
  String get auth_consentRequired => '您必須同意才能建立帳戶。';

  @override
  String get validation_required => '此欄位為必填。';

  @override
  String get validation_email => '請輸入有效的電子郵件地址。';

  @override
  String get validation_password => '密碼太短：至少需要 8 個 UTF-8 位元組。';

  @override
  String get validation_passwordTooLong => '密碼太長：最多只能有 72 個 UTF-8 位元組。';

  @override
  String get validation_phone => '請使用國際格式，例如 +33612345678。';

  @override
  String get validation_country => '請使用兩個字母的國家代碼，例如 FR。';

  @override
  String get passwordReset_title => '重設密碼';

  @override
  String get passwordReset_description => '輸入您帳戶的電子郵件地址，以要求取得密碼重設連結。';

  @override
  String get passwordReset_send => '傳送連結';

  @override
  String get connection_title => '您的連線';

  @override
  String get connection_subtitle => '選擇位置，然後開啟 VPN。';

  @override
  String get connection_prepare => '準備好連線了嗎？';

  @override
  String get connection_advancedOptions => '進階選項';

  @override
  String get connection_location => '位置';

  @override
  String get connection_chooseLocation => '選擇位置';

  @override
  String get connection_protocol => '通訊協定';

  @override
  String get connection_connect => '連線';

  @override
  String get connection_connecting => '正在連線…';

  @override
  String get connection_disconnect => '中斷連線';

  @override
  String get connection_disconnecting => '正在中斷連線';

  @override
  String get connection_locationChange => '正在變更位置…';

  @override
  String connection_unavailable(Object protocol) {
    return '$protocol 無法使用';
  }

  @override
  String get connection_activeLocation => '目前位置';

  @override
  String get connection_duration => '持續時間';

  @override
  String get connection_received => '已接收';

  @override
  String get connection_sent => '已傳送';

  @override
  String get connection_lastHandshake => '上次安全交換';

  @override
  String connection_handshakeAgo(Object duration) {
    return '$duration前';
  }

  @override
  String get verification_title => '確認您的電子郵件地址';

  @override
  String get verification_message => '確認您的電子郵件地址，以便在此手機上使用 VPN。';

  @override
  String get verification_resend => '重新傳送電子郵件';

  @override
  String get migration_title => '位置變更';

  @override
  String get migration_draining => '正在準備變更位置…';

  @override
  String get migration_activating => '正在啟用新伺服器…';

  @override
  String get migration_ready => '位置已更新。';

  @override
  String get migration_blocked => '變更位置需要伺服器介入。請稍後再試或聯絡支援人員。';

  @override
  String get migration_progress => '位置變更進度';

  @override
  String migration_retryDelay(Object seconds) {
    return '檢查間隔：$seconds 秒。';
  }

  @override
  String get migration_resume => '繼續變更位置';

  @override
  String get status_authorizing => '需要權限';

  @override
  String get status_authorizingDetail => '接受 Android 要求，以允許 VPN。';

  @override
  String get status_preparing => '準備中';

  @override
  String get status_preparingDetail => '正在準備您的安全連線。';

  @override
  String get status_reconnecting => '正在重新連線…';

  @override
  String get status_reconnectingDetail => '連線已中斷。VPN 正在嘗試重新連線。';

  @override
  String get status_connecting => '連線中';

  @override
  String get status_connectingDetail => '正在連線至 VPN 伺服器…';

  @override
  String get status_connected => '已連線';

  @override
  String get status_connectedDetail => '您的 VPN 連線已啟用。';

  @override
  String get status_disconnecting => '中斷連線中';

  @override
  String get status_disconnectingDetail => '您的 VPN 連線正在停止。';

  @override
  String get status_error => '連線無法使用';

  @override
  String get status_errorDetail => '尚未確認 VPN 連線。請再試一次。';

  @override
  String get status_idle => '已中斷連線';

  @override
  String get status_idleDetail => '連線至 VPN 以保護您的連線。';

  @override
  String get trust_note => '關閉應用程式不會停止 VPN。若要停止 VPN，請使用「中斷連線」。';

  @override
  String get locations_none => '目前沒有可用的位置。';

  @override
  String get locations_available => '選擇您的下一個位置。';

  @override
  String get locations_selected => '已選取的位置';

  @override
  String get locations_select => '選擇此位置';

  @override
  String get locations_lockedTunnel => '請中斷 VPN 連線以變更位置。';

  @override
  String get locations_lockedMigration => '請等待位置變更完成。';

  @override
  String get devices_title => '您的裝置';

  @override
  String devices_used(Object count, Object limit) {
    return '$count / $limit 部裝置';
  }

  @override
  String get devices_refresh => '重新整理裝置';

  @override
  String get devices_empty => '尚未註冊任何 VPN 裝置。';

  @override
  String get devices_firstConnection => '您的手機會在首次連線時新增。';

  @override
  String get devices_thisDevice => '此裝置';

  @override
  String devices_added(Object date) {
    return '新增於 $date';
  }

  @override
  String get action_remove => '移除';

  @override
  String get settings_title => '設定';

  @override
  String get settings_subtitle => '您的偏好設定與帳戶集中在同一處。';

  @override
  String get settings_appearance => '外觀';

  @override
  String get settings_language => '語言';

  @override
  String get settings_languageDescription => '您選擇的語言也會套用至 VPN 通知。';

  @override
  String get settings_account => '帳戶';

  @override
  String get settings_signOut => '登出';

  @override
  String get settings_privacy => '隱私權政策';

  @override
  String get settings_terms => '使用條款';

  @override
  String get settings_security => '安全性與透明度';

  @override
  String get settings_licenses => '元件授權';

  @override
  String get settings_licensesDetail => '應用程式使用的軟體';

  @override
  String get settings_background =>
      '離開應用程式時 VPN 仍會保持開啟。若要停止 VPN，請在「連線」分頁使用「中斷連線」。';

  @override
  String get theme_system => '系統';

  @override
  String get theme_light => '淺色';

  @override
  String get theme_dark => '深色';

  @override
  String get language_system => '手機語言';

  @override
  String get language_fr => '法文';

  @override
  String get language_en => '英文';

  @override
  String get language_es => '西班牙文';

  @override
  String get language_de => '德文';

  @override
  String get dialog_removeDevice => '要移除此裝置嗎？';

  @override
  String get dialog_removeCurrent =>
      '此手機將中斷 VPN 連線並失去存取權。伺服器確認後，將移除此手機的 VPN 連線資料。';

  @override
  String dialog_removeOther(Object name) {
    return '將撤銷「$name」的 VPN 存取權。此操作無法復原。';
  }

  @override
  String get dialog_signOut => '要登出嗎？';

  @override
  String get dialog_signOutMessage =>
      'VPN 將停止，您必須再次登入。您的加密 VPN 金鑰會留在此手機上，以供下次連線使用。';

  @override
  String get action_cancel => '取消';

  @override
  String get action_signOut => '登出';

  @override
  String get notice_close => '關閉訊息';

  @override
  String get notice_sessionExpired_title => '工作階段已過期';

  @override
  String get notice_sessionExpired_message => '您的工作階段已過期。請再次登入。';

  @override
  String get notice_connectionFailed_title => '連線失敗';

  @override
  String get notice_invalidCredentials_message => '電子郵件地址或密碼不正確。';

  @override
  String get notice_emailVerification_title => '需要確認電子郵件';

  @override
  String get notice_emailVerification_message => '請先確認您的電子郵件地址，再新增 VPN 裝置。';

  @override
  String get notice_rateLimited_title => '嘗試次數過多';

  @override
  String get notice_deviceLimit_title => '已達 2 部裝置的上限';

  @override
  String get notice_deviceLimit_message => '請先移除現有裝置，再新增其他裝置。';

  @override
  String get notice_identityRenewal_title => '必須更新 VPN 身分';

  @override
  String get notice_identityRenewal_message => '此身分已被移除。請建立新的本機身分。';

  @override
  String get notice_migrationPending_title => '位置變更進行中';

  @override
  String get notice_migrationPending_message => '位置變更已在進行中。';

  @override
  String get notice_migrationBlocked_title => '位置變更遭封鎖';

  @override
  String get notice_migrationBlocked_message => '變更位置需要伺服器介入。請稍後再試或聯絡支援人員。';

  @override
  String get notice_targetUnavailable_title => '伺服器暫時無法使用';

  @override
  String get notice_targetUnavailable_message => '此伺服器暫時無法使用。';

  @override
  String get notice_networkUnavailable_title => '網際網路連線無法使用';

  @override
  String get notice_networkUnavailable_message => '請檢查您的連線並再試一次。';

  @override
  String get notice_permissionDenied_title => 'VPN 權限遭拒';

  @override
  String get notice_permissionDenied_message => '請重新開始連線並接受 Android 權限要求。';

  @override
  String get notice_wireguardTimeout_title => '伺服器沒有回應';

  @override
  String get notice_wireguardTimeout_message =>
      'WireGuard 連線耗時過長。請再試一次或選擇其他位置。';

  @override
  String get notice_tlsFailed_title => '安全連線遭拒';

  @override
  String get notice_tlsFailed_message =>
      '伺服器不接受 OpenVPN 連線。請再試一次。如果問題持續，請執行診斷。';

  @override
  String get notice_tunRejected_title => 'Android 拒絕了 VPN 介面';

  @override
  String get notice_tunRejected_message => 'Android 拒絕了 OpenVPN 要求的網路設定。';

  @override
  String get notice_openvpnStart_title => 'OpenVPN 無法啟動';

  @override
  String get notice_openvpnStart_message =>
      'OpenVPN 引擎無法完成啟動。請再試一次。如果問題仍然存在，請聯絡支援人員。';

  @override
  String notice_diagnosticCode(Object code) {
    return '診斷代碼：$code';
  }

  @override
  String get notice_generic_title => 'VPN 連線失敗';

  @override
  String get notice_generic_message => '發生錯誤。請稍後再試。';

  @override
  String notice_controller_title(String code) {
    String _temp0 = intl.Intl.selectLogic(code, {
      'account_created_email_unavailable': '帳戶已建立',
      'password_reset_sent': '已收到密碼重設要求',
      'verification_email_sent': '驗證電子郵件已傳送',
      'location_migration_pending': '位置變更進行中',
      'vpn_sign_in_required': '需要登入',
      'protocol_unavailable_at_location': '通訊協定無法使用',
      'vpn_permission_denied': 'VPN 權限遭拒',
      'revoked_identity_device_limit': '已達 2 部裝置的上限',
      'tunnel_start_unexpected': 'VPN 無法啟動',
      'flutter_disconnect_timeout': '尚未確認中斷連線',
      'flutter_disconnect_unexpected': '無法中斷連線',
      'device_revoked': '裝置已移除',
      'revoke_unexpected': '無法移除裝置',
      'identity_renewal_unexpected': '無法更新身分',
      'openvpn_renewal_unexpected': '無法更新 OpenVPN',
      'location_migration_blocked': '位置變更遭封鎖',
      'location_migration_slow': '位置變更仍在進行中',
      'location_migration_conflict': '位置變更需要重新整理',
      'location_migration_verification_failed': '尚未確認位置變更',
      'location_migration_device_changed': '位置變更期間裝置已變更',
      'tunnel_stop_failed': '位置變更無法使用',
      'other': '操作失敗',
    });
    return '$_temp0';
  }

  @override
  String notice_controller_message(String code, String target) {
    String _temp0 = intl.Intl.selectLogic(code, {
      'account_created_email_unavailable': '帳戶已建立，但無法傳送驗證電子郵件。請在應用程式中使用重新傳送功能。',
      'password_reset_sent': '已收到您的要求。如果有帳戶使用此地址，您可能會收到電子郵件。也請檢查垃圾郵件資料夾。',
      'verification_email_sent': '新的驗證電子郵件剛剛已傳送。',
      'location_migration_pending': '正在準備移至 $target。您可以繼續此作業，不必重新建立裝置。',
      'vpn_sign_in_required': '請先登入您的帳戶，再啟動 VPN。',
      'protocol_unavailable_at_location': '所選通訊協定未由此位置提供。請重新整理位置或選擇其他通訊協定。',
      'vpn_permission_denied': 'Android 拒絕了 VPN 權限。請重新開始連線並接受系統要求。',
      'revoked_identity_device_limit':
          '此裝置的 VPN 存取權已移除，且已達裝置上限。請前往「帳戶」→「管理我的裝置」移除裝置。',
      'tunnel_start_unexpected': '非預期錯誤中斷了通道準備作業。請檢查診斷代碼並再試一次。',
      'flutter_disconnect_timeout': 'Android 未及時確認 VPN 已停止。請再次嘗試停止 VPN。',
      'flutter_disconnect_unexpected': '非預期錯誤導致無法確認通道已停止。',
      'device_revoked': '裝置的 VPN 存取權已撤銷，其本機密碼已移除。',
      'revoke_unexpected': '無法移除裝置。請重新整理清單並再試一次。',
      'identity_renewal_unexpected': '無法建立新的 VPN 身分。請重新整理裝置並再試一次。',
      'openvpn_renewal_unexpected': '無法更新 OpenVPN 設定檔。請再試一次或檢查診斷代碼。',
      'location_migration_blocked': '伺服器目前無法完成此變更。裝置及其本機身分已保留。',
      'location_migration_slow': '伺服器仍在準備移至 $target。請稍候片刻後使用「繼續」。',
      'location_migration_conflict': '伺服器上的裝置狀態已變更。請重新整理裝置，然後繼續變更。',
      'location_migration_verification_failed': '伺服器未確認新位置。先前的本機身分已保留。',
      'location_migration_device_changed': '伺服器傳回的裝置已不再符合正在變更的裝置。請重新整理裝置後再試一次。',
      'tunnel_stop_failed': '必須先完全停止先前的通道，才能建立新連線。',
      'other': '無法完成操作。請再試一次，或將診斷代碼傳送給支援人員。',
    });
    return '$_temp0';
  }

  @override
  String notice_api_title(String code) {
    String _temp0 = intl.Intl.selectLogic(code, {
      'unauthorized': '工作階段已過期',
      'invalid_credentials': '登入失敗',
      'email_verification_required': '需要確認電子郵件',
      'verification_email_cooldown': '電子郵件已傳送',
      'rate_limited': '嘗試次數過多',
      'invalid_registration': '必須更正資訊',
      'email_exists': '帳戶已存在',
      'invalid_profile': '個人資料無效',
      'invalid_device': '裝置無效',
      'invalid_location': '位置無法使用',
      'device_limit': '已達裝置上限',
      'device_exists': 'VPN 身分已在使用中',
      'device_identity_revoked': '必須更新 VPN 身分',
      'device_location_locked': '位置變更需要重新整理',
      'location_migration_pending': '位置變更進行中',
      'location_migration_blocked': '位置變更遭封鎖',
      'target_ca_mismatch': '不相容的 OpenVPN 伺服器',
      'location_migration_conflict': '位置變更需要重新整理',
      'server_full': '伺服器已滿',
      'capacity_unavailable': '位置暫時無法使用',
      'target_unavailable': '伺服器暫時無法使用',
      'not_found': '找不到項目',
      'invalid_openvpn_csr': 'OpenVPN 身分無效',
      'openvpn_profile_exists': 'OpenVPN 設定檔已存在',
      'openvpn_profile_revoked': 'OpenVPN 設定檔已撤銷',
      'openvpn_operation_pending': 'OpenVPN 操作進行中',
      'openvpn_operation_terminal': 'OpenVPN 操作已中斷',
      'openvpn_address_unavailable': 'OpenVPN 地址無法使用',
      'openvpn_profile_conflict': 'OpenVPN 衝突',
      'openvpn_signer_unavailable': 'OpenVPN 無法使用',
      'email_delivery_unavailable': '電子郵件無法使用',
      'invalid_token': '連結無效',
      'network_unavailable': '網際網路連線無法使用',
      'invalid_json': '要求無效',
      'invalid_api_response': '伺服器回應無效',
      'ipv6_unavailable': 'IPv6 無法使用',
      'invalid_ip_families': '網路設定遭拒',
      'other': '服務無法使用',
    });
    return '$_temp0';
  }

  @override
  String notice_api_message(String code) {
    String _temp0 = intl.Intl.selectLogic(code, {
      'unauthorized': '您的工作階段已過期。請再次登入。',
      'invalid_credentials': '電子郵件地址或密碼不正確。',
      'email_verification_required': '請先確認您的電子郵件地址，再新增 VPN 裝置。',
      'invalid_registration': '請檢查所要求的資訊與同意事項。',
      'email_exists': '已有帳戶使用此電子郵件地址。',
      'invalid_profile': '請檢查您的個人資料。',
      'invalid_device': '此裝置的名稱或本機身分無效。',
      'invalid_location': '請重新整理位置清單並再試一次。',
      'device_limit': '請先移除現有裝置，再新增其他裝置。',
      'device_exists': '此 VPN 身分已連結至其他帳戶。',
      'device_identity_revoked': '此身分已被移除。必須建立新的本機身分。',
      'device_location_locked': '此裝置的位置剛剛已變更。應用程式將繼續進行中的變更。',
      'location_migration_pending': '位置變更已在進行中。',
      'location_migration_blocked': '變更位置需要伺服器介入。請稍後再試或聯絡支援人員。',
      'target_ca_mismatch': '此伺服器尚未與目前的 OpenVPN 設定檔相容。',
      'location_migration_conflict': '請重新整理裝置，然後再次嘗試變更位置。',
      'server_full': '此位置已達連線上限。請選擇其他位置或稍後再試。',
      'capacity_unavailable': '我們目前無法確認此位置是否可用。請選擇其他位置或稍後再試。',
      'target_unavailable': '此伺服器暫時無法使用。',
      'not_found': '此項目已不再於您的帳戶中提供。',
      'invalid_openvpn_csr': '請建立新的 OpenVPN 身分並再試一次。',
      'openvpn_profile_exists': '此裝置已有 OpenVPN 設定檔。',
      'openvpn_profile_revoked': '請更新 OpenVPN 設定檔以繼續。',
      'openvpn_operation_pending': '變更仍在傳播中。請稍後再試。',
      'openvpn_operation_terminal': '請建立新的 OpenVPN 身分並再試一次。',
      'openvpn_address_unavailable': '目前沒有可用的 OpenVPN 地址。',
      'openvpn_profile_conflict': '設定檔已變更。請重新整理裝置並再試一次。',
      'openvpn_signer_unavailable': 'OpenVPN 服務暫時無法使用。',
      'email_delivery_unavailable': '無法傳送電子郵件。請稍後再試。',
      'invalid_token': '此連結無效或已過期。請要求新的連結。',
      'network_unavailable': '請檢查您的網際網路連線並再試一次。',
      'invalid_json': '請檢查輸入的資訊並再試一次。',
      'invalid_api_response': '伺服器傳回非預期的回應。請稍後再試。',
      'ipv6_unavailable': '伺服器目前無法啟用 IPv6。請稍後再試。',
      'invalid_ip_families': '通道設定不完整，或與授權地址不相符。請從應用程式再試一次。',
      'other': '發生伺服器錯誤。請稍後再試。',
    });
    return '$_temp0';
  }

  @override
  String get notice_retryLater => '請稍候片刻再試一次。';

  @override
  String notice_retryAfter(Object seconds) {
    return '請在 $seconds 秒後再試一次。';
  }

  @override
  String notice_native_title(String code, String protocol) {
    String _temp0 = intl.Intl.selectLogic(code, {
      'system_vpn_resume_unavailable': '系統 VPN 無法繼續',
      'system_vpn_resume_corrupt': '系統 VPN 繼續資料無效',
      'system_vpn_resume_session_invalid': 'VPN 繼續工作階段無效',
      'system_vpn_resume_identity_changed': 'VPN 身分已變更',
      'system_vpn_resume_identity_invalid': 'VPN 繼續身分無效',
      'system_vpn_resume_storage_failed': 'VPN 繼續儲存空間無法使用',
      'system_vpn_resume_network_timeout': 'VPN 繼續時沒有網路',
      'system_vpn_resume_blocked': 'VPN 繼續遭封鎖',
      'system_vpn_resume_failed': 'VPN 繼續失敗',
      'system_vpn_resume_error_invalid': 'VPN 繼續錯誤無效',
      'wireguard_identity_store_failed': 'WireGuard 身分未儲存',
      'wireguard_identity_unavailable': 'WireGuard 身分無法使用',
      'vpn_host_destroyed': 'Android VPN 主機已停止',
      'vpn_host_unavailable': 'Android VPN 主機無法使用',
      'vpn_permission_required': '需要 VPN 權限',
      'vpn_permission_denied': 'VPN 權限遭拒',
      'vpn_permission_request_failed': '無法要求權限',
      'wireguard_foreground_service_unavailable': 'WireGuard 服務無法使用',
      'wireguard_identity_invalid': '本機 WireGuard 金鑰無效',
      'wireguard_identity_in_use': 'WireGuard 身分已在使用中',
      'wireguard_configuration_invalid': 'WireGuard 設定無效',
      'wireguard_operation_pending': 'WireGuard 操作仍在啟用',
      'wireguard_start_failed': 'WireGuard 啟動遭拒',
      'wireguard_stop_timeout': '尚未確認 WireGuard 已停止',
      'wireguard_handshake_timeout': 'WireGuard 沒有回應',
      'openvpn_connection_timeout': 'OpenVPN 沒有回應',
      'openvpn_core_unavailable': 'OpenVPN 引擎無法使用',
      'openvpn_operation_pending': 'OpenVPN 工作階段仍在啟用',
      'openvpn_stop_timeout': '尚未確認 OpenVPN 已停止',
      'openvpn_profile_unavailable': '找不到本機 OpenVPN 設定檔',
      'openvpn_native_failed': '原生 OpenVPN 呼叫已中斷',
      'openvpn_key_generation_failed': '無法建立 OpenVPN P-256 金鑰',
      'openvpn_csr_generation_failed': '無法建立 OpenVPN CSR',
      'openvpn_identity_store_failed': 'OpenVPN 身分未儲存',
      'openvpn_identity_clear_failed': 'OpenVPN 移除作業不完整',
      'openvpn_identity_in_use': 'OpenVPN 身分仍在使用中',
      'openvpn_tls_verification_required': '缺少 OpenVPN TLS 驗證',
      'openvpn_cipher_invalid': 'OpenVPN 加密法無效',
      'openvpn_profile_rejected': 'OpenVPN 設定檔遭拒',
      'openvpn_identity_inconsistent': 'OpenVPN 身分不一致',
      'tls_handshake_failed': 'OpenVPN 協商遭拒',
      'tls_alert_unknown_ca': 'OpenVPN 用戶端憑證不受信任',
      'tls_alert_bad_certificate': 'OpenVPN 用戶端憑證遭拒',
      'tls_alert_unsupported_certificate': '不支援的 OpenVPN 憑證',
      'tls_client_certificate_required': '需要 OpenVPN 用戶端憑證',
      'tls_alert_misc': 'OpenVPN TLS 警示',
      'tls_signature_algorithm_rejected': '不支援的 OpenVPN 簽章',
      'tls_handshake_rejected': 'OpenVPN TLS 協商遭拒',
      'tls_version_rejected': '不相容的 OpenVPN TLS 版本',
      'tls_certificate_expired': 'TLS 憑證已過期',
      'tls_certificate_revoked': 'TLS 憑證已撤銷',
      'transport_failed': '無法連線至 OpenVPN 伺服器',
      'tun_configuration_rejected': '無法建立 OpenVPN 介面',
      'tun_setup_failed': 'OpenVPN TUN 設定失敗',
      'tun_interface_create_failed': 'OpenVPN 介面建立失敗',
      'tun_interface_disabled': 'OpenVPN 介面已停用',
      'tun_halted': 'OpenVPN 介面已中斷',
      'tun_already_established': 'OpenVPN 介面已開啟',
      'tun_addresses_missing': '缺少 OpenVPN 地址',
      'tun_routes_missing': '缺少 OpenVPN 路由',
      'tun_dns_missing': '缺少 OpenVPN DNS',
      'tun_permission_revoked': 'VPN 權限已撤銷',
      'tun_establish_returned_null': 'Android 拒絕了 VPN 介面',
      'openvpn_service_start_failed': 'OpenVPN 服務無法使用',
      'openvpn_operation_timeout': 'OpenVPN 呼叫逾時',
      'openvpn_start_failed': 'OpenVPN 啟動遭拒',
      'openvpn_connection_failed': 'OpenVPN 連線已中斷',
      'openvpn_core_status_error': 'OpenVPN Core 結束時發生錯誤',
      'openvpn_stopped_before_connected': 'OpenVPN 在連線前已停止',
      'openvpn_auth_failed': 'OpenVPN 驗證遭拒',
      'openvpn_client_setup_failed': 'OpenVPN 用戶端設定失敗',
      'openvpn_client_halted': 'OpenVPN 用戶端已中斷',
      'openvpn_client_restart': '已要求重新啟動 OpenVPN',
      'openvpn_inactive_timeout': 'OpenVPN 閒置時間過長',
      'openvpn_session_expired': 'OpenVPN 工作階段已過期',
      'openvpn_credentials_required': '不支援的 OpenVPN 驗證',
      'openvpn_proxy_failed': 'OpenVPN 中介傳輸失敗',
      'openvpn_compression_failed': 'OpenVPN 壓縮遭拒',
      'openvpn_ntlm_crypto_unavailable': 'OpenVPN NTLM 加密無法使用',
      'openvpn_feature_unsupported': '不支援的 OpenVPN 功能',
      'network_unavailable': '網際網路連線無法使用',
      'network_lost': '網路無法使用',
      'certificate_validation_failed': '伺服器憑證遭拒',
      'openvpn_certificate_expired': 'OpenVPN 憑證已過期',
      'tunnel_active_for_another_account': '其他帳戶的通道仍在啟用',
      'tunnel_already_active': '原生通道已在啟用',
      'tunnel_stop_timeout': '尚未確認 $protocol 已停止',
      'tunnel_disconnected': '$protocol 已中斷',
      'native_bridge_unavailable': 'Android 橋接程式無法使用',
      'native_operation_failed': 'Android 操作已中斷',
      'invalid_arguments': 'VPN 參數不完整',
      'invalid_account_id': 'VPN 帳戶無效',
      'invalid_device_id': '裝置識別碼無效',
      'storage_key_not_allowed': '儲存金鑰遭拒',
      'secure_storage_read_failed': '安全讀取失敗',
      'secure_storage_write_failed': '安全寫入失敗',
      'key_generation_failed': '無法產生 WireGuard 金鑰',
      'csr_generation_failed': '無法產生 OpenVPN CSR',
      'other': '未分類的原生 VPN 錯誤',
    });
    return '$_temp0';
  }

  @override
  String notice_native_message(String code, String protocol) {
    String _temp0 = intl.Intl.selectLogic(code, {
      'system_vpn_resume_unavailable':
          'Android 找不到可繼續的 VPN 工作階段。請在應用程式中開始新的連線。',
      'system_vpn_resume_corrupt': '儲存的 VPN 繼續資料無效，將不會使用。請開始新的連線。',
      'system_vpn_resume_session_invalid': '儲存的工作階段無法再繼續 VPN。請在應用程式中再次登入。',
      'system_vpn_resume_identity_changed': '本機 VPN 身分已變更。繼續作業已停止；請開始新的連線。',
      'system_vpn_resume_identity_invalid': '用於繼續的身分無效。請開始新的連線。',
      'system_vpn_resume_storage_failed': 'Android 無法讀取或更新加密的繼續資料。請開始新的連線。',
      'system_vpn_resume_network_timeout':
          'Android 未能及時找到網路以繼續 VPN。請在有網路可用時再試一次。',
      'system_vpn_resume_blocked': 'VPN 繼續作業遭封鎖。請檢查 Android 設定，然後開始新的連線。',
      'system_vpn_resume_failed': 'Android VPN 繼續作業失敗。請在應用程式中開始新的連線。',
      'system_vpn_resume_error_invalid': 'Android 傳回無法使用的繼續錯誤。請開始新的連線。',
      'wireguard_identity_store_failed': 'Android 無法儲存此帳戶的加密 WireGuard 身分。',
      'wireguard_identity_unavailable': '此連線沒有可用的 WireGuard 身分。',
      'vpn_host_destroyed': '承載 VPN 的 Android 元件已停止。請開始新的連線。',
      'vpn_host_unavailable': 'Android 無法建立承載 VPN 的元件。請檢查 VPN 設定後再試一次。',
      'openvpn_renewal_required': '憑證需要您在應用程式中採取動作後才能連線。',
      'openvpn_recovery_failed': '自動復原失敗。請在應用程式中開始新的連線。',
      'openvpn_recovery_exhausted': '自動復原已使用過。請在應用程式中開始新的連線。',
      'vpn_permission_required': 'Android 需要新的 VPN 授權，才能啟動通道。',
      'vpn_permission_denied': '請在 Android 要求中允許 FuzeVPN，以繼續操作。',
      'vpn_permission_request_failed': 'Android 無法開啟 VPN 權限畫面。',
      'wireguard_foreground_service_unavailable':
          'Android 無法讓 WireGuard 服務保持在前景。',
      'wireguard_identity_invalid': '此帳戶的加密 WireGuard 金鑰無法讀取或無效。',
      'wireguard_identity_in_use': '另一項操作仍在使用此帳戶的 WireGuard 金鑰。',
      'wireguard_configuration_invalid': '收到的 WireGuard 地址、DNS、伺服器金鑰或路由無效。',
      'wireguard_operation_pending': '先前的 WireGuard 操作尚未釋放其原生服務。',
      'wireguard_start_failed': 'WireGuard 引擎拒絕啟用設定。',
      'wireguard_stop_timeout': 'WireGuard 服務未在時限內確認釋放 VPN 介面。',
      'wireguard_handshake_timeout': '通道未能及時確認與伺服器的交握。',
      'openvpn_connection_timeout': 'OpenVPN 未能及時確認與伺服器的連線。',
      'openvpn_core_unavailable': '此應用程式版本不包含可用的 OpenVPN 引擎。',
      'openvpn_operation_pending': '原生引擎仍持有先前的 OpenVPN 工作階段，拒絕建立第二個工作階段。',
      'openvpn_stop_timeout': 'OpenVPN Core 未在時限內確認其原生工作階段已停止並銷毀。',
      'openvpn_profile_unavailable': '無法讀取此連線的任何已驗證 OpenVPN 設定檔。',
      'openvpn_native_failed': '應用程式錯誤中斷了 OpenVPN。請再次嘗試連線。如果問題持續，請執行診斷。',
      'openvpn_key_generation_failed':
          'Android Keystore 無法建立或讀取不可匯出的 P-256 私密金鑰。',
      'openvpn_csr_generation_failed': 'Android Keystore 金鑰無法簽署 OpenVPN 憑證要求。',
      'openvpn_identity_store_failed': '無法將 OpenVPN 憑證或設定檔儲存在加密儲存空間中。',
      'openvpn_identity_clear_failed': 'Android 無法移除此帳戶完整的本機 OpenVPN 身分。',
      'openvpn_identity_in_use': '原生 OpenVPN 工作階段仍在使用此裝置的金鑰或憑證。',
      'openvpn_tls_verification_required': '設定檔未明確要求伺服器憑證驗證。',
      'openvpn_cipher_invalid': '伺服器提供的加密演算法不在允許清單中。',
      'openvpn_profile_rejected': '從伺服器收到的設定檔不相容。請重新建立此裝置並再試一次。',
      'openvpn_identity_inconsistent': '憑證與此手機的安全身分不相符。未取代任何本機設定檔。',
      'tls_handshake_failed': '伺服器拒絕 TLS 協商。如果問題持續，請重新建立設定檔。',
      'tls_alert_unknown_ca': '伺服器不信任此裝置憑證的簽發機構。必須檢查 OpenVPN 伺服器。',
      'tls_alert_bad_certificate': '伺服器拒絕此裝置憑證。請在再次嘗試前重新建立裝置。',
      'tls_alert_unsupported_certificate': '伺服器不支援 Android 使用的安全憑證類型。',
      'tls_client_certificate_required': '伺服器需要用戶端憑證，但 OpenVPN Core 無法提供憑證。',
      'tls_alert_misc': '伺服器傳回不屬於憑證與版本類別的 TLS 警示。',
      'tls_signature_algorithm_rejected':
          '伺服器拒絕 Android Keystore 金鑰的 ECDSA P-256 演算法。',
      'tls_handshake_rejected': '伺服器在連線前中斷了 TLS 協商。',
      'tls_version_rejected': '用戶端與伺服器找不到共同的 TLS 版本。',
      'tls_certificate_expired': '連線期間提供的憑證已過期。',
      'tls_certificate_revoked': '連線期間提供的憑證已撤銷。',
      'transport_failed': 'OpenVPN 伺服器未在目前網路上回應。請稍後再試。',
      'tun_configuration_rejected': 'Android 拒絕了 OpenVPN 要求的網路設定。',
      'tun_setup_failed': 'OpenVPN Core 在建立 Android 介面前拒絕了網路計畫。',
      'tun_interface_create_failed':
          'OpenVPN Core 無法從 Android VpnService 取得 TUN 介面。',
      'tun_interface_disabled': 'Android 或 OpenVPN Core 在連線期間停用了 TUN 介面。',
      'tun_halted': 'OpenVPN Core 收到停止 TUN 介面的要求。',
      'tun_already_established': 'OpenVPN 在同一連線中要求第二個介面。為了安全起見，通道已停止。',
      'tun_addresses_missing': '伺服器未提供可用的通道地址。',
      'tun_routes_missing': '伺服器未提供可用的通道路由。',
      'tun_dns_missing': '伺服器未提供可用的 DNS 伺服器。',
      'tun_permission_revoked': 'Android 在連線期間撤銷了 VPN 權限。',
      'tun_establish_returned_null': 'Android 未建立介面，通常是因為另一個 VPN 仍在啟用。',
      'openvpn_service_start_failed': 'Android 無法啟動 OpenVPN 前景服務。',
      'openvpn_operation_timeout': '對 OpenVPN Core 的 JNI 呼叫超過最長持續時間。',
      'openvpn_start_failed': 'Android 服務已就緒，但 OpenVPN Core 不接受啟動設定檔。',
      'openvpn_connection_failed': 'OpenVPN Core 在發出 CONNECTED 事件前已停止。',
      'openvpn_core_status_error': '原生 OpenVPN 迴圈以錯誤結束，且沒有更具體的終止事件。',
      'openvpn_stopped_before_connected':
          '原生 OpenVPN 迴圈在 CONNECTED 前停止，且沒有明確的 Core 錯誤。',
      'openvpn_auth_failed': 'OpenVPN 伺服器拒絕了設定檔驗證。',
      'openvpn_client_setup_failed': 'OpenVPN Core 無法在網路連線前初始化用戶端。',
      'openvpn_client_halted': 'OpenVPN Core 收到終止用戶端的要求。',
      'openvpn_client_restart': 'OpenVPN Core 要求重新啟動其傳輸工作階段。',
      'openvpn_inactive_timeout': 'OpenVPN Core 在閒置逾時後關閉了工作階段。',
      'openvpn_session_expired': '伺服器回報 OpenVPN 工作階段已過期。',
      'openvpn_credentials_required': '伺服器或代理伺服器要求互動式憑證，而此憑證設定檔不包含這些憑證。',
      'openvpn_proxy_failed': 'OpenVPN Core 回報設定的代理伺服器或中繼失敗。',
      'openvpn_compression_failed': 'OpenVPN Core 拒絕了設定檔或伺服器宣告的壓縮模式。',
      'openvpn_ntlm_crypto_unavailable': '設定檔要求此版本無法使用的 NTLM 加密。',
      'openvpn_feature_unsupported': '設定檔或伺服器需要此 Android 用戶端缺少的功能。',
      'network_unavailable': '沒有可用的實體網路。',
      'network_lost': '網路遺失後，通道已停止。',
      'certificate_validation_failed': '無法驗證 OpenVPN 伺服器身分。',
      'openvpn_certificate_expired': '請在重新連線前更新 OpenVPN 設定檔。',
      'tunnel_active_for_another_account': '屬於其他帳戶的通道必須停止後，才能建立此連線。',
      'tunnel_already_active': 'Android 回報先前的 VPN 工作階段仍在使用此介面。',
      'tunnel_stop_timeout': '$protocol 引擎未在時限內確認釋放 VPN 介面。',
      'tunnel_disconnected': '原生引擎回報通道在啟動後非預期結束。',
      'native_bridge_unavailable':
          '應用程式無法存取 Android VPN 服務。請關閉並重新開啟應用程式，然後再試一次。',
      'native_operation_failed': '應用程式錯誤中斷了 VPN 操作。請再試一次。如果問題持續，請執行診斷。',
      'invalid_arguments': '此 VPN 操作所需的資訊不完整。請再試一次。如果問題持續，請執行診斷。',
      'invalid_account_id': '此原生操作未與有效的帳戶識別碼建立關聯。',
      'invalid_device_id': '傳送至原生引擎的裝置識別碼遺失或無效。',
      'storage_key_not_allowed': 'Android 橋接程式封鎖了允許儲存清單之外的金鑰。',
      'secure_storage_read_failed': 'Android Keystore 無法解密此帳戶的本機資料。',
      'secure_storage_write_failed': 'Android Keystore 無法加密或儲存本機資料。',
      'key_generation_failed': 'Android 無法在安全儲存空間中建立或讀取 WireGuard 金鑰。',
      'csr_generation_failed': 'Android Keystore 無法建立或簽署 OpenVPN P-256 CSR。',
      'other': '未記錄的原生分支失敗。請將下方顯示的診斷代碼傳送給支援人員。',
    });
    return '$_temp0';
  }

  @override
  String get notice_permissionRequestInProgress_title => '權限要求已開啟';

  @override
  String get notice_permissionRequestInProgress_message =>
      'Android VPN 權限要求已顯示。請完成該要求後再試一次。';

  @override
  String get notice_permissionRequestInterrupted_title => 'VPN 權限要求已中斷';

  @override
  String get notice_permissionRequestInterrupted_message =>
      '應用程式收到回應前，VPN 權限畫面已關閉。';

  @override
  String get notice_openvpnProofMissing_title => '尚未確認 OpenVPN 連線';

  @override
  String get notice_openvpnProofMissing_message =>
      '無法確認 OpenVPN 連線。為了安全起見，連線已停止。請再試一次。';

  @override
  String get openvpnCleanup_title => 'OpenVPN 設定檔已撤銷';

  @override
  String get openvpnCleanup_working => '正在停止並移除已撤銷的 OpenVPN 設定檔…';

  @override
  String get openvpnCleanup_stopFailed => '尚未確認 OpenVPN 已關閉。請在建立新設定檔前重試。';

  @override
  String get openvpnCleanup_cleanupFailed => '無法完整移除已撤銷的 OpenVPN 設定檔。請重試清除作業。';

  @override
  String get openvpnCleanup_complete => '已移除已撤銷的 OpenVPN 設定檔。點選「連線」以建立新的設定檔。';

  @override
  String get network_title => '網路設定';

  @override
  String get network_ipv4Fallback => 'IPv6 暫時無法使用。正在以 IPv4 繼續準備。';

  @override
  String get network_rejectedTitle => '網路設定遭拒';

  @override
  String get network_rejectedMessage => '通道設定不完整，或與授權地址不相符。請從應用程式再試一次。';

  @override
  String get network_unreadableTitle => '無法讀取本機設定';

  @override
  String get network_unreadableMessage =>
      '儲存的 OpenVPN 網路設定無法使用。請從應用程式重新連線以更新設定。';

  @override
  String get network_ipv4 => 'IPv4';

  @override
  String get network_dualStack => 'IPv4 + IPv6';

  @override
  String get protection_title => '網路保護';

  @override
  String get protection_subtitle => '如果 VPN 中斷連線，請封鎖直接存取網際網路。';

  @override
  String get protection_active => '系統保護已啟用';

  @override
  String get protection_alwaysOnOnly => '永遠開啟的 VPN 已啟用；請開啟 VPN 外部的封鎖功能';

  @override
  String get protection_inactive => '系統保護未啟用';

  @override
  String get protection_unknown => '檢查系統保護';

  @override
  String get protection_openSettings => '開啟 Android 設定';

  @override
  String get protection_dialogTitle => '設定網路保護';

  @override
  String get protection_dialogMessage =>
      'Android 會管理永遠開啟的 VPN，以及 VPN 外部的連線封鎖。請確認已選取 FuzeVPN，並在系統設定中啟用封鎖功能。';

  @override
  String get protection_dialogOpen => '開啟設定';

  @override
  String get session_systemProtectionNote =>
      '如果 Android 仍封鎖 VPN 外部的流量，請開啟系統設定以檢查或變更此保護功能。';

  @override
  String get diagnostics_title => '診斷';

  @override
  String get diagnostics_settingsTitle => '應用程式診斷';

  @override
  String get diagnostics_automaticTitle => '傳送重要錯誤';

  @override
  String get diagnostics_automaticDescription => '發生重要錯誤時，分享一份簡短的技術報告。';

  @override
  String get diagnostics_privacy =>
      '已傳送的報告會連結至已登入的帳戶，並保留 30 天。報告不包含瀏覽記錄、密碼或 VPN 金鑰。';

  @override
  String get diagnostics_manualOpen => '執行診斷';

  @override
  String get diagnostics_localDescription => '建立應用程式與 VPN 狀態的報告。您的連線不會變更。';

  @override
  String get diagnostics_sendReport => '傳送報告';

  @override
  String get diagnostics_sendHint => '取消勾選此方塊即可將報告保留在此裝置上。';

  @override
  String get diagnostics_signedOut => '登入您的帳戶以傳送報告。';

  @override
  String get diagnostics_localLifetime => '將此報告儲存在手機上，以便關閉應用程式後仍保留。';

  @override
  String get diagnostics_run => '執行診斷';

  @override
  String get diagnostics_rerun => '再次執行診斷';

  @override
  String get diagnostics_running => '檢查中…';

  @override
  String get diagnostics_sending => '正在傳送報告…';

  @override
  String get diagnostics_prepared => '報告已在此裝置上準備就緒';

  @override
  String get diagnostics_queued => '報告等待傳送';

  @override
  String get diagnostics_sent => '已收到報告';

  @override
  String get diagnostics_failed => '傳送失敗。您的本機報告仍可使用。';

  @override
  String get diagnostics_preparationFailed => '無法準備診斷報告。請再試一次。';

  @override
  String get diagnostics_authenticationRequired => '請再次登入以傳送報告。';

  @override
  String get diagnostics_retry => '重試傳送';

  @override
  String get diagnostics_export => '儲存報告';

  @override
  String get diagnostics_exportFailed => '匯出失敗。請從本機報告再試一次。';

  @override
  String get diagnostics_preferenceFailed => '無法儲存此設定。請再試一次。';

  @override
  String diagnostics_receipt(Object id) {
    return '參考編號：$id';
  }

  @override
  String diagnostics_received(Object date) {
    return '收到日期：$date';
  }

  @override
  String diagnostics_expires(Object date) {
    return '保留至 $date';
  }

  @override
  String get diagnostics_duplicate => '此報告先前已收到。';

  @override
  String get diagnostics_preview => '報告預覽';

  @override
  String diagnostics_eventCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '已附加 $count 個技術事件',
      one: '已附加 1 個技術事件',
      zero: '未附加技術事件',
    );
    return '$_temp0';
  }

  @override
  String get diagnostics_technical => '技術詳細資料';

  @override
  String get diagnostics_empty => '尚未準備任何診斷報告。';

  @override
  String diagnostics_checkName(String id) {
    String _temp0 = intl.Intl.selectLogic(id, {
      'tunnel_connection': '通道狀態',
      'handshake': '連線確認',
      'certificate': 'VPN 憑證',
      'kill_switch': 'Android 保護',
      'connectivity': '可用網路',
      'api_reachability': '服務存取',
      'secure_storage': '安全儲存空間',
      'other': '本機檢查',
    });
    return '$_temp0';
  }

  @override
  String diagnostics_checkResult(String result) {
    String _temp0 = intl.Intl.selectLogic(result, {
      'passed': '已檢查',
      'failed': '需要注意',
      'skipped': '未測試 — 沒有啟用中的探測',
      'unknown': '資訊無法使用',
      'other': '資訊無法使用',
    });
    return '$_temp0';
  }

  @override
  String get auth_welcome => '歡迎使用 FuzeVPN';

  @override
  String get connection_changeLocation => '變更位置';

  @override
  String get connection_details => '連線詳細資料';

  @override
  String get locations_searchLabel => '搜尋城市或國家';

  @override
  String get locations_clearSearch => '清除搜尋';

  @override
  String get locations_filterAll => '全部';

  @override
  String get locations_filterFavorites => '我的最愛';

  @override
  String locations_results(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count 個位置',
      one: '$count 個位置',
    );
    return '$_temp0';
  }

  @override
  String get locations_noResults => '找不到位置';

  @override
  String get locations_noResultsHint => '請嘗試其他城市或國家。';

  @override
  String get locations_noFavorites => '您的最愛，隨手可得';

  @override
  String get locations_noFavoritesHint => '點選位置旁的星號，即可將其儲存於此。';

  @override
  String get locations_showAll => '查看所有位置';

  @override
  String locations_addFavorite(String name) {
    return '將 $name 加入我的最愛';
  }

  @override
  String locations_removeFavorite(String name) {
    return '從我的最愛移除 $name';
  }

  @override
  String get locations_favoriteSaveFailed => '無法儲存我的最愛。請再試一次。';

  @override
  String get locations_emptyTitle => '沒有可用的位置';

  @override
  String get locations_emptyHint => '重新整理清單以再試一次。';

  @override
  String get devices_manage => '管理我的裝置';

  @override
  String get settings_personalization => '打造專屬體驗';

  @override
  String get settings_safety => '保護';

  @override
  String get settings_help => '需要協助嗎？';

  @override
  String get settings_about => '關於 FuzeVPN';

  @override
  String get diagnostics_heading => '了解連線問題';

  @override
  String devices_profileStatus(String status) {
    String _temp0 = intl.Intl.selectLogic(status, {
      'active': '可用',
      'pending': '準備中',
      'revoked': '已移除',
      'expired': '已過期',
      'other': '狀態無法使用',
    });
    return '$_temp0';
  }

  @override
  String get notice_preferenceSave_title => '偏好設定未儲存';

  @override
  String get notice_preferenceSave_message =>
      '您的選擇目前已套用，但無法儲存。請再試一次，以便關閉應用程式後仍保留設定。';

  @override
  String get connection_androidDisconnectHint =>
      '如果 Android 讓 VPN 保持啟用，請在開啟的設定中關閉「永遠開啟的 VPN」。';

  @override
  String get protection_learnMore => '了解 Android 保護功能';

  @override
  String get protection_guideWhy =>
      '如果 VPN 中斷連線，此保護功能會防止應用程式直接使用網際網路。此功能在 Android 中設定。';

  @override
  String get protection_guideAlwaysOnTitle => '永遠開啟的 VPN';

  @override
  String get protection_guideAlwaysOn =>
      'Android 會讓 VPN 服務持續執行，並可在手機重新啟動後重新啟動服務。';

  @override
  String get protection_guideBlockTitle => '封鎖沒有 VPN 的連線';

  @override
  String get protection_guideBlock => '此設定會防止流量繞過 VPN，包括連線中斷期間。';

  @override
  String get protection_guideWarning => '啟用此封鎖功能後，必須等到 VPN 連線，網際網路存取才會恢復。';

  @override
  String get protection_guideStepsTitle => '開啟保護功能';

  @override
  String get protection_guideStep1 => '使用下方按鈕開啟 Android VPN 設定。';

  @override
  String get protection_guideStep2 => '點選 FuzeVPN 旁的齒輪圖示以開啟選項。';

  @override
  String get protection_guideStep3 =>
      '啟用「永遠開啟的 VPN」，然後啟用「封鎖沒有 VPN 的連線」（如果有這些選項）。';

  @override
  String get protection_guideManufacturers =>
      '各手機的名稱可能不同。如有需要，請在「設定」中搜尋 VPN，通常位於「網路與網際網路」下。';

  @override
  String get protection_guideDisableTitle => '關閉此保護功能';

  @override
  String get protection_guideDisable =>
      '在相同設定中，關閉沒有 VPN 時的封鎖功能，即可允許沒有 VPN 的網際網路存取。如果不再希望 Android 自動重新啟動 VPN，也請關閉「永遠開啟的 VPN」。';

  @override
  String get protection_guideManual => '您可以在 Android 中選擇這些設定。FuzeVPN 不會替您變更設定。';

  @override
  String get locations_changeTitle => '要變更位置嗎？';

  @override
  String locations_changeActive(String name) {
    return 'VPN 將中斷連線，然後嘗試連線至 $name。';
  }

  @override
  String locations_changeIdle(String name) {
    return 'VPN 將嘗試連線至 $name。';
  }

  @override
  String get locations_confirmChange => '變更並連線';

  @override
  String get locations_changeBusy => '變更正在進行中。請等待後再選擇其他位置。';

  @override
  String get locations_automaticSelection => '自動選擇';

  @override
  String get locations_cities => '城市';

  @override
  String get locations_servers => '伺服器';

  @override
  String locations_viewCities(String name) {
    return '查看 $name 的城市';
  }

  @override
  String locations_viewServers(String name) {
    return '查看 $name 的伺服器';
  }

  @override
  String locations_countryCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count 個國家',
      one: '$count 個國家',
    );
    return '$_temp0';
  }

  @override
  String locations_cityCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count 個城市',
      one: '$count 個城市',
    );
    return '$_temp0';
  }

  @override
  String locations_serverCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count 部伺服器',
      one: '$count 部伺服器',
    );
    return '$_temp0';
  }

  @override
  String get locations_allCountries => '所有國家';

  @override
  String get locations_backToCountries => '返回國家';

  @override
  String locations_backToCities(String name) {
    return '返回 $name 的城市';
  }

  @override
  String locations_chooseCountry(String name) {
    return '選擇 $name';
  }

  @override
  String locations_chooseCity(String name) {
    return '選擇 $name';
  }

  @override
  String get locations_noCompatibleServer => '沒有可相容的伺服器。';

  @override
  String get externalLink_failed => '無法開啟此連結。您可以複製連結並在瀏覽器中開啟。';

  @override
  String get externalLink_copy => '複製連結';

  @override
  String get externalLink_copied => '連結已複製';

  @override
  String get externalLink_copyFailed => '無法複製連結。請選取下方網址。';

  @override
  String get settings_deleteAccount => '刪除我的帳戶';

  @override
  String get settings_deleteAccountDetail => '查看申請刪除帳戶的流程';

  @override
  String get billing_title => 'Fuze Premium';

  @override
  String get billing_subtitle => '選擇您的 VPN 訂閱。';

  @override
  String get billing_subscribe => '訂閱';

  @override
  String get billing_choosePlan => '選擇方案以繼續。';

  @override
  String get billing_monthly => '月付';

  @override
  String get billing_yearly => '年付';

  @override
  String get billing_continue => '透過 Google Play 繼續';

  @override
  String get billing_restore => '還原購買';

  @override
  String get billing_manage => '管理訂閱';

  @override
  String get billing_deleteAccountWarning =>
      '如果您透過 Google Play 訂閱，刪除 FuzeVPN 帳戶並不會取消該訂閱的續訂。請在 Google Play 中另外管理或取消續訂。';

  @override
  String get billing_deleteAccountContinue => '繼續申請刪除帳戶';

  @override
  String get billing_refresh => '重新整理存取權限';

  @override
  String get billing_loadingPlans => '正在載入方案…';

  @override
  String get billing_unavailable => '目前沒有可用方案。請稍後重試。';

  @override
  String get billing_comingSoon => '訂閱即將推出。';

  @override
  String get billing_priceDisclosure => '價格由 Google Play 提供。您確認前會顯示最終金額及適用稅費。';

  @override
  String get billing_renewalMonthly =>
      '除非取消，否則每月自動續訂。您可以隨時在 Google Play 訂閱中取消。';

  @override
  String get billing_renewalYearly => '除非取消，否則每年自動續訂。您可以隨時在 Google Play 訂閱中取消。';

  @override
  String get billing_active => '您的 Premium 存取權限已生效';

  @override
  String billing_accessUntil(String date) {
    return '可使用至 $date。';
  }

  @override
  String get billing_webManaged => '您的訂閱在 FuzeVPN 網站上管理。';

  @override
  String get billing_playManaged => '您的訂閱透過 Google Play 管理。';

  @override
  String get billing_inactive => '沒有生效的訂閱。';

  @override
  String get billing_checkingAccess => '正在檢查您的存取權限…';

  @override
  String get billing_restoring => '正在還原購買…';

  @override
  String get billing_pending => '付款待處理。確認後將開通存取權限。';

  @override
  String get billing_cancelled => '購買已取消。未開通新的訂閱。';

  @override
  String get billing_verifying => '正在驗證購買…';

  @override
  String get billing_success => '訂閱已開通。您現在可以使用 Premium。';

  @override
  String get billing_restored => '您的購買已還原。';

  @override
  String get billing_restoreEmpty => '此 Google Play 帳戶沒有可還原的購買。';

  @override
  String get billing_catalogError => '無法載入方案。請重試。';

  @override
  String get billing_purchaseError => '無法開始購買。請重試。';

  @override
  String get billing_verificationError => '購買驗證暫時無法使用。請還原購買以重試。';

  @override
  String get billing_restoreError => '無法還原購買。請重試。';

  @override
  String get billing_managementError => '無法開啟訂閱管理。請重試。';

  @override
  String get billing_storeUnavailable => '此裝置無法使用 Google Play。';

  @override
  String get welcome_title => '您的 VPN，簡單易用。';

  @override
  String get welcome_description => '保護您的連線。掌握您的隱私。';

  @override
  String get welcome_start => '開始使用';

  @override
  String get welcome_alreadyPurchased => '已購買？';

  @override
  String get welcome_noAccountRequired => '無需建立帳戶即可開始。';

  @override
  String get guest_accountTitle => '帳戶尚未連結';

  @override
  String get guest_accountDescription =>
      '使用同一個 Google Play 帳戶還原購買項目，即可在其他裝置上使用訂閱。';

  @override
  String get guest_existingSubscriberSignIn => '已有訂閱？登入';

  @override
  String get guest_claimTitle => '隨時隨地使用 FuzeVPN';

  @override
  String get guest_claimDescription => '建立帳戶，即可在其他裝置上使用您的訂閱。此步驟為選用項目。';

  @override
  String get guest_skip => '稍後再說';

  @override
  String get guest_activationTitle => 'Fuze Premium 已啟用';

  @override
  String get guest_activationDescription => '您的訂閱已就緒。現在即可使用 VPN，並隨時建立帳戶。';

  @override
  String get guest_useVpn => '使用我的 VPN';

  @override
  String get guest_loginRequired => '此購買項目已連結至一個 FuzeVPN 帳戶。請登入該帳戶以使用您的訂閱。';

  @override
  String get guest_signOutWarning => '您可以透過同一個 Google Play 帳戶還原購買項目，找回您的訂閱。';

  @override
  String get guest_profileUnavailable => '您的帳戶已經連結。請登入以檢視和管理您的資訊。';

  @override
  String get billing_acceptance => '繼續即表示您接受使用條款和隱私權政策。';

  @override
  String get guest_verifyEmailReminder => '請確認您的電子郵件地址以保護帳戶安全。您可以繼續使用 VPN。';

  @override
  String get guest_serviceUnavailable => '服務暫時無法使用。請稍後再試。';

  @override
  String get guest_restoreError => '無法還原您的購買項目。請使用購買時的 Google Play 帳戶重試。';

  @override
  String get guest_claimSuccess => '您的帳戶已建立。訂閱和 VPN 使用權限均已保留。';

  @override
  String get guest_emailExists =>
      '此電子郵件地址已被使用。請選擇其他地址或登入現有帳戶。您的購買項目仍可透過 Google Play 使用。';

  @override
  String get guest_claimError => '無法建立您的帳戶。您可以繼續使用 VPN，並稍後再試。';

  @override
  String get guest_secureStorageError => '無法在此裝置上安全儲存您的工作階段。請重試。';

  @override
  String get guest_premiumRequired => '請選擇訂閱以啟用您的 VPN。';

  @override
  String get welcome_viewPlans => '查看方案';

  @override
  String get google_continue => '使用 Google 繼續';

  @override
  String get google_or => '或';

  @override
  String get google_title => '您的 FuzeVPN 帳戶';

  @override
  String get google_settingUp => '完成帳戶建立';

  @override
  String get google_country => '居住國家或地區';

  @override
  String get google_profileDescription => '選擇居住國家或地區並閱讀兩份文件，以建立 FuzeVPN 帳戶。';

  @override
  String get google_claimDescription => '將訪客帳戶連結至 Google。訂閱和裝置仍歸屬於此帳戶。';

  @override
  String get google_linkTitle => '將 Google 連結至 FuzeVPN';

  @override
  String get google_linkDescription =>
      '確認您對現有 FuzeVPN 帳戶的存取權限。此步驟不會要求提供 Google 密碼。';

  @override
  String get google_password => 'FuzeVPN 密碼';

  @override
  String get google_linkAccount => '確認連結';

  @override
  String get google_requestEmail => '接收確認郵件';

  @override
  String get google_emailInstructions => '開啟 FuzeVPN 郵件並輸入確認碼。';

  @override
  String get google_emailCode => '郵件確認碼';

  @override
  String get google_confirmEmail => '確認代碼';

  @override
  String get google_restart => '選擇其他 Google 帳戶';

  @override
  String get google_resume => '檢查此次嘗試';

  @override
  String get google_unavailable => 'Google 登入無法使用。您可以使用電子郵件和密碼。';

  @override
  String get google_expired => '此次嘗試已過期。請取消後重新開始。';

  @override
  String get google_conflict => '此 Google 帳戶已連結至其他帳戶。目前的帳戶和訂閱將被保留。';

  @override
  String get google_error => 'Google 登入失敗。請重試，目前的存取權限將被保留。';

  @override
  String get google_uncertain => '無法確認結果。請檢查此次嘗試，或取消後重新開始。';

  @override
  String get google_cancelFailed => '無法確認取消操作。請在離開此頁面前再次嘗試取消。';

  @override
  String get google_cancelled => '已取消 Google 登入。';

  @override
  String get google_selecting => '請選擇 Google 帳戶…';

  @override
  String get google_verifying => '正在檢查帳戶…';

  @override
  String get google_emailUnavailable => '無法傳送確認郵件。請稍後重試。';

  @override
  String get google_emailSent => '已傳送確認郵件。請檢查收件匣。';

  @override
  String get google_rateLimited => '請稍候再重試。';

  @override
  String get google_invalidPassword => 'FuzeVPN 密碼不正確。目前的帳戶將被保留。';

  @override
  String get google_invalidCode => '確認碼無效或已過期。';

  @override
  String get google_accountChanged => '工作階段已變更。請取消此次嘗試後重新開始。';

  @override
  String get google_invalidResponse => '無法驗證回應。目前的存取權限將被保留。';

  @override
  String get google_invalidRegistration => '請檢查國家或地區及兩項同意。';

  @override
  String get google_consentRequired => '選擇居住國家或地區並同意兩份文件後繼續。';

  @override
  String get google_challengeRequired => '需要額外的安全驗證。目前的存取權限將被保留。';

  @override
  String get google_challengeUnavailable => '安全驗證無法使用。請稍後重試。';

  @override
  String get billing_trialTitle => '免費試用 Fuze Premium';

  @override
  String get billing_trialSubtitle => '從今天起保護您的連線。';

  @override
  String get billing_trialWeeks => '2 週免費試用';

  @override
  String billing_trialDays(String days) {
    return '$days 天免費試用';
  }

  @override
  String get billing_trialStart => '開始免費試用';

  @override
  String billing_trialFirstCharge(String date) {
    return '如果今天開始，首次扣款預計在 $date。';
  }

  @override
  String get billing_trialTerms =>
      '按所示價格自動續訂。如需避免扣款，請在試用結束前透過 Google Play 取消訂閱。';

  @override
  String billing_trialThenMonthly(String price) {
    return '之後每月 $price';
  }

  @override
  String billing_trialThenYearly(String price) {
    return '之後每年 $price';
  }

  @override
  String get billing_choosePeriod => '選擇您的方案';

  @override
  String get billing_selectionHint => '請選擇方案以繼續。';

  @override
  String get billing_benefitConnection => '加密連線';

  @override
  String get billing_benefitPrivacy => '線上隱私';

  @override
  String get billing_benefitNoAccount => '無需強制註冊';

  @override
  String get billing_cancellation => '透過 Google Play 取消';

  @override
  String get billing_premiumTitle => '讓您的連線得到更好的保護。';

  @override
  String get billing_premiumSubtitle => '按您的需求保護連線。';

  @override
  String get billing_priceMonthly => '每月';

  @override
  String get billing_priceYearly => '每年';

  @override
  String get billing_trialToday => '今天無需付款';

  @override
  String get billing_trialConfirmation => '您確認前，Google Play 會確認日期、最終金額及適用稅費。';

  @override
  String get billing_offerChanged => '此優惠的條件已變更。請重新整理方案並重新選擇。';
}
