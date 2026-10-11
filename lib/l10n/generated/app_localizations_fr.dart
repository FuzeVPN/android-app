// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get vpnDisclosure_title => 'Protéger votre connexion';

  @override
  String get vpnDisclosure_body =>
      'FuzeVPN utilise le service VPN d’Android (VpnService) pour créer un tunnel chiffré entre cet appareil et les serveurs FuzeVPN.';

  @override
  String get vpnDisclosure_dataBody =>
      'Lorsque le VPN est actif, le trafic Internet de vos applications, les adresses de destination et les requêtes DNS transitent par ce tunnel pour acheminer votre connexion, même lorsque FuzeVPN est en arrière-plan.';

  @override
  String get vpnDisclosure_statusBody =>
      'L’application utilise l’état de la connexion, sa durée et le volume de données échangées pour afficher votre connexion VPN. Vous pouvez l’arrêter à tout moment.';

  @override
  String get vpnDisclosure_privacy => 'Confidentialité';

  @override
  String get vpnDisclosure_accept => 'Accepter et continuer';

  @override
  String get vpnDisclosure_decline => 'Pas maintenant';

  @override
  String get accountRestoration_title => 'Compte temporairement indisponible';

  @override
  String get accountRestoration_message =>
      'Votre session est conservée. Réessayez pour retrouver votre compte ; vous pouvez toujours gérer la connexion VPN ici.';

  @override
  String get action_retry => 'Réessayer';

  @override
  String get session_endingTitle => 'Arrêt de la session';

  @override
  String get session_ending =>
      'Votre session est invalidée. Arrêt du VPN et nettoyage en cours…';

  @override
  String get session_stopFailed =>
      'L’arrêt du VPN n’est pas confirmé. Réessayez avant de vous reconnecter.';

  @override
  String get session_cleanupFailed =>
      'Le VPN est arrêté, mais l’effacement de la session n’est pas confirmé. Réessayez le nettoyage.';

  @override
  String get session_retryStop => 'Réessayer l’arrêt';

  @override
  String get session_retryCleanup => 'Réessayer le nettoyage';

  @override
  String get appTitle => 'FuzeVPN';

  @override
  String get startup => 'Préparation sécurisée de FuzeVPN…';

  @override
  String get nav_connection => 'Connexion';

  @override
  String get nav_locations => 'Emplacements';

  @override
  String get nav_account => 'Compte';

  @override
  String get nav_devices => 'Appareils';

  @override
  String get nav_settings => 'Réglages';

  @override
  String get action_refresh => 'Actualiser';

  @override
  String get auth_tab_login => 'Connexion';

  @override
  String get auth_tab_register => 'Inscription';

  @override
  String get auth_stepAccount => 'Compte';

  @override
  String get auth_stepIdentity => 'Identité';

  @override
  String get auth_stepAddress => 'Adresse et accords';

  @override
  String auth_stepProgress(Object current, Object total) {
    return 'Étape $current sur $total';
  }

  @override
  String get auth_tagline => 'Votre VPN, simplement.';

  @override
  String get auth_keysLocal => 'Vos clés privées VPN restent sur cet appareil.';

  @override
  String get form_email => 'Adresse e-mail';

  @override
  String get form_password => 'Mot de passe';

  @override
  String get form_showPassword => 'Afficher le mot de passe';

  @override
  String get form_hidePassword => 'Masquer le mot de passe';

  @override
  String get form_passwordMin =>
      '8 à 72 octets UTF-8. Certains caractères occupent plusieurs octets.';

  @override
  String get form_firstName => 'Prénom';

  @override
  String get form_lastName => 'Nom';

  @override
  String get form_phone => 'Téléphone (+33612345678)';

  @override
  String get form_address => 'Adresse';

  @override
  String get form_address2 => 'Complément d’adresse (facultatif)';

  @override
  String get form_postalCode => 'Code postal';

  @override
  String get form_city => 'Ville';

  @override
  String get form_country => 'Code pays (ex. FR)';

  @override
  String get action_login => 'Se connecter';

  @override
  String get action_createAccount => 'Créer un compte';

  @override
  String get action_createMyAccount => 'Créer mon compte';

  @override
  String get action_next => 'Continuer';

  @override
  String get action_previous => 'Retour';

  @override
  String get action_forgotPassword => 'Mot de passe oublié ?';

  @override
  String get auth_noAccount => 'Vous n’avez pas encore de compte ?';

  @override
  String get auth_requiredInformation => 'Créez votre compte en trois étapes.';

  @override
  String get auth_termsPrefix => 'J’accepte les ';

  @override
  String get auth_termsLink => 'conditions d’utilisation';

  @override
  String get auth_privacyPrefix => 'J’accepte la ';

  @override
  String get auth_privacyLink => 'politique de confidentialité';

  @override
  String get auth_consentRequired =>
      'Votre accord est nécessaire pour créer un compte.';

  @override
  String get validation_required => 'Ce champ est obligatoire.';

  @override
  String get validation_email => 'Saisissez une adresse e-mail valide.';

  @override
  String get validation_password =>
      'Mot de passe trop court : au moins 8 octets UTF-8.';

  @override
  String get validation_passwordTooLong =>
      'Mot de passe trop long : au maximum 72 octets UTF-8.';

  @override
  String get validation_phone =>
      'Utilisez le format international, par exemple +33612345678.';

  @override
  String get validation_country =>
      'Utilisez un code pays à deux lettres, par exemple FR.';

  @override
  String get passwordReset_title => 'Réinitialiser le mot de passe';

  @override
  String get passwordReset_description =>
      'Saisissez l’adresse e-mail de votre compte pour demander un lien de réinitialisation.';

  @override
  String get passwordReset_send => 'Envoyer le lien';

  @override
  String get connection_title => 'Votre connexion';

  @override
  String get connection_subtitle =>
      'Choisissez une destination, puis activez votre VPN.';

  @override
  String get connection_prepare => 'Prêt à vous connecter ?';

  @override
  String get connection_advancedOptions => 'Options avancées';

  @override
  String get connection_location => 'Emplacement';

  @override
  String get connection_chooseLocation => 'Choisissez un emplacement';

  @override
  String get connection_protocol => 'Protocole';

  @override
  String get connection_connect => 'Se connecter';

  @override
  String get connection_connecting => 'Connexion en cours…';

  @override
  String get connection_disconnect => 'Se déconnecter';

  @override
  String get connection_disconnecting => 'Déconnexion en cours';

  @override
  String get connection_locationChange => 'Changement d’emplacement…';

  @override
  String connection_unavailable(Object protocol) {
    return '$protocol indisponible';
  }

  @override
  String get connection_activeLocation => 'Emplacement actif';

  @override
  String get connection_duration => 'Durée';

  @override
  String get connection_received => 'Reçus';

  @override
  String get connection_sent => 'Envoyés';

  @override
  String get connection_lastHandshake => 'Dernier échange sécurisé';

  @override
  String connection_handshakeAgo(Object duration) {
    return 'Il y a $duration';
  }

  @override
  String get verification_title => 'Confirmez votre adresse e-mail';

  @override
  String get verification_message =>
      'Confirmez votre adresse e-mail pour activer le VPN sur ce téléphone.';

  @override
  String get verification_resend => 'Renvoyer l’e-mail';

  @override
  String get migration_title => 'Changement d’emplacement';

  @override
  String get migration_draining => 'Préparation du changement d’emplacement…';

  @override
  String get migration_activating => 'Activation du nouveau serveur…';

  @override
  String get migration_ready => 'Emplacement mis à jour.';

  @override
  String get migration_blocked =>
      'Le changement nécessite une intervention serveur. Réessayez plus tard ou contactez le support.';

  @override
  String get migration_progress => 'Progression du changement d’emplacement';

  @override
  String migration_retryDelay(Object seconds) {
    return 'Délai entre deux vérifications : $seconds s.';
  }

  @override
  String get migration_resume => 'Reprendre le changement';

  @override
  String get status_authorizing => 'Autorisation requise';

  @override
  String get status_authorizingDetail =>
      'Acceptez la demande Android pour autoriser le VPN.';

  @override
  String get status_preparing => 'Préparation';

  @override
  String get status_preparingDetail => 'Votre connexion sécurisée se prépare.';

  @override
  String get status_reconnecting => 'Reconnexion…';

  @override
  String get status_reconnectingDetail =>
      'Connexion interrompue. Le VPN tente de se reconnecter.';

  @override
  String get status_connecting => 'Connexion en cours';

  @override
  String get status_connectingDetail => 'Connexion au serveur VPN…';

  @override
  String get status_connected => 'Connecté';

  @override
  String get status_connectedDetail => 'Votre connexion VPN est active.';

  @override
  String get status_disconnecting => 'Déconnexion en cours';

  @override
  String get status_disconnectingDetail =>
      'Votre connexion VPN est en cours d’arrêt.';

  @override
  String get status_error => 'Connexion indisponible';

  @override
  String get status_errorDetail =>
      'La connexion VPN n’est pas confirmée. Réessayez.';

  @override
  String get status_idle => 'Déconnecté';

  @override
  String get status_idleDetail =>
      'Connectez le VPN pour protéger votre connexion.';

  @override
  String get trust_note =>
      'Fermer l’application ne coupe pas le VPN. Pour l’arrêter, utilisez Se déconnecter.';

  @override
  String get locations_none => 'Aucun emplacement disponible pour le moment.';

  @override
  String get locations_available => 'Choisissez votre prochaine destination.';

  @override
  String get locations_selected => 'Emplacement sélectionné';

  @override
  String get locations_select => 'Choisir cet emplacement';

  @override
  String get locations_lockedTunnel =>
      'Déconnectez le VPN pour changer d’emplacement.';

  @override
  String get locations_lockedMigration =>
      'Patientez jusqu’à la fin du changement d’emplacement.';

  @override
  String get devices_title => 'Vos appareils';

  @override
  String devices_used(Object count, Object limit) {
    return '$count / $limit appareils';
  }

  @override
  String get devices_refresh => 'Actualiser les appareils';

  @override
  String get devices_empty => 'Aucun appareil VPN n’est encore enregistré.';

  @override
  String get devices_firstConnection =>
      'Votre téléphone sera ajouté lors de la première connexion.';

  @override
  String get devices_thisDevice => 'Cet appareil';

  @override
  String devices_added(Object date) {
    return 'Ajouté le $date';
  }

  @override
  String get action_remove => 'Retirer';

  @override
  String get settings_title => 'Réglages';

  @override
  String get settings_subtitle =>
      'Vos préférences et votre compte, au même endroit.';

  @override
  String get settings_appearance => 'Apparence';

  @override
  String get settings_language => 'Langue';

  @override
  String get settings_languageDescription =>
      'La langue choisie s’applique aussi aux notifications VPN.';

  @override
  String get settings_account => 'Compte';

  @override
  String get settings_signOut => 'Déconnecter le compte';

  @override
  String get settings_privacy => 'Politique de confidentialité';

  @override
  String get settings_terms => 'Conditions d’utilisation';

  @override
  String get settings_security => 'Sécurité et transparence';

  @override
  String get settings_licenses => 'Licences des composants';

  @override
  String get settings_licensesDetail => 'Logiciels utilisés dans l’application';

  @override
  String get settings_background =>
      'Le VPN reste actif quand vous quittez l’application. Pour l’arrêter, utilisez Se déconnecter dans l’onglet Connexion.';

  @override
  String get theme_system => 'Système';

  @override
  String get theme_light => 'Clair';

  @override
  String get theme_dark => 'Sombre';

  @override
  String get language_system => 'Langue du téléphone';

  @override
  String get language_fr => 'Français';

  @override
  String get language_en => 'English';

  @override
  String get language_es => 'Español';

  @override
  String get language_de => 'Deutsch';

  @override
  String get dialog_removeDevice => 'Retirer cet appareil ?';

  @override
  String get dialog_removeCurrent =>
      'Ce téléphone sera déconnecté du VPN et perdra son accès. Ses données de connexion VPN seront effacées après confirmation du serveur.';

  @override
  String dialog_removeOther(Object name) {
    return 'L’accès VPN de « $name » sera révoqué. Cette action ne peut pas être annulée.';
  }

  @override
  String get dialog_signOut => 'Déconnecter le compte ?';

  @override
  String get dialog_signOutMessage =>
      'Le VPN sera arrêté et vous devrez vous reconnecter à votre compte. Les clés VPN chiffrées resteront sur ce téléphone pour votre prochaine connexion.';

  @override
  String get action_cancel => 'Annuler';

  @override
  String get action_signOut => 'Déconnecter';

  @override
  String get notice_close => 'Fermer le message';

  @override
  String get notice_sessionExpired_title => 'Session expirée';

  @override
  String get notice_sessionExpired_message =>
      'Votre session a expiré. Connectez-vous de nouveau.';

  @override
  String get notice_connectionFailed_title => 'Connexion impossible';

  @override
  String get notice_invalidCredentials_message =>
      'L’adresse e-mail ou le mot de passe est incorrect.';

  @override
  String get notice_emailVerification_title => 'Adresse e-mail à confirmer';

  @override
  String get notice_emailVerification_message =>
      'Confirmez votre adresse e-mail avant d’ajouter un appareil VPN.';

  @override
  String get notice_rateLimited_title => 'Trop de tentatives';

  @override
  String get notice_deviceLimit_title => 'Limite de 2 appareils atteinte';

  @override
  String get notice_deviceLimit_message =>
      'Retirez un appareil existant avant d’en ajouter un autre.';

  @override
  String get notice_identityRenewal_title => 'Identité VPN à renouveler';

  @override
  String get notice_identityRenewal_message =>
      'Cette identité a été retirée. Créez une nouvelle identité locale.';

  @override
  String get notice_migrationPending_title =>
      'Changement d’emplacement en cours';

  @override
  String get notice_migrationPending_message =>
      'Un changement d’emplacement est déjà en cours.';

  @override
  String get notice_migrationBlocked_title => 'Changement d’emplacement bloqué';

  @override
  String get notice_migrationBlocked_message =>
      'Le changement d’emplacement nécessite une intervention serveur. Réessayez plus tard ou contactez le support.';

  @override
  String get notice_targetUnavailable_title =>
      'Serveur temporairement indisponible';

  @override
  String get notice_targetUnavailable_message =>
      'Ce serveur est temporairement indisponible.';

  @override
  String get notice_networkUnavailable_title =>
      'Connexion Internet indisponible';

  @override
  String get notice_networkUnavailable_message =>
      'Vérifiez votre connexion puis réessayez.';

  @override
  String get notice_permissionDenied_title => 'Autorisation VPN refusée';

  @override
  String get notice_permissionDenied_message =>
      'Relancez la connexion et acceptez la demande d’autorisation Android.';

  @override
  String get notice_wireguardTimeout_title => 'Le serveur ne répond pas';

  @override
  String get notice_wireguardTimeout_message =>
      'La connexion WireGuard n’a pas abouti à temps. Réessayez ou choisissez un autre emplacement.';

  @override
  String get notice_tlsFailed_title => 'Connexion sécurisée refusée';

  @override
  String get notice_tlsFailed_message =>
      'Le serveur n’a pas accepté la connexion OpenVPN. Réessayez. Si le problème persiste, lancez un diagnostic.';

  @override
  String get notice_tunRejected_title => 'Interface VPN refusée par Android';

  @override
  String get notice_tunRejected_message =>
      'Android a refusé la configuration réseau demandée par OpenVPN.';

  @override
  String get notice_openvpnStart_title => 'Démarrage OpenVPN impossible';

  @override
  String get notice_openvpnStart_message =>
      'Le moteur OpenVPN n’a pas pu terminer le démarrage. Réessayez. Si le problème persiste, contactez le support.';

  @override
  String notice_diagnosticCode(Object code) {
    return 'Code diagnostic : $code';
  }

  @override
  String get notice_generic_title => 'Connexion VPN impossible';

  @override
  String get notice_generic_message =>
      'Une erreur est survenue. Réessayez plus tard.';

  @override
  String notice_controller_title(String code) {
    String _temp0 = intl.Intl.selectLogic(code, {
      'account_created_email_unavailable': 'Compte créé',
      'password_reset_sent': 'Demande de réinitialisation reçue',
      'verification_email_sent': 'E-mail de vérification envoyé',
      'location_migration_pending': 'Changement d’emplacement en cours',
      'vpn_sign_in_required': 'Connexion requise',
      'protocol_unavailable_at_location': 'Protocole indisponible',
      'vpn_permission_denied': 'Autorisation VPN refusée',
      'revoked_identity_device_limit': 'Limite de 2 appareils atteinte',
      'tunnel_start_unexpected': 'Démarrage VPN impossible',
      'flutter_disconnect_timeout': 'Déconnexion non confirmée',
      'flutter_disconnect_unexpected': 'Déconnexion impossible',
      'device_revoked': 'Appareil retiré',
      'revoke_unexpected': 'Suppression impossible',
      'identity_renewal_unexpected': 'Renouvellement impossible',
      'openvpn_renewal_unexpected': 'Renouvellement OpenVPN impossible',
      'location_migration_blocked': 'Changement d’emplacement bloqué',
      'location_migration_slow': 'Changement toujours en cours',
      'location_migration_conflict': 'Changement d’emplacement à actualiser',
      'location_migration_verification_failed': 'Changement non confirmé',
      'location_migration_device_changed':
          'Appareil modifié pendant le changement',
      'tunnel_stop_failed': 'Changement impossible',
      'other': 'Opération impossible',
    });
    return '$_temp0';
  }

  @override
  String notice_controller_message(String code, String target) {
    String _temp0 = intl.Intl.selectLogic(code, {
      'account_created_email_unavailable':
          'Le compte a été créé, mais l’e-mail de vérification n’a pas pu être envoyé. Utilisez le renvoi depuis l’application.',
      'password_reset_sent':
          'Votre demande a été reçue. Si un compte correspond à cette adresse, un e-mail pourra vous parvenir. Vérifiez aussi vos courriers indésirables.',
      'verification_email_sent':
          'Un nouvel e-mail de vérification vient d’être envoyé.',
      'location_migration_pending':
          'La préparation du déplacement vers $target est toujours en cours. Vous pouvez la reprendre sans recréer l’appareil.',
      'vpn_sign_in_required':
          'Connectez-vous à votre compte avant de démarrer le VPN.',
      'protocol_unavailable_at_location':
          'Le protocole sélectionné n’est pas proposé par cet emplacement. Actualisez les emplacements ou choisissez un autre protocole.',
      'vpn_permission_denied':
          'Android a refusé l’autorisation VPN. Relancez la connexion puis acceptez la demande système.',
      'revoked_identity_device_limit':
          'L’accès VPN de cet appareil a été retiré et la limite d’appareils est atteinte. Retirez un appareil dans Compte → Gérer mes appareils.',
      'tunnel_start_unexpected':
          'Une erreur inattendue a interrompu la préparation du tunnel. Consultez le code diagnostic puis réessayez.',
      'flutter_disconnect_timeout':
          'Android n’a pas confirmé l’arrêt du VPN à temps. Réessayez l’arrêt.',
      'flutter_disconnect_unexpected':
          'Une erreur inattendue a empêché la confirmation de l’arrêt du tunnel.',
      'device_revoked':
          'L’accès VPN de l’appareil a été révoqué et ses secrets locaux ont été supprimés.',
      'revoke_unexpected':
          'L’appareil n’a pas pu être retiré. Actualisez la liste puis réessayez.',
      'identity_renewal_unexpected':
          'La nouvelle identité VPN n’a pas pu être créée. Actualisez les appareils puis réessayez.',
      'openvpn_renewal_unexpected':
          'Le profil OpenVPN n’a pas pu être renouvelé. Réessayez ou consultez le code diagnostic.',
      'location_migration_blocked':
          'Le serveur ne peut pas terminer ce changement pour le moment. L’appareil et son identité locale ont été conservés.',
      'location_migration_slow':
          'Le serveur prépare encore le déplacement vers $target. Utilisez Reprendre dans quelques instants.',
      'location_migration_conflict':
          'L’état de l’appareil a changé sur le serveur. Actualisez les appareils puis reprenez le changement.',
      'location_migration_verification_failed':
          'Le serveur n’a pas confirmé le nouvel emplacement. L’ancienne identité locale a été conservée.',
      'location_migration_device_changed':
          'L’appareil retourné par le serveur ne correspond plus à celui du changement. Actualisez les appareils avant de réessayer.',
      'tunnel_stop_failed':
          'Le tunnel précédent doit être complètement arrêté avant la nouvelle connexion.',
      'other':
          'L’opération n’a pas pu être terminée. Réessayez ou transmettez le code diagnostic au support.',
    });
    return '$_temp0';
  }

  @override
  String notice_api_title(String code) {
    String _temp0 = intl.Intl.selectLogic(code, {
      'unauthorized': 'Session expirée',
      'invalid_credentials': 'Connexion impossible',
      'email_verification_required': 'Adresse e-mail à confirmer',
      'verification_email_cooldown': 'E-mail déjà envoyé',
      'rate_limited': 'Trop de tentatives',
      'invalid_registration': 'Informations à corriger',
      'email_exists': 'Compte existant',
      'invalid_profile': 'Profil invalide',
      'invalid_device': 'Appareil invalide',
      'invalid_location': 'Emplacement indisponible',
      'device_limit': 'Limite d’appareils atteinte',
      'device_exists': 'Identité VPN déjà utilisée',
      'device_identity_revoked': 'Identité VPN à renouveler',
      'device_location_locked': 'Changement d’emplacement à actualiser',
      'location_migration_pending': 'Changement d’emplacement en cours',
      'location_migration_blocked': 'Changement d’emplacement bloqué',
      'target_ca_mismatch': 'Serveur OpenVPN non compatible',
      'location_migration_conflict': 'Changement d’emplacement à actualiser',
      'server_full': 'Serveur complet',
      'capacity_unavailable': 'Emplacement temporairement indisponible',
      'target_unavailable': 'Serveur temporairement indisponible',
      'not_found': 'Élément introuvable',
      'invalid_openvpn_csr': 'Identité OpenVPN invalide',
      'openvpn_profile_exists': 'Profil OpenVPN existant',
      'openvpn_profile_revoked': 'Profil OpenVPN révoqué',
      'openvpn_operation_pending': 'Opération OpenVPN en cours',
      'openvpn_operation_terminal': 'Opération OpenVPN interrompue',
      'openvpn_address_unavailable': 'Adresse OpenVPN indisponible',
      'openvpn_profile_conflict': 'Conflit OpenVPN',
      'openvpn_signer_unavailable': 'OpenVPN indisponible',
      'email_delivery_unavailable': 'E-mail indisponible',
      'invalid_token': 'Lien invalide',
      'network_unavailable': 'Connexion Internet indisponible',
      'invalid_json': 'Demande invalide',
      'invalid_api_response': 'Réponse serveur invalide',
      'ipv6_unavailable': 'IPv6 indisponible',
      'invalid_ip_families': 'Configuration réseau refusée',
      'other': 'Service indisponible',
    });
    return '$_temp0';
  }

  @override
  String notice_api_message(String code) {
    String _temp0 = intl.Intl.selectLogic(code, {
      'unauthorized': 'Votre session a expiré. Connectez-vous de nouveau.',
      'invalid_credentials':
          'L’adresse e-mail ou le mot de passe est incorrect.',
      'email_verification_required':
          'Confirmez votre adresse e-mail avant d’ajouter un appareil VPN.',
      'invalid_registration':
          'Vérifiez les informations et les consentements demandés.',
      'email_exists': 'Cette adresse e-mail possède déjà un compte.',
      'invalid_profile': 'Vérifiez les informations de votre profil.',
      'invalid_device':
          'Le nom ou l’identité locale de cet appareil est invalide.',
      'invalid_location':
          'Actualisez la liste des emplacements puis réessayez.',
      'device_limit':
          'Retirez un appareil existant avant d’en ajouter un autre.',
      'device_exists': 'Cette identité VPN est déjà liée à un autre compte.',
      'device_identity_revoked':
          'Cette identité a été retirée. Une nouvelle identité locale doit être créée.',
      'device_location_locked':
          'L’emplacement de cet appareil vient de changer. L’application va reprendre le changement en cours.',
      'location_migration_pending':
          'Un changement d’emplacement est déjà en cours.',
      'location_migration_blocked':
          'Le changement d’emplacement nécessite une intervention serveur. Réessayez plus tard ou contactez le support.',
      'target_ca_mismatch':
          'Ce serveur n’est pas encore compatible avec le profil OpenVPN actuel.',
      'location_migration_conflict':
          'Actualisez les appareils puis réessayez le changement d’emplacement.',
      'server_full':
          'Cet emplacement a atteint sa limite de connexions. Choisissez un autre emplacement ou réessayez plus tard.',
      'capacity_unavailable':
          'La disponibilité de cet emplacement ne peut pas être confirmée pour le moment. Choisissez un autre emplacement ou réessayez plus tard.',
      'target_unavailable': 'Ce serveur est temporairement indisponible.',
      'not_found': 'Cet élément n’est plus disponible sur votre compte.',
      'invalid_openvpn_csr':
          'Créez une nouvelle identité OpenVPN puis réessayez.',
      'openvpn_profile_exists':
          'Un profil OpenVPN existe déjà pour cet appareil.',
      'openvpn_profile_revoked': 'Renouvelez le profil OpenVPN pour continuer.',
      'openvpn_operation_pending':
          'La modification est en cours de propagation. Réessayez plus tard.',
      'openvpn_operation_terminal':
          'Créez une nouvelle identité OpenVPN puis réessayez.',
      'openvpn_address_unavailable':
          'Aucune adresse OpenVPN n’est disponible pour le moment.',
      'openvpn_profile_conflict':
          'Le profil a changé. Actualisez les appareils puis réessayez.',
      'openvpn_signer_unavailable':
          'Le service OpenVPN est momentanément indisponible.',
      'email_delivery_unavailable':
          'L’e-mail n’a pas pu être envoyé. Réessayez plus tard.',
      'invalid_token':
          'Ce lien est invalide ou a expiré. Demandez-en un nouveau.',
      'network_unavailable':
          'Vérifiez votre connexion Internet puis réessayez.',
      'invalid_json': 'Vérifiez les informations saisies puis réessayez.',
      'invalid_api_response':
          'Le serveur a renvoyé une réponse inattendue. Réessayez plus tard.',
      'ipv6_unavailable':
          'Le serveur ne peut pas activer IPv6 pour le moment. Réessayez plus tard.',
      'invalid_ip_families':
          'La configuration du tunnel est incomplète ou ne correspond pas aux adresses autorisées. Réessayez depuis l’application.',
      'other': 'Une erreur serveur est survenue. Réessayez plus tard.',
    });
    return '$_temp0';
  }

  @override
  String get notice_retryLater => 'Réessayez dans quelques instants.';

  @override
  String notice_retryAfter(Object seconds) {
    return 'Réessayez dans $seconds secondes.';
  }

  @override
  String notice_native_title(String code, String protocol) {
    String _temp0 = intl.Intl.selectLogic(code, {
      'system_vpn_resume_unavailable': 'Reprise VPN système indisponible',
      'system_vpn_resume_corrupt': 'Reprise VPN système invalide',
      'system_vpn_resume_session_invalid': 'Session de reprise VPN invalide',
      'system_vpn_resume_identity_changed': 'Identité VPN modifiée',
      'system_vpn_resume_identity_invalid': 'Identité de reprise VPN invalide',
      'system_vpn_resume_storage_failed':
          'Stockage de reprise VPN indisponible',
      'system_vpn_resume_network_timeout': 'Reprise VPN sans réseau',
      'system_vpn_resume_blocked': 'Reprise VPN bloquée',
      'system_vpn_resume_failed': 'Reprise VPN échouée',
      'system_vpn_resume_error_invalid': 'Erreur de reprise VPN invalide',
      'wireguard_identity_store_failed': 'Identité WireGuard non enregistrée',
      'wireguard_identity_unavailable': 'Identité WireGuard indisponible',
      'vpn_host_destroyed': 'Hôte VPN Android arrêté',
      'vpn_host_unavailable': 'Hôte VPN Android indisponible',
      'vpn_permission_required': 'Autorisation VPN requise',
      'vpn_permission_denied': 'Autorisation VPN refusée',
      'vpn_permission_request_failed': 'Demande d’autorisation impossible',
      'wireguard_foreground_service_unavailable':
          'Service WireGuard indisponible',
      'wireguard_identity_invalid': 'Clé WireGuard locale invalide',
      'wireguard_identity_in_use': 'Identité WireGuard déjà utilisée',
      'wireguard_configuration_invalid': 'Configuration WireGuard invalide',
      'wireguard_operation_pending': 'Opération WireGuard encore active',
      'wireguard_start_failed': 'Démarrage WireGuard refusé',
      'wireguard_stop_timeout': 'Arrêt WireGuard non confirmé',
      'wireguard_handshake_timeout': 'WireGuard sans réponse',
      'openvpn_connection_timeout': 'OpenVPN sans réponse',
      'openvpn_core_unavailable': 'Moteur OpenVPN indisponible',
      'openvpn_operation_pending': 'Session OpenVPN encore active',
      'openvpn_stop_timeout': 'Arrêt OpenVPN non confirmé',
      'openvpn_profile_unavailable': 'Profil OpenVPN local absent',
      'openvpn_native_failed': 'Appel natif OpenVPN interrompu',
      'openvpn_key_generation_failed': 'Clé OpenVPN P-256 impossible',
      'openvpn_csr_generation_failed': 'CSR OpenVPN impossible',
      'openvpn_identity_store_failed': 'Identité OpenVPN non enregistrée',
      'openvpn_identity_clear_failed': 'Suppression OpenVPN incomplète',
      'openvpn_identity_in_use': 'Identité OpenVPN encore utilisée',
      'openvpn_tls_verification_required': 'Vérification TLS OpenVPN absente',
      'openvpn_cipher_invalid': 'Chiffrement OpenVPN invalide',
      'openvpn_profile_rejected': 'Profil OpenVPN refusé',
      'openvpn_identity_inconsistent': 'Identité OpenVPN incohérente',
      'tls_handshake_failed': 'Négociation OpenVPN refusée',
      'tls_alert_unknown_ca': 'Certificat client OpenVPN non reconnu',
      'tls_alert_bad_certificate': 'Certificat client OpenVPN refusé',
      'tls_alert_unsupported_certificate': 'Certificat OpenVPN non compatible',
      'tls_client_certificate_required': 'Certificat client OpenVPN requis',
      'tls_alert_misc': 'Alerte TLS OpenVPN',
      'tls_signature_algorithm_rejected': 'Signature OpenVPN non compatible',
      'tls_handshake_rejected': 'Négociation TLS OpenVPN refusée',
      'tls_version_rejected': 'Version TLS OpenVPN incompatible',
      'tls_certificate_expired': 'Certificat TLS expiré',
      'tls_certificate_revoked': 'Certificat TLS révoqué',
      'transport_failed': 'Serveur OpenVPN injoignable',
      'tun_configuration_rejected': 'Interface OpenVPN impossible',
      'tun_setup_failed': 'Initialisation TUN OpenVPN échouée',
      'tun_interface_create_failed': 'Création de l’interface OpenVPN échouée',
      'tun_interface_disabled': 'Interface OpenVPN désactivée',
      'tun_halted': 'Interface OpenVPN interrompue',
      'tun_already_established': 'Interface OpenVPN déjà ouverte',
      'tun_addresses_missing': 'Adresse OpenVPN absente',
      'tun_routes_missing': 'Routes OpenVPN absentes',
      'tun_dns_missing': 'DNS OpenVPN absent',
      'tun_permission_revoked': 'Autorisation VPN révoquée',
      'tun_establish_returned_null': 'Interface VPN refusée par Android',
      'openvpn_service_start_failed': 'Service OpenVPN indisponible',
      'openvpn_operation_timeout': 'Appel OpenVPN expiré',
      'openvpn_start_failed': 'Démarrage OpenVPN refusé',
      'openvpn_connection_failed': 'Connexion OpenVPN interrompue',
      'openvpn_core_status_error': 'OpenVPN Core terminé en erreur',
      'openvpn_stopped_before_connected': 'OpenVPN arrêté avant connexion',
      'openvpn_auth_failed': 'Authentification OpenVPN refusée',
      'openvpn_client_setup_failed': 'Préparation du client OpenVPN échouée',
      'openvpn_client_halted': 'Client OpenVPN interrompu',
      'openvpn_client_restart': 'Redémarrage OpenVPN demandé',
      'openvpn_inactive_timeout': 'OpenVPN inactif trop longtemps',
      'openvpn_session_expired': 'Session OpenVPN expirée',
      'openvpn_credentials_required':
          'Authentification OpenVPN non prise en charge',
      'openvpn_proxy_failed': 'Transport intermédiaire OpenVPN en échec',
      'openvpn_compression_failed': 'Compression OpenVPN refusée',
      'openvpn_ntlm_crypto_unavailable':
          'Chiffrement NTLM OpenVPN indisponible',
      'openvpn_feature_unsupported': 'Fonction OpenVPN non prise en charge',
      'network_unavailable': 'Connexion Internet indisponible',
      'network_lost': 'Réseau indisponible',
      'certificate_validation_failed': 'Certificat serveur refusé',
      'openvpn_certificate_expired': 'Certificat OpenVPN expiré',
      'tunnel_active_for_another_account':
          'Tunnel d’un autre compte encore actif',
      'tunnel_already_active': 'Tunnel natif déjà actif',
      'tunnel_stop_timeout': 'Arrêt $protocol non confirmé',
      'tunnel_disconnected': '$protocol interrompu',
      'native_bridge_unavailable': 'Bridge Android indisponible',
      'native_operation_failed': 'Opération Android interrompue',
      'invalid_arguments': 'Paramètres VPN incomplets',
      'invalid_account_id': 'Compte VPN invalide',
      'invalid_device_id': 'Identifiant d’appareil invalide',
      'storage_key_not_allowed': 'Clé de stockage refusée',
      'secure_storage_read_failed': 'Lecture sécurisée impossible',
      'secure_storage_write_failed': 'Écriture sécurisée impossible',
      'key_generation_failed': 'Génération WireGuard impossible',
      'csr_generation_failed': 'Génération OpenVPN impossible',
      'other': 'Erreur VPN native non classée',
    });
    return '$_temp0';
  }

  @override
  String notice_native_message(String code, String protocol) {
    String _temp0 = intl.Intl.selectLogic(code, {
      'system_vpn_resume_unavailable':
          'Android ne trouve aucune reprise VPN utilisable. Démarrez une nouvelle connexion dans l’application.',
      'system_vpn_resume_corrupt':
          'Les données de reprise VPN enregistrées sont invalides et ne seront pas utilisées. Démarrez une nouvelle connexion.',
      'system_vpn_resume_session_invalid':
          'La session enregistrée ne permet plus de reprendre le VPN. Connectez-vous à nouveau dans l’application.',
      'system_vpn_resume_identity_changed':
          'L’identité VPN locale a changé. La reprise a été arrêtée; démarrez une nouvelle connexion.',
      'system_vpn_resume_identity_invalid':
          'L’identité prévue pour la reprise n’est pas valide. Démarrez une nouvelle connexion.',
      'system_vpn_resume_storage_failed':
          'Android n’a pas pu lire ou mettre à jour les données de reprise chiffrées. Démarrez une nouvelle connexion.',
      'system_vpn_resume_network_timeout':
          'Android n’a pas trouvé de réseau à temps pour reprendre le VPN. Réessayez lorsque le réseau est disponible.',
      'system_vpn_resume_blocked':
          'La reprise VPN est bloquée. Vérifiez les réglages Android puis démarrez une nouvelle connexion.',
      'system_vpn_resume_failed':
          'La reprise VPN par Android a échoué. Démarrez une nouvelle connexion dans l’application.',
      'system_vpn_resume_error_invalid':
          'Android a renvoyé une erreur de reprise non utilisable. Démarrez une nouvelle connexion.',
      'wireguard_identity_store_failed':
          'Android n’a pas pu enregistrer l’identité WireGuard chiffrée de ce compte.',
      'wireguard_identity_unavailable':
          'Aucune identité WireGuard utilisable n’est disponible pour cette connexion.',
      'vpn_host_destroyed':
          'Le composant Android qui hébergeait le VPN a été arrêté. Démarrez une nouvelle connexion.',
      'vpn_host_unavailable':
          'Android ne peut pas créer le composant qui héberge le VPN. Réessayez après avoir vérifié les réglages VPN.',
      'openvpn_renewal_required':
          'Le certificat nécessite une action dans l’application avant la connexion.',
      'openvpn_recovery_failed':
          'La reprise automatique a échoué. Relancez la connexion dans l’application.',
      'openvpn_recovery_exhausted':
          'La reprise automatique a déjà été utilisée. Relancez la connexion dans l’application.',
      'vpn_permission_required':
          'Android exige une nouvelle autorisation VPN avant le démarrage du tunnel.',
      'vpn_permission_denied':
          'Autorisez FuzeVPN dans la demande Android pour continuer.',
      'vpn_permission_request_failed':
          'Android n’a pas pu ouvrir l’écran d’autorisation VPN.',
      'wireguard_foreground_service_unavailable':
          'Android n’a pas pu maintenir le service WireGuard au premier plan.',
      'wireguard_identity_invalid':
          'La clé WireGuard chiffrée de ce compte est illisible ou invalide.',
      'wireguard_identity_in_use':
          'Une autre opération utilise encore la clé WireGuard de ce compte.',
      'wireguard_configuration_invalid':
          'L’adresse, le DNS, la clé serveur ou les routes WireGuard reçues sont invalides.',
      'wireguard_operation_pending':
          'La précédente opération WireGuard n’a pas encore libéré son service natif.',
      'wireguard_start_failed':
          'Le moteur WireGuard a refusé la mise en ligne de la configuration.',
      'wireguard_stop_timeout':
          'Le service WireGuard n’a pas confirmé la libération de l’interface VPN dans le délai imparti.',
      'wireguard_handshake_timeout':
          'Le tunnel n’a pas confirmé de handshake avec le serveur à temps.',
      'openvpn_connection_timeout':
          'OpenVPN n’a pas confirmé la connexion avec le serveur à temps.',
      'openvpn_core_unavailable':
          'Cette version de l’application ne contient pas un moteur OpenVPN utilisable.',
      'openvpn_operation_pending':
          'Le moteur natif conserve la session OpenVPN précédente et refuse d’en créer une seconde.',
      'openvpn_stop_timeout':
          'OpenVPN Core n’a pas confirmé l’arrêt et la destruction de sa session native dans le délai imparti.',
      'openvpn_profile_unavailable':
          'Aucun profil OpenVPN validé ne peut être relu pour cette connexion.',
      'openvpn_native_failed':
          'Une erreur de l’application a interrompu OpenVPN. Réessayez la connexion. Si le problème persiste, lancez un diagnostic.',
      'openvpn_key_generation_failed':
          'Android Keystore n’a pas pu créer ou relire la clé privée P-256 non exportable.',
      'openvpn_csr_generation_failed':
          'La clé Android Keystore n’a pas pu signer la demande de certificat OpenVPN.',
      'openvpn_identity_store_failed':
          'Le certificat ou le profil OpenVPN n’a pas pu être enregistré dans le stockage chiffré.',
      'openvpn_identity_clear_failed':
          'Android n’a pas pu supprimer toute l’identité OpenVPN locale de ce compte.',
      'openvpn_identity_in_use':
          'Une session OpenVPN native utilise encore la clé ou le certificat de cet appareil.',
      'openvpn_tls_verification_required':
          'Le profil ne demande pas explicitement la vérification du certificat serveur.',
      'openvpn_cipher_invalid':
          'Le serveur a fourni un algorithme de chiffrement absent de la liste autorisée.',
      'openvpn_profile_rejected':
          'Le profil reçu du serveur n’est pas compatible. Recréez cet appareil puis réessayez.',
      'openvpn_identity_inconsistent':
          'Le certificat ne correspond pas à l’identité sécurisée de ce téléphone. Aucun profil local n’a été remplacé.',
      'tls_handshake_failed':
          'Le serveur a refusé la négociation TLS. Recréez le profil si le problème persiste.',
      'tls_alert_unknown_ca':
          'Le serveur ne reconnaît pas l’autorité du certificat de cet appareil. Le serveur OpenVPN doit être vérifié.',
      'tls_alert_bad_certificate':
          'Le serveur a refusé le certificat de cet appareil. Recréez l’appareil avant un nouvel essai.',
      'tls_alert_unsupported_certificate':
          'Le serveur ne prend pas en charge le type de certificat sécurisé utilisé par Android.',
      'tls_client_certificate_required':
          'Le serveur exige un certificat client, mais OpenVPN Core n’a pas pu en présenter un.',
      'tls_alert_misc':
          'Le serveur a renvoyé une alerte TLS qui ne correspond pas aux catégories certificat ou version.',
      'tls_signature_algorithm_rejected':
          'Le serveur a refusé l’algorithme ECDSA P-256 de la clé Android Keystore.',
      'tls_handshake_rejected':
          'Le serveur a interrompu la négociation TLS avant la connexion.',
      'tls_version_rejected':
          'Le client et le serveur n’ont pas trouvé de version TLS commune.',
      'tls_certificate_expired':
          'Le certificat présenté pendant la connexion a expiré.',
      'tls_certificate_revoked':
          'Le certificat présenté pendant la connexion a été révoqué.',
      'transport_failed':
          'Le serveur OpenVPN ne répond pas sur le réseau actuel. Réessayez dans un instant.',
      'tun_configuration_rejected':
          'Android a refusé la configuration réseau demandée par OpenVPN.',
      'tun_setup_failed':
          'OpenVPN Core a refusé le plan réseau avant la création de l’interface Android.',
      'tun_interface_create_failed':
          'OpenVPN Core n’a pas pu obtenir l’interface TUN auprès du VpnService Android.',
      'tun_interface_disabled':
          'Android ou OpenVPN Core a désactivé l’interface TUN pendant la connexion.',
      'tun_halted':
          'OpenVPN Core a reçu une demande d’arrêt de l’interface TUN.',
      'tun_already_established':
          'OpenVPN a demandé une seconde interface dans la même connexion. Le tunnel a été arrêté par sécurité.',
      'tun_addresses_missing':
          'Le serveur n’a fourni aucune adresse utilisable pour le tunnel.',
      'tun_routes_missing':
          'Le serveur n’a fourni aucune route utilisable pour le tunnel.',
      'tun_dns_missing': 'Le serveur n’a fourni aucun serveur DNS utilisable.',
      'tun_permission_revoked':
          'Android a retiré l’autorisation VPN pendant la connexion.',
      'tun_establish_returned_null':
          'Android n’a pas créé l’interface, généralement parce qu’un autre VPN est encore actif.',
      'openvpn_service_start_failed':
          'Android n’a pas pu démarrer le service OpenVPN au premier plan.',
      'openvpn_operation_timeout':
          'Un appel JNI vers OpenVPN Core a dépassé son délai maximal.',
      'openvpn_start_failed':
          'Le service Android est prêt, mais OpenVPN Core n’a pas accepté le démarrage du profil.',
      'openvpn_connection_failed':
          'OpenVPN Core s’est arrêté avant d’émettre l’événement CONNECTED.',
      'openvpn_core_status_error':
          'La boucle native OpenVPN s’est terminée en erreur sans événement terminal plus précis.',
      'openvpn_stopped_before_connected':
          'La boucle native OpenVPN s’est arrêtée avant l’événement CONNECTED, sans erreur Core explicite.',
      'openvpn_auth_failed':
          'Le serveur OpenVPN a refusé l’authentification du profil.',
      'openvpn_client_setup_failed':
          'OpenVPN Core n’a pas pu initialiser le client avant la connexion réseau.',
      'openvpn_client_halted':
          'OpenVPN Core a reçu un arrêt terminal du client.',
      'openvpn_client_restart':
          'OpenVPN Core a demandé le redémarrage de sa session de transport.',
      'openvpn_inactive_timeout':
          'OpenVPN Core a fermé la session après le délai d’inactivité.',
      'openvpn_session_expired':
          'Le serveur a signalé l’expiration de la session OpenVPN.',
      'openvpn_credentials_required':
          'Le serveur ou un proxy demande des identifiants interactifs absents de ce profil certificat.',
      'openvpn_proxy_failed':
          'OpenVPN Core a signalé un échec du proxy ou du relais configuré.',
      'openvpn_compression_failed':
          'OpenVPN Core a rejeté le mode de compression annoncé par le profil ou le serveur.',
      'openvpn_ntlm_crypto_unavailable':
          'Le profil demande un chiffrement NTLM qui n’est pas disponible dans cette version.',
      'openvpn_feature_unsupported':
          'Le profil ou le serveur demande une fonction absente de ce client Android.',
      'network_unavailable':
          'Aucun réseau physique utilisable n’est disponible.',
      'network_lost': 'Le tunnel a été arrêté après la perte du réseau.',
      'certificate_validation_failed':
          'L’identité du serveur OpenVPN n’a pas pu être vérifiée.',
      'openvpn_certificate_expired':
          'Renouvelez le profil OpenVPN avant de vous reconnecter.',
      'tunnel_active_for_another_account':
          'Un tunnel appartenant à un autre compte doit être arrêté avant cette connexion.',
      'tunnel_already_active':
          'Android signale qu’une session VPN précédente utilise encore l’interface.',
      'tunnel_stop_timeout':
          'Le moteur $protocol n’a pas confirmé la libération de l’interface VPN dans le délai imparti.',
      'tunnel_disconnected':
          'Le moteur natif a signalé la fin inattendue du tunnel après son démarrage.',
      'native_bridge_unavailable':
          'L’application ne peut pas accéder au service VPN Android. Fermez puis rouvrez l’application et réessayez.',
      'native_operation_failed':
          'Une erreur de l’application a interrompu l’opération VPN. Réessayez. Si le problème persiste, lancez un diagnostic.',
      'invalid_arguments':
          'Les informations nécessaires à cette opération VPN sont incomplètes. Réessayez. Si le problème persiste, lancez un diagnostic.',
      'invalid_account_id':
          'L’opération native n’est pas associée à un identifiant de compte valide.',
      'invalid_device_id':
          'L’identifiant d’appareil transmis au moteur natif est absent ou invalide.',
      'storage_key_not_allowed':
          'Le bridge Android a bloqué une clé qui n’appartient pas à la liste de stockage autorisée.',
      'secure_storage_read_failed':
          'Android Keystore n’a pas pu déchiffrer les données locales de ce compte.',
      'secure_storage_write_failed':
          'Android Keystore n’a pas pu chiffrer ou enregistrer les données locales.',
      'key_generation_failed':
          'Android n’a pas pu créer ou relire la clé WireGuard dans le stockage sécurisé.',
      'csr_generation_failed':
          'Android Keystore n’a pas pu créer ou signer le CSR P-256 OpenVPN.',
      'other':
          'Une branche native non documentée a échoué. Transmettez le code diagnostic affiché ci-dessous.',
    });
    return '$_temp0';
  }

  @override
  String get notice_permissionRequestInProgress_title =>
      'Demande d’autorisation déjà ouverte';

  @override
  String get notice_permissionRequestInProgress_message =>
      'La demande d’autorisation VPN Android est déjà affichée. Terminez-la avant de réessayer.';

  @override
  String get notice_permissionRequestInterrupted_title =>
      'Autorisation VPN interrompue';

  @override
  String get notice_permissionRequestInterrupted_message =>
      'L’écran d’autorisation VPN a été fermé avant que l’application reçoive la réponse.';

  @override
  String get notice_openvpnProofMissing_title =>
      'Connexion OpenVPN non confirmée';

  @override
  String get notice_openvpnProofMissing_message =>
      'La connexion OpenVPN n’a pas pu être confirmée. Elle a été arrêtée par sécurité. Réessayez.';

  @override
  String get openvpnCleanup_title => 'Profil OpenVPN révoqué';

  @override
  String get openvpnCleanup_working =>
      'Arrêt et suppression du profil OpenVPN révoqué…';

  @override
  String get openvpnCleanup_stopFailed =>
      'L’arrêt d’OpenVPN n’est pas confirmé. Réessayez avant de créer un nouveau profil.';

  @override
  String get openvpnCleanup_cleanupFailed =>
      'Le profil OpenVPN révoqué n’a pas pu être entièrement supprimé. Réessayez le nettoyage.';

  @override
  String get openvpnCleanup_complete =>
      'Le profil OpenVPN révoqué a été supprimé. Appuyez sur Se connecter pour en créer un nouveau.';

  @override
  String get network_title => 'Configuration réseau';

  @override
  String get network_ipv4Fallback =>
      'IPv6 est momentanément indisponible. La préparation continue en IPv4.';

  @override
  String get network_rejectedTitle => 'Configuration réseau refusée';

  @override
  String get network_rejectedMessage =>
      'La configuration du tunnel est incomplète ou ne correspond pas aux adresses autorisées. Réessayez depuis l’application.';

  @override
  String get network_unreadableTitle => 'Configuration locale illisible';

  @override
  String get network_unreadableMessage =>
      'La configuration réseau OpenVPN enregistrée ne peut pas être utilisée. Reconnectez-vous depuis l’application pour l’actualiser.';

  @override
  String get network_ipv4 => 'IPv4';

  @override
  String get network_dualStack => 'IPv4 + IPv6';

  @override
  String get protection_title => 'Protection réseau';

  @override
  String get protection_subtitle =>
      'Bloquez l’accès direct à Internet si le VPN s’interrompt.';

  @override
  String get protection_active => 'Protection système active';

  @override
  String get protection_alwaysOnOnly =>
      'VPN permanent activé, blocage hors VPN à activer';

  @override
  String get protection_inactive => 'Protection système inactive';

  @override
  String get protection_unknown => 'Protection système à vérifier';

  @override
  String get protection_openSettings => 'Ouvrir les réglages Android';

  @override
  String get protection_dialogTitle => 'Configurer la protection réseau';

  @override
  String get protection_dialogMessage =>
      'Android gère le VPN permanent et le blocage des connexions hors VPN. Vérifiez que FuzeVPN est sélectionné et activez le blocage dans les réglages système.';

  @override
  String get protection_dialogOpen => 'Ouvrir les réglages';

  @override
  String get session_systemProtectionNote =>
      'Si Android bloque encore le trafic hors VPN, ouvrez les réglages système pour vérifier ou modifier cette protection.';

  @override
  String get diagnostics_title => 'Diagnostic';

  @override
  String get diagnostics_settingsTitle => 'Diagnostic de l’application';

  @override
  String get diagnostics_automaticTitle => 'Envoyer les erreurs importantes';

  @override
  String get diagnostics_automaticDescription =>
      'Partagez un petit rapport technique lorsqu’une erreur importante survient.';

  @override
  String get diagnostics_privacy =>
      'Les rapports envoyés sont liés au compte connecté et conservés pendant 30 jours. Ils ne contiennent pas d’historique de navigation, de mots de passe ou de clés VPN.';

  @override
  String get diagnostics_manualOpen => 'Lancer un diagnostic';

  @override
  String get diagnostics_localDescription =>
      'Créez un rapport de l’état de l’application et du VPN. Votre connexion reste inchangée.';

  @override
  String get diagnostics_sendReport => 'Envoyer le rapport';

  @override
  String get diagnostics_sendHint =>
      'Laissez cette case décochée pour garder le rapport sur cet appareil.';

  @override
  String get diagnostics_signedOut =>
      'Connectez-vous à votre compte pour envoyer un rapport.';

  @override
  String get diagnostics_localLifetime =>
      'Pour conserver ce rapport après la fermeture de l’application, enregistrez-le sur votre téléphone.';

  @override
  String get diagnostics_run => 'Lancer le diagnostic';

  @override
  String get diagnostics_rerun => 'Refaire un diagnostic';

  @override
  String get diagnostics_running => 'Vérifications en cours…';

  @override
  String get diagnostics_sending => 'Envoi du rapport…';

  @override
  String get diagnostics_prepared => 'Rapport prêt sur cet appareil';

  @override
  String get diagnostics_queued => 'Rapport en attente d’envoi';

  @override
  String get diagnostics_sent => 'Rapport reçu';

  @override
  String get diagnostics_failed =>
      'L’envoi a échoué. Votre rapport local reste disponible.';

  @override
  String get diagnostics_preparationFailed =>
      'Le diagnostic n’a pas pu être préparé. Réessayez.';

  @override
  String get diagnostics_authenticationRequired =>
      'Reconnectez-vous pour envoyer le rapport.';

  @override
  String get diagnostics_retry => 'Réessayer l’envoi';

  @override
  String get diagnostics_export => 'Enregistrer le rapport';

  @override
  String get diagnostics_exportFailed =>
      'L’export a échoué. Réessayez depuis le rapport local.';

  @override
  String get diagnostics_preferenceFailed =>
      'Ce réglage n’a pas pu être enregistré. Réessayez.';

  @override
  String diagnostics_receipt(Object id) {
    return 'Référence : $id';
  }

  @override
  String diagnostics_received(Object date) {
    return 'Reçu le $date';
  }

  @override
  String diagnostics_expires(Object date) {
    return 'Conservé jusqu’au $date';
  }

  @override
  String get diagnostics_duplicate => 'Ce rapport avait déjà été reçu.';

  @override
  String get diagnostics_preview => 'Aperçu du rapport';

  @override
  String diagnostics_eventCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count événements techniques joints',
      one: '1 événement technique joint',
      zero: 'Aucun événement technique joint',
    );
    return '$_temp0';
  }

  @override
  String get diagnostics_technical => 'Détails techniques';

  @override
  String get diagnostics_empty => 'Aucun diagnostic n’a encore été préparé.';

  @override
  String diagnostics_checkName(String id) {
    String _temp0 = intl.Intl.selectLogic(id, {
      'tunnel_connection': 'État du tunnel',
      'handshake': 'Confirmation de connexion',
      'certificate': 'Certificat VPN',
      'kill_switch': 'Protection Android',
      'connectivity': 'Réseau disponible',
      'api_reachability': 'Accès au service',
      'secure_storage': 'Stockage sécurisé',
      'other': 'Vérification locale',
    });
    return '$_temp0';
  }

  @override
  String diagnostics_checkResult(String result) {
    String _temp0 = intl.Intl.selectLogic(result, {
      'passed': 'Vérifié',
      'failed': 'À vérifier',
      'skipped': 'Non testé — aucune sonde active',
      'unknown': 'Information indisponible',
      'other': 'Information indisponible',
    });
    return '$_temp0';
  }

  @override
  String get auth_welcome => 'Bienvenue chez FuzeVPN';

  @override
  String get connection_changeLocation => 'Changer d’emplacement';

  @override
  String get connection_details => 'Détails de la connexion';

  @override
  String get locations_searchLabel => 'Rechercher une ville ou un pays';

  @override
  String get locations_clearSearch => 'Effacer la recherche';

  @override
  String get locations_filterAll => 'Tous';

  @override
  String get locations_filterFavorites => 'Favoris';

  @override
  String locations_results(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count destinations',
      one: '$count destination',
    );
    return '$_temp0';
  }

  @override
  String get locations_noResults => 'Aucune destination trouvée';

  @override
  String get locations_noResultsHint =>
      'Essayez une autre ville ou un autre pays.';

  @override
  String get locations_noFavorites => 'Vos favoris, à portée de main';

  @override
  String get locations_noFavoritesHint =>
      'Touchez l’étoile d’une destination pour la retrouver ici.';

  @override
  String get locations_showAll => 'Voir toutes les destinations';

  @override
  String locations_addFavorite(String name) {
    return 'Ajouter $name aux favoris';
  }

  @override
  String locations_removeFavorite(String name) {
    return 'Retirer $name des favoris';
  }

  @override
  String get locations_favoriteSaveFailed =>
      'Le favori n’a pas pu être enregistré. Réessayez.';

  @override
  String get locations_emptyTitle => 'Aucune destination disponible';

  @override
  String get locations_emptyHint => 'Actualisez la liste pour réessayer.';

  @override
  String get devices_manage => 'Gérer mes appareils';

  @override
  String get settings_personalization => 'À votre goût';

  @override
  String get settings_safety => 'Protection';

  @override
  String get settings_help => 'Besoin d’aide ?';

  @override
  String get settings_about => 'À propos de FuzeVPN';

  @override
  String get diagnostics_heading => 'Comprendre un problème de connexion';

  @override
  String devices_profileStatus(String status) {
    String _temp0 = intl.Intl.selectLogic(status, {
      'active': 'Disponible',
      'pending': 'En préparation',
      'revoked': 'Retiré',
      'expired': 'Expiré',
      'other': 'Statut indisponible',
    });
    return '$_temp0';
  }

  @override
  String get notice_preferenceSave_title => 'Préférence non enregistrée';

  @override
  String get notice_preferenceSave_message =>
      'Votre choix est appliqué pour le moment, mais n’a pas pu être enregistré. Réessayez pour le conserver après la fermeture de l’application.';

  @override
  String get connection_androidDisconnectHint =>
      'Si Android maintient le VPN actif, désactivez « VPN permanent » dans les réglages qui s’ouvrent.';

  @override
  String get protection_learnMore => 'Comprendre la protection Android';

  @override
  String get protection_guideWhy =>
      'Cette protection évite que vos applications utilisent directement Internet si le VPN s’interrompt. Elle se règle dans Android.';

  @override
  String get protection_guideAlwaysOnTitle => 'VPN permanent';

  @override
  String get protection_guideAlwaysOn =>
      'Android maintient le service VPN actif et peut le relancer après un redémarrage du téléphone.';

  @override
  String get protection_guideBlockTitle => 'Bloquer les connexions sans VPN';

  @override
  String get protection_guideBlock =>
      'Ce réglage empêche le trafic de passer en dehors du VPN, y compris pendant une interruption de la connexion.';

  @override
  String get protection_guideWarning =>
      'Avec ce blocage activé, Internet reste coupé tant que le VPN n’est pas connecté.';

  @override
  String get protection_guideStepsTitle => 'Activer la protection';

  @override
  String get protection_guideStep1 =>
      'Ouvrez les réglages VPN Android avec le bouton ci-dessous.';

  @override
  String get protection_guideStep2 =>
      'À côté de FuzeVPN, ouvrez les options avec la roue dentée.';

  @override
  String get protection_guideStep3 =>
      'Activez « VPN permanent », puis « Bloquer les connexions sans VPN », si ces options sont proposées.';

  @override
  String get protection_guideManufacturers =>
      'Les noms varient selon le téléphone. Si nécessaire, recherchez « VPN » dans les paramètres, souvent dans Réseau et Internet.';

  @override
  String get protection_guideDisableTitle => 'Désactiver cette protection';

  @override
  String get protection_guideDisable =>
      'Dans les mêmes réglages, désactivez le blocage sans VPN pour autoriser Internet sans VPN. Désactivez aussi le VPN permanent si vous ne voulez plus qu’Android le relance.';

  @override
  String get protection_guideManual =>
      'Vous choisissez ces réglages dans Android. FuzeVPN ne les modifie pas à votre place.';

  @override
  String get locations_changeTitle => 'Changer d’emplacement ?';

  @override
  String locations_changeActive(String name) {
    return 'Le VPN va se déconnecter, puis tenter une connexion à $name.';
  }

  @override
  String locations_changeIdle(String name) {
    return 'Le VPN va tenter une connexion à $name.';
  }

  @override
  String get locations_confirmChange => 'Changer et se connecter';

  @override
  String get locations_changeBusy =>
      'Un changement est en cours. Patientez avant de choisir un autre emplacement.';

  @override
  String get locations_automaticSelection => 'Sélection automatique';

  @override
  String get locations_cities => 'Villes';

  @override
  String get locations_servers => 'Serveurs';

  @override
  String locations_viewCities(String name) {
    return 'Voir les villes de $name';
  }

  @override
  String locations_viewServers(String name) {
    return 'Voir les serveurs de $name';
  }

  @override
  String locations_countryCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count pays',
      one: '$count pays',
    );
    return '$_temp0';
  }

  @override
  String locations_cityCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count villes',
      one: '$count ville',
      zero: '0 villes',
    );
    return '$_temp0';
  }

  @override
  String locations_serverCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count serveurs',
      one: '$count serveur',
      zero: '0 serveurs',
    );
    return '$_temp0';
  }

  @override
  String get locations_allCountries => 'Tous les pays';

  @override
  String get locations_backToCountries => 'Retour aux pays';

  @override
  String locations_backToCities(String name) {
    return 'Retour aux villes de $name';
  }

  @override
  String locations_chooseCountry(String name) {
    return 'Choisir $name';
  }

  @override
  String locations_chooseCity(String name) {
    return 'Choisir $name';
  }

  @override
  String get locations_noCompatibleServer =>
      'Aucun serveur compatible disponible.';

  @override
  String get externalLink_failed =>
      'Impossible d’ouvrir ce lien. Vous pouvez le copier pour l’ouvrir dans votre navigateur.';

  @override
  String get externalLink_copy => 'Copier le lien';

  @override
  String get externalLink_copied => 'Lien copié';

  @override
  String get externalLink_copyFailed =>
      'Impossible de copier le lien. Sélectionnez l’adresse ci-dessous.';

  @override
  String get settings_deleteAccount => 'Supprimer mon compte';

  @override
  String get settings_deleteAccountDetail =>
      'Consulter la procédure de demande de suppression';

  @override
  String get billing_title => 'Fuze Premium';

  @override
  String get billing_subtitle => 'Choisissez votre abonnement VPN.';

  @override
  String get billing_subscribe => 'S’abonner';

  @override
  String get billing_choosePlan => 'Choisissez une formule pour continuer.';

  @override
  String get billing_monthly => 'Mensuel';

  @override
  String get billing_yearly => 'Annuel';

  @override
  String get billing_continue => 'Continuer avec Google Play';

  @override
  String get billing_restore => 'Restaurer les achats';

  @override
  String get billing_manage => 'Gérer l’abonnement';

  @override
  String get billing_deleteAccountWarning =>
      'Si vous avez un abonnement Google Play, supprimer votre compte FuzeVPN n\'annule pas son renouvellement. Gérez ou annulez ce renouvellement séparément dans Google Play.';

  @override
  String get billing_deleteAccountContinue =>
      'Continuer vers la demande de suppression';

  @override
  String get billing_refresh => 'Actualiser l’accès';

  @override
  String get billing_loadingPlans => 'Chargement des offres…';

  @override
  String get billing_unavailable =>
      'Aucune offre disponible actuellement. Réessayez plus tard.';

  @override
  String get billing_comingSoon => 'Abonnements bientôt disponibles.';

  @override
  String get billing_priceDisclosure =>
      'Prix fourni par Google Play. Le montant final et les taxes applicables sont confirmés avant votre validation.';

  @override
  String get billing_renewalMonthly =>
      'Renouvellement automatique chaque mois, sauf résiliation. Vous pouvez résilier à tout moment dans les abonnements Google Play.';

  @override
  String get billing_renewalYearly =>
      'Renouvellement automatique chaque année, sauf résiliation. Vous pouvez résilier à tout moment dans les abonnements Google Play.';

  @override
  String get billing_active => 'Votre accès Premium est actif';

  @override
  String billing_accessUntil(String date) {
    return 'Accès jusqu’au $date.';
  }

  @override
  String get billing_webManaged =>
      'Votre abonnement est géré sur le site FuzeVPN.';

  @override
  String get billing_playManaged =>
      'Votre abonnement est géré par Google Play.';

  @override
  String get billing_inactive => 'Aucun abonnement actif.';

  @override
  String get billing_checkingAccess => 'Vérification de votre accès…';

  @override
  String get billing_restoring => 'Restauration des achats…';

  @override
  String get billing_pending =>
      'Le paiement est en attente. Votre accès sera activé après confirmation.';

  @override
  String get billing_cancelled =>
      'Achat annulé. Aucun nouvel abonnement n’a été activé.';

  @override
  String get billing_verifying => 'Vérification de l’achat…';

  @override
  String get billing_success =>
      'Abonnement activé. Votre accès Premium est prêt.';

  @override
  String get billing_restored => 'Vos achats ont été restaurés.';

  @override
  String get billing_restoreEmpty =>
      'Aucun achat à restaurer pour ce compte Google Play.';

  @override
  String get billing_catalogError =>
      'Impossible de charger les offres. Réessayez.';

  @override
  String get billing_purchaseError =>
      'Impossible de démarrer l’achat. Réessayez.';

  @override
  String get billing_verificationError =>
      'La vérification de l’achat est temporairement indisponible. Restaurez les achats pour réessayer.';

  @override
  String get billing_restoreError =>
      'Impossible de restaurer les achats. Réessayez.';

  @override
  String get billing_managementError =>
      'Impossible d’ouvrir la gestion des abonnements. Réessayez.';

  @override
  String get billing_storeUnavailable =>
      'Google Play n’est pas disponible sur cet appareil.';

  @override
  String get welcome_title => 'Votre VPN, simplement.';

  @override
  String get welcome_description =>
      'Protégez votre connexion. Gardez le contrôle sur votre vie privée.';

  @override
  String get welcome_start => 'Démarrer';

  @override
  String get welcome_alreadyPurchased => 'Déjà acheté ?';

  @override
  String get welcome_noAccountRequired =>
      'Aucun compte à créer pour commencer.';

  @override
  String get guest_accountTitle => 'Compte non rattaché';

  @override
  String get guest_accountDescription =>
      'Vos achats peuvent être restaurés sur un autre appareil avec le même compte Google Play.';

  @override
  String get guest_existingSubscriberSignIn => 'Déjà abonné ? Se connecter';

  @override
  String get guest_claimTitle => 'Retrouvez FuzeVPN partout';

  @override
  String get guest_claimDescription =>
      'Créez votre compte pour retrouver votre abonnement sur vos autres appareils. Cette étape est facultative.';

  @override
  String get guest_skip => 'Plus tard';

  @override
  String get guest_activationTitle => 'Fuze Premium est activé';

  @override
  String get guest_activationDescription =>
      'Votre abonnement est prêt. Vous pouvez utiliser votre VPN et créer votre compte quand vous le souhaitez.';

  @override
  String get guest_useVpn => 'Utiliser mon VPN';

  @override
  String get guest_loginRequired =>
      'Cet achat est déjà rattaché à un compte FuzeVPN. Connectez-vous à ce compte pour retrouver votre abonnement.';

  @override
  String get guest_signOutWarning =>
      'Vous pourrez retrouver votre abonnement en restaurant vos achats avec le même compte Google Play.';

  @override
  String get guest_profileUnavailable =>
      'Votre compte est déjà rattaché. Connectez-vous pour afficher et gérer vos informations.';

  @override
  String get billing_acceptance =>
      'En continuant, vous acceptez les Conditions d’utilisation et la Politique de confidentialité.';

  @override
  String get guest_verifyEmailReminder =>
      'Confirmez votre adresse e-mail pour sécuriser votre compte. Vous pouvez continuer à utiliser votre VPN.';

  @override
  String get guest_serviceUnavailable =>
      'Le service est temporairement indisponible. Réessayez dans un instant.';

  @override
  String get guest_restoreError =>
      'Impossible de restaurer vos achats. Réessayez avec le compte Google Play utilisé pour l’achat.';

  @override
  String get guest_claimSuccess =>
      'Votre compte a été créé. Votre abonnement et votre accès VPN sont conservés.';

  @override
  String get guest_emailExists =>
      'Cette adresse est déjà utilisée. Choisissez une autre adresse ou connectez-vous à votre compte existant. Votre achat reste disponible avec Google Play.';

  @override
  String get guest_claimError =>
      'Votre compte n’a pas pu être créé. Vous pouvez continuer à utiliser votre VPN et réessayer plus tard.';

  @override
  String get guest_secureStorageError =>
      'Impossible de sécuriser votre session sur cet appareil. Réessayez.';

  @override
  String get guest_premiumRequired =>
      'Choisissez un abonnement pour activer votre VPN.';

  @override
  String get welcome_viewPlans => 'Voir les formules';

  @override
  String get google_continue => 'Continuer avec Google';

  @override
  String get google_or => 'ou';

  @override
  String get google_title => 'Votre compte FuzeVPN';

  @override
  String get google_settingUp => 'Finalisez votre compte';

  @override
  String get google_country => 'Pays de résidence';

  @override
  String get google_profileDescription =>
      'Choisissez votre pays et consultez les deux documents pour créer votre compte FuzeVPN.';

  @override
  String get google_claimDescription =>
      'Rattachez votre compte invité à Google. Votre abonnement et votre appareil restent associés à ce compte.';

  @override
  String get google_linkTitle => 'Associer Google à FuzeVPN';

  @override
  String get google_linkDescription =>
      'Confirmez l’accès à votre compte FuzeVPN existant. Cette étape ne demande pas votre mot de passe Google.';

  @override
  String get google_password => 'Mot de passe FuzeVPN';

  @override
  String get google_linkAccount => 'Confirmer l’association';

  @override
  String get google_requestEmail => 'Recevoir un e-mail de confirmation';

  @override
  String get google_emailInstructions =>
      'Ouvrez l’e-mail de FuzeVPN et saisissez le code de confirmation.';

  @override
  String get google_emailCode => 'Code de confirmation par e-mail';

  @override
  String get google_confirmEmail => 'Confirmer le code';

  @override
  String get google_restart => 'Choisir un autre compte Google';

  @override
  String get google_resume => 'Vérifier cette tentative';

  @override
  String get google_unavailable =>
      'La connexion Google est indisponible. Vous pouvez utiliser votre e-mail et votre mot de passe.';

  @override
  String get google_expired =>
      'Cette tentative a expiré. Annulez-la puis recommencez.';

  @override
  String get google_conflict =>
      'Ce compte Google est déjà associé ailleurs. Votre compte et votre abonnement actuels sont conservés.';

  @override
  String get google_error =>
      'La connexion Google a échoué. Réessayez ; votre accès actuel est conservé.';

  @override
  String get google_uncertain =>
      'Le résultat n’a pas pu être confirmé. Vérifiez cette tentative ou annulez-la avant de recommencer.';

  @override
  String get google_cancelFailed =>
      'L’annulation n’a pas pu être confirmée. Réessayez d’annuler avant de quitter cet écran.';

  @override
  String get google_cancelled => 'Connexion Google annulée.';

  @override
  String get google_selecting => 'Choisissez votre compte Google…';

  @override
  String get google_verifying => 'Vérification de votre compte…';

  @override
  String get google_emailUnavailable =>
      'L’e-mail de confirmation n’a pas pu être envoyé. Réessayez plus tard.';

  @override
  String get google_emailSent =>
      'E-mail de confirmation envoyé. Consultez votre messagerie.';

  @override
  String get google_rateLimited => 'Veuillez patienter avant de réessayer.';

  @override
  String get google_invalidPassword =>
      'Le mot de passe FuzeVPN est incorrect. Votre compte actuel est conservé.';

  @override
  String get google_invalidCode =>
      'Le code de confirmation est invalide ou expiré.';

  @override
  String get google_accountChanged =>
      'La session a changé. Annulez cette tentative avant de recommencer.';

  @override
  String get google_invalidResponse =>
      'Impossible de valider la réponse. Votre accès actuel est conservé.';

  @override
  String get google_invalidRegistration =>
      'Vérifiez le pays et les consentements.';

  @override
  String get google_consentRequired =>
      'Choisissez votre pays et acceptez les deux documents pour continuer.';

  @override
  String get google_challengeRequired =>
      'Une vérification de sécurité supplémentaire est requise. Votre accès actuel est conservé.';

  @override
  String get google_challengeUnavailable =>
      'La vérification de sécurité est indisponible. Réessayez plus tard.';

  @override
  String get billing_trialTitle => 'Essayez Fuze Premium gratuitement';

  @override
  String get billing_trialSubtitle =>
      'Protégez votre connexion dès aujourd’hui.';

  @override
  String get billing_trialWeeks => '2 semaines d’essai gratuit';

  @override
  String billing_trialDays(String days) {
    return '$days jours d’essai gratuit';
  }

  @override
  String get billing_trialStart => 'Commencer mon essai gratuit';

  @override
  String billing_trialFirstCharge(String date) {
    return 'Si vous commencez aujourd’hui, premier débit prévu le $date.';
  }

  @override
  String get billing_trialTerms =>
      'Renouvellement automatique au tarif indiqué. Pour éviter un débit, annulez dans Google Play avant la fin de l’essai.';

  @override
  String billing_trialThenMonthly(String price) {
    return 'Puis $price par mois';
  }

  @override
  String billing_trialThenYearly(String price) {
    return 'Puis $price par an';
  }

  @override
  String get billing_choosePeriod => 'Choisissez votre formule';

  @override
  String get billing_selectionHint =>
      'Sélectionnez une formule pour continuer.';

  @override
  String get billing_benefitConnection => 'Connexion chiffrée';

  @override
  String get billing_benefitPrivacy => 'Confidentialité en ligne';

  @override
  String get billing_benefitNoAccount => 'Sans inscription obligatoire';

  @override
  String get billing_cancellation => 'Annulation dans Google Play';

  @override
  String get billing_premiumTitle => 'Votre connexion, mieux protégée.';

  @override
  String get billing_premiumSubtitle =>
      'Protégez votre connexion, à votre rythme.';

  @override
  String get billing_priceMonthly => 'par mois';

  @override
  String get billing_priceYearly => 'par an';

  @override
  String get billing_trialToday => 'Aujourd’hui, rien à payer';

  @override
  String get billing_trialConfirmation =>
      'Google Play confirme les dates, le montant final et les taxes applicables avant votre validation.';

  @override
  String get billing_offerChanged =>
      'Les conditions de cette offre ont changé. Actualisez les formules et choisissez à nouveau.';
}
