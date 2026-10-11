// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Italian (`it`).
class AppLocalizationsIt extends AppLocalizations {
  AppLocalizationsIt([String locale = 'it']) : super(locale);

  @override
  String get vpnDisclosure_title => 'Proteggi la tua connessione';

  @override
  String get vpnDisclosure_body =>
      'FuzeVPN utilizza il servizio VPN di Android (VpnService) per creare un tunnel crittografato tra questo dispositivo e i server FuzeVPN.';

  @override
  String get vpnDisclosure_dataBody =>
      'Quando la VPN è attiva, il traffico Internet delle tue app, gli indirizzi di destinazione e le richieste DNS passano attraverso questo tunnel per instradare la tua connessione, anche quando FuzeVPN è in background.';

  @override
  String get vpnDisclosure_statusBody =>
      'L’app utilizza lo stato della connessione, la sua durata e il volume di dati trasferiti per mostrare la tua connessione VPN. Puoi interromperla in qualsiasi momento.';

  @override
  String get vpnDisclosure_privacy => 'Privacy';

  @override
  String get vpnDisclosure_accept => 'Accetta e continua';

  @override
  String get vpnDisclosure_decline => 'Non ora';

  @override
  String get accountRestoration_title =>
      'Account temporaneamente non disponibile';

  @override
  String get accountRestoration_message =>
      'La tua sessione è stata mantenuta. Riprova per ripristinare il tuo account; qui puoi ancora gestire la connessione VPN.';

  @override
  String get action_retry => 'Riprova';

  @override
  String get session_endingTitle => 'Chiusura della sessione';

  @override
  String get session_ending =>
      'La tua sessione è stata invalidata. Arresto della VPN e cancellazione della sessione…';

  @override
  String get session_stopFailed =>
      'L\'arresto della VPN non è confermato. Riprova prima di effettuare nuovamente l\'accesso.';

  @override
  String get session_cleanupFailed =>
      'La VPN è arrestata, ma la rimozione della sessione non è confermata. Riprova a cancellare la sessione.';

  @override
  String get session_retryStop => 'Riprova ad arrestare';

  @override
  String get session_retryCleanup => 'Riprova a cancellare';

  @override
  String get appTitle => 'FuzeVPN';

  @override
  String get startup => 'Preparazione sicura di FuzeVPN…';

  @override
  String get nav_connection => 'Connessione';

  @override
  String get nav_locations => 'Posizioni';

  @override
  String get nav_account => 'Account';

  @override
  String get nav_devices => 'Dispositivi';

  @override
  String get nav_settings => 'Impostazioni';

  @override
  String get action_refresh => 'Aggiorna';

  @override
  String get auth_tab_login => 'Accedi';

  @override
  String get auth_tab_register => 'Registrati';

  @override
  String get auth_stepAccount => 'Account';

  @override
  String get auth_stepIdentity => 'Identità';

  @override
  String get auth_stepAddress => 'Indirizzo e accordi';

  @override
  String auth_stepProgress(Object current, Object total) {
    return 'Passaggio $current di $total';
  }

  @override
  String get auth_tagline => 'La tua VPN, resa semplice.';

  @override
  String get auth_keysLocal =>
      'Le tue chiavi VPN private restano su questo dispositivo.';

  @override
  String get form_email => 'Indirizzo email';

  @override
  String get form_password => 'Password';

  @override
  String get form_showPassword => 'Mostra password';

  @override
  String get form_hidePassword => 'Nascondi password';

  @override
  String get form_passwordMin =>
      '8–72 byte UTF-8. Alcuni caratteri occupano più di un byte.';

  @override
  String get form_firstName => 'Nome';

  @override
  String get form_lastName => 'Cognome';

  @override
  String get form_phone => 'Telefono (+33612345678)';

  @override
  String get form_address => 'Indirizzo';

  @override
  String get form_address2 => 'Seconda riga dell\'indirizzo (facoltativa)';

  @override
  String get form_postalCode => 'Codice postale';

  @override
  String get form_city => 'Città';

  @override
  String get form_country => 'Codice del Paese (ad es. FR)';

  @override
  String get action_login => 'Accedi';

  @override
  String get action_createAccount => 'Crea un account';

  @override
  String get action_createMyAccount => 'Crea il mio account';

  @override
  String get action_next => 'Continua';

  @override
  String get action_previous => 'Indietro';

  @override
  String get action_forgotPassword => 'Hai dimenticato la password?';

  @override
  String get auth_noAccount => 'Non hai ancora un account?';

  @override
  String get auth_requiredInformation => 'Crea il tuo account in tre passaggi.';

  @override
  String get auth_termsPrefix => 'Accetto i ';

  @override
  String get auth_termsLink => 'termini di utilizzo';

  @override
  String get auth_privacyPrefix => 'Accetto la ';

  @override
  String get auth_privacyLink => 'informativa sulla privacy';

  @override
  String get auth_consentRequired =>
      'Per creare un account è necessario il tuo consenso.';

  @override
  String get validation_required => 'Questo campo è obbligatorio.';

  @override
  String get validation_email => 'Inserisci un indirizzo email valido.';

  @override
  String get validation_password =>
      'La password è troppo corta: deve contenere almeno 8 byte UTF-8.';

  @override
  String get validation_passwordTooLong =>
      'La password è troppo lunga: può contenere al massimo 72 byte UTF-8.';

  @override
  String get validation_phone =>
      'Usa il formato internazionale, ad esempio +33612345678.';

  @override
  String get validation_country =>
      'Usa un codice del Paese di due lettere, ad esempio FR.';

  @override
  String get passwordReset_title => 'Reimposta la password';

  @override
  String get passwordReset_description =>
      'Inserisci l\'indirizzo email del tuo account per richiedere un link di reimpostazione della password.';

  @override
  String get passwordReset_send => 'Invia il link';

  @override
  String get connection_title => 'La tua connessione';

  @override
  String get connection_subtitle => 'Scegli una posizione, poi attiva la VPN.';

  @override
  String get connection_prepare => 'Pronto per connetterti?';

  @override
  String get connection_advancedOptions => 'Opzioni avanzate';

  @override
  String get connection_location => 'Posizione';

  @override
  String get connection_chooseLocation => 'Scegli una posizione';

  @override
  String get connection_protocol => 'Protocollo';

  @override
  String get connection_connect => 'Connetti';

  @override
  String get connection_connecting => 'Connessione in corso…';

  @override
  String get connection_disconnect => 'Disconnetti';

  @override
  String get connection_disconnecting => 'Disconnessione in corso';

  @override
  String get connection_locationChange => 'Cambio di posizione in corso…';

  @override
  String connection_unavailable(Object protocol) {
    return '$protocol non disponibile';
  }

  @override
  String get connection_activeLocation => 'Posizione attiva';

  @override
  String get connection_duration => 'Durata';

  @override
  String get connection_received => 'Ricevuti';

  @override
  String get connection_sent => 'Inviati';

  @override
  String get connection_lastHandshake => 'Ultimo scambio sicuro';

  @override
  String connection_handshakeAgo(Object duration) {
    return '$duration fa';
  }

  @override
  String get verification_title => 'Conferma il tuo indirizzo email';

  @override
  String get verification_message =>
      'Conferma il tuo indirizzo email per usare la VPN su questo telefono.';

  @override
  String get verification_resend => 'Invia nuovamente l\'email';

  @override
  String get migration_title => 'Cambio di posizione';

  @override
  String get migration_draining => 'Preparazione del cambio di posizione…';

  @override
  String get migration_activating => 'Attivazione del nuovo server…';

  @override
  String get migration_ready => 'Posizione aggiornata.';

  @override
  String get migration_blocked =>
      'Il cambio di posizione richiede un intervento sul server. Riprova più tardi o contatta l\'assistenza.';

  @override
  String get migration_progress => 'Avanzamento del cambio di posizione';

  @override
  String migration_retryDelay(Object seconds) {
    return 'Intervallo tra i controlli: ${seconds}s.';
  }

  @override
  String get migration_resume => 'Riprendi il cambio di posizione';

  @override
  String get status_authorizing => 'Autorizzazione richiesta';

  @override
  String get status_authorizingDetail =>
      'Accetta la richiesta di Android per consentire la VPN.';

  @override
  String get status_preparing => 'Preparazione';

  @override
  String get status_preparingDetail =>
      'Preparazione della tua connessione sicura.';

  @override
  String get status_reconnecting => 'Riconnessione in corso…';

  @override
  String get status_reconnectingDetail =>
      'Connessione interrotta. La VPN sta tentando di riconnettersi.';

  @override
  String get status_connecting => 'Connessione in corso';

  @override
  String get status_connectingDetail => 'Connessione al server VPN in corso…';

  @override
  String get status_connected => 'Connesso';

  @override
  String get status_connectedDetail => 'La tua connessione VPN è attiva.';

  @override
  String get status_disconnecting => 'Disconnessione in corso';

  @override
  String get status_disconnectingDetail =>
      'La tua connessione VPN si sta arrestando.';

  @override
  String get status_error => 'Connessione non disponibile';

  @override
  String get status_errorDetail =>
      'La connessione VPN non è confermata. Riprova.';

  @override
  String get status_idle => 'Disconnesso';

  @override
  String get status_idleDetail =>
      'Connetti la VPN per proteggere la tua connessione.';

  @override
  String get trust_note =>
      'Chiudere l\'app non arresta la VPN. Per arrestarla, usa Disconnetti.';

  @override
  String get locations_none => 'Al momento non è disponibile alcuna posizione.';

  @override
  String get locations_available => 'Scegli la tua prossima posizione.';

  @override
  String get locations_selected => 'Posizione selezionata';

  @override
  String get locations_select => 'Scegli questa posizione';

  @override
  String get locations_lockedTunnel =>
      'Disconnetti la VPN per cambiare posizione.';

  @override
  String get locations_lockedMigration =>
      'Attendi il completamento del cambio di posizione.';

  @override
  String get devices_title => 'I tuoi dispositivi';

  @override
  String devices_used(Object count, Object limit) {
    return '$count / $limit dispositivi';
  }

  @override
  String get devices_refresh => 'Aggiorna dispositivi';

  @override
  String get devices_empty => 'Non è ancora registrato alcun dispositivo VPN.';

  @override
  String get devices_firstConnection =>
      'Il tuo telefono verrà aggiunto alla prima connessione.';

  @override
  String get devices_thisDevice => 'Questo dispositivo';

  @override
  String devices_added(Object date) {
    return 'Aggiunto il $date';
  }

  @override
  String get action_remove => 'Rimuovi';

  @override
  String get settings_title => 'Impostazioni';

  @override
  String get settings_subtitle =>
      'Le tue preferenze e il tuo account, tutto in un unico posto.';

  @override
  String get settings_appearance => 'Aspetto';

  @override
  String get settings_language => 'Lingua';

  @override
  String get settings_languageDescription =>
      'La lingua scelta si applica anche alle notifiche VPN.';

  @override
  String get settings_account => 'Account';

  @override
  String get settings_signOut => 'Esci';

  @override
  String get settings_privacy => 'Informativa sulla privacy';

  @override
  String get settings_terms => 'Termini di utilizzo';

  @override
  String get settings_security => 'Sicurezza e trasparenza';

  @override
  String get settings_licenses => 'Licenze dei componenti';

  @override
  String get settings_licensesDetail => 'Software utilizzato nell\'app';

  @override
  String get settings_background =>
      'La VPN resta attiva quando esci dall\'app. Per arrestarla, usa Disconnetti nella scheda Connessione.';

  @override
  String get theme_system => 'Sistema';

  @override
  String get theme_light => 'Chiaro';

  @override
  String get theme_dark => 'Scuro';

  @override
  String get language_system => 'Lingua del telefono';

  @override
  String get language_fr => 'Français';

  @override
  String get language_en => 'English';

  @override
  String get language_es => 'Español';

  @override
  String get language_de => 'Deutsch';

  @override
  String get dialog_removeDevice => 'Rimuovere questo dispositivo?';

  @override
  String get dialog_removeCurrent =>
      'Questo telefono verrà disconnesso dalla VPN e perderà l\'accesso. I dati della sua connessione VPN verranno rimossi dopo la conferma del server.';

  @override
  String dialog_removeOther(Object name) {
    return 'L\'accesso VPN per “$name” verrà revocato. Questa operazione non può essere annullata.';
  }

  @override
  String get dialog_signOut => 'Uscire?';

  @override
  String get dialog_signOutMessage =>
      'La VPN verrà arrestata e dovrai effettuare nuovamente l\'accesso. Le tue chiavi VPN crittografate resteranno su questo telefono per la prossima connessione.';

  @override
  String get action_cancel => 'Annulla';

  @override
  String get action_signOut => 'Esci';

  @override
  String get notice_close => 'Ignora il messaggio';

  @override
  String get notice_sessionExpired_title => 'Sessione scaduta';

  @override
  String get notice_sessionExpired_message =>
      'La tua sessione è scaduta. Effettua nuovamente l\'accesso.';

  @override
  String get notice_connectionFailed_title => 'Connessione non riuscita';

  @override
  String get notice_invalidCredentials_message =>
      'L\'indirizzo email o la password non sono corretti.';

  @override
  String get notice_emailVerification_title => 'Conferma dell\'email richiesta';

  @override
  String get notice_emailVerification_message =>
      'Conferma il tuo indirizzo email prima di aggiungere un dispositivo VPN.';

  @override
  String get notice_rateLimited_title => 'Troppi tentativi';

  @override
  String get notice_deviceLimit_title => 'Limite di 2 dispositivi raggiunto';

  @override
  String get notice_deviceLimit_message =>
      'Rimuovi un dispositivo esistente prima di aggiungerne un altro.';

  @override
  String get notice_identityRenewal_title =>
      'L\'identità VPN deve essere rinnovata';

  @override
  String get notice_identityRenewal_message =>
      'Questa identità è stata rimossa. Crea una nuova identità locale.';

  @override
  String get notice_migrationPending_title => 'Cambio di posizione in corso';

  @override
  String get notice_migrationPending_message =>
      'È già in corso un cambio di posizione.';

  @override
  String get notice_migrationBlocked_title => 'Cambio di posizione bloccato';

  @override
  String get notice_migrationBlocked_message =>
      'Il cambio di posizione richiede un intervento sul server. Riprova più tardi o contatta l\'assistenza.';

  @override
  String get notice_targetUnavailable_title =>
      'Server temporaneamente non disponibile';

  @override
  String get notice_targetUnavailable_message =>
      'Questo server è temporaneamente non disponibile.';

  @override
  String get notice_networkUnavailable_title =>
      'Connessione Internet non disponibile';

  @override
  String get notice_networkUnavailable_message =>
      'Controlla la connessione e riprova.';

  @override
  String get notice_permissionDenied_title => 'Autorizzazione VPN negata';

  @override
  String get notice_permissionDenied_message =>
      'Avvia nuovamente la connessione e accetta la richiesta di autorizzazione di Android.';

  @override
  String get notice_wireguardTimeout_title => 'Il server non risponde';

  @override
  String get notice_wireguardTimeout_message =>
      'La connessione WireGuard ha impiegato troppo tempo. Riprova o scegli un\'altra posizione.';

  @override
  String get notice_tlsFailed_title => 'Connessione sicura rifiutata';

  @override
  String get notice_tlsFailed_message =>
      'Il server non ha accettato la connessione OpenVPN. Riprova. Se il problema persiste, esegui una diagnostica.';

  @override
  String get notice_tunRejected_title =>
      'Android ha rifiutato l\'interfaccia VPN';

  @override
  String get notice_tunRejected_message =>
      'Android ha rifiutato la configurazione di rete richiesta da OpenVPN.';

  @override
  String get notice_openvpnStart_title => 'OpenVPN non è riuscito ad avviarsi';

  @override
  String get notice_openvpnStart_message =>
      'Il motore OpenVPN non ha completato l\'avvio. Riprova. Se il problema persiste, contatta l\'assistenza.';

  @override
  String notice_diagnosticCode(Object code) {
    return 'Codice diagnostico: $code';
  }

  @override
  String get notice_generic_title => 'Connessione VPN non riuscita';

  @override
  String get notice_generic_message =>
      'Si è verificato un errore. Riprova più tardi.';

  @override
  String notice_controller_title(String code) {
    String _temp0 = intl.Intl.selectLogic(code, {
      'account_created_email_unavailable': 'Account creato',
      'password_reset_sent':
          'Richiesta di reimpostazione della password ricevuta',
      'verification_email_sent': 'Email di verifica inviata',
      'location_migration_pending': 'Cambio di posizione in corso',
      'vpn_sign_in_required': 'Accesso richiesto',
      'protocol_unavailable_at_location': 'Protocollo non disponibile',
      'vpn_permission_denied': 'Autorizzazione VPN negata',
      'revoked_identity_device_limit': 'Limite di 2 dispositivi raggiunto',
      'tunnel_start_unexpected': 'Impossibile avviare la VPN',
      'flutter_disconnect_timeout': 'Disconnessione non confermata',
      'flutter_disconnect_unexpected': 'Impossibile disconnettersi',
      'device_revoked': 'Dispositivo rimosso',
      'revoke_unexpected': 'Impossibile rimuovere il dispositivo',
      'identity_renewal_unexpected': 'Impossibile rinnovare l\'identità',
      'openvpn_renewal_unexpected': 'Impossibile rinnovare OpenVPN',
      'location_migration_blocked': 'Cambio di posizione bloccato',
      'location_migration_slow': 'Cambio di posizione ancora in corso',
      'location_migration_conflict':
          'È necessario aggiornare il cambio di posizione',
      'location_migration_verification_failed':
          'Cambio di posizione non confermato',
      'location_migration_device_changed':
          'Dispositivo cambiato durante il cambio di posizione',
      'tunnel_stop_failed': 'Cambio di posizione non disponibile',
      'other': 'Operazione non riuscita',
    });
    return '$_temp0';
  }

  @override
  String notice_controller_message(String code, String target) {
    String _temp0 = intl.Intl.selectLogic(code, {
      'account_created_email_unavailable':
          'L\'account è stato creato, ma non è stato possibile inviare l\'email di verifica. Usa l\'opzione per inviarla nuovamente nell\'app.',
      'password_reset_sent':
          'La tua richiesta è stata ricevuta. Se un account corrisponde a questo indirizzo, potresti ricevere un\'email. Controlla anche la cartella dello spam.',
      'verification_email_sent':
          'È stata appena inviata una nuova email di verifica.',
      'location_migration_pending':
          'Lo spostamento a $target è ancora in preparazione. Puoi riprenderlo senza ricreare il dispositivo.',
      'vpn_sign_in_required': 'Accedi al tuo account prima di avviare la VPN.',
      'protocol_unavailable_at_location':
          'Il protocollo selezionato non è offerto da questa posizione. Aggiorna le posizioni o scegli un altro protocollo.',
      'vpn_permission_denied':
          'Android ha negato l\'autorizzazione VPN. Avvia nuovamente la connessione e accetta la richiesta del sistema.',
      'revoked_identity_device_limit':
          'L\'accesso VPN di questo dispositivo è stato rimosso e il limite di dispositivi è stato raggiunto. Rimuovi un dispositivo da Account → Gestisci i miei dispositivi.',
      'tunnel_start_unexpected':
          'Un errore imprevisto ha interrotto la preparazione del tunnel. Controlla il codice diagnostico e riprova.',
      'flutter_disconnect_timeout':
          'Android non ha confermato in tempo l\'arresto della VPN. Prova ad arrestarla nuovamente.',
      'flutter_disconnect_unexpected':
          'Un errore imprevisto ha impedito di confermare l\'arresto del tunnel.',
      'device_revoked':
          'L\'accesso VPN del dispositivo è stato revocato e i suoi segreti locali sono stati rimossi.',
      'revoke_unexpected':
          'Non è stato possibile rimuovere il dispositivo. Aggiorna l\'elenco e riprova.',
      'identity_renewal_unexpected':
          'Non è stato possibile creare la nuova identità VPN. Aggiorna i dispositivi e riprova.',
      'openvpn_renewal_unexpected':
          'Non è stato possibile rinnovare il profilo OpenVPN. Riprova o controlla il codice diagnostico.',
      'location_migration_blocked':
          'Il server non può completare questo cambio in questo momento. Il dispositivo e la sua identità locale sono stati conservati.',
      'location_migration_slow':
          'Il server sta ancora preparando lo spostamento a $target. Usa Riprendi tra qualche istante.',
      'location_migration_conflict':
          'Lo stato del dispositivo è cambiato sul server. Aggiorna i dispositivi, poi riprendi il cambio.',
      'location_migration_verification_failed':
          'Il server non ha confermato la nuova posizione. La precedente identità locale è stata conservata.',
      'location_migration_device_changed':
          'Il dispositivo restituito dal server non corrisponde più a quello che stai modificando. Aggiorna i dispositivi prima di riprovare.',
      'tunnel_stop_failed':
          'Il tunnel precedente deve essere completamente arrestato prima della nuova connessione.',
      'other':
          'Non è stato possibile completare l\'operazione. Riprova o invia il codice diagnostico all\'assistenza.',
    });
    return '$_temp0';
  }

  @override
  String notice_api_title(String code) {
    String _temp0 = intl.Intl.selectLogic(code, {
      'unauthorized': 'Sessione scaduta',
      'invalid_credentials': 'Accesso non riuscito',
      'email_verification_required': 'Conferma dell\'email richiesta',
      'verification_email_cooldown': 'Email già inviata',
      'rate_limited': 'Troppi tentativi',
      'invalid_registration': 'Le informazioni devono essere corrette',
      'email_exists': 'Account già esistente',
      'invalid_profile': 'Profilo non valido',
      'invalid_device': 'Dispositivo non valido',
      'invalid_location': 'Posizione non disponibile',
      'device_limit': 'Limite di dispositivi raggiunto',
      'device_exists': 'Identità VPN già in uso',
      'device_identity_revoked': 'L\'identità VPN deve essere rinnovata',
      'device_location_locked':
          'È necessario aggiornare il cambio di posizione',
      'location_migration_pending': 'Cambio di posizione in corso',
      'location_migration_blocked': 'Cambio di posizione bloccato',
      'target_ca_mismatch': 'Server OpenVPN incompatibile',
      'location_migration_conflict':
          'È necessario aggiornare il cambio di posizione',
      'server_full': 'Server pieno',
      'capacity_unavailable': 'Posizione temporaneamente non disponibile',
      'target_unavailable': 'Server temporaneamente non disponibile',
      'not_found': 'Elemento non trovato',
      'invalid_openvpn_csr': 'Identità OpenVPN non valida',
      'openvpn_profile_exists': 'Profilo OpenVPN già esistente',
      'openvpn_profile_revoked': 'Profilo OpenVPN revocato',
      'openvpn_operation_pending': 'Operazione OpenVPN in corso',
      'openvpn_operation_terminal': 'Operazione OpenVPN interrotta',
      'openvpn_address_unavailable': 'Indirizzo OpenVPN non disponibile',
      'openvpn_profile_conflict': 'Conflitto OpenVPN',
      'openvpn_signer_unavailable': 'OpenVPN non disponibile',
      'email_delivery_unavailable': 'Email non disponibile',
      'invalid_token': 'Link non valido',
      'network_unavailable': 'Connessione Internet non disponibile',
      'invalid_json': 'Richiesta non valida',
      'invalid_api_response': 'Risposta del server non valida',
      'ipv6_unavailable': 'IPv6 non disponibile',
      'invalid_ip_families': 'Configurazione di rete rifiutata',
      'other': 'Servizio non disponibile',
    });
    return '$_temp0';
  }

  @override
  String notice_api_message(String code) {
    String _temp0 = intl.Intl.selectLogic(code, {
      'unauthorized':
          'La tua sessione è scaduta. Effettua nuovamente l\'accesso.',
      'invalid_credentials':
          'L\'indirizzo email o la password non sono corretti.',
      'email_verification_required':
          'Conferma il tuo indirizzo email prima di aggiungere un dispositivo VPN.',
      'invalid_registration':
          'Controlla le informazioni e i consensi richiesti.',
      'email_exists': 'Un account utilizza già questo indirizzo email.',
      'invalid_profile': 'Controlla le informazioni del tuo profilo.',
      'invalid_device':
          'Il nome o l\'identità locale di questo dispositivo non sono validi.',
      'invalid_location': 'Aggiorna l\'elenco delle posizioni e riprova.',
      'device_limit':
          'Rimuovi un dispositivo esistente prima di aggiungerne un altro.',
      'device_exists':
          'Questa identità VPN è già collegata a un altro account.',
      'device_identity_revoked':
          'Questa identità è stata rimossa. È necessario creare una nuova identità locale.',
      'device_location_locked':
          'La posizione di questo dispositivo è appena cambiata. L\'app riprenderà il cambio in corso.',
      'location_migration_pending': 'È già in corso un cambio di posizione.',
      'location_migration_blocked':
          'Il cambio di posizione richiede un intervento sul server. Riprova più tardi o contatta l\'assistenza.',
      'target_ca_mismatch':
          'Questo server non è ancora compatibile con il profilo OpenVPN attuale.',
      'location_migration_conflict':
          'Aggiorna i dispositivi, poi riprova a cambiare posizione.',
      'server_full':
          'Questa posizione ha raggiunto il limite di connessioni. Scegli un\'altra posizione o riprova più tardi.',
      'capacity_unavailable':
          'Non possiamo confermare se questa posizione è disponibile in questo momento. Scegli un\'altra posizione o riprova più tardi.',
      'target_unavailable': 'Questo server è temporaneamente non disponibile.',
      'not_found': 'Questo elemento non è più disponibile nel tuo account.',
      'invalid_openvpn_csr': 'Crea una nuova identità OpenVPN e riprova.',
      'openvpn_profile_exists':
          'Esiste già un profilo OpenVPN per questo dispositivo.',
      'openvpn_profile_revoked': 'Rinnova il profilo OpenVPN per continuare.',
      'openvpn_operation_pending':
          'Il cambio è ancora in propagazione. Riprova più tardi.',
      'openvpn_operation_terminal':
          'Crea una nuova identità OpenVPN e riprova.',
      'openvpn_address_unavailable':
          'Al momento non è disponibile alcun indirizzo OpenVPN.',
      'openvpn_profile_conflict':
          'Il profilo è cambiato. Aggiorna i dispositivi e riprova.',
      'openvpn_signer_unavailable':
          'Il servizio OpenVPN è temporaneamente non disponibile.',
      'email_delivery_unavailable':
          'Non è stato possibile inviare l\'email. Riprova più tardi.',
      'invalid_token':
          'Questo link non è valido o è scaduto. Richiedine uno nuovo.',
      'network_unavailable': 'Controlla la connessione Internet e riprova.',
      'invalid_json': 'Controlla le informazioni inserite e riprova.',
      'invalid_api_response':
          'Il server ha restituito una risposta imprevista. Riprova più tardi.',
      'ipv6_unavailable':
          'Al momento il server non può attivare IPv6. Riprova più tardi.',
      'invalid_ip_families':
          'La configurazione del tunnel è incompleta o non corrisponde agli indirizzi autorizzati. Riprova dall\'app.',
      'other': 'Si è verificato un errore del server. Riprova più tardi.',
    });
    return '$_temp0';
  }

  @override
  String get notice_retryLater => 'Riprova tra qualche istante.';

  @override
  String notice_retryAfter(Object seconds) {
    return 'Riprova tra $seconds secondi.';
  }

  @override
  String notice_native_title(String code, String protocol) {
    String _temp0 = intl.Intl.selectLogic(code, {
      'system_vpn_resume_unavailable':
          'Ripresa della VPN di sistema non disponibile',
      'system_vpn_resume_corrupt': 'Ripresa della VPN di sistema non valida',
      'system_vpn_resume_session_invalid': 'Sessione di ripresa VPN non valida',
      'system_vpn_resume_identity_changed': 'Identità VPN cambiata',
      'system_vpn_resume_identity_invalid':
          'Identità di ripresa VPN non valida',
      'system_vpn_resume_storage_failed':
          'Memoria per la ripresa VPN non disponibile',
      'system_vpn_resume_network_timeout':
          'La ripresa VPN non ha accesso alla rete',
      'system_vpn_resume_blocked': 'Ripresa VPN bloccata',
      'system_vpn_resume_failed': 'Ripresa VPN non riuscita',
      'system_vpn_resume_error_invalid': 'Errore di ripresa VPN non valido',
      'wireguard_identity_store_failed': 'Identità WireGuard non salvata',
      'wireguard_identity_unavailable': 'Identità WireGuard non disponibile',
      'vpn_host_destroyed': 'Host VPN di Android arrestato',
      'vpn_host_unavailable': 'Host VPN di Android non disponibile',
      'vpn_permission_required': 'Autorizzazione VPN richiesta',
      'vpn_permission_denied': 'Autorizzazione VPN negata',
      'vpn_permission_request_failed':
          'Impossibile richiedere l\'autorizzazione',
      'wireguard_foreground_service_unavailable':
          'Servizio WireGuard non disponibile',
      'wireguard_identity_invalid': 'Chiave WireGuard locale non valida',
      'wireguard_identity_in_use': 'Identità WireGuard già in uso',
      'wireguard_configuration_invalid': 'Configurazione WireGuard non valida',
      'wireguard_operation_pending': 'Operazione WireGuard ancora attiva',
      'wireguard_start_failed': 'Avvio di WireGuard rifiutato',
      'wireguard_stop_timeout': 'Arresto di WireGuard non confermato',
      'wireguard_handshake_timeout': 'WireGuard non ha risposto',
      'openvpn_connection_timeout': 'OpenVPN non ha risposto',
      'openvpn_core_unavailable': 'Motore OpenVPN non disponibile',
      'openvpn_operation_pending': 'Sessione OpenVPN ancora attiva',
      'openvpn_stop_timeout': 'Arresto di OpenVPN non confermato',
      'openvpn_profile_unavailable': 'Profilo OpenVPN locale mancante',
      'openvpn_native_failed': 'Chiamata OpenVPN nativa interrotta',
      'openvpn_key_generation_failed':
          'Impossibile creare la chiave OpenVPN P-256',
      'openvpn_csr_generation_failed': 'Impossibile creare il CSR OpenVPN',
      'openvpn_identity_store_failed': 'Identità OpenVPN non salvata',
      'openvpn_identity_clear_failed': 'Rimozione OpenVPN incompleta',
      'openvpn_identity_in_use': 'Identità OpenVPN ancora in uso',
      'openvpn_tls_verification_required': 'Verifica TLS OpenVPN mancante',
      'openvpn_cipher_invalid': 'Cifratura OpenVPN non valida',
      'openvpn_profile_rejected': 'Profilo OpenVPN rifiutato',
      'openvpn_identity_inconsistent': 'Identità OpenVPN incoerente',
      'tls_handshake_failed': 'Negoziazione OpenVPN rifiutata',
      'tls_alert_unknown_ca': 'Certificato client OpenVPN non riconosciuto',
      'tls_alert_bad_certificate': 'Certificato client OpenVPN rifiutato',
      'tls_alert_unsupported_certificate': 'Certificato OpenVPN non supportato',
      'tls_client_certificate_required': 'Certificato client OpenVPN richiesto',
      'tls_alert_misc': 'Avviso TLS OpenVPN',
      'tls_signature_algorithm_rejected': 'Firma OpenVPN non supportata',
      'tls_handshake_rejected': 'Negoziazione TLS OpenVPN rifiutata',
      'tls_version_rejected': 'Versione TLS OpenVPN incompatibile',
      'tls_certificate_expired': 'Certificato TLS scaduto',
      'tls_certificate_revoked': 'Certificato TLS revocato',
      'transport_failed': 'Server OpenVPN irraggiungibile',
      'tun_configuration_rejected': 'Impossibile creare l\'interfaccia OpenVPN',
      'tun_setup_failed': 'Configurazione TUN OpenVPN non riuscita',
      'tun_interface_create_failed':
          'Creazione dell\'interfaccia OpenVPN non riuscita',
      'tun_interface_disabled': 'Interfaccia OpenVPN disabilitata',
      'tun_halted': 'Interfaccia OpenVPN interrotta',
      'tun_already_established': 'Interfaccia OpenVPN già aperta',
      'tun_addresses_missing': 'Indirizzo OpenVPN mancante',
      'tun_routes_missing': 'Route OpenVPN mancanti',
      'tun_dns_missing': 'DNS OpenVPN mancante',
      'tun_permission_revoked': 'Autorizzazione VPN revocata',
      'tun_establish_returned_null': 'Android ha rifiutato l\'interfaccia VPN',
      'openvpn_service_start_failed': 'Servizio OpenVPN non disponibile',
      'openvpn_operation_timeout': 'La chiamata OpenVPN è scaduta',
      'openvpn_start_failed': 'Avvio di OpenVPN rifiutato',
      'openvpn_connection_failed': 'Connessione OpenVPN interrotta',
      'openvpn_core_status_error': 'OpenVPN Core si è chiuso con un errore',
      'openvpn_stopped_before_connected':
          'OpenVPN si è arrestato prima della connessione',
      'openvpn_auth_failed': 'Autenticazione OpenVPN rifiutata',
      'openvpn_client_setup_failed':
          'Configurazione del client OpenVPN non riuscita',
      'openvpn_client_halted': 'Client OpenVPN interrotto',
      'openvpn_client_restart': 'Riavvio di OpenVPN richiesto',
      'openvpn_inactive_timeout': 'OpenVPN è rimasto inattivo troppo a lungo',
      'openvpn_session_expired': 'Sessione OpenVPN scaduta',
      'openvpn_credentials_required': 'Autenticazione OpenVPN non supportata',
      'openvpn_proxy_failed': 'Trasporto intermedio OpenVPN non riuscito',
      'openvpn_compression_failed': 'Compressione OpenVPN rifiutata',
      'openvpn_ntlm_crypto_unavailable':
          'Crittografia NTLM OpenVPN non disponibile',
      'openvpn_feature_unsupported': 'Funzionalità OpenVPN non supportata',
      'network_unavailable': 'Connessione Internet non disponibile',
      'network_lost': 'Rete non disponibile',
      'certificate_validation_failed': 'Certificato del server rifiutato',
      'openvpn_certificate_expired': 'Certificato OpenVPN scaduto',
      'tunnel_active_for_another_account':
          'Il tunnel di un altro account è ancora attivo',
      'tunnel_already_active': 'Tunnel nativo già attivo',
      'tunnel_stop_timeout': 'Arresto di $protocol non confermato',
      'tunnel_disconnected': '$protocol interrotto',
      'native_bridge_unavailable': 'Bridge Android non disponibile',
      'native_operation_failed': 'Operazione Android interrotta',
      'invalid_arguments': 'Parametri VPN incompleti',
      'invalid_account_id': 'Account VPN non valido',
      'invalid_device_id': 'Identificatore del dispositivo non valido',
      'storage_key_not_allowed': 'Chiave di memoria rifiutata',
      'secure_storage_read_failed': 'Lettura sicura non riuscita',
      'secure_storage_write_failed': 'Scrittura sicura non riuscita',
      'key_generation_failed': 'Impossibile generare la chiave WireGuard',
      'csr_generation_failed': 'Impossibile generare il CSR OpenVPN',
      'other': 'Errore VPN nativo non classificato',
    });
    return '$_temp0';
  }

  @override
  String notice_native_message(String code, String protocol) {
    String _temp0 = intl.Intl.selectLogic(code, {
      'system_vpn_resume_unavailable':
          'Android non trova una sessione VPN ripristinabile. Avvia una nuova connessione nell\'app.',
      'system_vpn_resume_corrupt':
          'I dati salvati per la ripresa della VPN non sono validi e non verranno utilizzati. Avvia una nuova connessione.',
      'system_vpn_resume_session_invalid':
          'La sessione salvata non può più riprendere la VPN. Accedi nuovamente nell\'app.',
      'system_vpn_resume_identity_changed':
          'L\'identità VPN locale è cambiata. La ripresa è stata arrestata; avvia una nuova connessione.',
      'system_vpn_resume_identity_invalid':
          'L\'identità per la ripresa non è valida. Avvia una nuova connessione.',
      'system_vpn_resume_storage_failed':
          'Android non ha potuto leggere o aggiornare i dati crittografati per la ripresa. Avvia una nuova connessione.',
      'system_vpn_resume_network_timeout':
          'Android non ha trovato una rete in tempo per riprendere la VPN. Riprova quando sarà disponibile una rete.',
      'system_vpn_resume_blocked':
          'La ripresa della VPN è bloccata. Controlla le impostazioni di Android, poi avvia una nuova connessione.',
      'system_vpn_resume_failed':
          'Ripresa della VPN Android non riuscita. Avvia una nuova connessione nell\'app.',
      'system_vpn_resume_error_invalid':
          'Android ha restituito un errore di ripresa inutilizzabile. Avvia una nuova connessione.',
      'wireguard_identity_store_failed':
          'Android non ha potuto salvare l\'identità WireGuard crittografata di questo account.',
      'wireguard_identity_unavailable':
          'Non è disponibile alcuna identità WireGuard utilizzabile per questa connessione.',
      'vpn_host_destroyed':
          'Il componente Android che ospita la VPN è stato arrestato. Avvia una nuova connessione.',
      'vpn_host_unavailable':
          'Android non può creare il componente che ospita la VPN. Riprova dopo aver controllato le impostazioni VPN.',
      'openvpn_renewal_required':
          'Il certificato richiede un\'azione nell\'app prima della connessione.',
      'openvpn_recovery_failed':
          'Ripristino automatico non riuscito. Avvia una nuova connessione nell\'app.',
      'openvpn_recovery_exhausted':
          'Il ripristino automatico è già stato utilizzato. Avvia una nuova connessione nell\'app.',
      'vpn_permission_required':
          'Android richiede una nuova autorizzazione VPN prima di avviare il tunnel.',
      'vpn_permission_denied':
          'Consenti FuzeVPN nella richiesta di Android per continuare.',
      'vpn_permission_request_failed':
          'Android non ha potuto aprire la schermata di autorizzazione VPN.',
      'wireguard_foreground_service_unavailable':
          'Android non ha potuto mantenere il servizio WireGuard in primo piano.',
      'wireguard_identity_invalid':
          'La chiave WireGuard crittografata di questo account non è leggibile o non è valida.',
      'wireguard_identity_in_use':
          'Un\'altra operazione sta ancora usando la chiave WireGuard di questo account.',
      'wireguard_configuration_invalid':
          'L\'indirizzo WireGuard, il DNS, la chiave del server o le route ricevuti non sono validi.',
      'wireguard_operation_pending':
          'L\'operazione WireGuard precedente non ha ancora rilasciato il servizio nativo.',
      'wireguard_start_failed':
          'Il motore WireGuard ha rifiutato l\'attivazione della configurazione.',
      'wireguard_stop_timeout':
          'Il servizio WireGuard non ha confermato il rilascio dell\'interfaccia VPN entro il limite di tempo.',
      'wireguard_handshake_timeout':
          'Il tunnel non ha confermato in tempo l\'handshake con il server.',
      'openvpn_connection_timeout':
          'OpenVPN non ha confermato in tempo la connessione al server.',
      'openvpn_core_unavailable':
          'Questa versione dell\'app non contiene un motore OpenVPN utilizzabile.',
      'openvpn_operation_pending':
          'Il motore nativo mantiene ancora la sessione OpenVPN precedente e rifiuta di crearne una seconda.',
      'openvpn_stop_timeout':
          'OpenVPN Core non ha confermato che la sessione nativa si sia arrestata e sia stata eliminata entro il limite di tempo.',
      'openvpn_profile_unavailable':
          'Non è possibile leggere alcun profilo OpenVPN convalidato per questa connessione.',
      'openvpn_native_failed':
          'Un errore dell\'app ha interrotto OpenVPN. Prova a connetterti nuovamente. Se il problema continua, esegui una diagnostica.',
      'openvpn_key_generation_failed':
          'Android Keystore non ha potuto creare o leggere la chiave privata P-256 non esportabile.',
      'openvpn_csr_generation_failed':
          'La chiave di Android Keystore non ha potuto firmare la richiesta di certificato OpenVPN.',
      'openvpn_identity_store_failed':
          'Non è stato possibile salvare il certificato o il profilo OpenVPN nella memoria crittografata.',
      'openvpn_identity_clear_failed':
          'Android non ha potuto rimuovere completamente l\'identità OpenVPN locale di questo account.',
      'openvpn_identity_in_use':
          'Una sessione OpenVPN nativa sta ancora usando la chiave o il certificato di questo dispositivo.',
      'openvpn_tls_verification_required':
          'Il profilo non richiede esplicitamente la verifica del certificato del server.',
      'openvpn_cipher_invalid':
          'Il server ha fornito un algoritmo di cifratura che non è nell\'elenco consentito.',
      'openvpn_profile_rejected':
          'Il profilo ricevuto dal server è incompatibile. Ricrea questo dispositivo e riprova.',
      'openvpn_identity_inconsistent':
          'Il certificato non corrisponde all\'identità sicura di questo telefono. Nessun profilo locale è stato sostituito.',
      'tls_handshake_failed':
          'Il server ha rifiutato la negoziazione TLS. Ricrea il profilo se il problema persiste.',
      'tls_alert_unknown_ca':
          'Il server non riconosce l\'autorità del certificato di questo dispositivo. È necessario controllare il server OpenVPN.',
      'tls_alert_bad_certificate':
          'Il server ha rifiutato il certificato di questo dispositivo. Ricrea il dispositivo prima di riprovare.',
      'tls_alert_unsupported_certificate':
          'Il server non supporta il tipo di certificato sicuro usato da Android.',
      'tls_client_certificate_required':
          'Il server richiede un certificato client, ma OpenVPN Core non ha potuto presentarne uno.',
      'tls_alert_misc':
          'Il server ha restituito un avviso TLS al di fuori delle categorie di certificato e versione.',
      'tls_signature_algorithm_rejected':
          'Il server ha rifiutato l\'algoritmo ECDSA P-256 della chiave di Android Keystore.',
      'tls_handshake_rejected':
          'Il server ha interrotto la negoziazione TLS prima della connessione.',
      'tls_version_rejected':
          'Il client e il server non hanno trovato una versione TLS comune.',
      'tls_certificate_expired':
          'Il certificato presentato durante la connessione è scaduto.',
      'tls_certificate_revoked':
          'Il certificato presentato durante la connessione è stato revocato.',
      'transport_failed':
          'Il server OpenVPN non risponde sulla rete attuale. Riprova tra poco.',
      'tun_configuration_rejected':
          'Android ha rifiutato la configurazione di rete richiesta da OpenVPN.',
      'tun_setup_failed':
          'OpenVPN Core ha rifiutato il piano di rete prima di creare l\'interfaccia Android.',
      'tun_interface_create_failed':
          'OpenVPN Core non ha potuto ottenere l\'interfaccia TUN da Android VpnService.',
      'tun_interface_disabled':
          'Android o OpenVPN Core ha disabilitato l\'interfaccia TUN durante la connessione.',
      'tun_halted':
          'OpenVPN Core ha ricevuto una richiesta di arresto dell\'interfaccia TUN.',
      'tun_already_established':
          'OpenVPN ha richiesto una seconda interfaccia nella stessa connessione. Il tunnel è stato arrestato per motivi di sicurezza.',
      'tun_addresses_missing':
          'Il server non ha fornito un indirizzo del tunnel utilizzabile.',
      'tun_routes_missing':
          'Il server non ha fornito route del tunnel utilizzabili.',
      'tun_dns_missing': 'Il server non ha fornito un server DNS utilizzabile.',
      'tun_permission_revoked':
          'Android ha revocato l\'autorizzazione VPN durante la connessione.',
      'tun_establish_returned_null':
          'Android non ha creato l\'interfaccia, in genere perché un\'altra VPN è ancora attiva.',
      'openvpn_service_start_failed':
          'Android non ha potuto avviare il servizio OpenVPN in primo piano.',
      'openvpn_operation_timeout':
          'Una chiamata JNI a OpenVPN Core ha superato la durata massima.',
      'openvpn_start_failed':
          'Il servizio Android è pronto, ma OpenVPN Core non ha accettato l\'avvio del profilo.',
      'openvpn_connection_failed':
          'OpenVPN Core si è arrestato prima di emettere l\'evento CONNECTED.',
      'openvpn_core_status_error':
          'Il ciclo OpenVPN nativo è terminato con un errore e senza un evento terminale più specifico.',
      'openvpn_stopped_before_connected':
          'Il ciclo OpenVPN nativo si è arrestato prima di CONNECTED, senza un errore esplicito di Core.',
      'openvpn_auth_failed':
          'Il server OpenVPN ha rifiutato l\'autenticazione del profilo.',
      'openvpn_client_setup_failed':
          'OpenVPN Core non ha potuto inizializzare il client prima della connessione di rete.',
      'openvpn_client_halted':
          'OpenVPN Core ha ricevuto un arresto terminale del client.',
      'openvpn_client_restart':
          'OpenVPN Core ha richiesto il riavvio della sessione di trasporto.',
      'openvpn_inactive_timeout':
          'OpenVPN Core ha chiuso la sessione dopo il timeout di inattività.',
      'openvpn_session_expired':
          'Il server ha segnalato che la sessione OpenVPN è scaduta.',
      'openvpn_credentials_required':
          'Il server o un proxy richiede credenziali interattive che non fanno parte di questo profilo certificato.',
      'openvpn_proxy_failed':
          'OpenVPN Core ha segnalato un errore del proxy o del relay configurato.',
      'openvpn_compression_failed':
          'OpenVPN Core ha rifiutato la modalità di compressione annunciata dal profilo o dal server.',
      'openvpn_ntlm_crypto_unavailable':
          'Il profilo richiede una cifratura NTLM non disponibile in questa versione.',
      'openvpn_feature_unsupported':
          'Il profilo o il server richiede una funzionalità mancante in questo client Android.',
      'network_unavailable':
          'Non è disponibile alcuna rete fisica utilizzabile.',
      'network_lost': 'Il tunnel è stato arrestato dopo la perdita della rete.',
      'certificate_validation_failed':
          'Non è stato possibile verificare l\'identità del server OpenVPN.',
      'openvpn_certificate_expired':
          'Rinnova il profilo OpenVPN prima di riconnetterti.',
      'tunnel_active_for_another_account':
          'Un tunnel appartenente a un altro account deve essere arrestato prima di questa connessione.',
      'tunnel_already_active':
          'Android segnala che una sessione VPN precedente sta ancora usando l\'interfaccia.',
      'tunnel_stop_timeout':
          'Il motore $protocol non ha confermato il rilascio dell\'interfaccia VPN entro il limite di tempo.',
      'tunnel_disconnected':
          'Il motore nativo ha segnalato che il tunnel è terminato inaspettatamente dopo l\'avvio.',
      'native_bridge_unavailable':
          'L\'app non può accedere al servizio VPN di Android. Chiudi e riapri l\'app, poi riprova.',
      'native_operation_failed':
          'Un errore dell\'app ha interrotto l\'operazione VPN. Riprova. Se il problema continua, esegui una diagnostica.',
      'invalid_arguments':
          'Le informazioni necessarie per questa operazione VPN sono incomplete. Riprova. Se il problema continua, esegui una diagnostica.',
      'invalid_account_id':
          'L\'operazione nativa non è associata a un identificatore di account valido.',
      'invalid_device_id':
          'L\'identificatore del dispositivo inviato al motore nativo è mancante o non valido.',
      'storage_key_not_allowed':
          'Il bridge Android ha bloccato una chiave al di fuori dell\'elenco di memoria consentito.',
      'secure_storage_read_failed':
          'Android Keystore non ha potuto decrittografare i dati locali di questo account.',
      'secure_storage_write_failed':
          'Android Keystore non ha potuto crittografare o salvare i dati locali.',
      'key_generation_failed':
          'Android non ha potuto creare o leggere la chiave WireGuard nella memoria sicura.',
      'csr_generation_failed':
          'Android Keystore non ha potuto creare o firmare il CSR OpenVPN P-256.',
      'other':
          'Un ramo nativo non documentato non è riuscito. Invia il codice diagnostico mostrato qui sotto all\'assistenza.',
    });
    return '$_temp0';
  }

  @override
  String get notice_permissionRequestInProgress_title =>
      'Richiesta di autorizzazione già aperta';

  @override
  String get notice_permissionRequestInProgress_message =>
      'La richiesta di autorizzazione VPN di Android è già visualizzata. Completa la procedura prima di riprovare.';

  @override
  String get notice_permissionRequestInterrupted_title =>
      'Richiesta di autorizzazione VPN interrotta';

  @override
  String get notice_permissionRequestInterrupted_message =>
      'La schermata di autorizzazione VPN si è chiusa prima che l\'app ricevesse una risposta.';

  @override
  String get notice_openvpnProofMissing_title =>
      'Connessione OpenVPN non confermata';

  @override
  String get notice_openvpnProofMissing_message =>
      'Non è stato possibile confermare la connessione OpenVPN. È stata arrestata per motivi di sicurezza. Riprova.';

  @override
  String get openvpnCleanup_title => 'Profilo OpenVPN revocato';

  @override
  String get openvpnCleanup_working =>
      'Arresto e rimozione del profilo OpenVPN revocato…';

  @override
  String get openvpnCleanup_stopFailed =>
      'L\'arresto di OpenVPN non è stato confermato. Riprova prima di creare un nuovo profilo.';

  @override
  String get openvpnCleanup_cleanupFailed =>
      'Non è stato possibile rimuovere completamente il profilo OpenVPN revocato. Riprova a cancellarlo.';

  @override
  String get openvpnCleanup_complete =>
      'Il profilo OpenVPN revocato è stato rimosso. Tocca Connetti per crearne uno nuovo.';

  @override
  String get network_title => 'Configurazione di rete';

  @override
  String get network_ipv4Fallback =>
      'IPv6 è temporaneamente non disponibile. La preparazione continua con IPv4.';

  @override
  String get network_rejectedTitle => 'Configurazione di rete rifiutata';

  @override
  String get network_rejectedMessage =>
      'La configurazione del tunnel è incompleta o non corrisponde agli indirizzi autorizzati. Riprova dall\'app.';

  @override
  String get network_unreadableTitle => 'Configurazione locale illeggibile';

  @override
  String get network_unreadableMessage =>
      'La configurazione di rete OpenVPN salvata non può essere utilizzata. Riconnettiti dall\'app per aggiornarla.';

  @override
  String get network_ipv4 => 'IPv4';

  @override
  String get network_dualStack => 'IPv4 + IPv6';

  @override
  String get protection_title => 'Protezione della rete';

  @override
  String get protection_subtitle =>
      'Blocca l\'accesso diretto a Internet se la VPN si disconnette.';

  @override
  String get protection_active => 'Protezione del sistema attiva';

  @override
  String get protection_alwaysOnOnly =>
      'VPN sempre attiva abilitata; attiva il blocco al di fuori della VPN';

  @override
  String get protection_inactive => 'Protezione del sistema inattiva';

  @override
  String get protection_unknown => 'Controlla la protezione del sistema';

  @override
  String get protection_openSettings => 'Apri le impostazioni di Android';

  @override
  String get protection_dialogTitle => 'Configura la protezione della rete';

  @override
  String get protection_dialogMessage =>
      'Android gestisce la VPN sempre attiva e il blocco delle connessioni al di fuori della VPN. Verifica che FuzeVPN sia selezionata e attiva il blocco nelle impostazioni del sistema.';

  @override
  String get protection_dialogOpen => 'Apri impostazioni';

  @override
  String get session_systemProtectionNote =>
      'Se Android continua a bloccare il traffico al di fuori della VPN, apri le impostazioni del sistema per controllare o modificare questa protezione.';

  @override
  String get diagnostics_title => 'Diagnostica';

  @override
  String get diagnostics_settingsTitle => 'Diagnostica dell\'app';

  @override
  String get diagnostics_automaticTitle => 'Invia errori importanti';

  @override
  String get diagnostics_automaticDescription =>
      'Condividi un breve rapporto tecnico quando si verifica un errore importante.';

  @override
  String get diagnostics_privacy =>
      'I rapporti inviati sono collegati all\'account con cui hai effettuato l\'accesso e conservati per 30 giorni. Non contengono cronologia di navigazione, password o chiavi VPN.';

  @override
  String get diagnostics_manualOpen => 'Esegui diagnostica';

  @override
  String get diagnostics_localDescription =>
      'Crea un rapporto sullo stato dell\'app e della VPN. La tua connessione non cambia.';

  @override
  String get diagnostics_sendReport => 'Invia il rapporto';

  @override
  String get diagnostics_sendHint =>
      'Lascia deselezionata questa casella per conservare il rapporto su questo dispositivo.';

  @override
  String get diagnostics_signedOut =>
      'Accedi al tuo account per inviare un rapporto.';

  @override
  String get diagnostics_localLifetime =>
      'Salva questo rapporto sul telefono per conservarlo dopo la chiusura dell\'app.';

  @override
  String get diagnostics_run => 'Esegui diagnostica';

  @override
  String get diagnostics_rerun => 'Esegui di nuovo la diagnostica';

  @override
  String get diagnostics_running => 'Controllo in corso…';

  @override
  String get diagnostics_sending => 'Invio del rapporto…';

  @override
  String get diagnostics_prepared => 'Rapporto pronto su questo dispositivo';

  @override
  String get diagnostics_queued => 'Rapporto in attesa di invio';

  @override
  String get diagnostics_sent => 'Rapporto ricevuto';

  @override
  String get diagnostics_failed =>
      'Invio non riuscito. Il rapporto locale è ancora disponibile.';

  @override
  String get diagnostics_preparationFailed =>
      'Non è stato possibile preparare il rapporto diagnostico. Riprova.';

  @override
  String get diagnostics_authenticationRequired =>
      'Effettua nuovamente l\'accesso per inviare il rapporto.';

  @override
  String get diagnostics_retry => 'Riprova a inviare';

  @override
  String get diagnostics_export => 'Salva rapporto';

  @override
  String get diagnostics_exportFailed =>
      'Esportazione non riuscita. Riprova dal rapporto locale.';

  @override
  String get diagnostics_preferenceFailed =>
      'Non è stato possibile salvare questa impostazione. Riprova.';

  @override
  String diagnostics_receipt(Object id) {
    return 'Riferimento: $id';
  }

  @override
  String diagnostics_received(Object date) {
    return 'Ricevuto il $date';
  }

  @override
  String diagnostics_expires(Object date) {
    return 'Conservato fino al $date';
  }

  @override
  String get diagnostics_duplicate => 'Questo rapporto era già stato ricevuto.';

  @override
  String get diagnostics_preview => 'Anteprima del rapporto';

  @override
  String diagnostics_eventCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count eventi tecnici associati',
      one: '1 evento tecnico associato',
      zero: 'Nessun evento tecnico associato',
    );
    return '$_temp0';
  }

  @override
  String get diagnostics_technical => 'Dettagli tecnici';

  @override
  String get diagnostics_empty =>
      'Non è ancora stato preparato alcun rapporto diagnostico.';

  @override
  String diagnostics_checkName(String id) {
    String _temp0 = intl.Intl.selectLogic(id, {
      'tunnel_connection': 'Stato del tunnel',
      'handshake': 'Conferma della connessione',
      'certificate': 'Certificato VPN',
      'kill_switch': 'Protezione Android',
      'connectivity': 'Rete disponibile',
      'api_reachability': 'Accesso al servizio',
      'secure_storage': 'Memoria sicura',
      'other': 'Controllo locale',
    });
    return '$_temp0';
  }

  @override
  String diagnostics_checkResult(String result) {
    String _temp0 = intl.Intl.selectLogic(result, {
      'passed': 'Controllato',
      'failed': 'Richiede attenzione',
      'skipped': 'Non testato — nessuna verifica attiva',
      'unknown': 'Informazioni non disponibili',
      'other': 'Informazioni non disponibili',
    });
    return '$_temp0';
  }

  @override
  String get auth_welcome => 'Benvenuto in FuzeVPN';

  @override
  String get connection_changeLocation => 'Cambia posizione';

  @override
  String get connection_details => 'Dettagli della connessione';

  @override
  String get locations_searchLabel => 'Cerca una città o un Paese';

  @override
  String get locations_clearSearch => 'Cancella ricerca';

  @override
  String get locations_filterAll => 'Tutte';

  @override
  String get locations_filterFavorites => 'Preferite';

  @override
  String locations_results(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count posizioni',
      one: '$count posizione',
    );
    return '$_temp0';
  }

  @override
  String get locations_noResults => 'Nessuna posizione trovata';

  @override
  String get locations_noResultsHint =>
      'Prova un\'altra città o un altro Paese.';

  @override
  String get locations_noFavorites =>
      'Le tue preferite, sempre a portata di mano';

  @override
  String get locations_noFavoritesHint =>
      'Tocca la stella accanto a una posizione per salvarla qui.';

  @override
  String get locations_showAll => 'Vedi tutte le posizioni';

  @override
  String locations_addFavorite(String name) {
    return 'Aggiungi $name alle preferite';
  }

  @override
  String locations_removeFavorite(String name) {
    return 'Rimuovi $name dalle preferite';
  }

  @override
  String get locations_favoriteSaveFailed =>
      'Non è stato possibile salvare la preferita. Riprova.';

  @override
  String get locations_emptyTitle => 'Nessuna posizione disponibile';

  @override
  String get locations_emptyHint => 'Aggiorna l\'elenco per riprovare.';

  @override
  String get devices_manage => 'Gestisci i miei dispositivi';

  @override
  String get settings_personalization => 'Personalizza';

  @override
  String get settings_safety => 'Protezione';

  @override
  String get settings_help => 'Hai bisogno di aiuto?';

  @override
  String get settings_about => 'Informazioni su FuzeVPN';

  @override
  String get diagnostics_heading => 'Capire un problema di connessione';

  @override
  String devices_profileStatus(String status) {
    String _temp0 = intl.Intl.selectLogic(status, {
      'active': 'Disponibile',
      'pending': 'Preparazione',
      'revoked': 'Rimosso',
      'expired': 'Scaduto',
      'other': 'Stato non disponibile',
    });
    return '$_temp0';
  }

  @override
  String get notice_preferenceSave_title => 'Preferenza non salvata';

  @override
  String get notice_preferenceSave_message =>
      'La tua scelta è applicata per ora, ma non è stato possibile salvarla. Riprova per conservarla dopo la chiusura dell\'app.';

  @override
  String get connection_androidDisconnectHint =>
      'Se Android mantiene attiva la VPN, disattiva la VPN sempre attiva nelle impostazioni che si aprono.';

  @override
  String get protection_learnMore =>
      'Scopri di più sulla protezione di Android';

  @override
  String get protection_guideWhy =>
      'Questa protezione impedisce alle app di usare direttamente Internet se la VPN si disconnette. Viene configurata in Android.';

  @override
  String get protection_guideAlwaysOnTitle => 'VPN sempre attiva';

  @override
  String get protection_guideAlwaysOn =>
      'Android mantiene attivo il servizio VPN e può riavviarlo dopo il riavvio del telefono.';

  @override
  String get protection_guideBlockTitle => 'Blocca le connessioni senza VPN';

  @override
  String get protection_guideBlock =>
      'Questa impostazione impedisce al traffico di bypassare la VPN, anche quando la connessione è interrotta.';

  @override
  String get protection_guideWarning =>
      'Con questo blocco attivo, l\'accesso a Internet resta disattivato finché la VPN non è connessa.';

  @override
  String get protection_guideStepsTitle => 'Attiva la protezione';

  @override
  String get protection_guideStep1 =>
      'Apri le impostazioni VPN di Android con il pulsante qui sotto.';

  @override
  String get protection_guideStep2 =>
      'Apri le opzioni usando l\'icona a forma di ingranaggio accanto a FuzeVPN.';

  @override
  String get protection_guideStep3 =>
      'Abilita VPN sempre attiva, poi Blocca le connessioni senza VPN, se queste opzioni sono disponibili.';

  @override
  String get protection_guideManufacturers =>
      'I nomi variano in base al telefono. Se necessario, cerca VPN nelle Impostazioni, spesso in Rete e Internet.';

  @override
  String get protection_guideDisableTitle => 'Disattiva questa protezione';

  @override
  String get protection_guideDisable =>
      'Nelle stesse impostazioni, disattiva il blocco senza VPN per consentire l\'accesso a Internet senza la VPN. Disattiva anche VPN sempre attiva se non vuoi più che Android la riavvii.';

  @override
  String get protection_guideManual =>
      'Scegli tu queste impostazioni in Android. FuzeVPN non le modifica al posto tuo.';

  @override
  String get locations_changeTitle => 'Cambiare posizione?';

  @override
  String locations_changeActive(String name) {
    return 'La VPN si disconnetterà, poi proverà a connettersi a $name.';
  }

  @override
  String locations_changeIdle(String name) {
    return 'La VPN proverà a connettersi a $name.';
  }

  @override
  String get locations_confirmChange => 'Cambia e connetti';

  @override
  String get locations_changeBusy =>
      'È in corso un cambio. Attendi prima di scegliere un\'altra posizione.';

  @override
  String get locations_automaticSelection => 'Selezione automatica';

  @override
  String get locations_cities => 'Città';

  @override
  String get locations_servers => 'Server';

  @override
  String locations_viewCities(String name) {
    return 'Visualizza le città in $name';
  }

  @override
  String locations_viewServers(String name) {
    return 'Visualizza i server in $name';
  }

  @override
  String locations_countryCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Paesi',
      one: '$count Paese',
    );
    return '$_temp0';
  }

  @override
  String locations_cityCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count città',
      one: '$count città',
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
  String get locations_allCountries => 'Tutti i Paesi';

  @override
  String get locations_backToCountries => 'Torna ai Paesi';

  @override
  String locations_backToCities(String name) {
    return 'Torna alle città di $name';
  }

  @override
  String locations_chooseCountry(String name) {
    return 'Scegli $name';
  }

  @override
  String locations_chooseCity(String name) {
    return 'Scegli $name';
  }

  @override
  String get locations_noCompatibleServer =>
      'Nessun server compatibile disponibile.';

  @override
  String get externalLink_failed =>
      'Impossibile aprire questo link. Puoi copiarlo e aprirlo nel browser.';

  @override
  String get externalLink_copy => 'Copia link';

  @override
  String get externalLink_copied => 'Link copiato';

  @override
  String get externalLink_copyFailed =>
      'Impossibile copiare il link. Seleziona l’indirizzo qui sotto.';

  @override
  String get settings_deleteAccount => 'Elimina il mio account';

  @override
  String get settings_deleteAccountDetail =>
      'Consulta come richiedere l’eliminazione dell’account';

  @override
  String get billing_title => 'Fuze Premium';

  @override
  String get billing_subtitle => 'Scegli il tuo abbonamento VPN.';

  @override
  String get billing_subscribe => 'Abbonati';

  @override
  String get billing_choosePlan => 'Scegli un piano per continuare.';

  @override
  String get billing_monthly => 'Mensile';

  @override
  String get billing_yearly => 'Annuale';

  @override
  String get billing_continue => 'Continua con Google Play';

  @override
  String get billing_restore => 'Ripristina acquisti';

  @override
  String get billing_manage => 'Gestisci abbonamento';

  @override
  String get billing_deleteAccountWarning =>
      'Se hai un abbonamento Google Play, eliminare il tuo account FuzeVPN non ne annulla il rinnovo. Gestisci o annulla il rinnovo separatamente in Google Play.';

  @override
  String get billing_deleteAccountContinue =>
      'Continua alla richiesta di eliminazione dell\'account';

  @override
  String get billing_refresh => 'Aggiorna accesso';

  @override
  String get billing_loadingPlans => 'Caricamento dei piani…';

  @override
  String get billing_unavailable =>
      'Nessun piano disponibile al momento. Riprova più tardi.';

  @override
  String get billing_comingSoon => 'Abbonamenti disponibili a breve.';

  @override
  String get billing_priceDisclosure =>
      'Prezzo fornito da Google Play. L’importo finale e le imposte applicabili vengono confermati prima della tua conferma.';

  @override
  String get billing_renewalMonthly =>
      'Si rinnova automaticamente ogni mese, salvo disdetta. Puoi annullare in qualsiasi momento negli abbonamenti di Google Play.';

  @override
  String get billing_renewalYearly =>
      'Si rinnova automaticamente ogni anno, salvo disdetta. Puoi annullare in qualsiasi momento negli abbonamenti di Google Play.';

  @override
  String get billing_active => 'Il tuo accesso Premium è attivo';

  @override
  String billing_accessUntil(String date) {
    return 'Accesso fino al $date.';
  }

  @override
  String get billing_webManaged =>
      'Il tuo abbonamento è gestito sul sito FuzeVPN.';

  @override
  String get billing_playManaged =>
      'Il tuo abbonamento è gestito da Google Play.';

  @override
  String get billing_inactive => 'Nessun abbonamento attivo.';

  @override
  String get billing_checkingAccess => 'Verifica del tuo accesso…';

  @override
  String get billing_restoring => 'Ripristino degli acquisti…';

  @override
  String get billing_pending =>
      'Pagamento in sospeso. L’accesso sarà attivato dopo la conferma.';

  @override
  String get billing_cancelled =>
      'Acquisto annullato. Nessun nuovo abbonamento è stato attivato.';

  @override
  String get billing_verifying => 'Verifica dell’acquisto…';

  @override
  String get billing_success =>
      'Abbonamento attivato. Il tuo accesso Premium è pronto.';

  @override
  String get billing_restored => 'I tuoi acquisti sono stati ripristinati.';

  @override
  String get billing_restoreEmpty =>
      'Nessun acquisto da ripristinare per questo account Google Play.';

  @override
  String get billing_catalogError => 'Impossibile caricare i piani. Riprova.';

  @override
  String get billing_purchaseError =>
      'Impossibile avviare l’acquisto. Riprova.';

  @override
  String get billing_verificationError =>
      'La verifica dell’acquisto è temporaneamente indisponibile. Ripristina gli acquisti per riprovare.';

  @override
  String get billing_restoreError =>
      'Impossibile ripristinare gli acquisti. Riprova.';

  @override
  String get billing_managementError =>
      'Impossibile aprire la gestione degli abbonamenti. Riprova.';

  @override
  String get billing_storeUnavailable =>
      'Google Play non è disponibile su questo dispositivo.';

  @override
  String get welcome_title => 'La tua VPN, senza complicazioni.';

  @override
  String get welcome_description =>
      'Proteggi la tua connessione. Mantieni il controllo sulla tua privacy.';

  @override
  String get welcome_start => 'Inizia';

  @override
  String get welcome_alreadyPurchased => 'Hai già acquistato?';

  @override
  String get welcome_noAccountRequired =>
      'Non serve creare un account per iniziare.';

  @override
  String get guest_accountTitle => 'Account non collegato';

  @override
  String get guest_accountDescription =>
      'Ripristina gli acquisti con lo stesso account Google Play per usare l’abbonamento su un altro dispositivo.';

  @override
  String get guest_existingSubscriberSignIn => 'Hai già un abbonamento? Accedi';

  @override
  String get guest_claimTitle => 'Porta FuzeVPN con te';

  @override
  String get guest_claimDescription =>
      'Crea un account per accedere al tuo abbonamento sugli altri dispositivi. Questo passaggio è facoltativo.';

  @override
  String get guest_skip => 'Più tardi';

  @override
  String get guest_activationTitle => 'Fuze Premium è attivo';

  @override
  String get guest_activationDescription =>
      'Il tuo abbonamento è pronto. Usa la VPN e crea un account quando vuoi.';

  @override
  String get guest_useVpn => 'Usa la mia VPN';

  @override
  String get guest_loginRequired =>
      'Questo acquisto è già collegato a un account FuzeVPN. Accedi a quell’account per utilizzare il tuo abbonamento.';

  @override
  String get guest_signOutWarning =>
      'Puoi recuperare il tuo abbonamento ripristinando gli acquisti con lo stesso account Google Play.';

  @override
  String get guest_profileUnavailable =>
      'Il tuo account è già collegato. Accedi per visualizzare e gestire i tuoi dati.';

  @override
  String get billing_acceptance =>
      'Continuando, accetti le Condizioni d’uso e l’Informativa sulla privacy.';

  @override
  String get guest_verifyEmailReminder =>
      'Conferma il tuo indirizzo email per proteggere l’account. Puoi continuare a usare la VPN.';

  @override
  String get guest_serviceUnavailable =>
      'Il servizio è temporaneamente non disponibile. Riprova tra poco.';

  @override
  String get guest_restoreError =>
      'Impossibile ripristinare i tuoi acquisti. Riprova con l’account Google Play usato per l’acquisto.';

  @override
  String get guest_claimSuccess =>
      'Il tuo account è stato creato. Il tuo abbonamento e l’accesso alla VPN restano invariati.';

  @override
  String get guest_emailExists =>
      'Questo indirizzo email è già in uso. Scegli un altro indirizzo o accedi al tuo account esistente. Il tuo acquisto rimane disponibile tramite Google Play.';

  @override
  String get guest_claimError =>
      'Impossibile creare il tuo account. Puoi continuare a usare la VPN e riprovare più tardi.';

  @override
  String get guest_secureStorageError =>
      'Impossibile proteggere la tua sessione su questo dispositivo. Riprova.';

  @override
  String get guest_premiumRequired =>
      'Scegli un abbonamento per attivare la tua VPN.';

  @override
  String get welcome_viewPlans => 'Vedi i piani';

  @override
  String get google_continue => 'Continua con Google';

  @override
  String get google_or => 'oppure';

  @override
  String get google_title => 'Il tuo account FuzeVPN';

  @override
  String get google_settingUp => 'Completa il tuo account';

  @override
  String get google_country => 'Paese di residenza';

  @override
  String get google_profileDescription =>
      'Scegli il tuo paese e leggi i due documenti per creare il tuo account FuzeVPN.';

  @override
  String get google_claimDescription =>
      'Collega il tuo account ospite a Google. Abbonamento e dispositivo restano associati a questo account.';

  @override
  String get google_linkTitle => 'Collega Google a FuzeVPN';

  @override
  String get google_linkDescription =>
      'Conferma l’accesso al tuo account FuzeVPN esistente. Non viene richiesta la password di Google.';

  @override
  String get google_password => 'Password FuzeVPN';

  @override
  String get google_linkAccount => 'Conferma il collegamento';

  @override
  String get google_requestEmail => 'Ricevi un’email di conferma';

  @override
  String get google_emailInstructions =>
      'Apri l’email di FuzeVPN e inserisci il codice di conferma.';

  @override
  String get google_emailCode => 'Codice di conferma email';

  @override
  String get google_confirmEmail => 'Conferma il codice';

  @override
  String get google_restart => 'Scegli un altro account Google';

  @override
  String get google_resume => 'Verifica questo tentativo';

  @override
  String get google_unavailable =>
      'L’accesso Google non è disponibile. Puoi usare email e password.';

  @override
  String get google_expired =>
      'Questo tentativo è scaduto. Annullalo e ricomincia.';

  @override
  String get google_conflict =>
      'Questo account Google è già collegato altrove. Account e abbonamento attuali vengono mantenuti.';

  @override
  String get google_error =>
      'L’accesso Google non è riuscito. Riprova; l’accesso attuale viene mantenuto.';

  @override
  String get google_uncertain =>
      'Il risultato non è stato confermato. Verifica questo tentativo o annullalo prima di ricominciare.';

  @override
  String get google_cancelFailed =>
      'L’annullamento non è stato confermato. Riprova ad annullare prima di lasciare questa schermata.';

  @override
  String get google_cancelled => 'Accesso Google annullato.';

  @override
  String get google_selecting => 'Scegli il tuo account Google…';

  @override
  String get google_verifying => 'Verifica dell’account…';

  @override
  String get google_emailUnavailable =>
      'Impossibile inviare l’email di conferma. Riprova più tardi.';

  @override
  String get google_emailSent =>
      'Email di conferma inviata. Controlla la posta in arrivo.';

  @override
  String get google_rateLimited => 'Attendi prima di riprovare.';

  @override
  String get google_invalidPassword =>
      'La password FuzeVPN non è corretta. L’account attuale viene mantenuto.';

  @override
  String get google_invalidCode =>
      'Il codice di conferma non è valido o è scaduto.';

  @override
  String get google_accountChanged =>
      'La sessione è cambiata. Annulla questo tentativo prima di ricominciare.';

  @override
  String get google_invalidResponse =>
      'Impossibile verificare la risposta. L’accesso attuale viene mantenuto.';

  @override
  String get google_invalidRegistration =>
      'Controlla il paese ed entrambi i consensi.';

  @override
  String get google_consentRequired =>
      'Scegli il tuo paese e accetta i due documenti per continuare.';

  @override
  String get google_challengeRequired =>
      'È necessaria una verifica di sicurezza aggiuntiva. L’accesso attuale viene mantenuto.';

  @override
  String get google_challengeUnavailable =>
      'La verifica di sicurezza non è disponibile. Riprova più tardi.';

  @override
  String get billing_trialTitle => 'Prova Fuze Premium gratis';

  @override
  String get billing_trialSubtitle => 'Proteggi la tua connessione da oggi.';

  @override
  String get billing_trialWeeks => '2 settimane di prova gratuita';

  @override
  String billing_trialDays(String days) {
    return '$days giorni di prova gratuita';
  }

  @override
  String get billing_trialStart => 'Inizia la mia prova gratuita';

  @override
  String billing_trialFirstCharge(String date) {
    return 'Se inizi oggi, il primo addebito è previsto per il $date.';
  }

  @override
  String get billing_trialTerms =>
      'Rinnovo automatico al prezzo indicato. Per evitare un addebito, annulla su Google Play prima della fine della prova.';

  @override
  String billing_trialThenMonthly(String price) {
    return 'Poi $price al mese';
  }

  @override
  String billing_trialThenYearly(String price) {
    return 'Poi $price all’anno';
  }

  @override
  String get billing_choosePeriod => 'Scegli il tuo piano';

  @override
  String get billing_selectionHint => 'Seleziona un piano per continuare.';

  @override
  String get billing_benefitConnection => 'Connessione crittografata';

  @override
  String get billing_benefitPrivacy => 'Privacy online';

  @override
  String get billing_benefitNoAccount => 'Registrazione facoltativa';

  @override
  String get billing_cancellation => 'Annullamento su Google Play';

  @override
  String get billing_premiumTitle => 'La tua connessione, più protetta.';

  @override
  String get billing_premiumSubtitle =>
      'Proteggi la connessione con il piano più adatto a te.';

  @override
  String get billing_priceMonthly => 'al mese';

  @override
  String get billing_priceYearly => 'all’anno';

  @override
  String get billing_trialToday => 'Oggi non paghi nulla';

  @override
  String get billing_trialConfirmation =>
      'Google Play conferma le date, l’importo finale e le imposte applicabili prima della tua conferma.';

  @override
  String get billing_offerChanged =>
      'Le condizioni di questa offerta sono cambiate. Aggiorna i piani e scegli di nuovo.';
}
