// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Japanese (`ja`).
class AppLocalizationsJa extends AppLocalizations {
  AppLocalizationsJa([String locale = 'ja']) : super(locale);

  @override
  String get vpnDisclosure_title => '接続を保護する';

  @override
  String get vpnDisclosure_body =>
      'FuzeVPN は Android の VPN サービス（VpnService）を使用して、この端末と FuzeVPN サーバーの間に暗号化されたトンネルを作成します。';

  @override
  String get vpnDisclosure_dataBody =>
      'VPN が有効な間、アプリのインターネット通信、宛先アドレス、DNS リクエストは、接続をルーティングするためにこのトンネルを通ります。FuzeVPN がバックグラウンドで動作している場合も同様です。';

  @override
  String get vpnDisclosure_statusBody =>
      'アプリは接続状態、接続時間、転送データ量を使用して VPN 接続を表示します。接続はいつでも停止できます。';

  @override
  String get vpnDisclosure_privacy => 'プライバシー';

  @override
  String get vpnDisclosure_accept => '同意して続行';

  @override
  String get vpnDisclosure_decline => '今はしない';

  @override
  String get accountRestoration_title => 'アカウントを一時的に利用できません';

  @override
  String get accountRestoration_message =>
      'セッションは保持されています。再試行してアカウントを復元してください。ここではVPN接続を引き続き管理できます。';

  @override
  String get action_retry => '再試行';

  @override
  String get session_endingTitle => 'セッションを終了しています';

  @override
  String get session_ending => 'セッションが無効になりました。VPNを停止し、セッションを消去しています…';

  @override
  String get session_stopFailed => 'VPNが停止したことを確認できません。もう一度サインインする前に再試行してください。';

  @override
  String get session_cleanupFailed =>
      'VPNは停止しましたが、セッションの削除を確認できません。クリーンアップを再試行してください。';

  @override
  String get session_retryStop => '停止を再試行';

  @override
  String get session_retryCleanup => 'クリーンアップを再試行';

  @override
  String get appTitle => 'FuzeVPN';

  @override
  String get startup => 'FuzeVPNを安全に準備しています…';

  @override
  String get nav_connection => '接続';

  @override
  String get nav_locations => '場所';

  @override
  String get nav_account => 'アカウント';

  @override
  String get nav_devices => 'デバイス';

  @override
  String get nav_settings => '設定';

  @override
  String get action_refresh => '更新';

  @override
  String get auth_tab_login => 'サインイン';

  @override
  String get auth_tab_register => '登録';

  @override
  String get auth_stepAccount => 'アカウント';

  @override
  String get auth_stepIdentity => '本人確認';

  @override
  String get auth_stepAddress => '住所と同意事項';

  @override
  String auth_stepProgress(Object current, Object total) {
    return '$current/$totalステップ';
  }

  @override
  String get auth_tagline => 'あなたのVPNを、もっとシンプルに。';

  @override
  String get auth_keysLocal => 'VPNの秘密鍵はこのデバイスに保存されます。';

  @override
  String get form_email => 'メールアドレス';

  @override
  String get form_password => 'パスワード';

  @override
  String get form_showPassword => 'パスワードを表示';

  @override
  String get form_hidePassword => 'パスワードを非表示';

  @override
  String get form_passwordMin => 'UTF-8で8～72バイト。一部の文字は複数バイトを使用します。';

  @override
  String get form_firstName => '名';

  @override
  String get form_lastName => '姓';

  @override
  String get form_phone => '電話番号（+33612345678）';

  @override
  String get form_address => '住所';

  @override
  String get form_address2 => '住所2（任意）';

  @override
  String get form_postalCode => '郵便番号';

  @override
  String get form_city => '市区町村';

  @override
  String get form_country => '国コード（例：FR）';

  @override
  String get action_login => 'サインイン';

  @override
  String get action_createAccount => 'アカウントを作成';

  @override
  String get action_createMyAccount => '自分のアカウントを作成';

  @override
  String get action_next => '続行';

  @override
  String get action_previous => '戻る';

  @override
  String get action_forgotPassword => 'パスワードをお忘れですか？';

  @override
  String get auth_noAccount => 'まだアカウントをお持ちではありませんか？';

  @override
  String get auth_requiredInformation => '3つのステップでアカウントを作成します。';

  @override
  String get auth_termsPrefix => '次に同意します：';

  @override
  String get auth_termsLink => '利用規約';

  @override
  String get auth_privacyPrefix => '次に同意します：';

  @override
  String get auth_privacyLink => 'プライバシーポリシー';

  @override
  String get auth_consentRequired => 'アカウントを作成するには同意が必要です。';

  @override
  String get validation_required => 'この項目は必須です。';

  @override
  String get validation_email => '有効なメールアドレスを入力してください。';

  @override
  String get validation_password => 'パスワードが短すぎます：UTF-8で8バイト以上必要です。';

  @override
  String get validation_passwordTooLong => 'パスワードが長すぎます：UTF-8で72バイト以下にしてください。';

  @override
  String get validation_phone => '国際形式を使用してください（例：+33612345678）。';

  @override
  String get validation_country => '2文字の国コードを使用してください（例：FR）。';

  @override
  String get passwordReset_title => 'パスワードをリセット';

  @override
  String get passwordReset_description =>
      'パスワードリセット用リンクをリクエストするには、アカウントのメールアドレスを入力してください。';

  @override
  String get passwordReset_send => 'リンクを送信';

  @override
  String get connection_title => '接続';

  @override
  String get connection_subtitle => '場所を選択してから、VPNをオンにしてください。';

  @override
  String get connection_prepare => '接続の準備はできましたか？';

  @override
  String get connection_advancedOptions => '詳細オプション';

  @override
  String get connection_location => '場所';

  @override
  String get connection_chooseLocation => '場所を選択';

  @override
  String get connection_protocol => 'プロトコル';

  @override
  String get connection_connect => '接続';

  @override
  String get connection_connecting => '接続しています…';

  @override
  String get connection_disconnect => '切断';

  @override
  String get connection_disconnecting => '切断しています';

  @override
  String get connection_locationChange => '場所を変更しています…';

  @override
  String connection_unavailable(Object protocol) {
    return '$protocolは利用できません';
  }

  @override
  String get connection_activeLocation => '現在の場所';

  @override
  String get connection_duration => '接続時間';

  @override
  String get connection_received => '受信';

  @override
  String get connection_sent => '送信';

  @override
  String get connection_lastHandshake => '最後の安全な交換';

  @override
  String connection_handshakeAgo(Object duration) {
    return '$duration前';
  }

  @override
  String get verification_title => 'メールアドレスを確認';

  @override
  String get verification_message => 'このスマートフォンでVPNを使用するには、メールアドレスを確認してください。';

  @override
  String get verification_resend => 'メールを再送信';

  @override
  String get migration_title => '場所の変更';

  @override
  String get migration_draining => '場所の変更を準備しています…';

  @override
  String get migration_activating => '新しいサーバーを有効にしています…';

  @override
  String get migration_ready => '場所を更新しました。';

  @override
  String get migration_blocked =>
      '場所の変更にはサーバー側の対応が必要です。後でもう一度試すか、サポートに連絡してください。';

  @override
  String get migration_progress => '場所の変更の進行状況';

  @override
  String migration_retryDelay(Object seconds) {
    return 'チェック間隔：$seconds秒。';
  }

  @override
  String get migration_resume => '場所の変更を再開';

  @override
  String get status_authorizing => '権限が必要です';

  @override
  String get status_authorizingDetail => 'VPNを許可するAndroidのリクエストを承認してください。';

  @override
  String get status_preparing => '準備中';

  @override
  String get status_preparingDetail => '安全な接続を準備しています。';

  @override
  String get status_reconnecting => '再接続しています…';

  @override
  String get status_reconnectingDetail => '接続が中断されました。VPNが再接続を試みています。';

  @override
  String get status_connecting => '接続中';

  @override
  String get status_connectingDetail => 'VPNサーバーに接続しています…';

  @override
  String get status_connected => '接続済み';

  @override
  String get status_connectedDetail => 'VPN接続は有効です。';

  @override
  String get status_disconnecting => '切断中';

  @override
  String get status_disconnectingDetail => 'VPN接続を停止しています。';

  @override
  String get status_error => '接続を利用できません';

  @override
  String get status_errorDetail => 'VPN接続を確認できません。もう一度試してください。';

  @override
  String get status_idle => '切断済み';

  @override
  String get status_idleDetail => '接続を保護するにはVPNに接続してください。';

  @override
  String get trust_note => 'アプリを閉じてもVPNは停止しません。停止するには「切断」を使用してください。';

  @override
  String get locations_none => '現在利用できる場所はありません。';

  @override
  String get locations_available => '次の場所を選択してください。';

  @override
  String get locations_selected => '選択中の場所';

  @override
  String get locations_select => 'この場所を選択';

  @override
  String get locations_lockedTunnel => '場所を変更するにはVPNを切断してください。';

  @override
  String get locations_lockedMigration => '場所の変更が完了するまでお待ちください。';

  @override
  String get devices_title => 'デバイス';

  @override
  String devices_used(Object count, Object limit) {
    return '$count / $limit台のデバイス';
  }

  @override
  String get devices_refresh => 'デバイスを更新';

  @override
  String get devices_empty => 'VPNデバイスはまだ登録されていません。';

  @override
  String get devices_firstConnection => '最初の接続時にスマートフォンが追加されます。';

  @override
  String get devices_thisDevice => 'このデバイス';

  @override
  String devices_added(Object date) {
    return '$dateに追加';
  }

  @override
  String get action_remove => '削除';

  @override
  String get settings_title => '設定';

  @override
  String get settings_subtitle => '好みの設定とアカウントを一か所で管理できます。';

  @override
  String get settings_appearance => '表示';

  @override
  String get settings_language => '言語';

  @override
  String get settings_languageDescription => '選択した言語はVPN通知にも適用されます。';

  @override
  String get settings_account => 'アカウント';

  @override
  String get settings_signOut => 'サインアウト';

  @override
  String get settings_privacy => 'プライバシーポリシー';

  @override
  String get settings_terms => '利用規約';

  @override
  String get settings_security => 'セキュリティと透明性';

  @override
  String get settings_licenses => 'コンポーネントのライセンス';

  @override
  String get settings_licensesDetail => 'アプリで使用しているソフトウェア';

  @override
  String get settings_background =>
      'アプリを離れてもVPNはオンのままです。停止するには「接続」タブの「切断」を使用してください。';

  @override
  String get theme_system => 'システム設定';

  @override
  String get theme_light => 'ライト';

  @override
  String get theme_dark => 'ダーク';

  @override
  String get language_system => 'スマートフォンの言語';

  @override
  String get language_fr => 'Français';

  @override
  String get language_en => 'English';

  @override
  String get language_es => 'Español';

  @override
  String get language_de => 'Deutsch';

  @override
  String get dialog_removeDevice => 'このデバイスを削除しますか？';

  @override
  String get dialog_removeCurrent =>
      'このスマートフォンはVPNから切断され、アクセスできなくなります。サーバーが確認した後、VPN接続データが削除されます。';

  @override
  String dialog_removeOther(Object name) {
    return '「$name」のVPNアクセスを取り消します。この操作は元に戻せません。';
  }

  @override
  String get dialog_signOut => 'サインアウトしますか？';

  @override
  String get dialog_signOutMessage =>
      'VPNが停止し、再度サインインする必要があります。暗号化されたVPNキーは次回の接続のため、このスマートフォンに保存されます。';

  @override
  String get action_cancel => 'キャンセル';

  @override
  String get action_signOut => 'サインアウト';

  @override
  String get notice_close => 'メッセージを閉じる';

  @override
  String get notice_sessionExpired_title => 'セッションの有効期限が切れました';

  @override
  String get notice_sessionExpired_message =>
      'セッションの有効期限が切れました。もう一度サインインしてください。';

  @override
  String get notice_connectionFailed_title => '接続に失敗しました';

  @override
  String get notice_invalidCredentials_message => 'メールアドレスまたはパスワードが正しくありません。';

  @override
  String get notice_emailVerification_title => 'メールの確認が必要です';

  @override
  String get notice_emailVerification_message =>
      'VPNデバイスを追加する前に、メールアドレスを確認してください。';

  @override
  String get notice_rateLimited_title => '試行回数が多すぎます';

  @override
  String get notice_deviceLimit_title => '2台のデバイス上限に達しました';

  @override
  String get notice_deviceLimit_message => '別のデバイスを追加する前に、既存のデバイスを削除してください。';

  @override
  String get notice_identityRenewal_title => 'VPN IDの更新が必要です';

  @override
  String get notice_identityRenewal_message =>
      'このIDは削除されました。新しいローカルIDを作成してください。';

  @override
  String get notice_migrationPending_title => '場所を変更しています';

  @override
  String get notice_migrationPending_message => '場所の変更はすでに進行中です。';

  @override
  String get notice_migrationBlocked_title => '場所の変更がブロックされました';

  @override
  String get notice_migrationBlocked_message =>
      '場所の変更にはサーバー側の対応が必要です。後でもう一度試すか、サポートに連絡してください。';

  @override
  String get notice_targetUnavailable_title => 'サーバーを一時的に利用できません';

  @override
  String get notice_targetUnavailable_message => 'このサーバーは一時的に利用できません。';

  @override
  String get notice_networkUnavailable_title => 'インターネット接続を利用できません';

  @override
  String get notice_networkUnavailable_message => '接続を確認して、もう一度試してください。';

  @override
  String get notice_permissionDenied_title => 'VPN権限が拒否されました';

  @override
  String get notice_permissionDenied_message =>
      '接続をもう一度開始し、Androidの権限リクエストを承認してください。';

  @override
  String get notice_wireguardTimeout_title => 'サーバーが応答していません';

  @override
  String get notice_wireguardTimeout_message =>
      'WireGuard接続に時間がかかりすぎました。もう一度試すか、別の場所を選択してください。';

  @override
  String get notice_tlsFailed_title => '安全な接続が拒否されました';

  @override
  String get notice_tlsFailed_message =>
      'サーバーがOpenVPN接続を受け付けませんでした。もう一度試してください。問題が続く場合は、診断を実行してください。';

  @override
  String get notice_tunRejected_title => 'AndroidがVPNインターフェースを拒否しました';

  @override
  String get notice_tunRejected_message =>
      'AndroidがOpenVPNから要求されたネットワーク設定を拒否しました。';

  @override
  String get notice_openvpnStart_title => 'OpenVPNを起動できませんでした';

  @override
  String get notice_openvpnStart_message =>
      'OpenVPNエンジンの起動を完了できませんでした。もう一度試してください。問題が解決しない場合は、サポートに連絡してください。';

  @override
  String notice_diagnosticCode(Object code) {
    return '診断コード：$code';
  }

  @override
  String get notice_generic_title => 'VPN接続に失敗しました';

  @override
  String get notice_generic_message => 'エラーが発生しました。後でもう一度試してください。';

  @override
  String notice_controller_title(String code) {
    String _temp0 = intl.Intl.selectLogic(code, {
      'account_created_email_unavailable': 'アカウントを作成しました',
      'password_reset_sent': 'パスワードリセットのリクエストを受け付けました',
      'verification_email_sent': '確認メールを送信しました',
      'location_migration_pending': '場所を変更しています',
      'vpn_sign_in_required': 'サインインが必要です',
      'protocol_unavailable_at_location': 'プロトコルを利用できません',
      'vpn_permission_denied': 'VPN権限が拒否されました',
      'revoked_identity_device_limit': '2台のデバイス上限に達しました',
      'tunnel_start_unexpected': 'VPNを起動できませんでした',
      'flutter_disconnect_timeout': '切断を確認できません',
      'flutter_disconnect_unexpected': '切断できませんでした',
      'device_revoked': 'デバイスを削除しました',
      'revoke_unexpected': 'デバイスを削除できませんでした',
      'identity_renewal_unexpected': 'IDを更新できませんでした',
      'openvpn_renewal_unexpected': 'OpenVPNを更新できませんでした',
      'location_migration_blocked': '場所の変更がブロックされました',
      'location_migration_slow': '場所の変更がまだ進行中です',
      'location_migration_conflict': '場所の変更には更新が必要です',
      'location_migration_verification_failed': '場所の変更を確認できません',
      'location_migration_device_changed': '場所の変更中にデバイスが変更されました',
      'tunnel_stop_failed': '場所を変更できません',
      'other': '操作に失敗しました',
    });
    return '$_temp0';
  }

  @override
  String notice_controller_message(String code, String target) {
    String _temp0 = intl.Intl.selectLogic(code, {
      'account_created_email_unavailable':
          'アカウントは作成されましたが、確認メールを送信できませんでした。アプリで再送信を使用してください。',
      'password_reset_sent':
          'リクエストを受け付けました。このアドレスに一致するアカウントがある場合、メールが届くことがあります。迷惑メールフォルダーも確認してください。',
      'verification_email_sent': '新しい確認メールを送信しました。',
      'location_migration_pending': '$targetへの移動はまだ準備中です。デバイスを作り直さずに再開できます。',
      'vpn_sign_in_required': 'VPNを開始する前に、アカウントにサインインしてください。',
      'protocol_unavailable_at_location':
          '選択したプロトコルはこの場所では提供されていません。場所を更新するか、別のプロトコルを選択してください。',
      'vpn_permission_denied':
          'AndroidがVPN権限を拒否しました。接続をもう一度開始し、システムのリクエストを承認してください。',
      'revoked_identity_device_limit':
          'このデバイスのVPNアクセスが削除され、デバイス上限に達しました。アカウント → デバイスを管理からデバイスを削除してください。',
      'tunnel_start_unexpected':
          '予期しないエラーによりトンネルの準備が中断されました。診断コードを確認して、もう一度試してください。',
      'flutter_disconnect_timeout':
          'AndroidはVPNが時間内に停止したことを確認しませんでした。もう一度停止してください。',
      'flutter_disconnect_unexpected': '予期しないエラーにより、トンネルが停止したことを確認できませんでした。',
      'device_revoked': 'デバイスのVPNアクセスが取り消され、ローカルの秘密情報が削除されました。',
      'revoke_unexpected': 'デバイスを削除できませんでした。リストを更新して、もう一度試してください。',
      'identity_renewal_unexpected':
          '新しいVPN IDを作成できませんでした。デバイスを更新して、もう一度試してください。',
      'openvpn_renewal_unexpected':
          'OpenVPNプロファイルを更新できませんでした。もう一度試すか、診断コードを確認してください。',
      'location_migration_blocked': 'サーバーは現在この変更を完了できません。デバイスとローカルIDは保持されています。',
      'location_migration_slow':
          'サーバーは$targetへの移動をまだ準備中です。しばらくしてから「再開」を使用してください。',
      'location_migration_conflict':
          'サーバー上でデバイスの状態が変更されました。デバイスを更新してから、変更を再開してください。',
      'location_migration_verification_failed':
          'サーバーが新しい場所を確認しませんでした。以前のローカルIDは保持されています。',
      'location_migration_device_changed':
          'サーバーから返されたデバイスが、変更中のデバイスと一致しません。もう一度試す前にデバイスを更新してください。',
      'tunnel_stop_failed': '新しい接続を開始する前に、以前のトンネルを完全に停止する必要があります。',
      'other': '操作を完了できませんでした。もう一度試すか、診断コードをサポートに送信してください。',
    });
    return '$_temp0';
  }

  @override
  String notice_api_title(String code) {
    String _temp0 = intl.Intl.selectLogic(code, {
      'unauthorized': 'セッションの有効期限が切れました',
      'invalid_credentials': 'サインインに失敗しました',
      'email_verification_required': 'メールの確認が必要です',
      'verification_email_cooldown': 'メールはすでに送信されています',
      'rate_limited': '試行回数が多すぎます',
      'invalid_registration': '情報を修正する必要があります',
      'email_exists': 'アカウントはすでに存在します',
      'invalid_profile': '無効なプロフィールです',
      'invalid_device': '無効なデバイスです',
      'invalid_location': '場所を利用できません',
      'device_limit': 'デバイス上限に達しました',
      'device_exists': 'VPN IDはすでに使用されています',
      'device_identity_revoked': 'VPN IDの更新が必要です',
      'device_location_locked': '場所の変更には更新が必要です',
      'location_migration_pending': '場所を変更しています',
      'location_migration_blocked': '場所の変更がブロックされました',
      'target_ca_mismatch': '互換性のないOpenVPNサーバーです',
      'location_migration_conflict': '場所の変更には更新が必要です',
      'server_full': 'サーバーが満員です',
      'capacity_unavailable': '場所を一時的に利用できません',
      'target_unavailable': 'サーバーを一時的に利用できません',
      'not_found': '項目が見つかりません',
      'invalid_openvpn_csr': '無効なOpenVPN IDです',
      'openvpn_profile_exists': 'OpenVPNプロファイルはすでに存在します',
      'openvpn_profile_revoked': 'OpenVPNプロファイルが取り消されました',
      'openvpn_operation_pending': 'OpenVPN操作が進行中です',
      'openvpn_operation_terminal': 'OpenVPN操作が中断されました',
      'openvpn_address_unavailable': 'OpenVPNアドレスを利用できません',
      'openvpn_profile_conflict': 'OpenVPNの競合です',
      'openvpn_signer_unavailable': 'OpenVPNを利用できません',
      'email_delivery_unavailable': 'メールを利用できません',
      'invalid_token': '無効なリンクです',
      'network_unavailable': 'インターネット接続を利用できません',
      'invalid_json': '無効なリクエストです',
      'invalid_api_response': '無効なサーバー応答です',
      'ipv6_unavailable': 'IPv6を利用できません',
      'invalid_ip_families': 'ネットワーク設定が拒否されました',
      'other': 'サービスを利用できません',
    });
    return '$_temp0';
  }

  @override
  String notice_api_message(String code) {
    String _temp0 = intl.Intl.selectLogic(code, {
      'unauthorized': 'セッションの有効期限が切れました。もう一度サインインしてください。',
      'invalid_credentials': 'メールアドレスまたはパスワードが正しくありません。',
      'email_verification_required': 'VPNデバイスを追加する前に、メールアドレスを確認してください。',
      'invalid_registration': '要求された情報と同意事項を確認してください。',
      'email_exists': 'このメールアドレスを使用するアカウントがすでに存在します。',
      'invalid_profile': 'プロフィール情報を確認してください。',
      'invalid_device': 'このデバイスの名前またはローカルIDが無効です。',
      'invalid_location': '場所のリストを更新して、もう一度試してください。',
      'device_limit': '別のデバイスを追加する前に、既存のデバイスを削除してください。',
      'device_exists': 'このVPN IDはすでに別のアカウントにリンクされています。',
      'device_identity_revoked': 'このIDは削除されました。新しいローカルIDを作成する必要があります。',
      'device_location_locked': 'このデバイスの場所が変更されたばかりです。アプリは進行中の変更を再開します。',
      'location_migration_pending': '場所の変更はすでに進行中です。',
      'location_migration_blocked':
          '場所の変更にはサーバー側の対応が必要です。後でもう一度試すか、サポートに連絡してください。',
      'target_ca_mismatch': 'このサーバーは現在のOpenVPNプロファイルとまだ互換性がありません。',
      'location_migration_conflict': 'デバイスを更新してから、場所の変更をもう一度試してください。',
      'server_full': 'この場所は接続上限に達しています。別の場所を選択するか、後でもう一度試してください。',
      'capacity_unavailable':
          'この場所が現在利用可能かどうかを確認できません。別の場所を選択するか、後でもう一度試してください。',
      'target_unavailable': 'このサーバーは一時的に利用できません。',
      'not_found': 'この項目はアカウントで利用できなくなりました。',
      'invalid_openvpn_csr': '新しいOpenVPN IDを作成して、もう一度試してください。',
      'openvpn_profile_exists': 'このデバイスにはOpenVPNプロファイルがすでに存在します。',
      'openvpn_profile_revoked': '続行するにはOpenVPNプロファイルを更新してください。',
      'openvpn_operation_pending': '変更はまだ反映中です。後でもう一度試してください。',
      'openvpn_operation_terminal': '新しいOpenVPN IDを作成して、もう一度試してください。',
      'openvpn_address_unavailable': '現在利用できるOpenVPNアドレスはありません。',
      'openvpn_profile_conflict': 'プロファイルが変更されました。デバイスを更新して、もう一度試してください。',
      'openvpn_signer_unavailable': 'OpenVPNサービスは一時的に利用できません。',
      'email_delivery_unavailable': 'メールを送信できませんでした。後でもう一度試してください。',
      'invalid_token': 'このリンクは無効か、有効期限が切れています。新しいリンクをリクエストしてください。',
      'network_unavailable': 'インターネット接続を確認して、もう一度試してください。',
      'invalid_json': '入力した情報を確認して、もう一度試してください。',
      'invalid_api_response': 'サーバーから予期しない応答が返されました。後でもう一度試してください。',
      'ipv6_unavailable': 'サーバーは現在IPv6を有効にできません。後でもう一度試してください。',
      'invalid_ip_families': 'トンネル設定が不完全か、認証済みアドレスと一致しません。アプリからもう一度試してください。',
      'other': 'サーバーエラーが発生しました。後でもう一度試してください。',
    });
    return '$_temp0';
  }

  @override
  String get notice_retryLater => 'しばらくしてからもう一度試してください。';

  @override
  String notice_retryAfter(Object seconds) {
    return '$seconds秒後にもう一度試してください。';
  }

  @override
  String notice_native_title(String code, String protocol) {
    String _temp0 = intl.Intl.selectLogic(code, {
      'system_vpn_resume_unavailable': 'システムVPNの再開を利用できません',
      'system_vpn_resume_corrupt': 'システムVPNの再開情報が無効です',
      'system_vpn_resume_session_invalid': 'VPN再開セッションが無効です',
      'system_vpn_resume_identity_changed': 'VPN IDが変更されました',
      'system_vpn_resume_identity_invalid': 'VPN再開IDが無効です',
      'system_vpn_resume_storage_failed': 'VPN再開用ストレージを利用できません',
      'system_vpn_resume_network_timeout': 'VPN再開時にネットワークがありません',
      'system_vpn_resume_blocked': 'VPNの再開がブロックされました',
      'system_vpn_resume_failed': 'VPNの再開に失敗しました',
      'system_vpn_resume_error_invalid': 'VPN再開エラーが無効です',
      'wireguard_identity_store_failed': 'WireGuard IDを保存できません',
      'wireguard_identity_unavailable': 'WireGuard IDを利用できません',
      'vpn_host_destroyed': 'Android VPNホストが停止しました',
      'vpn_host_unavailable': 'Android VPNホストを利用できません',
      'vpn_permission_required': 'VPN権限が必要です',
      'vpn_permission_denied': 'VPN権限が拒否されました',
      'vpn_permission_request_failed': '権限をリクエストできませんでした',
      'wireguard_foreground_service_unavailable': 'WireGuardサービスを利用できません',
      'wireguard_identity_invalid': 'ローカルWireGuardキーが無効です',
      'wireguard_identity_in_use': 'WireGuard IDはすでに使用されています',
      'wireguard_configuration_invalid': 'WireGuard設定が無効です',
      'wireguard_operation_pending': 'WireGuard操作がまだアクティブです',
      'wireguard_start_failed': 'WireGuardの起動が拒否されました',
      'wireguard_stop_timeout': 'WireGuardの停止を確認できません',
      'wireguard_handshake_timeout': 'WireGuardが応答しません',
      'openvpn_connection_timeout': 'OpenVPNが応答しません',
      'openvpn_core_unavailable': 'OpenVPNエンジンを利用できません',
      'openvpn_operation_pending': 'OpenVPNセッションがまだアクティブです',
      'openvpn_stop_timeout': 'OpenVPNの停止を確認できません',
      'openvpn_profile_unavailable': 'ローカルOpenVPNプロファイルがありません',
      'openvpn_native_failed': 'ネイティブOpenVPN呼び出しが中断されました',
      'openvpn_key_generation_failed': 'OpenVPN P-256キーを作成できませんでした',
      'openvpn_csr_generation_failed': 'OpenVPN CSRを作成できませんでした',
      'openvpn_identity_store_failed': 'OpenVPN IDを保存できません',
      'openvpn_identity_clear_failed': 'OpenVPNの削除が不完全です',
      'openvpn_identity_in_use': 'OpenVPN IDはまだ使用中です',
      'openvpn_tls_verification_required': 'OpenVPN TLS検証がありません',
      'openvpn_cipher_invalid': 'OpenVPN暗号方式が無効です',
      'openvpn_profile_rejected': 'OpenVPNプロファイルが拒否されました',
      'openvpn_identity_inconsistent': 'OpenVPN IDに一貫性がありません',
      'tls_handshake_failed': 'OpenVPNネゴシエーションが拒否されました',
      'tls_alert_unknown_ca': 'OpenVPNクライアント証明書を認識できません',
      'tls_alert_bad_certificate': 'OpenVPNクライアント証明書が拒否されました',
      'tls_alert_unsupported_certificate': 'サポートされていないOpenVPN証明書です',
      'tls_client_certificate_required': 'OpenVPNクライアント証明書が必要です',
      'tls_alert_misc': 'OpenVPN TLSアラート',
      'tls_signature_algorithm_rejected': 'サポートされていないOpenVPN署名です',
      'tls_handshake_rejected': 'OpenVPN TLSネゴシエーションが拒否されました',
      'tls_version_rejected': '互換性のないOpenVPN TLSバージョンです',
      'tls_certificate_expired': 'TLS証明書の有効期限が切れています',
      'tls_certificate_revoked': 'TLS証明書が取り消されました',
      'transport_failed': 'OpenVPNサーバーに接続できません',
      'tun_configuration_rejected': 'OpenVPNインターフェースを作成できませんでした',
      'tun_setup_failed': 'OpenVPN TUNの設定に失敗しました',
      'tun_interface_create_failed': 'OpenVPNインターフェースの作成に失敗しました',
      'tun_interface_disabled': 'OpenVPNインターフェースが無効です',
      'tun_halted': 'OpenVPNインターフェースが中断されました',
      'tun_already_established': 'OpenVPNインターフェースはすでに開いています',
      'tun_addresses_missing': 'OpenVPNアドレスがありません',
      'tun_routes_missing': 'OpenVPNルートがありません',
      'tun_dns_missing': 'OpenVPN DNSがありません',
      'tun_permission_revoked': 'VPN権限が取り消されました',
      'tun_establish_returned_null': 'AndroidがVPNインターフェースを拒否しました',
      'openvpn_service_start_failed': 'OpenVPNサービスを利用できません',
      'openvpn_operation_timeout': 'OpenVPN呼び出しがタイムアウトしました',
      'openvpn_start_failed': 'OpenVPNの起動が拒否されました',
      'openvpn_connection_failed': 'OpenVPN接続が中断されました',
      'openvpn_core_status_error': 'OpenVPN Coreがエラーで終了しました',
      'openvpn_stopped_before_connected': 'OpenVPNは接続前に停止しました',
      'openvpn_auth_failed': 'OpenVPN認証が拒否されました',
      'openvpn_client_setup_failed': 'OpenVPNクライアントの設定に失敗しました',
      'openvpn_client_halted': 'OpenVPNクライアントが中断されました',
      'openvpn_client_restart': 'OpenVPNの再起動がリクエストされました',
      'openvpn_inactive_timeout': 'OpenVPNが長時間非アクティブでした',
      'openvpn_session_expired': 'OpenVPNセッションの有効期限が切れました',
      'openvpn_credentials_required': 'サポートされていないOpenVPN認証です',
      'openvpn_proxy_failed': 'OpenVPN中継トランスポートに失敗しました',
      'openvpn_compression_failed': 'OpenVPN圧縮が拒否されました',
      'openvpn_ntlm_crypto_unavailable': 'OpenVPN NTLM暗号化を利用できません',
      'openvpn_feature_unsupported': 'サポートされていないOpenVPN機能です',
      'network_unavailable': 'インターネット接続を利用できません',
      'network_lost': 'ネットワークを利用できません',
      'certificate_validation_failed': 'サーバー証明書が拒否されました',
      'openvpn_certificate_expired': 'OpenVPN証明書の有効期限が切れています',
      'tunnel_active_for_another_account': '別のアカウントのトンネルがまだアクティブです',
      'tunnel_already_active': 'ネイティブトンネルはすでにアクティブです',
      'tunnel_stop_timeout': '$protocolの停止を確認できません',
      'tunnel_disconnected': '$protocolが中断されました',
      'native_bridge_unavailable': 'Androidブリッジを利用できません',
      'native_operation_failed': 'Android操作が中断されました',
      'invalid_arguments': 'VPNパラメーターが不完全です',
      'invalid_account_id': 'VPNアカウントが無効です',
      'invalid_device_id': 'デバイス識別子が無効です',
      'storage_key_not_allowed': 'ストレージキーが拒否されました',
      'secure_storage_read_failed': '安全な読み取りに失敗しました',
      'secure_storage_write_failed': '安全な書き込みに失敗しました',
      'key_generation_failed': 'WireGuardキーを生成できませんでした',
      'csr_generation_failed': 'OpenVPN CSRを生成できませんでした',
      'other': '分類されていないネイティブVPNエラー',
    });
    return '$_temp0';
  }

  @override
  String notice_native_message(String code, String protocol) {
    String _temp0 = intl.Intl.selectLogic(code, {
      'system_vpn_resume_unavailable':
          'Androidは再開できるVPNセッションを見つけられません。アプリで新しい接続を開始してください。',
      'system_vpn_resume_corrupt': '保存されたVPN再開データが無効なため使用しません。新しい接続を開始してください。',
      'system_vpn_resume_session_invalid':
          '保存されたセッションではVPNを再開できません。アプリでもう一度サインインしてください。',
      'system_vpn_resume_identity_changed':
          'ローカルVPN IDが変更されました。再開を停止しました。新しい接続を開始してください。',
      'system_vpn_resume_identity_invalid': '再開用のIDが無効です。新しい接続を開始してください。',
      'system_vpn_resume_storage_failed':
          'Androidは暗号化された再開データを読み取るか更新できませんでした。新しい接続を開始してください。',
      'system_vpn_resume_network_timeout':
          'AndroidはVPNを再開する時間内にネットワークを見つけられませんでした。ネットワークが利用できるときにもう一度試してください。',
      'system_vpn_resume_blocked':
          'VPNの再開がブロックされています。Androidの設定を確認してから、新しい接続を開始してください。',
      'system_vpn_resume_failed': 'Android VPNの再開に失敗しました。アプリで新しい接続を開始してください。',
      'system_vpn_resume_error_invalid':
          'Androidが使用できない再開エラーを返しました。新しい接続を開始してください。',
      'wireguard_identity_store_failed':
          'Androidはこのアカウントの暗号化されたWireGuard IDを保存できませんでした。',
      'wireguard_identity_unavailable': 'この接続に使用できるWireGuard IDがありません。',
      'vpn_host_destroyed': 'VPNをホストするAndroidコンポーネントが停止しました。新しい接続を開始してください。',
      'vpn_host_unavailable':
          'AndroidはVPNをホストするコンポーネントを作成できません。VPN設定を確認してからもう一度試してください。',
      'openvpn_renewal_required': '接続する前に、アプリで証明書への対応が必要です。',
      'openvpn_recovery_failed': '自動復旧に失敗しました。アプリで新しい接続を開始してください。',
      'openvpn_recovery_exhausted': '自動復旧はすでに使用されています。アプリで新しい接続を開始してください。',
      'vpn_permission_required': 'トンネルを開始する前に、Androidで新しいVPN認証が必要です。',
      'vpn_permission_denied': '続行するには、AndroidのリクエストでFuzeVPNを許可してください。',
      'vpn_permission_request_failed': 'AndroidはVPN権限画面を開けませんでした。',
      'wireguard_foreground_service_unavailable':
          'AndroidはWireGuardサービスをフォアグラウンドで維持できませんでした。',
      'wireguard_identity_invalid': 'このアカウントの暗号化されたWireGuardキーを読み取れないか、無効です。',
      'wireguard_identity_in_use': '別の操作がこのアカウントのWireGuardキーをまだ使用しています。',
      'wireguard_configuration_invalid':
          '受信したWireGuardアドレス、DNS、サーバーキー、またはルートが無効です。',
      'wireguard_operation_pending': '前回のWireGuard操作はまだネイティブサービスを解放していません。',
      'wireguard_start_failed': 'WireGuardエンジンが設定の有効化を拒否しました。',
      'wireguard_stop_timeout': 'WireGuardサービスは制限時間内にVPNインターフェースの解放を確認しませんでした。',
      'wireguard_handshake_timeout': 'トンネルは制限時間内にサーバーとのハンドシェイクを確認できませんでした。',
      'openvpn_connection_timeout': 'OpenVPNは制限時間内にサーバーへの接続を確認しませんでした。',
      'openvpn_core_unavailable': 'このアプリのバージョンには使用できるOpenVPNエンジンが含まれていません。',
      'openvpn_operation_pending':
          'ネイティブエンジンが前回のOpenVPNセッションを保持しており、2つ目のセッションの作成を拒否しています。',
      'openvpn_stop_timeout': 'OpenVPN Coreは制限時間内にネイティブセッションの停止と破棄を確認しませんでした。',
      'openvpn_profile_unavailable': 'この接続で検証済みのOpenVPNプロファイルを読み取れません。',
      'openvpn_native_failed':
          'アプリのエラーによりOpenVPNが中断されました。もう一度接続してください。問題が続く場合は、診断を実行してください。',
      'openvpn_key_generation_failed':
          'Android KeystoreはエクスポートできないP-256秘密鍵を作成または読み取れませんでした。',
      'openvpn_csr_generation_failed':
          'Android KeystoreキーでOpenVPN証明書リクエストに署名できませんでした。',
      'openvpn_identity_store_failed':
          'OpenVPN証明書またはプロファイルを暗号化ストレージに保存できませんでした。',
      'openvpn_identity_clear_failed':
          'AndroidはこのアカウントのローカルOpenVPN ID全体を削除できませんでした。',
      'openvpn_identity_in_use': 'ネイティブOpenVPNセッションがこのデバイスのキーまたは証明書をまだ使用しています。',
      'openvpn_tls_verification_required': 'プロファイルでサーバー証明書の検証が明示的に必須になっていません。',
      'openvpn_cipher_invalid': 'サーバーが許可リストにない暗号化アルゴリズムを提供しました。',
      'openvpn_profile_rejected':
          'サーバーから受け取ったプロファイルは互換性がありません。このデバイスを作り直して、もう一度試してください。',
      'openvpn_identity_inconsistent':
          '証明書がこのスマートフォンの安全なIDと一致しません。ローカルプロファイルは置き換えられていません。',
      'tls_handshake_failed':
          'サーバーがTLSネゴシエーションを拒否しました。問題が続く場合はプロファイルを作り直してください。',
      'tls_alert_unknown_ca':
          'サーバーはこのデバイス証明書の認証局を認識していません。OpenVPNサーバーを確認する必要があります。',
      'tls_alert_bad_certificate':
          'サーバーがこのデバイス証明書を拒否しました。もう一度試す前にデバイスを作り直してください。',
      'tls_alert_unsupported_certificate':
          'サーバーはAndroidが使用する安全な証明書形式をサポートしていません。',
      'tls_client_certificate_required':
          'サーバーはクライアント証明書を要求しましたが、OpenVPN Coreは提示できませんでした。',
      'tls_alert_misc': 'サーバーが証明書とバージョン以外のTLSアラートを返しました。',
      'tls_signature_algorithm_rejected':
          'サーバーがAndroid KeystoreキーのECDSA P-256アルゴリズムを拒否しました。',
      'tls_handshake_rejected': 'サーバーが接続前にTLSネゴシエーションを中断しました。',
      'tls_version_rejected': 'クライアントとサーバーに共通するTLSバージョンがありませんでした。',
      'tls_certificate_expired': '接続中に提示された証明書の有効期限が切れています。',
      'tls_certificate_revoked': '接続中に提示された証明書は取り消されています。',
      'transport_failed': '現在のネットワークでOpenVPNサーバーが応答していません。しばらくしてからもう一度試してください。',
      'tun_configuration_rejected': 'AndroidがOpenVPNから要求されたネットワーク設定を拒否しました。',
      'tun_setup_failed': 'OpenVPN CoreはAndroidインターフェースを作成する前にネットワーク計画を拒否しました。',
      'tun_interface_create_failed':
          'OpenVPN CoreはAndroid VpnServiceからTUNインターフェースを取得できませんでした。',
      'tun_interface_disabled':
          'AndroidまたはOpenVPN Coreが接続中にTUNインターフェースを無効にしました。',
      'tun_halted': 'OpenVPN CoreはTUNインターフェースの停止リクエストを受け取りました。',
      'tun_already_established':
          'OpenVPNが同じ接続で2つ目のインターフェースを要求しました。安全のためトンネルを停止しました。',
      'tun_addresses_missing': 'サーバーが使用できるトンネルアドレスを提供しませんでした。',
      'tun_routes_missing': 'サーバーが使用できるトンネルルートを提供しませんでした。',
      'tun_dns_missing': 'サーバーが使用できるDNSサーバーを提供しませんでした。',
      'tun_permission_revoked': 'Androidが接続中にVPN権限を取り消しました。',
      'tun_establish_returned_null':
          'Androidがインターフェースを作成しませんでした。通常、別のVPNがまだアクティブなことが原因です。',
      'openvpn_service_start_failed': 'AndroidはOpenVPNフォアグラウンドサービスを開始できませんでした。',
      'openvpn_operation_timeout': 'OpenVPN CoreへのJNI呼び出しが最大実行時間を超えました。',
      'openvpn_start_failed':
          'Androidサービスの準備はできていますが、OpenVPN Coreはプロファイルの開始を受け付けませんでした。',
      'openvpn_connection_failed': 'CONNECTEDイベントを発生させる前にOpenVPN Coreが停止しました。',
      'openvpn_core_status_error':
          'ネイティブOpenVPNループがエラーで終了し、より具体的な終了イベントはありませんでした。',
      'openvpn_stopped_before_connected':
          'CONNECTEDになる前にネイティブOpenVPNループが停止しました。Coreから明示的なエラーはありませんでした。',
      'openvpn_auth_failed': 'OpenVPNサーバーがプロファイル認証を拒否しました。',
      'openvpn_client_setup_failed':
          'OpenVPN Coreはネットワーク接続前にクライアントを初期化できませんでした。',
      'openvpn_client_halted': 'OpenVPN Coreがクライアント停止の終了通知を受け取りました。',
      'openvpn_client_restart': 'OpenVPN Coreがトランスポートセッションの再起動を要求しました。',
      'openvpn_inactive_timeout': 'OpenVPN Coreは非アクティブのタイムアウト後にセッションを閉じました。',
      'openvpn_session_expired': 'サーバーからOpenVPNセッションの有効期限が切れたと報告されました。',
      'openvpn_credentials_required':
          'サーバーまたはプロキシが、この証明書プロファイルに含まれない対話型認証情報を要求しています。',
      'openvpn_proxy_failed': 'OpenVPN Coreが設定済みプロキシまたはリレーの失敗を報告しました。',
      'openvpn_compression_failed':
          'OpenVPN Coreがプロファイルまたはサーバーから通知された圧縮モードを拒否しました。',
      'openvpn_ntlm_crypto_unavailable': 'プロファイルが要求するNTLM暗号化はこのバージョンで利用できません。',
      'openvpn_feature_unsupported':
          'プロファイルまたはサーバーが、このAndroidクライアントにない機能を要求しています。',
      'network_unavailable': '使用できる物理ネットワークがありません。',
      'network_lost': 'ネットワークが失われたためトンネルを停止しました。',
      'certificate_validation_failed': 'OpenVPNサーバーのIDを検証できませんでした。',
      'openvpn_certificate_expired': '再接続する前にOpenVPNプロファイルを更新してください。',
      'tunnel_active_for_another_account':
          'この接続の前に、別のアカウントに属するトンネルを停止する必要があります。',
      'tunnel_already_active': 'Androidによると、以前のVPNセッションがまだインターフェースを使用しています。',
      'tunnel_stop_timeout': '$protocolエンジンは制限時間内にVPNインターフェースの解放を確認しませんでした。',
      'tunnel_disconnected': 'ネイティブエンジンが、開始後にトンネルが予期せず終了したと報告しました。',
      'native_bridge_unavailable':
          'アプリはAndroid VPNサービスにアクセスできません。アプリを閉じて再度開き、もう一度試してください。',
      'native_operation_failed':
          'アプリのエラーによりVPN操作が中断されました。もう一度試してください。問題が続く場合は、診断を実行してください。',
      'invalid_arguments':
          'このVPN操作に必要な情報が不完全です。もう一度試してください。問題が続く場合は、診断を実行してください。',
      'invalid_account_id': 'ネイティブ操作に有効なアカウント識別子が関連付けられていません。',
      'invalid_device_id': 'ネイティブエンジンに送信されたデバイス識別子がないか、無効です。',
      'storage_key_not_allowed': 'Androidブリッジが許可されたストレージリスト外のキーをブロックしました。',
      'secure_storage_read_failed':
          'Android Keystoreはこのアカウントのローカルデータを復号できませんでした。',
      'secure_storage_write_failed':
          'Android Keystoreはローカルデータを暗号化または保存できませんでした。',
      'key_generation_failed':
          'Androidは安全なストレージにWireGuardキーを作成または読み取りできませんでした。',
      'csr_generation_failed':
          'Android KeystoreはOpenVPN P-256 CSRを作成または署名できませんでした。',
      'other': '未文書化のネイティブ分岐が失敗しました。下に表示された診断コードをサポートに送信してください。',
    });
    return '$_temp0';
  }

  @override
  String get notice_permissionRequestInProgress_title => '権限リクエストはすでに開いています';

  @override
  String get notice_permissionRequestInProgress_message =>
      'AndroidのVPN権限リクエストはすでに表示されています。もう一度試す前に完了してください。';

  @override
  String get notice_permissionRequestInterrupted_title => 'VPN権限リクエストが中断されました';

  @override
  String get notice_permissionRequestInterrupted_message =>
      'アプリが応答を受け取る前に、VPN権限画面が閉じられました。';

  @override
  String get notice_openvpnProofMissing_title => 'OpenVPN接続を確認できません';

  @override
  String get notice_openvpnProofMissing_message =>
      'OpenVPN接続を確認できなかったため、安全のため停止しました。もう一度試してください。';

  @override
  String get openvpnCleanup_title => 'OpenVPNプロファイルが取り消されました';

  @override
  String get openvpnCleanup_working => '取り消されたOpenVPNプロファイルを停止して削除しています…';

  @override
  String get openvpnCleanup_stopFailed =>
      'OpenVPNが停止したことを確認できません。新しいプロファイルを作成する前に再試行してください。';

  @override
  String get openvpnCleanup_cleanupFailed =>
      '取り消されたOpenVPNプロファイルを完全に削除できませんでした。クリーンアップを再試行してください。';

  @override
  String get openvpnCleanup_complete =>
      '取り消されたOpenVPNプロファイルを削除しました。「接続」をタップして新しいプロファイルを作成してください。';

  @override
  String get network_title => 'ネットワーク設定';

  @override
  String get network_ipv4Fallback => 'IPv6は一時的に利用できません。IPv4で準備を続行します。';

  @override
  String get network_rejectedTitle => 'ネットワーク設定が拒否されました';

  @override
  String get network_rejectedMessage =>
      'トンネル設定が不完全か、認証済みアドレスと一致しません。アプリからもう一度試してください。';

  @override
  String get network_unreadableTitle => 'ローカル設定を読み取れません';

  @override
  String get network_unreadableMessage =>
      '保存されたOpenVPNネットワーク設定は使用できません。アプリから再接続して更新してください。';

  @override
  String get network_ipv4 => 'IPv4';

  @override
  String get network_dualStack => 'IPv4 + IPv6';

  @override
  String get protection_title => 'ネットワーク保護';

  @override
  String get protection_subtitle => 'VPNが切断された場合に、インターネットへの直接アクセスをブロックします。';

  @override
  String get protection_active => 'システム保護は有効です';

  @override
  String get protection_alwaysOnOnly => '常時接続VPNが有効です。VPN外の接続のブロックをオンにしてください';

  @override
  String get protection_inactive => 'システム保護は無効です';

  @override
  String get protection_unknown => 'システム保護を確認';

  @override
  String get protection_openSettings => 'Androidの設定を開く';

  @override
  String get protection_dialogTitle => 'ネットワーク保護を設定';

  @override
  String get protection_dialogMessage =>
      'Androidは常時接続VPNと、VPN外の接続のブロックを管理します。FuzeVPNが選択されていることを確認し、システム設定でブロックを有効にしてください。';

  @override
  String get protection_dialogOpen => '設定を開く';

  @override
  String get session_systemProtectionNote =>
      'AndroidがVPN外の通信をブロックし続けている場合は、システム設定を開いてこの保護を確認または変更してください。';

  @override
  String get diagnostics_title => '診断';

  @override
  String get diagnostics_settingsTitle => 'アプリの診断';

  @override
  String get diagnostics_automaticTitle => '重要なエラーを送信';

  @override
  String get diagnostics_automaticDescription =>
      '重要なエラーが発生したときに、簡単な技術レポートを共有します。';

  @override
  String get diagnostics_privacy =>
      '送信されたレポートはサインイン中のアカウントに紐付けられ、30日間保持されます。閲覧履歴、パスワード、VPNキーは含まれません。';

  @override
  String get diagnostics_manualOpen => '診断を実行';

  @override
  String get diagnostics_localDescription =>
      'アプリとVPNの状態のレポートを作成します。接続は変更されません。';

  @override
  String get diagnostics_sendReport => 'レポートを送信';

  @override
  String get diagnostics_sendHint => 'レポートをこのデバイスに保存するには、このボックスのチェックを外してください。';

  @override
  String get diagnostics_signedOut => 'レポートを送信するには、アカウントにサインインしてください。';

  @override
  String get diagnostics_localLifetime =>
      'アプリを閉じた後も保持するには、このレポートをスマートフォンに保存してください。';

  @override
  String get diagnostics_run => '診断を実行';

  @override
  String get diagnostics_rerun => '診断をもう一度実行';

  @override
  String get diagnostics_running => '確認しています…';

  @override
  String get diagnostics_sending => 'レポートを送信しています…';

  @override
  String get diagnostics_prepared => 'このデバイスでレポートの準備ができました';

  @override
  String get diagnostics_queued => 'レポートは送信待ちです';

  @override
  String get diagnostics_sent => 'レポートを受信しました';

  @override
  String get diagnostics_failed => '送信に失敗しました。ローカルレポートは引き続き利用できます。';

  @override
  String get diagnostics_preparationFailed => '診断レポートを準備できませんでした。もう一度試してください。';

  @override
  String get diagnostics_authenticationRequired =>
      'レポートを送信するには、もう一度サインインしてください。';

  @override
  String get diagnostics_retry => '送信を再試行';

  @override
  String get diagnostics_export => 'レポートを保存';

  @override
  String get diagnostics_exportFailed => 'エクスポートに失敗しました。ローカルレポートからもう一度試してください。';

  @override
  String get diagnostics_preferenceFailed => 'この設定を保存できませんでした。もう一度試してください。';

  @override
  String diagnostics_receipt(Object id) {
    return '参照：$id';
  }

  @override
  String diagnostics_received(Object date) {
    return '$dateに受信';
  }

  @override
  String diagnostics_expires(Object date) {
    return '$dateまで保持';
  }

  @override
  String get diagnostics_duplicate => 'このレポートはすでに受信されています。';

  @override
  String get diagnostics_preview => 'レポートのプレビュー';

  @override
  String diagnostics_eventCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '技術イベントを$count件添付',
      one: '技術イベントを1件添付',
      zero: '技術イベントは添付されていません',
    );
    return '$_temp0';
  }

  @override
  String get diagnostics_technical => '技術情報';

  @override
  String get diagnostics_empty => '診断レポートはまだ準備されていません。';

  @override
  String diagnostics_checkName(String id) {
    String _temp0 = intl.Intl.selectLogic(id, {
      'tunnel_connection': 'トンネル状態',
      'handshake': '接続確認',
      'certificate': 'VPN証明書',
      'kill_switch': 'Android保護',
      'connectivity': '利用可能なネットワーク',
      'api_reachability': 'サービスアクセス',
      'secure_storage': '安全なストレージ',
      'other': 'ローカルチェック',
    });
    return '$_temp0';
  }

  @override
  String diagnostics_checkResult(String result) {
    String _temp0 = intl.Intl.selectLogic(result, {
      'passed': '確認済み',
      'failed': '対応が必要です',
      'skipped': '未テスト — アクティブなプローブなし',
      'unknown': '情報を利用できません',
      'other': '情報を利用できません',
    });
    return '$_temp0';
  }

  @override
  String get auth_welcome => 'FuzeVPNへようこそ';

  @override
  String get connection_changeLocation => '場所を変更';

  @override
  String get connection_details => '接続の詳細';

  @override
  String get locations_searchLabel => '都市または国を検索';

  @override
  String get locations_clearSearch => '検索をクリア';

  @override
  String get locations_filterAll => 'すべて';

  @override
  String get locations_filterFavorites => 'お気に入り';

  @override
  String locations_results(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '場所$count件',
      one: '場所$count件',
    );
    return '$_temp0';
  }

  @override
  String get locations_noResults => '場所が見つかりません';

  @override
  String get locations_noResultsHint => '別の都市または国を試してください。';

  @override
  String get locations_noFavorites => 'お気に入りをすぐに利用できます';

  @override
  String get locations_noFavoritesHint => '場所の横にある星をタップして、ここに保存してください。';

  @override
  String get locations_showAll => 'すべての場所を見る';

  @override
  String locations_addFavorite(String name) {
    return '$nameをお気に入りに追加';
  }

  @override
  String locations_removeFavorite(String name) {
    return 'お気に入りから$nameを削除';
  }

  @override
  String get locations_favoriteSaveFailed => 'お気に入りを保存できませんでした。もう一度試してください。';

  @override
  String get locations_emptyTitle => '利用できる場所がありません';

  @override
  String get locations_emptyHint => 'リストを更新してもう一度試してください。';

  @override
  String get devices_manage => 'デバイスを管理';

  @override
  String get settings_personalization => '自分好みに設定';

  @override
  String get settings_safety => '保護';

  @override
  String get settings_help => 'お困りですか？';

  @override
  String get settings_about => 'FuzeVPNについて';

  @override
  String get diagnostics_heading => '接続の問題を理解する';

  @override
  String devices_profileStatus(String status) {
    String _temp0 = intl.Intl.selectLogic(status, {
      'active': '利用可能',
      'pending': '準備中',
      'revoked': '削除済み',
      'expired': '期限切れ',
      'other': 'ステータスを利用できません',
    });
    return '$_temp0';
  }

  @override
  String get notice_preferenceSave_title => '設定を保存できませんでした';

  @override
  String get notice_preferenceSave_message =>
      '選択は現在適用されていますが、保存できませんでした。アプリを閉じた後も保持するには、もう一度試してください。';

  @override
  String get connection_androidDisconnectHint =>
      'AndroidがVPNをアクティブなままにする場合は、開いた設定で常時接続VPNをオフにしてください。';

  @override
  String get protection_learnMore => 'Androidの保護について詳しく見る';

  @override
  String get protection_guideWhy =>
      'この保護により、VPNが切断された場合にアプリがインターネットを直接使用できなくなります。Androidで設定します。';

  @override
  String get protection_guideAlwaysOnTitle => '常時接続VPN';

  @override
  String get protection_guideAlwaysOn =>
      'AndroidはVPNサービスを実行し続け、スマートフォンの再起動後に再開できます。';

  @override
  String get protection_guideBlockTitle => 'VPNなしの接続をブロック';

  @override
  String get protection_guideBlock => 'この設定により、接続が中断されている間も含め、VPNを迂回する通信を防ぎます。';

  @override
  String get protection_guideWarning =>
      'このブロックを有効にすると、VPNに接続されるまでインターネットアクセスはオフのままです。';

  @override
  String get protection_guideStepsTitle => '保護をオンにする';

  @override
  String get protection_guideStep1 => '下のボタンでAndroidのVPN設定を開きます。';

  @override
  String get protection_guideStep2 => 'FuzeVPNの横にある歯車アイコンでオプションを開きます。';

  @override
  String get protection_guideStep3 =>
      '利用できる場合は、常時接続VPN、次にVPNなしの接続をブロックを有効にします。';

  @override
  String get protection_guideManufacturers =>
      '名称はスマートフォンによって異なります。必要に応じて、設定でVPNを検索してください。多くの場合はネットワークとインターネットの下にあります。';

  @override
  String get protection_guideDisableTitle => 'この保護をオフにする';

  @override
  String get protection_guideDisable =>
      '同じ設定でVPNなしのブロックをオフにすると、VPNなしでインターネットにアクセスできます。Androidによる再起動を望まない場合は、常時接続VPNもオフにしてください。';

  @override
  String get protection_guideManual =>
      'これらの設定はAndroidで選択します。FuzeVPNが代わりに変更することはありません。';

  @override
  String get locations_changeTitle => '場所を変更しますか？';

  @override
  String locations_changeActive(String name) {
    return 'VPNを切断してから、$nameへの接続を試みます。';
  }

  @override
  String locations_changeIdle(String name) {
    return 'VPNは$nameへの接続を試みます。';
  }

  @override
  String get locations_confirmChange => '変更して接続';

  @override
  String get locations_changeBusy => '変更が進行中です。別の場所を選択する前にお待ちください。';

  @override
  String get locations_automaticSelection => '自動選択';

  @override
  String get locations_cities => '都市';

  @override
  String get locations_servers => 'サーバー';

  @override
  String locations_viewCities(String name) {
    return '$nameの都市を見る';
  }

  @override
  String locations_viewServers(String name) {
    return '$nameのサーバーを見る';
  }

  @override
  String locations_countryCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '国$countか国',
      one: '国$countか国',
    );
    return '$_temp0';
  }

  @override
  String locations_cityCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '都市$count件',
      one: '都市$count件',
    );
    return '$_temp0';
  }

  @override
  String locations_serverCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'サーバー$count台',
      one: 'サーバー$count台',
    );
    return '$_temp0';
  }

  @override
  String get locations_allCountries => 'すべての国';

  @override
  String get locations_backToCountries => '国に戻る';

  @override
  String locations_backToCities(String name) {
    return '$nameの都市に戻る';
  }

  @override
  String locations_chooseCountry(String name) {
    return '$nameを選択';
  }

  @override
  String locations_chooseCity(String name) {
    return '$nameを選択';
  }

  @override
  String get locations_noCompatibleServer => '互換性のあるサーバーはありません。';

  @override
  String get externalLink_failed => 'このリンクを開けませんでした。コピーしてブラウザで開くことができます。';

  @override
  String get externalLink_copy => 'リンクをコピー';

  @override
  String get externalLink_copied => 'リンクをコピーしました';

  @override
  String get externalLink_copyFailed => 'リンクをコピーできませんでした。下のアドレスを選択してください。';

  @override
  String get settings_deleteAccount => 'アカウントを削除';

  @override
  String get settings_deleteAccountDetail => 'アカウント削除の申請手順を確認';

  @override
  String get billing_title => 'Fuze Premium';

  @override
  String get billing_subtitle => 'VPNのサブスクリプションを選択してください。';

  @override
  String get billing_subscribe => '登録する';

  @override
  String get billing_choosePlan => '続行するにはプランを選択してください。';

  @override
  String get billing_monthly => '月額';

  @override
  String get billing_yearly => '年額';

  @override
  String get billing_continue => 'Google Playで続行';

  @override
  String get billing_restore => '購入を復元';

  @override
  String get billing_manage => 'サブスクリプションを管理';

  @override
  String get billing_deleteAccountWarning =>
      'Google Playの定期購入をご利用の場合、FuzeVPNアカウントを削除しても自動更新は停止されません。自動更新の管理や停止は、Google Playで別途行ってください。';

  @override
  String get billing_deleteAccountContinue => 'アカウント削除の申請に進む';

  @override
  String get billing_refresh => 'アクセスを更新';

  @override
  String get billing_loadingPlans => 'プランを読み込み中…';

  @override
  String get billing_unavailable => '現在利用できるプランはありません。後でもう一度お試しください。';

  @override
  String get billing_comingSoon => 'サブスクリプションは近日公開予定です。';

  @override
  String get billing_priceDisclosure =>
      '価格はGoogle Playから提供されます。最終金額はお支払い前に確認できます。';

  @override
  String get billing_renewalMonthly =>
      '解約しない限り毎月自動更新されます。Google Playの定期購入からいつでも解約できます。';

  @override
  String get billing_renewalYearly =>
      '解約しない限り毎年自動更新されます。Google Playの定期購入からいつでも解約できます。';

  @override
  String get billing_active => 'Premiumアクセスは有効です';

  @override
  String billing_accessUntil(String date) {
    return '$dateまで利用可能です。';
  }

  @override
  String get billing_webManaged => 'サブスクリプションはFuzeVPNのウェブサイトで管理できます。';

  @override
  String get billing_playManaged => 'サブスクリプションはGoogle Playで管理できます。';

  @override
  String get billing_inactive => '有効なサブスクリプションはありません。';

  @override
  String get billing_checkingAccess => 'アクセスを確認中…';

  @override
  String get billing_restoring => '購入を復元中…';

  @override
  String get billing_pending => 'お支払いは保留中です。確認後にアクセスが有効になります。';

  @override
  String get billing_cancelled => '購入がキャンセルされました。新しいサブスクリプションは有効になっていません。';

  @override
  String get billing_verifying => '購入を確認中…';

  @override
  String get billing_success => 'サブスクリプションが有効になりました。Premiumをご利用いただけます。';

  @override
  String get billing_restored => '購入を復元しました。';

  @override
  String get billing_restoreEmpty => 'このGoogle Playアカウントに復元できる購入はありません。';

  @override
  String get billing_catalogError => 'プランを読み込めませんでした。もう一度お試しください。';

  @override
  String get billing_purchaseError => '購入を開始できませんでした。もう一度お試しください。';

  @override
  String get billing_verificationError =>
      '購入の確認は一時的に利用できません。購入を復元してもう一度お試しください。';

  @override
  String get billing_restoreError => '購入を復元できませんでした。もう一度お試しください。';

  @override
  String get billing_managementError => 'サブスクリプション管理を開けませんでした。もう一度お試しください。';

  @override
  String get billing_storeUnavailable => 'このデバイスではGoogle Playを利用できません。';

  @override
  String get welcome_title => 'VPNを、もっとシンプルに。';

  @override
  String get welcome_description => '接続を保護。プライバシーを自分で管理。';

  @override
  String get welcome_start => 'はじめる';

  @override
  String get welcome_alreadyPurchased => '購入済みですか？';

  @override
  String get welcome_noAccountRequired => 'アカウントを作成せずに始められます。';

  @override
  String get guest_accountTitle => 'アカウント未連携';

  @override
  String get guest_accountDescription =>
      '同じGoogle Playアカウントで購入を復元すると、別の端末でもサブスクリプションを利用できます。';

  @override
  String get guest_existingSubscriberSignIn => 'すでにご契約済みですか？ログイン';

  @override
  String get guest_claimTitle => 'FuzeVPNをどこでも';

  @override
  String get guest_claimDescription =>
      'ほかの端末でもサブスクリプションを利用するためにアカウントを作成できます。この手順は任意です。';

  @override
  String get guest_skip => '後で';

  @override
  String get guest_activationTitle => 'Fuze Premiumは有効です';

  @override
  String get guest_activationDescription =>
      'サブスクリプションの準備ができました。VPNを利用し、アカウントはいつでも作成できます。';

  @override
  String get guest_useVpn => 'VPNを利用する';

  @override
  String get guest_loginRequired =>
      'この購入はすでにFuzeVPNアカウントに連携されています。そのアカウントにログインしてサブスクリプションを利用してください。';

  @override
  String get guest_signOutWarning =>
      '同じGoogle Playアカウントで購入を復元すると、サブスクリプションを復旧できます。';

  @override
  String get guest_profileUnavailable =>
      'アカウントはすでに連携されています。ログインして情報を表示・管理してください。';

  @override
  String get billing_acceptance => '続行すると、利用規約とプライバシーポリシーに同意したことになります。';

  @override
  String get guest_verifyEmailReminder =>
      'アカウントを保護するため、メールアドレスを確認してください。VPNは引き続き利用できます。';

  @override
  String get guest_serviceUnavailable => 'サービスは一時的に利用できません。しばらくしてから再試行してください。';

  @override
  String get guest_restoreError =>
      '購入を復元できませんでした。購入時に使用したGoogle Playアカウントで再試行してください。';

  @override
  String get guest_claimSuccess => 'アカウントを作成しました。サブスクリプションとVPNへのアクセスは維持されます。';

  @override
  String get guest_emailExists =>
      'このメールアドレスはすでに使用されています。別のアドレスを選ぶか、既存のアカウントにログインしてください。購入は引き続きGoogle Playから利用できます。';

  @override
  String get guest_claimError =>
      'アカウントを作成できませんでした。VPNは引き続き利用できます。アカウント作成は後で再試行してください。';

  @override
  String get guest_secureStorageError => 'この端末でセッションを安全に保存できませんでした。再試行してください。';

  @override
  String get guest_premiumRequired => 'VPNを有効にするには、サブスクリプションを選んでください。';

  @override
  String get welcome_viewPlans => 'プランを見る';

  @override
  String get google_continue => 'Google で続行';

  @override
  String get google_or => 'または';

  @override
  String get google_title => 'FuzeVPN アカウント';

  @override
  String get google_settingUp => 'アカウントの設定を完了';

  @override
  String get google_country => '居住国';

  @override
  String get google_profileDescription =>
      '国を選び、2つの文書を確認して FuzeVPN アカウントを作成してください。';

  @override
  String get google_claimDescription =>
      'ゲストアカウントを Google に関連付けます。サブスクリプションと端末はこのアカウントに残ります。';

  @override
  String get google_linkTitle => 'Google を FuzeVPN に関連付ける';

  @override
  String get google_linkDescription =>
      '既存の FuzeVPN アカウントへのアクセスを確認します。Google のパスワードは求めません。';

  @override
  String get google_password => 'FuzeVPN のパスワード';

  @override
  String get google_linkAccount => '関連付けを確認';

  @override
  String get google_requestEmail => '確認メールを送信';

  @override
  String get google_emailInstructions => 'FuzeVPN からのメールを開き、確認コードを入力してください。';

  @override
  String get google_emailCode => 'メール確認コード';

  @override
  String get google_confirmEmail => 'コードを確認';

  @override
  String get google_restart => '別の Google アカウントを選ぶ';

  @override
  String get google_resume => 'この操作を確認';

  @override
  String get google_unavailable => 'Google ログインを利用できません。メールとパスワードを使用できます。';

  @override
  String get google_expired => 'この操作の有効期限が切れました。キャンセルしてやり直してください。';

  @override
  String get google_conflict =>
      'この Google アカウントは別のアカウントに関連付けられています。現在のアカウントとサブスクリプションは保持されます。';

  @override
  String get google_error => 'Google ログインに失敗しました。再試行してください。現在のアクセスは保持されます。';

  @override
  String get google_uncertain => '結果を確認できませんでした。この操作を確認するか、キャンセルしてからやり直してください。';

  @override
  String get google_cancelFailed =>
      'キャンセルを確認できませんでした。この画面を離れる前にキャンセルを再試行してください。';

  @override
  String get google_cancelled => 'Google ログインをキャンセルしました。';

  @override
  String get google_selecting => 'Google アカウントを選んでください…';

  @override
  String get google_verifying => 'アカウントを確認中…';

  @override
  String get google_emailUnavailable => '確認メールを送信できませんでした。後でもう一度お試しください。';

  @override
  String get google_emailSent => '確認メールを送信しました。受信トレイを確認してください。';

  @override
  String get google_rateLimited => 'しばらく待ってから再試行してください。';

  @override
  String get google_invalidPassword =>
      'FuzeVPN のパスワードが正しくありません。現在のアカウントは保持されます。';

  @override
  String get google_invalidCode => '確認コードが無効、または期限切れです。';

  @override
  String get google_accountChanged => 'セッションが変わりました。この操作をキャンセルしてからやり直してください。';

  @override
  String get google_invalidResponse => '応答を検証できませんでした。現在のアクセスは保持されます。';

  @override
  String get google_invalidRegistration => '国と2つの同意を確認してください。';

  @override
  String get google_consentRequired => '続行するには国を選び、2つの文書に同意してください。';

  @override
  String get google_challengeRequired => '追加のセキュリティ確認が必要です。現在のアクセスは保持されます。';

  @override
  String get google_challengeUnavailable => 'セキュリティ確認を利用できません。後でもう一度お試しください。';
}
