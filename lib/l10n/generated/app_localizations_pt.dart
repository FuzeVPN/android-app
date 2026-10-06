// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Portuguese (`pt`).
class AppLocalizationsPt extends AppLocalizations {
  AppLocalizationsPt([String locale = 'pt']) : super(locale);

  @override
  String get accountRestoration_title => 'Conta temporariamente indisponível';

  @override
  String get accountRestoration_message =>
      'Sua sessão foi mantida. Tente novamente para restaurar sua conta; você ainda pode gerenciar a conexão VPN aqui.';

  @override
  String get action_retry => 'Tentar novamente';

  @override
  String get session_endingTitle => 'Encerrando a sessão';

  @override
  String get session_ending =>
      'Sua sessão foi invalidada. Parando a VPN e limpando a sessão…';

  @override
  String get session_stopFailed =>
      'O desligamento da VPN não foi confirmado. Tente novamente antes de entrar.';

  @override
  String get session_cleanupFailed =>
      'A VPN foi parada, mas a remoção da sessão não foi confirmada. Tente limpar novamente.';

  @override
  String get session_retryStop => 'Tentar desligar novamente';

  @override
  String get session_retryCleanup => 'Tentar limpar novamente';

  @override
  String get appTitle => 'FuzeVPN';

  @override
  String get startup => 'Preparando o FuzeVPN com segurança…';

  @override
  String get nav_connection => 'Conexão';

  @override
  String get nav_locations => 'Localizações';

  @override
  String get nav_account => 'Conta';

  @override
  String get nav_devices => 'Dispositivos';

  @override
  String get nav_settings => 'Configurações';

  @override
  String get action_refresh => 'Atualizar';

  @override
  String get auth_tab_login => 'Entrar';

  @override
  String get auth_tab_register => 'Cadastrar-se';

  @override
  String get auth_stepAccount => 'Conta';

  @override
  String get auth_stepIdentity => 'Identidade';

  @override
  String get auth_stepAddress => 'Endereço e acordos';

  @override
  String auth_stepProgress(Object current, Object total) {
    return 'Etapa $current de $total';
  }

  @override
  String get auth_tagline => 'Sua VPN, de forma simples.';

  @override
  String get auth_keysLocal =>
      'Suas chaves privadas da VPN permanecem neste dispositivo.';

  @override
  String get form_email => 'Endereço de e-mail';

  @override
  String get form_password => 'Senha';

  @override
  String get form_showPassword => 'Mostrar senha';

  @override
  String get form_hidePassword => 'Ocultar senha';

  @override
  String get form_passwordMin =>
      '8–72 bytes UTF-8. Alguns caracteres usam mais de um byte.';

  @override
  String get form_firstName => 'Nome';

  @override
  String get form_lastName => 'Sobrenome';

  @override
  String get form_phone => 'Telefone (+33612345678)';

  @override
  String get form_address => 'Endereço';

  @override
  String get form_address2 => 'Complemento do endereço (opcional)';

  @override
  String get form_postalCode => 'CEP';

  @override
  String get form_city => 'Cidade';

  @override
  String get form_country => 'Código do país (por exemplo, FR)';

  @override
  String get action_login => 'Entrar';

  @override
  String get action_createAccount => 'Criar uma conta';

  @override
  String get action_createMyAccount => 'Criar minha conta';

  @override
  String get action_next => 'Continuar';

  @override
  String get action_previous => 'Voltar';

  @override
  String get action_forgotPassword => 'Esqueceu a senha?';

  @override
  String get auth_noAccount => 'Ainda não tem uma conta?';

  @override
  String get auth_requiredInformation => 'Crie sua conta em três etapas.';

  @override
  String get auth_termsPrefix => 'Aceito os ';

  @override
  String get auth_termsLink => 'termos de uso';

  @override
  String get auth_privacyPrefix => 'Aceito a ';

  @override
  String get auth_privacyLink => 'política de privacidade';

  @override
  String get auth_consentRequired =>
      'Seu consentimento é necessário para criar uma conta.';

  @override
  String get validation_required => 'Este campo é obrigatório.';

  @override
  String get validation_email => 'Insira um endereço de e-mail válido.';

  @override
  String get validation_password =>
      'A senha é curta demais: pelo menos 8 bytes UTF-8.';

  @override
  String get validation_passwordTooLong =>
      'A senha é longa demais: no máximo 72 bytes UTF-8.';

  @override
  String get validation_phone =>
      'Use o formato internacional, por exemplo +33612345678.';

  @override
  String get validation_country =>
      'Use um código de país de duas letras, por exemplo FR.';

  @override
  String get passwordReset_title => 'Redefinir senha';

  @override
  String get passwordReset_description =>
      'Insira o endereço de e-mail da sua conta para solicitar um link de redefinição de senha.';

  @override
  String get passwordReset_send => 'Enviar link';

  @override
  String get connection_title => 'Sua conexão';

  @override
  String get connection_subtitle => 'Escolha uma localização e ative sua VPN.';

  @override
  String get connection_prepare => 'Pronto para conectar?';

  @override
  String get connection_advancedOptions => 'Opções avançadas';

  @override
  String get connection_location => 'Localização';

  @override
  String get connection_chooseLocation => 'Escolher uma localização';

  @override
  String get connection_protocol => 'Protocolo';

  @override
  String get connection_connect => 'Conectar';

  @override
  String get connection_connecting => 'Conectando…';

  @override
  String get connection_disconnect => 'Desconectar';

  @override
  String get connection_disconnecting => 'Desconectando';

  @override
  String get connection_locationChange => 'Alterando a localização…';

  @override
  String connection_unavailable(Object protocol) {
    return '$protocol indisponível';
  }

  @override
  String get connection_activeLocation => 'Localização ativa';

  @override
  String get connection_duration => 'Duração';

  @override
  String get connection_received => 'Recebidos';

  @override
  String get connection_sent => 'Enviados';

  @override
  String get connection_lastHandshake => 'Última troca segura';

  @override
  String connection_handshakeAgo(Object duration) {
    return 'há $duration';
  }

  @override
  String get verification_title => 'Confirme seu endereço de e-mail';

  @override
  String get verification_message =>
      'Confirme seu endereço de e-mail para usar a VPN neste telefone.';

  @override
  String get verification_resend => 'Reenviar e-mail';

  @override
  String get migration_title => 'Alteração de localização';

  @override
  String get migration_draining => 'Preparando a alteração de localização…';

  @override
  String get migration_activating => 'Ativando o novo servidor…';

  @override
  String get migration_ready => 'Localização atualizada.';

  @override
  String get migration_blocked =>
      'A alteração de localização requer intervenção do servidor. Tente novamente mais tarde ou entre em contato com o suporte.';

  @override
  String get migration_progress => 'Progresso da alteração de localização';

  @override
  String migration_retryDelay(Object seconds) {
    return 'Intervalo entre verificações: ${seconds}s.';
  }

  @override
  String get migration_resume => 'Retomar alteração de localização';

  @override
  String get status_authorizing => 'Permissão necessária';

  @override
  String get status_authorizingDetail =>
      'Aceite a solicitação do Android para permitir a VPN.';

  @override
  String get status_preparing => 'Preparando';

  @override
  String get status_preparingDetail => 'Preparando sua conexão segura.';

  @override
  String get status_reconnecting => 'Reconectando…';

  @override
  String get status_reconnectingDetail =>
      'A conexão foi interrompida. A VPN está tentando reconectar.';

  @override
  String get status_connecting => 'Conectando';

  @override
  String get status_connectingDetail => 'Conectando ao servidor VPN…';

  @override
  String get status_connected => 'Conectado';

  @override
  String get status_connectedDetail => 'Sua conexão VPN está ativa.';

  @override
  String get status_disconnecting => 'Desconectando';

  @override
  String get status_disconnectingDetail =>
      'Sua conexão VPN está sendo encerrada.';

  @override
  String get status_error => 'Conexão indisponível';

  @override
  String get status_errorDetail =>
      'A conexão VPN não foi confirmada. Tente novamente.';

  @override
  String get status_idle => 'Desconectado';

  @override
  String get status_idleDetail => 'Conecte a VPN para proteger sua conexão.';

  @override
  String get trust_note =>
      'Fechar o aplicativo não interrompe a VPN. Para pará-la, use Desconectar.';

  @override
  String get locations_none =>
      'Nenhuma localização está disponível no momento.';

  @override
  String get locations_available => 'Escolha sua próxima localização.';

  @override
  String get locations_selected => 'Localização selecionada';

  @override
  String get locations_select => 'Escolher esta localização';

  @override
  String get locations_lockedTunnel =>
      'Desconecte a VPN para alterar a localização.';

  @override
  String get locations_lockedMigration =>
      'Aguarde o término da alteração de localização.';

  @override
  String get devices_title => 'Seus dispositivos';

  @override
  String devices_used(Object count, Object limit) {
    return '$count / $limit dispositivos';
  }

  @override
  String get devices_refresh => 'Atualizar dispositivos';

  @override
  String get devices_empty => 'Nenhum dispositivo VPN foi registrado ainda.';

  @override
  String get devices_firstConnection =>
      'Seu telefone será adicionado na primeira conexão.';

  @override
  String get devices_thisDevice => 'Este dispositivo';

  @override
  String devices_added(Object date) {
    return 'Adicionado em $date';
  }

  @override
  String get action_remove => 'Remover';

  @override
  String get settings_title => 'Configurações';

  @override
  String get settings_subtitle =>
      'Suas preferências e sua conta, tudo em um só lugar.';

  @override
  String get settings_appearance => 'Aparência';

  @override
  String get settings_language => 'Idioma';

  @override
  String get settings_languageDescription =>
      'O idioma escolhido também se aplica às notificações da VPN.';

  @override
  String get settings_account => 'Conta';

  @override
  String get settings_signOut => 'Sair';

  @override
  String get settings_privacy => 'Política de privacidade';

  @override
  String get settings_terms => 'Termos de uso';

  @override
  String get settings_security => 'Segurança e transparência';

  @override
  String get settings_licenses => 'Licenças dos componentes';

  @override
  String get settings_licensesDetail => 'Software usado no aplicativo';

  @override
  String get settings_background =>
      'A VPN permanece ativa quando você sai do aplicativo. Para pará-la, use Desconectar na aba Conexão.';

  @override
  String get theme_system => 'Sistema';

  @override
  String get theme_light => 'Claro';

  @override
  String get theme_dark => 'Escuro';

  @override
  String get language_system => 'Idioma do telefone';

  @override
  String get language_fr => 'Français';

  @override
  String get language_en => 'English';

  @override
  String get language_es => 'Español';

  @override
  String get language_de => 'Deutsch';

  @override
  String get dialog_removeDevice => 'Remover este dispositivo?';

  @override
  String get dialog_removeCurrent =>
      'Este telefone será desconectado da VPN e perderá o acesso. Os dados da conexão VPN serão removidos depois que o servidor confirmar.';

  @override
  String dialog_removeOther(Object name) {
    return 'O acesso VPN de “$name” será revogado. Isso não pode ser desfeito.';
  }

  @override
  String get dialog_signOut => 'Sair?';

  @override
  String get dialog_signOutMessage =>
      'A VPN será parada e você precisará entrar novamente. Suas chaves VPN criptografadas permanecerão neste telefone para sua próxima conexão.';

  @override
  String get action_cancel => 'Cancelar';

  @override
  String get action_signOut => 'Sair';

  @override
  String get notice_close => 'Dispensar mensagem';

  @override
  String get notice_sessionExpired_title => 'Sessão expirada';

  @override
  String get notice_sessionExpired_message =>
      'Sua sessão expirou. Entre novamente.';

  @override
  String get notice_connectionFailed_title => 'Falha na conexão';

  @override
  String get notice_invalidCredentials_message =>
      'O endereço de e-mail ou a senha estão incorretos.';

  @override
  String get notice_emailVerification_title =>
      'Confirmação de e-mail necessária';

  @override
  String get notice_emailVerification_message =>
      'Confirme seu endereço de e-mail antes de adicionar um dispositivo VPN.';

  @override
  String get notice_rateLimited_title => 'Tentativas demais';

  @override
  String get notice_deviceLimit_title => 'Limite de 2 dispositivos atingido';

  @override
  String get notice_deviceLimit_message =>
      'Remova um dispositivo existente antes de adicionar outro.';

  @override
  String get notice_identityRenewal_title =>
      'A identidade VPN precisa ser renovada';

  @override
  String get notice_identityRenewal_message =>
      'Esta identidade foi removida. Crie uma nova identidade local.';

  @override
  String get notice_migrationPending_title =>
      'Alteração de localização em andamento';

  @override
  String get notice_migrationPending_message =>
      'Uma alteração de localização já está em andamento.';

  @override
  String get notice_migrationBlocked_title =>
      'Alteração de localização bloqueada';

  @override
  String get notice_migrationBlocked_message =>
      'A alteração de localização requer intervenção do servidor. Tente novamente mais tarde ou entre em contato com o suporte.';

  @override
  String get notice_targetUnavailable_title =>
      'Servidor temporariamente indisponível';

  @override
  String get notice_targetUnavailable_message =>
      'Este servidor está temporariamente indisponível.';

  @override
  String get notice_networkUnavailable_title =>
      'Conexão com a internet indisponível';

  @override
  String get notice_networkUnavailable_message =>
      'Verifique sua conexão e tente novamente.';

  @override
  String get notice_permissionDenied_title => 'Permissão da VPN negada';

  @override
  String get notice_permissionDenied_message =>
      'Inicie a conexão novamente e aceite a solicitação de permissão do Android.';

  @override
  String get notice_wireguardTimeout_title => 'O servidor não está respondendo';

  @override
  String get notice_wireguardTimeout_message =>
      'A conexão WireGuard demorou demais. Tente novamente ou escolha outra localização.';

  @override
  String get notice_tlsFailed_title => 'Conexão segura recusada';

  @override
  String get notice_tlsFailed_message =>
      'O servidor não aceitou a conexão OpenVPN. Tente novamente. Se o problema continuar, execute um diagnóstico.';

  @override
  String get notice_tunRejected_title => 'O Android rejeitou a interface VPN';

  @override
  String get notice_tunRejected_message =>
      'O Android rejeitou a configuração de rede solicitada pelo OpenVPN.';

  @override
  String get notice_openvpnStart_title => 'Não foi possível iniciar o OpenVPN';

  @override
  String get notice_openvpnStart_message =>
      'O mecanismo OpenVPN não conseguiu concluir a inicialização. Tente novamente. Se o problema persistir, entre em contato com o suporte.';

  @override
  String notice_diagnosticCode(Object code) {
    return 'Código de diagnóstico: $code';
  }

  @override
  String get notice_generic_title => 'Falha na conexão VPN';

  @override
  String get notice_generic_message =>
      'Ocorreu um erro. Tente novamente mais tarde.';

  @override
  String notice_controller_title(String code) {
    String _temp0 = intl.Intl.selectLogic(code, {
      'account_created_email_unavailable': 'Conta criada',
      'password_reset_sent': 'Solicitação de redefinição recebida',
      'verification_email_sent': 'E-mail de verificação enviado',
      'location_migration_pending': 'Alteração de localização em andamento',
      'vpn_sign_in_required': 'Login necessário',
      'protocol_unavailable_at_location': 'Protocolo indisponível',
      'vpn_permission_denied': 'Permissão da VPN negada',
      'revoked_identity_device_limit': 'Limite de 2 dispositivos atingido',
      'tunnel_start_unexpected': 'Não foi possível iniciar a VPN',
      'flutter_disconnect_timeout': 'Desconexão não confirmada',
      'flutter_disconnect_unexpected': 'Não foi possível desconectar',
      'device_revoked': 'Dispositivo removido',
      'revoke_unexpected': 'Não foi possível remover o dispositivo',
      'identity_renewal_unexpected': 'Não foi possível renovar a identidade',
      'openvpn_renewal_unexpected': 'Não foi possível renovar o OpenVPN',
      'location_migration_blocked': 'Alteração de localização bloqueada',
      'location_migration_slow': 'Alteração de localização ainda em andamento',
      'location_migration_conflict':
          'A alteração de localização precisa ser atualizada',
      'location_migration_verification_failed':
          'Alteração de localização não confirmada',
      'location_migration_device_changed':
          'Dispositivo alterado durante a mudança de localização',
      'tunnel_stop_failed': 'Localização indisponível',
      'other': 'Falha na operação',
    });
    return '$_temp0';
  }

  @override
  String notice_controller_message(String code, String target) {
    String _temp0 = intl.Intl.selectLogic(code, {
      'account_created_email_unavailable':
          'A conta foi criada, mas não foi possível enviar o e-mail de verificação. Use a opção de reenvio no aplicativo.',
      'password_reset_sent':
          'Sua solicitação foi recebida. Se houver uma conta associada a este endereço, você poderá receber um e-mail. Verifique também sua pasta de spam.',
      'verification_email_sent':
          'Um novo e-mail de verificação acaba de ser enviado.',
      'location_migration_pending':
          'A mudança para $target ainda está sendo preparada. Você pode retomá-la sem recriar o dispositivo.',
      'vpn_sign_in_required': 'Entre na sua conta antes de iniciar a VPN.',
      'protocol_unavailable_at_location':
          'O protocolo selecionado não é oferecido por esta localização. Atualize as localizações ou escolha outro protocolo.',
      'vpn_permission_denied':
          'O Android negou a permissão da VPN. Inicie a conexão novamente e aceite a solicitação do sistema.',
      'revoked_identity_device_limit':
          'O acesso VPN deste dispositivo foi removido e o limite de dispositivos foi atingido. Remova um dispositivo em Conta → Gerenciar meus dispositivos.',
      'tunnel_start_unexpected':
          'Um erro inesperado interrompeu a preparação do túnel. Verifique o código de diagnóstico e tente novamente.',
      'flutter_disconnect_timeout':
          'O Android não confirmou a tempo que a VPN foi interrompida. Tente interrompê-la novamente.',
      'flutter_disconnect_unexpected':
          'Um erro inesperado impediu a confirmação de que o túnel foi interrompido.',
      'device_revoked':
          'O acesso VPN do dispositivo foi revogado e os segredos locais foram removidos.',
      'revoke_unexpected':
          'Não foi possível remover o dispositivo. Atualize a lista e tente novamente.',
      'identity_renewal_unexpected':
          'Não foi possível criar a nova identidade VPN. Atualize os dispositivos e tente novamente.',
      'openvpn_renewal_unexpected':
          'Não foi possível renovar o perfil OpenVPN. Tente novamente ou verifique o código de diagnóstico.',
      'location_migration_blocked':
          'O servidor não pode concluir essa alteração agora. O dispositivo e sua identidade local foram mantidos.',
      'location_migration_slow':
          'O servidor ainda está preparando a mudança para $target. Use Retomar daqui a alguns instantes.',
      'location_migration_conflict':
          'O estado do dispositivo mudou no servidor. Atualize os dispositivos e retome a alteração.',
      'location_migration_verification_failed':
          'O servidor não confirmou a nova localização. A identidade local anterior foi mantida.',
      'location_migration_device_changed':
          'O dispositivo retornado pelo servidor não corresponde mais ao dispositivo que está sendo alterado. Atualize os dispositivos antes de tentar novamente.',
      'tunnel_stop_failed':
          'O túnel anterior precisa ser completamente interrompido antes da nova conexão.',
      'other':
          'Não foi possível concluir a operação. Tente novamente ou envie o código de diagnóstico ao suporte.',
    });
    return '$_temp0';
  }

  @override
  String notice_api_title(String code) {
    String _temp0 = intl.Intl.selectLogic(code, {
      'unauthorized': 'Sessão expirada',
      'invalid_credentials': 'Falha ao entrar',
      'email_verification_required': 'Confirmação de e-mail necessária',
      'verification_email_cooldown': 'E-mail já enviado',
      'rate_limited': 'Tentativas demais',
      'invalid_registration': 'As informações precisam ser corrigidas',
      'email_exists': 'A conta já existe',
      'invalid_profile': 'Perfil inválido',
      'invalid_device': 'Dispositivo inválido',
      'invalid_location': 'Localização indisponível',
      'device_limit': 'Limite de 2 dispositivos atingido',
      'device_exists': 'Identidade VPN já em uso',
      'device_identity_revoked': 'A identidade VPN precisa ser renovada',
      'device_location_locked':
          'A alteração de localização precisa ser atualizada',
      'location_migration_pending': 'Alteração de localização em andamento',
      'location_migration_blocked': 'Alteração de localização bloqueada',
      'target_ca_mismatch': 'Servidor OpenVPN incompatível',
      'location_migration_conflict':
          'A alteração de localização precisa ser atualizada',
      'server_full': 'Servidor cheio',
      'capacity_unavailable': 'Localização temporariamente indisponível',
      'target_unavailable': 'Servidor temporariamente indisponível',
      'not_found': 'Item não encontrado',
      'invalid_openvpn_csr': 'Identidade OpenVPN inválida',
      'openvpn_profile_exists': 'O perfil OpenVPN já existe',
      'openvpn_profile_revoked': 'Perfil OpenVPN revogado',
      'openvpn_operation_pending': 'Operação OpenVPN em andamento',
      'openvpn_operation_terminal': 'Operação OpenVPN interrompida',
      'openvpn_address_unavailable': 'Endereço OpenVPN indisponível',
      'openvpn_profile_conflict': 'Conflito OpenVPN',
      'openvpn_signer_unavailable': 'OpenVPN indisponível',
      'email_delivery_unavailable': 'E-mail indisponível',
      'invalid_token': 'Link inválido',
      'network_unavailable': 'Conexão com a internet indisponível',
      'invalid_json': 'Solicitação inválida',
      'invalid_api_response': 'Resposta do servidor inválida',
      'ipv6_unavailable': 'IPv6 indisponível',
      'invalid_ip_families': 'Configuração de rede rejeitada',
      'other': 'Serviço indisponível',
    });
    return '$_temp0';
  }

  @override
  String notice_api_message(String code) {
    String _temp0 = intl.Intl.selectLogic(code, {
      'unauthorized': 'Sua sessão expirou. Entre novamente.',
      'invalid_credentials':
          'O endereço de e-mail ou a senha estão incorretos.',
      'email_verification_required':
          'Confirme seu endereço de e-mail antes de adicionar um dispositivo VPN.',
      'invalid_registration':
          'Verifique as informações e os consentimentos solicitados.',
      'email_exists': 'Já existe uma conta usando este endereço de e-mail.',
      'invalid_profile': 'Verifique as informações do seu perfil.',
      'invalid_device':
          'O nome ou a identidade local deste dispositivo é inválido.',
      'invalid_location': 'Atualize a lista de localizações e tente novamente.',
      'device_limit':
          'Remova um dispositivo existente antes de adicionar outro.',
      'device_exists': 'Esta identidade VPN já está vinculada a outra conta.',
      'device_identity_revoked':
          'Esta identidade foi removida. É preciso criar uma nova identidade local.',
      'device_location_locked':
          'A localização deste dispositivo acabou de mudar. O aplicativo retomará a alteração em andamento.',
      'location_migration_pending':
          'Uma alteração de localização já está em andamento.',
      'location_migration_blocked':
          'A alteração de localização requer intervenção do servidor. Tente novamente mais tarde ou entre em contato com o suporte.',
      'target_ca_mismatch':
          'Este servidor ainda não é compatível com o perfil OpenVPN atual.',
      'location_migration_conflict':
          'Atualize os dispositivos e tente alterar a localização novamente.',
      'server_full':
          'Esta localização atingiu o limite de conexões. Escolha outra localização ou tente novamente mais tarde.',
      'capacity_unavailable':
          'Não é possível confirmar se esta localização está disponível agora. Escolha outra localização ou tente novamente mais tarde.',
      'target_unavailable': 'Este servidor está temporariamente indisponível.',
      'not_found': 'Este item não está mais disponível na sua conta.',
      'invalid_openvpn_csr':
          'Crie uma nova identidade OpenVPN e tente novamente.',
      'openvpn_profile_exists':
          'Já existe um perfil OpenVPN para este dispositivo.',
      'openvpn_profile_revoked': 'Renove o perfil OpenVPN para continuar.',
      'openvpn_operation_pending':
          'A alteração ainda está sendo propagada. Tente novamente mais tarde.',
      'openvpn_operation_terminal':
          'Crie uma nova identidade OpenVPN e tente novamente.',
      'openvpn_address_unavailable':
          'Nenhum endereço OpenVPN está disponível no momento.',
      'openvpn_profile_conflict':
          'O perfil foi alterado. Atualize os dispositivos e tente novamente.',
      'openvpn_signer_unavailable':
          'O serviço OpenVPN está temporariamente indisponível.',
      'email_delivery_unavailable':
          'Não foi possível enviar o e-mail. Tente novamente mais tarde.',
      'invalid_token': 'Este link é inválido ou expirou. Solicite um novo.',
      'network_unavailable':
          'Verifique sua conexão com a internet e tente novamente.',
      'invalid_json': 'Verifique as informações inseridas e tente novamente.',
      'invalid_api_response':
          'O servidor retornou uma resposta inesperada. Tente novamente mais tarde.',
      'ipv6_unavailable':
          'O servidor não pode ativar o IPv6 no momento. Tente novamente mais tarde.',
      'invalid_ip_families':
          'A configuração do túnel está incompleta ou não corresponde aos endereços autorizados. Tente novamente pelo aplicativo.',
      'other': 'Ocorreu um erro no servidor. Tente novamente mais tarde.',
    });
    return '$_temp0';
  }

  @override
  String get notice_retryLater => 'Tente novamente em alguns instantes.';

  @override
  String notice_retryAfter(Object seconds) {
    return 'Tente novamente em $seconds segundos.';
  }

  @override
  String notice_native_title(String code, String protocol) {
    String _temp0 = intl.Intl.selectLogic(code, {
      'system_vpn_resume_unavailable':
          'Retomada da VPN do sistema indisponível',
      'system_vpn_resume_corrupt': 'Retomada da VPN do sistema inválida',
      'system_vpn_resume_session_invalid': 'Sessão inválida para retomar a VPN',
      'system_vpn_resume_identity_changed': 'A identidade VPN mudou',
      'system_vpn_resume_identity_invalid':
          'Identidade inválida para retomar a VPN',
      'system_vpn_resume_storage_failed':
          'Armazenamento para retomar a VPN indisponível',
      'system_vpn_resume_network_timeout':
          'A retomada da VPN não encontrou uma rede',
      'system_vpn_resume_blocked': 'Retomada da VPN bloqueada',
      'system_vpn_resume_failed': 'Falha ao retomar a VPN',
      'system_vpn_resume_error_invalid': 'Erro inválido ao retomar a VPN',
      'wireguard_identity_store_failed': 'Identidade WireGuard não salva',
      'wireguard_identity_unavailable': 'Identidade WireGuard indisponível',
      'vpn_host_destroyed': 'Host da VPN do Android interrompido',
      'vpn_host_unavailable': 'Host da VPN do Android indisponível',
      'vpn_permission_required': 'Permissão da VPN necessária',
      'vpn_permission_denied': 'Permissão da VPN negada',
      'vpn_permission_request_failed': 'Não foi possível solicitar a permissão',
      'wireguard_foreground_service_unavailable':
          'Serviço WireGuard indisponível',
      'wireguard_identity_invalid': 'Chave WireGuard local inválida',
      'wireguard_identity_in_use': 'Identidade WireGuard já em uso',
      'wireguard_configuration_invalid': 'Configuração WireGuard inválida',
      'wireguard_operation_pending': 'A operação WireGuard ainda está ativa',
      'wireguard_start_failed': 'Inicialização do WireGuard rejeitada',
      'wireguard_stop_timeout': 'Parada do WireGuard não confirmada',
      'wireguard_handshake_timeout': 'O WireGuard não respondeu',
      'openvpn_connection_timeout': 'O OpenVPN não respondeu',
      'openvpn_core_unavailable': 'Mecanismo OpenVPN indisponível',
      'openvpn_operation_pending': 'A sessão OpenVPN ainda está ativa',
      'openvpn_stop_timeout': 'Parada do OpenVPN não confirmada',
      'openvpn_profile_unavailable': 'Perfil OpenVPN local ausente',
      'openvpn_native_failed': 'Chamada nativa do OpenVPN interrompida',
      'openvpn_key_generation_failed':
          'Não foi possível criar a chave OpenVPN P-256',
      'openvpn_csr_generation_failed':
          'Não foi possível criar a CSR do OpenVPN',
      'openvpn_identity_store_failed': 'Identidade OpenVPN não salva',
      'openvpn_identity_clear_failed':
          'Remoção incompleta da identidade OpenVPN',
      'openvpn_identity_in_use': 'Identidade OpenVPN ainda em uso',
      'openvpn_tls_verification_required': 'Verificação TLS do OpenVPN ausente',
      'openvpn_cipher_invalid': 'Cifra OpenVPN inválida',
      'openvpn_profile_rejected': 'Perfil OpenVPN rejeitado',
      'openvpn_identity_inconsistent': 'Identidade OpenVPN inconsistente',
      'tls_handshake_failed': 'Negociação OpenVPN rejeitada',
      'tls_alert_unknown_ca': 'Certificado do cliente OpenVPN não reconhecido',
      'tls_alert_bad_certificate': 'Certificado do cliente OpenVPN rejeitado',
      'tls_alert_unsupported_certificate': 'Certificado OpenVPN não compatível',
      'tls_client_certificate_required':
          'Certificado do cliente OpenVPN necessário',
      'tls_alert_misc': 'Alerta TLS do OpenVPN',
      'tls_signature_algorithm_rejected': 'Assinatura OpenVPN não compatível',
      'tls_handshake_rejected': 'Negociação TLS do OpenVPN rejeitada',
      'tls_version_rejected': 'Versão TLS do OpenVPN incompatível',
      'tls_certificate_expired': 'Certificado TLS expirado',
      'tls_certificate_revoked': 'Certificado TLS revogado',
      'transport_failed': 'Servidor OpenVPN inacessível',
      'tun_configuration_rejected':
          'Não foi possível criar a interface OpenVPN',
      'tun_setup_failed': 'Falha na configuração TUN do OpenVPN',
      'tun_interface_create_failed': 'Falha ao criar a interface OpenVPN',
      'tun_interface_disabled': 'Interface OpenVPN desativada',
      'tun_halted': 'Interface OpenVPN interrompida',
      'tun_already_established': 'Interface OpenVPN já aberta',
      'tun_addresses_missing': 'Endereço OpenVPN ausente',
      'tun_routes_missing': 'Rotas OpenVPN ausentes',
      'tun_dns_missing': 'DNS do OpenVPN ausente',
      'tun_permission_revoked': 'Permissão da VPN revogada',
      'tun_establish_returned_null': 'O Android rejeitou a interface VPN',
      'openvpn_service_start_failed': 'Serviço OpenVPN indisponível',
      'openvpn_operation_timeout': 'Tempo limite da chamada OpenVPN excedido',
      'openvpn_start_failed': 'Inicialização do OpenVPN rejeitada',
      'openvpn_connection_failed': 'Conexão OpenVPN interrompida',
      'openvpn_core_status_error': 'O OpenVPN Core terminou com um erro',
      'openvpn_stopped_before_connected':
          'O OpenVPN foi interrompido antes da conexão',
      'openvpn_auth_failed': 'Autenticação OpenVPN rejeitada',
      'openvpn_client_setup_failed': 'Falha na configuração do cliente OpenVPN',
      'openvpn_client_halted': 'Cliente OpenVPN interrompido',
      'openvpn_client_restart': 'Reinicialização do OpenVPN solicitada',
      'openvpn_inactive_timeout': 'OpenVPN inativo por tempo demais',
      'openvpn_session_expired': 'Sessão OpenVPN expirada',
      'openvpn_credentials_required': 'Autenticação OpenVPN não compatível',
      'openvpn_proxy_failed': 'Falha no transporte intermediário do OpenVPN',
      'openvpn_compression_failed': 'Compressão OpenVPN rejeitada',
      'openvpn_ntlm_crypto_unavailable':
          'Criptografia NTLM do OpenVPN indisponível',
      'openvpn_feature_unsupported': 'Recurso OpenVPN não compatível',
      'network_unavailable': 'Conexão com a internet indisponível',
      'network_lost': 'Rede indisponível',
      'certificate_validation_failed': 'Certificado do servidor rejeitado',
      'openvpn_certificate_expired': 'Certificado OpenVPN expirado',
      'tunnel_active_for_another_account':
          'O túnel de outra conta ainda está ativo',
      'tunnel_already_active': 'Túnel nativo já ativo',
      'tunnel_stop_timeout': 'Parada de $protocol não confirmada',
      'tunnel_disconnected': '$protocol interrompido',
      'native_bridge_unavailable': 'Ponte do Android indisponível',
      'native_operation_failed': 'Operação do Android interrompida',
      'invalid_arguments': 'Parâmetros VPN incompletos',
      'invalid_account_id': 'Conta VPN inválida',
      'invalid_device_id': 'Identificador de dispositivo inválido',
      'storage_key_not_allowed': 'Chave de armazenamento rejeitada',
      'secure_storage_read_failed': 'Falha na leitura segura',
      'secure_storage_write_failed': 'Falha na gravação segura',
      'key_generation_failed': 'Não foi possível gerar a chave WireGuard',
      'csr_generation_failed': 'Não foi possível gerar a CSR do OpenVPN',
      'other': 'Erro nativo de VPN não classificado',
    });
    return '$_temp0';
  }

  @override
  String notice_native_message(String code, String protocol) {
    String _temp0 = intl.Intl.selectLogic(code, {
      'system_vpn_resume_unavailable':
          'O Android não encontrou uma sessão VPN que possa ser retomada. Inicie uma nova conexão no aplicativo.',
      'system_vpn_resume_corrupt':
          'Os dados salvos para retomar a VPN são inválidos e não serão usados. Inicie uma nova conexão.',
      'system_vpn_resume_session_invalid':
          'A sessão salva não pode mais retomar a VPN. Entre novamente no aplicativo.',
      'system_vpn_resume_identity_changed':
          'A identidade VPN local mudou. A retomada foi interrompida; inicie uma nova conexão.',
      'system_vpn_resume_identity_invalid':
          'A identidade para retomada é inválida. Inicie uma nova conexão.',
      'system_vpn_resume_storage_failed':
          'O Android não conseguiu ler ou atualizar os dados criptografados de retomada. Inicie uma nova conexão.',
      'system_vpn_resume_network_timeout':
          'O Android não encontrou uma rede a tempo de retomar a VPN. Tente novamente quando houver uma rede disponível.',
      'system_vpn_resume_blocked':
          'A retomada da VPN está bloqueada. Verifique as configurações do Android e inicie uma nova conexão.',
      'system_vpn_resume_failed':
          'Falha ao retomar a VPN do Android. Inicie uma nova conexão no aplicativo.',
      'system_vpn_resume_error_invalid':
          'O Android retornou um erro de retomada inutilizável. Inicie uma nova conexão.',
      'wireguard_identity_store_failed':
          'O Android não conseguiu salvar a identidade WireGuard criptografada desta conta.',
      'wireguard_identity_unavailable':
          'Não há uma identidade WireGuard utilizável disponível para esta conexão.',
      'vpn_host_destroyed':
          'O componente do Android que hospeda a VPN foi interrompido. Inicie uma nova conexão.',
      'vpn_host_unavailable':
          'O Android não consegue criar o componente que hospeda a VPN. Tente novamente após verificar as configurações da VPN.',
      'openvpn_renewal_required':
          'O certificado requer uma ação no aplicativo antes da conexão.',
      'openvpn_recovery_failed':
          'A recuperação automática falhou. Inicie uma nova conexão no aplicativo.',
      'openvpn_recovery_exhausted':
          'A recuperação automática já foi usada. Inicie uma nova conexão no aplicativo.',
      'vpn_permission_required':
          'O Android requer uma nova autorização da VPN antes de iniciar o túnel.',
      'vpn_permission_denied':
          'Permita o FuzeVPN na solicitação do Android para continuar.',
      'vpn_permission_request_failed':
          'O Android não conseguiu abrir a tela de permissão da VPN.',
      'wireguard_foreground_service_unavailable':
          'O Android não conseguiu manter o serviço WireGuard em primeiro plano.',
      'wireguard_identity_invalid':
          'A chave WireGuard criptografada desta conta não pode ser lida ou é inválida.',
      'wireguard_identity_in_use':
          'Outra operação ainda está usando a chave WireGuard desta conta.',
      'wireguard_configuration_invalid':
          'O endereço, DNS, chave do servidor ou rotas WireGuard recebidos são inválidos.',
      'wireguard_operation_pending':
          'A operação WireGuard anterior ainda não liberou o serviço nativo.',
      'wireguard_start_failed':
          'O mecanismo WireGuard rejeitou a ativação da configuração.',
      'wireguard_stop_timeout':
          'O serviço WireGuard não confirmou a liberação da interface VPN dentro do limite de tempo.',
      'wireguard_handshake_timeout':
          'O túnel não confirmou a negociação com o servidor a tempo.',
      'openvpn_connection_timeout':
          'O OpenVPN não confirmou a conexão com o servidor a tempo.',
      'openvpn_core_unavailable':
          'Esta versão do aplicativo não contém um mecanismo OpenVPN utilizável.',
      'openvpn_operation_pending':
          'O mecanismo nativo ainda mantém a sessão OpenVPN anterior e recusa criar outra.',
      'openvpn_stop_timeout':
          'O OpenVPN Core não confirmou que sua sessão nativa foi interrompida e destruída dentro do limite de tempo.',
      'openvpn_profile_unavailable':
          'Nenhum perfil OpenVPN validado pode ser lido para esta conexão.',
      'openvpn_native_failed':
          'Um erro do aplicativo interrompeu o OpenVPN. Tente conectar novamente. Se o problema persistir, execute um diagnóstico.',
      'openvpn_key_generation_failed':
          'O Android Keystore não conseguiu criar ou ler a chave privada P-256 não exportável.',
      'openvpn_csr_generation_failed':
          'A chave do Android Keystore não conseguiu assinar a solicitação de certificado OpenVPN.',
      'openvpn_identity_store_failed':
          'Não foi possível salvar o certificado ou perfil OpenVPN no armazenamento criptografado.',
      'openvpn_identity_clear_failed':
          'O Android não conseguiu remover toda a identidade OpenVPN local desta conta.',
      'openvpn_identity_in_use':
          'Uma sessão OpenVPN nativa ainda está usando a chave ou o certificado deste dispositivo.',
      'openvpn_tls_verification_required':
          'O perfil não exige explicitamente a verificação do certificado do servidor.',
      'openvpn_cipher_invalid':
          'O servidor forneceu um algoritmo de criptografia que não está na lista permitida.',
      'openvpn_profile_rejected':
          'O perfil recebido do servidor é incompatível. Recrie este dispositivo e tente novamente.',
      'openvpn_identity_inconsistent':
          'O certificado não corresponde à identidade segura deste telefone. Nenhum perfil local foi substituído.',
      'tls_handshake_failed':
          'O servidor rejeitou a negociação TLS. Recrie o perfil se o problema persistir.',
      'tls_alert_unknown_ca':
          'O servidor não reconhece a autoridade do certificado deste dispositivo. O servidor OpenVPN precisa ser verificado.',
      'tls_alert_bad_certificate':
          'O servidor rejeitou este certificado do dispositivo. Recrie o dispositivo antes de tentar novamente.',
      'tls_alert_unsupported_certificate':
          'O servidor não oferece suporte ao tipo de certificado seguro usado pelo Android.',
      'tls_client_certificate_required':
          'O servidor exige um certificado de cliente, mas o OpenVPN Core não conseguiu apresentá-lo.',
      'tls_alert_misc':
          'O servidor retornou um alerta TLS fora das categorias de certificado e versão.',
      'tls_signature_algorithm_rejected':
          'O servidor rejeitou o algoritmo ECDSA P-256 da chave do Android Keystore.',
      'tls_handshake_rejected':
          'O servidor interrompeu a negociação TLS antes da conexão.',
      'tls_version_rejected':
          'O cliente e o servidor não encontraram uma versão TLS em comum.',
      'tls_certificate_expired':
          'O certificado apresentado durante a conexão expirou.',
      'tls_certificate_revoked':
          'O certificado apresentado durante a conexão foi revogado.',
      'transport_failed':
          'O servidor OpenVPN não responde na rede atual. Tente novamente em breve.',
      'tun_configuration_rejected':
          'O Android rejeitou a configuração de rede solicitada pelo OpenVPN.',
      'tun_setup_failed':
          'O OpenVPN Core rejeitou o plano de rede antes de criar a interface do Android.',
      'tun_interface_create_failed':
          'O OpenVPN Core não conseguiu obter a interface TUN do VpnService do Android.',
      'tun_interface_disabled':
          'O Android ou o OpenVPN Core desativou a interface TUN durante a conexão.',
      'tun_halted':
          'O OpenVPN Core recebeu uma solicitação para interromper a interface TUN.',
      'tun_already_established':
          'O OpenVPN solicitou uma segunda interface na mesma conexão. O túnel foi interrompido por segurança.',
      'tun_addresses_missing':
          'O servidor não forneceu um endereço de túnel utilizável.',
      'tun_routes_missing':
          'O servidor não forneceu rotas de túnel utilizáveis.',
      'tun_dns_missing': 'O servidor não forneceu um servidor DNS utilizável.',
      'tun_permission_revoked':
          'O Android revogou a permissão da VPN durante a conexão.',
      'tun_establish_returned_null':
          'O Android não criou a interface, geralmente porque outra VPN ainda está ativa.',
      'openvpn_service_start_failed':
          'O Android não conseguiu iniciar o serviço OpenVPN em primeiro plano.',
      'openvpn_operation_timeout':
          'Uma chamada JNI ao OpenVPN Core excedeu sua duração máxima.',
      'openvpn_start_failed':
          'O serviço do Android está pronto, mas o OpenVPN Core não aceitou iniciar o perfil.',
      'openvpn_connection_failed':
          'O OpenVPN Core foi interrompido antes de emitir o evento CONNECTED.',
      'openvpn_core_status_error':
          'O loop nativo do OpenVPN terminou com um erro e sem um evento terminal mais específico.',
      'openvpn_stopped_before_connected':
          'O loop nativo do OpenVPN parou antes de CONNECTED, sem um erro explícito do Core.',
      'openvpn_auth_failed':
          'O servidor OpenVPN rejeitou a autenticação do perfil.',
      'openvpn_client_setup_failed':
          'O OpenVPN Core não conseguiu inicializar o cliente antes da conexão de rede.',
      'openvpn_client_halted':
          'O OpenVPN Core recebeu uma solicitação de parada definitiva do cliente.',
      'openvpn_client_restart':
          'O OpenVPN Core solicitou a reinicialização da sessão de transporte.',
      'openvpn_inactive_timeout':
          'O OpenVPN Core encerrou a sessão após o tempo limite de inatividade.',
      'openvpn_session_expired':
          'O servidor informou que a sessão OpenVPN expirou.',
      'openvpn_credentials_required':
          'O servidor ou um proxy solicita credenciais interativas que não fazem parte deste perfil de certificado.',
      'openvpn_proxy_failed':
          'O OpenVPN Core informou uma falha no proxy ou relay configurado.',
      'openvpn_compression_failed':
          'O OpenVPN Core rejeitou o modo de compressão anunciado pelo perfil ou pelo servidor.',
      'openvpn_ntlm_crypto_unavailable':
          'O perfil solicita criptografia NTLM, indisponível nesta versão.',
      'openvpn_feature_unsupported':
          'O perfil ou servidor exige um recurso ausente neste cliente Android.',
      'network_unavailable': 'Nenhuma rede física utilizável está disponível.',
      'network_lost': 'O túnel foi interrompido após a perda da rede.',
      'certificate_validation_failed':
          'Não foi possível verificar a identidade do servidor OpenVPN.',
      'openvpn_certificate_expired':
          'Renove o perfil OpenVPN antes de conectar novamente.',
      'tunnel_active_for_another_account':
          'Um túnel pertencente a outra conta precisa ser interrompido antes desta conexão.',
      'tunnel_already_active':
          'O Android informa que uma sessão VPN anterior ainda está usando a interface.',
      'tunnel_stop_timeout':
          'O mecanismo $protocol não confirmou a liberação da interface VPN dentro do limite de tempo.',
      'tunnel_disconnected':
          'O mecanismo nativo informou que o túnel terminou inesperadamente após ser iniciado.',
      'native_bridge_unavailable':
          'O aplicativo não consegue acessar o serviço VPN do Android. Feche e reabra o aplicativo e tente novamente.',
      'native_operation_failed':
          'Um erro do aplicativo interrompeu a operação VPN. Tente novamente. Se o problema persistir, execute um diagnóstico.',
      'invalid_arguments':
          'As informações necessárias para esta operação VPN estão incompletas. Tente novamente. Se o problema persistir, execute um diagnóstico.',
      'invalid_account_id':
          'A operação nativa não está associada a um identificador de conta válido.',
      'invalid_device_id':
          'O identificador do dispositivo enviado ao mecanismo nativo está ausente ou é inválido.',
      'storage_key_not_allowed':
          'A ponte do Android bloqueou uma chave fora da lista de armazenamento permitida.',
      'secure_storage_read_failed':
          'O Android Keystore não conseguiu descriptografar os dados locais desta conta.',
      'secure_storage_write_failed':
          'O Android Keystore não conseguiu criptografar ou salvar os dados locais.',
      'key_generation_failed':
          'O Android não conseguiu criar ou ler a chave WireGuard no armazenamento seguro.',
      'csr_generation_failed':
          'O Android Keystore não conseguiu criar ou assinar a CSR OpenVPN P-256.',
      'other':
          'Uma ramificação nativa não documentada falhou. Envie o código de diagnóstico exibido abaixo ao suporte.',
    });
    return '$_temp0';
  }

  @override
  String get notice_permissionRequestInProgress_title =>
      'Solicitação de permissão já aberta';

  @override
  String get notice_permissionRequestInProgress_message =>
      'A solicitação de permissão VPN do Android já está sendo exibida. Conclua-a antes de tentar novamente.';

  @override
  String get notice_permissionRequestInterrupted_title =>
      'Solicitação de permissão VPN interrompida';

  @override
  String get notice_permissionRequestInterrupted_message =>
      'A tela de permissão VPN foi fechada antes que o aplicativo recebesse uma resposta.';

  @override
  String get notice_openvpnProofMissing_title =>
      'Conexão OpenVPN não confirmada';

  @override
  String get notice_openvpnProofMissing_message =>
      'Não foi possível confirmar a conexão OpenVPN. Ela foi interrompida por segurança. Tente novamente.';

  @override
  String get openvpnCleanup_title => 'Perfil OpenVPN revogado';

  @override
  String get openvpnCleanup_working =>
      'Parando e removendo o perfil OpenVPN revogado…';

  @override
  String get openvpnCleanup_stopFailed =>
      'O desligamento do OpenVPN não foi confirmado. Tente novamente antes de criar um novo perfil.';

  @override
  String get openvpnCleanup_cleanupFailed =>
      'Não foi possível remover completamente o perfil OpenVPN revogado. Tente limpar novamente.';

  @override
  String get openvpnCleanup_complete =>
      'O perfil OpenVPN revogado foi removido. Toque em Conectar para criar um novo.';

  @override
  String get network_title => 'Configuração de rede';

  @override
  String get network_ipv4Fallback =>
      'O IPv6 está temporariamente indisponível. A preparação continuará com IPv4.';

  @override
  String get network_rejectedTitle => 'Configuração de rede rejeitada';

  @override
  String get network_rejectedMessage =>
      'A configuração do túnel está incompleta ou não corresponde aos endereços autorizados. Tente novamente pelo aplicativo.';

  @override
  String get network_unreadableTitle => 'Configuração local ilegível';

  @override
  String get network_unreadableMessage =>
      'A configuração de rede OpenVPN salva não pode ser usada. Reconecte pelo aplicativo para atualizá-la.';

  @override
  String get network_ipv4 => 'IPv4';

  @override
  String get network_dualStack => 'IPv4 + IPv6';

  @override
  String get protection_title => 'Proteção de rede';

  @override
  String get protection_subtitle =>
      'Bloqueie o acesso direto à internet se a VPN for desconectada.';

  @override
  String get protection_active => 'Proteção do sistema ativa';

  @override
  String get protection_alwaysOnOnly =>
      'VPN sempre ativa habilitada; ative o bloqueio fora da VPN';

  @override
  String get protection_inactive => 'Proteção do sistema inativa';

  @override
  String get protection_unknown => 'Verificar proteção do sistema';

  @override
  String get protection_openSettings => 'Abrir configurações do Android';

  @override
  String get protection_dialogTitle => 'Configurar proteção de rede';

  @override
  String get protection_dialogMessage =>
      'O Android gerencia a VPN sempre ativa e o bloqueio de conexões fora da VPN. Verifique se o FuzeVPN está selecionado e ative o bloqueio nas configurações do sistema.';

  @override
  String get protection_dialogOpen => 'Abrir configurações';

  @override
  String get session_systemProtectionNote =>
      'Se o Android ainda estiver bloqueando o tráfego fora da VPN, abra as configurações do sistema para verificar ou alterar essa proteção.';

  @override
  String get diagnostics_title => 'Diagnóstico';

  @override
  String get diagnostics_settingsTitle => 'Diagnóstico do aplicativo';

  @override
  String get diagnostics_automaticTitle => 'Enviar erros importantes';

  @override
  String get diagnostics_automaticDescription =>
      'Compartilhe um pequeno relatório técnico quando ocorrer um erro importante.';

  @override
  String get diagnostics_privacy =>
      'Os relatórios enviados são vinculados à conta conectada e mantidos por 30 dias. Eles não contêm histórico de navegação, senhas ou chaves VPN.';

  @override
  String get diagnostics_manualOpen => 'Executar diagnóstico';

  @override
  String get diagnostics_localDescription =>
      'Crie um relatório do aplicativo e do estado da VPN. Sua conexão permanece inalterada.';

  @override
  String get diagnostics_sendReport => 'Enviar o relatório';

  @override
  String get diagnostics_sendHint =>
      'Deixe esta caixa desmarcada para manter o relatório neste dispositivo.';

  @override
  String get diagnostics_signedOut =>
      'Entre na sua conta para enviar um relatório.';

  @override
  String get diagnostics_localLifetime =>
      'Salve este relatório no telefone para mantê-lo depois de fechar o aplicativo.';

  @override
  String get diagnostics_run => 'Executar diagnóstico';

  @override
  String get diagnostics_rerun => 'Executar diagnóstico novamente';

  @override
  String get diagnostics_running => 'Verificando…';

  @override
  String get diagnostics_sending => 'Enviando relatório…';

  @override
  String get diagnostics_prepared => 'Relatório pronto neste dispositivo';

  @override
  String get diagnostics_queued => 'Relatório aguardando envio';

  @override
  String get diagnostics_sent => 'Relatório recebido';

  @override
  String get diagnostics_failed =>
      'Falha ao enviar. Seu relatório local ainda está disponível.';

  @override
  String get diagnostics_preparationFailed =>
      'Não foi possível preparar o relatório de diagnóstico. Tente novamente.';

  @override
  String get diagnostics_authenticationRequired =>
      'Entre novamente para enviar o relatório.';

  @override
  String get diagnostics_retry => 'Tentar enviar novamente';

  @override
  String get diagnostics_export => 'Salvar relatório';

  @override
  String get diagnostics_exportFailed =>
      'Falha ao exportar. Tente novamente a partir do relatório local.';

  @override
  String get diagnostics_preferenceFailed =>
      'Não foi possível salvar esta configuração. Tente novamente.';

  @override
  String diagnostics_receipt(Object id) {
    return 'Referência: $id';
  }

  @override
  String diagnostics_received(Object date) {
    return 'Recebido em $date';
  }

  @override
  String diagnostics_expires(Object date) {
    return 'Mantido até $date';
  }

  @override
  String get diagnostics_duplicate => 'Este relatório já havia sido recebido.';

  @override
  String get diagnostics_preview => 'Prévia do relatório';

  @override
  String diagnostics_eventCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count eventos técnicos anexados',
      one: '1 evento técnico anexado',
      zero: 'Nenhum evento técnico anexado',
    );
    return '$_temp0';
  }

  @override
  String get diagnostics_technical => 'Detalhes técnicos';

  @override
  String get diagnostics_empty =>
      'Nenhum relatório de diagnóstico foi preparado ainda.';

  @override
  String diagnostics_checkName(String id) {
    String _temp0 = intl.Intl.selectLogic(id, {
      'tunnel_connection': 'Estado do túnel',
      'handshake': 'Confirmação da conexão',
      'certificate': 'Certificado VPN',
      'kill_switch': 'Proteção do Android',
      'connectivity': 'Rede disponível',
      'api_reachability': 'Acesso ao serviço',
      'secure_storage': 'Armazenamento seguro',
      'other': 'Verificação local',
    });
    return '$_temp0';
  }

  @override
  String diagnostics_checkResult(String result) {
    String _temp0 = intl.Intl.selectLogic(result, {
      'passed': 'Verificado',
      'failed': 'Requer atenção',
      'skipped': 'Não testado — nenhuma verificação ativa',
      'unknown': 'Informação indisponível',
      'other': 'Informação indisponível',
    });
    return '$_temp0';
  }

  @override
  String get auth_welcome => 'Bem-vindo ao FuzeVPN';

  @override
  String get connection_changeLocation => 'Alterar localização';

  @override
  String get connection_details => 'Detalhes da conexão';

  @override
  String get locations_searchLabel => 'Pesquisar uma cidade ou país';

  @override
  String get locations_clearSearch => 'Limpar pesquisa';

  @override
  String get locations_filterAll => 'Todas';

  @override
  String get locations_filterFavorites => 'Favoritas';

  @override
  String locations_results(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count localizações',
      one: '$count localização',
    );
    return '$_temp0';
  }

  @override
  String get locations_noResults => 'Nenhuma localização encontrada';

  @override
  String get locations_noResultsHint => 'Tente outra cidade ou país.';

  @override
  String get locations_noFavorites => 'Suas favoritas, sempre à mão';

  @override
  String get locations_noFavoritesHint =>
      'Toque na estrela ao lado de uma localização para salvá-la aqui.';

  @override
  String get locations_showAll => 'Ver todas as localizações';

  @override
  String locations_addFavorite(String name) {
    return 'Adicionar $name às favoritas';
  }

  @override
  String locations_removeFavorite(String name) {
    return 'Remover $name das favoritas';
  }

  @override
  String get locations_favoriteSaveFailed =>
      'Não foi possível salvar a favorita. Tente novamente.';

  @override
  String get locations_emptyTitle => 'Nenhuma localização disponível';

  @override
  String get locations_emptyHint => 'Atualize a lista para tentar novamente.';

  @override
  String get devices_manage => 'Gerenciar meus dispositivos';

  @override
  String get settings_personalization => 'Personalize';

  @override
  String get settings_safety => 'Proteção';

  @override
  String get settings_help => 'Precisa de ajuda?';

  @override
  String get settings_about => 'Sobre o FuzeVPN';

  @override
  String get diagnostics_heading => 'Entenda um problema de conexão';

  @override
  String devices_profileStatus(String status) {
    String _temp0 = intl.Intl.selectLogic(status, {
      'active': 'Disponível',
      'pending': 'Preparando',
      'revoked': 'Removido',
      'expired': 'Expirado',
      'other': 'Status indisponível',
    });
    return '$_temp0';
  }

  @override
  String get notice_preferenceSave_title => 'Preferência não salva';

  @override
  String get notice_preferenceSave_message =>
      'Sua escolha foi aplicada por enquanto, mas não pôde ser salva. Tente novamente para mantê-la depois de fechar o aplicativo.';

  @override
  String get connection_androidDisconnectHint =>
      'Se o Android mantiver a VPN ativa, desative a VPN sempre ativa nas configurações abertas.';

  @override
  String get protection_learnMore => 'Saiba mais sobre a proteção do Android';

  @override
  String get protection_guideWhy =>
      'Esta proteção impede que os aplicativos usem a internet diretamente se a VPN for desconectada. Ela é configurada no Android.';

  @override
  String get protection_guideAlwaysOnTitle => 'VPN sempre ativa';

  @override
  String get protection_guideAlwaysOn =>
      'O Android mantém o serviço VPN em execução e pode reiniciá-lo após a reinicialização do telefone.';

  @override
  String get protection_guideBlockTitle => 'Bloquear conexões sem VPN';

  @override
  String get protection_guideBlock =>
      'Esta configuração impede que o tráfego contorne a VPN, inclusive quando a conexão é interrompida.';

  @override
  String get protection_guideWarning =>
      'Com este bloqueio ativado, o acesso à internet permanece desativado até a VPN se conectar.';

  @override
  String get protection_guideStepsTitle => 'Ativar proteção';

  @override
  String get protection_guideStep1 =>
      'Abra as configurações de VPN do Android usando o botão abaixo.';

  @override
  String get protection_guideStep2 =>
      'Abra as opções usando o ícone de engrenagem ao lado do FuzeVPN.';

  @override
  String get protection_guideStep3 =>
      'Ative VPN sempre ativa e depois Bloquear conexões sem VPN, se essas opções estiverem disponíveis.';

  @override
  String get protection_guideManufacturers =>
      'Os nomes variam conforme o telefone. Se necessário, pesquise por VPN em Configurações, geralmente em Rede e internet.';

  @override
  String get protection_guideDisableTitle => 'Desativar esta proteção';

  @override
  String get protection_guideDisable =>
      'Nas mesmas configurações, desative o bloqueio sem VPN para permitir acesso à internet sem a VPN. Desative também a VPN sempre ativa se não quiser mais que o Android a reinicie.';

  @override
  String get protection_guideManual =>
      'Você escolhe essas configurações no Android. O FuzeVPN não as altera por você.';

  @override
  String get locations_changeTitle => 'Alterar localização?';

  @override
  String locations_changeActive(String name) {
    return 'A VPN será desconectada e tentará se conectar a $name.';
  }

  @override
  String locations_changeIdle(String name) {
    return 'A VPN tentará se conectar a $name.';
  }

  @override
  String get locations_confirmChange => 'Alterar e conectar';

  @override
  String get locations_changeBusy =>
      'Uma alteração está em andamento. Aguarde antes de escolher outra localização.';

  @override
  String get locations_automaticSelection => 'Seleção automática';

  @override
  String get locations_cities => 'Cidades';

  @override
  String get locations_servers => 'Servidores';

  @override
  String locations_viewCities(String name) {
    return 'Ver cidades em $name';
  }

  @override
  String locations_viewServers(String name) {
    return 'Ver servidores em $name';
  }

  @override
  String locations_countryCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count países',
      one: '$count país',
    );
    return '$_temp0';
  }

  @override
  String locations_cityCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count cidades',
      one: '$count cidade',
    );
    return '$_temp0';
  }

  @override
  String locations_serverCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count servidores',
      one: '$count servidor',
    );
    return '$_temp0';
  }

  @override
  String get locations_allCountries => 'Todos os países';

  @override
  String get locations_backToCountries => 'Voltar aos países';

  @override
  String locations_backToCities(String name) {
    return 'Voltar às cidades em $name';
  }

  @override
  String locations_chooseCountry(String name) {
    return 'Escolher $name';
  }

  @override
  String locations_chooseCity(String name) {
    return 'Escolher $name';
  }

  @override
  String get locations_noCompatibleServer =>
      'Nenhum servidor compatível disponível.';

  @override
  String get externalLink_failed =>
      'Não foi possível abrir este link. Você pode copiá-lo e abri-lo no navegador.';

  @override
  String get externalLink_copy => 'Copiar link';

  @override
  String get externalLink_copied => 'Link copiado';

  @override
  String get externalLink_copyFailed =>
      'Não foi possível copiar o link. Selecione o endereço abaixo.';

  @override
  String get settings_deleteAccount => 'Excluir minha conta';

  @override
  String get settings_deleteAccountDetail =>
      'Consultar como solicitar a exclusão da conta';

  @override
  String get billing_title => 'Fuze Premium';

  @override
  String get billing_subtitle => 'Escolha a sua assinatura VPN.';

  @override
  String get billing_subscribe => 'Assinar';

  @override
  String get billing_choosePlan => 'Escolha um plano para continuar.';

  @override
  String get billing_monthly => 'Mensal';

  @override
  String get billing_yearly => 'Anual';

  @override
  String get billing_continue => 'Continuar com o Google Play';

  @override
  String get billing_restore => 'Restaurar compras';

  @override
  String get billing_manage => 'Gerenciar assinatura';

  @override
  String get billing_deleteAccountWarning =>
      'Se você tem uma assinatura do Google Play, excluir sua conta FuzeVPN não cancela a renovação. Gerencie ou cancele a renovação separadamente no Google Play.';

  @override
  String get billing_deleteAccountContinue =>
      'Continuar para a solicitação de exclusão da conta';

  @override
  String get billing_refresh => 'Atualizar acesso';

  @override
  String get billing_loadingPlans => 'Carregando planos…';

  @override
  String get billing_unavailable =>
      'Nenhum plano disponível no momento. Tente mais tarde.';

  @override
  String get billing_comingSoon => 'Assinaturas disponíveis em breve.';

  @override
  String get billing_priceDisclosure =>
      'Preço fornecido pelo Google Play. O valor final é confirmado antes do pagamento.';

  @override
  String get billing_renewalMonthly =>
      'Renovação automática mensal, salvo cancelamento. Você pode cancelar a qualquer momento nas assinaturas do Google Play.';

  @override
  String get billing_renewalYearly =>
      'Renovação automática anual, salvo cancelamento. Você pode cancelar a qualquer momento nas assinaturas do Google Play.';

  @override
  String get billing_active => 'Seu acesso Premium está ativo';

  @override
  String billing_accessUntil(String date) {
    return 'Acesso até $date.';
  }

  @override
  String get billing_webManaged =>
      'Sua assinatura é gerenciada no site do FuzeVPN.';

  @override
  String get billing_playManaged =>
      'Sua assinatura é gerenciada pelo Google Play.';

  @override
  String get billing_inactive => 'Nenhuma assinatura ativa.';

  @override
  String get billing_checkingAccess => 'Verificando seu acesso…';

  @override
  String get billing_restoring => 'Restaurando compras…';

  @override
  String get billing_pending =>
      'Pagamento pendente. Seu acesso será ativado após a confirmação.';

  @override
  String get billing_cancelled =>
      'Compra cancelada. Nenhuma nova assinatura foi ativada.';

  @override
  String get billing_verifying => 'Verificando a compra…';

  @override
  String get billing_success =>
      'Assinatura ativada. Seu acesso Premium está pronto.';

  @override
  String get billing_restored => 'Suas compras foram restauradas.';

  @override
  String get billing_restoreEmpty =>
      'Nenhuma compra para restaurar nesta conta do Google Play.';

  @override
  String get billing_catalogError =>
      'Não foi possível carregar os planos. Tente novamente.';

  @override
  String get billing_purchaseError =>
      'Não foi possível iniciar a compra. Tente novamente.';

  @override
  String get billing_verificationError =>
      'A verificação da compra está temporariamente indisponível. Restaure as compras para tentar novamente.';

  @override
  String get billing_restoreError =>
      'Não foi possível restaurar as compras. Tente novamente.';

  @override
  String get billing_managementError =>
      'Não foi possível abrir o gerenciamento de assinaturas. Tente novamente.';

  @override
  String get billing_storeUnavailable =>
      'O Google Play não está disponível neste dispositivo.';

  @override
  String get welcome_title => 'Seu VPN, sem complicações.';

  @override
  String get welcome_description =>
      'Proteja sua conexão. Mantenha o controle da sua privacidade.';

  @override
  String get welcome_start => 'Começar';

  @override
  String get welcome_alreadyPurchased => 'Já comprou?';

  @override
  String get welcome_noAccountRequired =>
      'Você não precisa criar uma conta para começar.';

  @override
  String get guest_accountTitle => 'Conta não vinculada';

  @override
  String get guest_accountDescription =>
      'Restaure suas compras com a mesma conta do Google Play para usar sua assinatura em outro dispositivo.';

  @override
  String get guest_existingSubscriberSignIn => 'Já tem uma assinatura? Entrar';

  @override
  String get guest_claimTitle => 'Leve o FuzeVPN com você';

  @override
  String get guest_claimDescription =>
      'Crie uma conta para acessar sua assinatura em outros dispositivos. Esta etapa é opcional.';

  @override
  String get guest_skip => 'Mais tarde';

  @override
  String get guest_activationTitle => 'Fuze Premium está ativo';

  @override
  String get guest_activationDescription =>
      'Sua assinatura está pronta. Use seu VPN e crie uma conta quando quiser.';

  @override
  String get guest_useVpn => 'Usar meu VPN';

  @override
  String get guest_loginRequired =>
      'Esta compra já está vinculada a uma conta FuzeVPN. Entre nessa conta para acessar sua assinatura.';

  @override
  String get guest_signOutWarning =>
      'Você pode recuperar sua assinatura restaurando as compras com a mesma conta do Google Play.';

  @override
  String get guest_profileUnavailable =>
      'Sua conta já está vinculada. Entre para ver e gerenciar seus dados.';

  @override
  String get billing_acceptance =>
      'Ao continuar, você aceita os Termos de uso e a Política de privacidade.';

  @override
  String get guest_verifyEmailReminder =>
      'Confirme seu endereço de e-mail para proteger sua conta. Você pode continuar usando seu VPN.';

  @override
  String get guest_serviceUnavailable =>
      'O serviço está temporariamente indisponível. Tente novamente em instantes.';

  @override
  String get guest_restoreError =>
      'Não foi possível restaurar suas compras. Tente novamente com a conta do Google Play usada na compra.';

  @override
  String get guest_claimSuccess =>
      'Sua conta foi criada. Sua assinatura e seu acesso ao VPN foram preservados.';

  @override
  String get guest_emailExists =>
      'Este e-mail já está em uso. Escolha outro endereço ou entre na sua conta existente. Sua compra continua disponível pelo Google Play.';

  @override
  String get guest_claimError =>
      'Não foi possível criar sua conta. Você pode continuar usando seu VPN e tentar novamente mais tarde.';

  @override
  String get guest_secureStorageError =>
      'Não foi possível proteger sua sessão neste dispositivo. Tente novamente.';

  @override
  String get guest_premiumRequired =>
      'Escolha uma assinatura para ativar seu VPN.';

  @override
  String get welcome_viewPlans => 'Ver planos';

  @override
  String get google_continue => 'Continuar com o Google';

  @override
  String get google_or => 'ou';

  @override
  String get google_title => 'Sua conta FuzeVPN';

  @override
  String get google_settingUp => 'Conclua sua conta';

  @override
  String get google_country => 'País de residência';

  @override
  String get google_profileDescription =>
      'Escolha seu país e leia os dois documentos para criar sua conta FuzeVPN.';

  @override
  String get google_claimDescription =>
      'Vincule sua conta de convidado ao Google. Sua assinatura e seu dispositivo continuam associados a esta conta.';

  @override
  String get google_linkTitle => 'Vincular Google ao FuzeVPN';

  @override
  String get google_linkDescription =>
      'Confirme o acesso à sua conta FuzeVPN existente. Sua senha do Google não é solicitada.';

  @override
  String get google_password => 'Senha do FuzeVPN';

  @override
  String get google_linkAccount => 'Confirmar vinculação';

  @override
  String get google_requestEmail => 'Receber e-mail de confirmação';

  @override
  String get google_emailInstructions =>
      'Abra o e-mail do FuzeVPN e insira o código de confirmação.';

  @override
  String get google_emailCode => 'Código de confirmação por e-mail';

  @override
  String get google_confirmEmail => 'Confirmar código';

  @override
  String get google_restart => 'Escolher outra conta Google';

  @override
  String get google_resume => 'Verificar esta tentativa';

  @override
  String get google_unavailable =>
      'O login com Google está indisponível. Você pode usar e-mail e senha.';

  @override
  String get google_expired =>
      'Esta tentativa expirou. Cancele e comece novamente.';

  @override
  String get google_conflict =>
      'Esta conta Google já está vinculada a outra conta. Sua conta e assinatura atuais são mantidas.';

  @override
  String get google_error =>
      'O login com Google falhou. Tente novamente; seu acesso atual é mantido.';

  @override
  String get google_uncertain =>
      'Não foi possível confirmar o resultado. Verifique esta tentativa ou cancele antes de recomeçar.';

  @override
  String get google_cancelFailed =>
      'Não foi possível confirmar o cancelamento. Tente cancelar novamente antes de sair.';

  @override
  String get google_cancelled => 'Login com Google cancelado.';

  @override
  String get google_selecting => 'Escolha sua conta Google…';

  @override
  String get google_verifying => 'Verificando sua conta…';

  @override
  String get google_emailUnavailable =>
      'Não foi possível enviar o e-mail de confirmação. Tente mais tarde.';

  @override
  String get google_emailSent =>
      'E-mail de confirmação enviado. Confira sua caixa de entrada.';

  @override
  String get google_rateLimited => 'Aguarde antes de tentar novamente.';

  @override
  String get google_invalidPassword =>
      'A senha do FuzeVPN está incorreta. Sua conta atual é mantida.';

  @override
  String get google_invalidCode =>
      'O código de confirmação é inválido ou expirou.';

  @override
  String get google_accountChanged =>
      'A sessão mudou. Cancele esta tentativa antes de recomeçar.';

  @override
  String get google_invalidResponse =>
      'Não foi possível validar a resposta. Seu acesso atual é mantido.';

  @override
  String get google_invalidRegistration =>
      'Verifique o país e os dois consentimentos.';

  @override
  String get google_consentRequired =>
      'Escolha seu país e aceite os dois documentos para continuar.';

  @override
  String get google_challengeRequired =>
      'Uma verificação adicional de segurança é necessária. Seu acesso atual é mantido.';

  @override
  String get google_challengeUnavailable =>
      'A verificação de segurança está indisponível. Tente mais tarde.';
}
