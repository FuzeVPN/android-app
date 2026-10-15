import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_cs.dart';
import 'app_localizations_da.dart';
import 'app_localizations_de.dart';
import 'app_localizations_el.dart';
import 'app_localizations_en.dart';
import 'app_localizations_es.dart';
import 'app_localizations_fa.dart';
import 'app_localizations_fil.dart';
import 'app_localizations_fr.dart';
import 'app_localizations_hi.dart';
import 'app_localizations_id.dart';
import 'app_localizations_it.dart';
import 'app_localizations_ja.dart';
import 'app_localizations_ko.dart';
import 'app_localizations_ms.dart';
import 'app_localizations_nb.dart';
import 'app_localizations_nl.dart';
import 'app_localizations_pl.dart';
import 'app_localizations_pt.dart';
import 'app_localizations_ro.dart';
import 'app_localizations_ru.dart';
import 'app_localizations_sv.dart';
import 'app_localizations_th.dart';
import 'app_localizations_tr.dart';
import 'app_localizations_uk.dart';
import 'app_localizations_ur.dart';
import 'app_localizations_vi.dart';
import 'app_localizations_zh.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'generated/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('cs'),
    Locale('da'),
    Locale('de'),
    Locale('el'),
    Locale('en'),
    Locale('es'),
    Locale('fa'),
    Locale('fil'),
    Locale('fr'),
    Locale('hi'),
    Locale('id'),
    Locale('it'),
    Locale('ja'),
    Locale('ko'),
    Locale('ms'),
    Locale('nb'),
    Locale('nl'),
    Locale('pl'),
    Locale('pt'),
    Locale('ro'),
    Locale('ru'),
    Locale('sv'),
    Locale('th'),
    Locale('tr'),
    Locale('uk'),
    Locale('ur'),
    Locale('vi'),
    Locale('zh'),
    Locale.fromSubtags(languageCode: 'zh', scriptCode: 'Hans'),
    Locale.fromSubtags(languageCode: 'zh', scriptCode: 'Hant'),
  ];

  /// No description provided for @vpnDisclosure_title.
  ///
  /// In fr, this message translates to:
  /// **'Protéger votre connexion'**
  String get vpnDisclosure_title;

  /// No description provided for @vpnDisclosure_body.
  ///
  /// In fr, this message translates to:
  /// **'FuzeVPN utilise le service VPN d’Android (VpnService) pour créer un tunnel chiffré entre cet appareil et les serveurs FuzeVPN.'**
  String get vpnDisclosure_body;

  /// No description provided for @vpnDisclosure_dataBody.
  ///
  /// In fr, this message translates to:
  /// **'Lorsque le VPN est actif, le trafic Internet de vos applications, les adresses de destination et les requêtes DNS transitent par ce tunnel pour acheminer votre connexion, même lorsque FuzeVPN est en arrière-plan.'**
  String get vpnDisclosure_dataBody;

  /// No description provided for @vpnDisclosure_statusBody.
  ///
  /// In fr, this message translates to:
  /// **'L’application utilise l’état de la connexion, sa durée et le volume de données échangées pour afficher votre connexion VPN. Vous pouvez l’arrêter à tout moment.'**
  String get vpnDisclosure_statusBody;

  /// No description provided for @vpnDisclosure_privacy.
  ///
  /// In fr, this message translates to:
  /// **'Confidentialité'**
  String get vpnDisclosure_privacy;

  /// No description provided for @vpnDisclosure_accept.
  ///
  /// In fr, this message translates to:
  /// **'Accepter et continuer'**
  String get vpnDisclosure_accept;

  /// No description provided for @vpnDisclosure_decline.
  ///
  /// In fr, this message translates to:
  /// **'Pas maintenant'**
  String get vpnDisclosure_decline;

  /// No description provided for @accountRestoration_title.
  ///
  /// In fr, this message translates to:
  /// **'Compte temporairement indisponible'**
  String get accountRestoration_title;

  /// No description provided for @accountRestoration_message.
  ///
  /// In fr, this message translates to:
  /// **'Votre session est conservée. Réessayez pour retrouver votre compte ; vous pouvez toujours gérer la connexion VPN ici.'**
  String get accountRestoration_message;

  /// No description provided for @action_retry.
  ///
  /// In fr, this message translates to:
  /// **'Réessayer'**
  String get action_retry;

  /// No description provided for @session_endingTitle.
  ///
  /// In fr, this message translates to:
  /// **'Arrêt de la session'**
  String get session_endingTitle;

  /// No description provided for @session_ending.
  ///
  /// In fr, this message translates to:
  /// **'Votre session est invalidée. Arrêt du VPN et nettoyage en cours…'**
  String get session_ending;

  /// No description provided for @session_stopFailed.
  ///
  /// In fr, this message translates to:
  /// **'L’arrêt du VPN n’est pas confirmé. Réessayez avant de vous reconnecter.'**
  String get session_stopFailed;

  /// No description provided for @session_cleanupFailed.
  ///
  /// In fr, this message translates to:
  /// **'Le VPN est arrêté, mais l’effacement de la session n’est pas confirmé. Réessayez le nettoyage.'**
  String get session_cleanupFailed;

  /// No description provided for @session_retryStop.
  ///
  /// In fr, this message translates to:
  /// **'Réessayer l’arrêt'**
  String get session_retryStop;

  /// No description provided for @session_retryCleanup.
  ///
  /// In fr, this message translates to:
  /// **'Réessayer le nettoyage'**
  String get session_retryCleanup;

  /// No description provided for @appTitle.
  ///
  /// In fr, this message translates to:
  /// **'FuzeVPN'**
  String get appTitle;

  /// No description provided for @startup.
  ///
  /// In fr, this message translates to:
  /// **'Préparation sécurisée de FuzeVPN…'**
  String get startup;

  /// No description provided for @nav_connection.
  ///
  /// In fr, this message translates to:
  /// **'Connexion'**
  String get nav_connection;

  /// No description provided for @nav_locations.
  ///
  /// In fr, this message translates to:
  /// **'Emplacements'**
  String get nav_locations;

  /// No description provided for @nav_account.
  ///
  /// In fr, this message translates to:
  /// **'Compte'**
  String get nav_account;

  /// No description provided for @nav_devices.
  ///
  /// In fr, this message translates to:
  /// **'Appareils'**
  String get nav_devices;

  /// No description provided for @nav_settings.
  ///
  /// In fr, this message translates to:
  /// **'Réglages'**
  String get nav_settings;

  /// No description provided for @action_refresh.
  ///
  /// In fr, this message translates to:
  /// **'Actualiser'**
  String get action_refresh;

  /// No description provided for @auth_tab_login.
  ///
  /// In fr, this message translates to:
  /// **'Connexion'**
  String get auth_tab_login;

  /// No description provided for @auth_tab_register.
  ///
  /// In fr, this message translates to:
  /// **'Inscription'**
  String get auth_tab_register;

  /// No description provided for @auth_stepAccount.
  ///
  /// In fr, this message translates to:
  /// **'Compte'**
  String get auth_stepAccount;

  /// No description provided for @auth_stepIdentity.
  ///
  /// In fr, this message translates to:
  /// **'Identité'**
  String get auth_stepIdentity;

  /// No description provided for @auth_stepAddress.
  ///
  /// In fr, this message translates to:
  /// **'Adresse et accords'**
  String get auth_stepAddress;

  /// No description provided for @auth_stepProgress.
  ///
  /// In fr, this message translates to:
  /// **'Étape {current} sur {total}'**
  String auth_stepProgress(Object current, Object total);

  /// No description provided for @auth_tagline.
  ///
  /// In fr, this message translates to:
  /// **'Votre VPN, simplement.'**
  String get auth_tagline;

  /// No description provided for @auth_keysLocal.
  ///
  /// In fr, this message translates to:
  /// **'Vos clés privées VPN restent sur cet appareil.'**
  String get auth_keysLocal;

  /// No description provided for @form_email.
  ///
  /// In fr, this message translates to:
  /// **'Adresse e-mail'**
  String get form_email;

  /// No description provided for @form_password.
  ///
  /// In fr, this message translates to:
  /// **'Mot de passe'**
  String get form_password;

  /// No description provided for @form_showPassword.
  ///
  /// In fr, this message translates to:
  /// **'Afficher le mot de passe'**
  String get form_showPassword;

  /// No description provided for @form_hidePassword.
  ///
  /// In fr, this message translates to:
  /// **'Masquer le mot de passe'**
  String get form_hidePassword;

  /// No description provided for @form_passwordMin.
  ///
  /// In fr, this message translates to:
  /// **'8 à 72 octets UTF-8. Certains caractères occupent plusieurs octets.'**
  String get form_passwordMin;

  /// No description provided for @form_firstName.
  ///
  /// In fr, this message translates to:
  /// **'Prénom'**
  String get form_firstName;

  /// No description provided for @form_lastName.
  ///
  /// In fr, this message translates to:
  /// **'Nom'**
  String get form_lastName;

  /// No description provided for @form_phone.
  ///
  /// In fr, this message translates to:
  /// **'Téléphone (+33612345678)'**
  String get form_phone;

  /// No description provided for @form_address.
  ///
  /// In fr, this message translates to:
  /// **'Adresse'**
  String get form_address;

  /// No description provided for @form_address2.
  ///
  /// In fr, this message translates to:
  /// **'Complément d’adresse (facultatif)'**
  String get form_address2;

  /// No description provided for @form_postalCode.
  ///
  /// In fr, this message translates to:
  /// **'Code postal'**
  String get form_postalCode;

  /// No description provided for @form_city.
  ///
  /// In fr, this message translates to:
  /// **'Ville'**
  String get form_city;

  /// No description provided for @form_country.
  ///
  /// In fr, this message translates to:
  /// **'Code pays (ex. FR)'**
  String get form_country;

  /// No description provided for @action_login.
  ///
  /// In fr, this message translates to:
  /// **'Se connecter'**
  String get action_login;

  /// No description provided for @action_createAccount.
  ///
  /// In fr, this message translates to:
  /// **'Créer un compte'**
  String get action_createAccount;

  /// No description provided for @action_createMyAccount.
  ///
  /// In fr, this message translates to:
  /// **'Créer mon compte'**
  String get action_createMyAccount;

  /// No description provided for @action_next.
  ///
  /// In fr, this message translates to:
  /// **'Continuer'**
  String get action_next;

  /// No description provided for @action_previous.
  ///
  /// In fr, this message translates to:
  /// **'Retour'**
  String get action_previous;

  /// No description provided for @action_forgotPassword.
  ///
  /// In fr, this message translates to:
  /// **'Mot de passe oublié ?'**
  String get action_forgotPassword;

  /// No description provided for @auth_noAccount.
  ///
  /// In fr, this message translates to:
  /// **'Vous n’avez pas encore de compte ?'**
  String get auth_noAccount;

  /// No description provided for @auth_requiredInformation.
  ///
  /// In fr, this message translates to:
  /// **'Créez votre compte en trois étapes.'**
  String get auth_requiredInformation;

  /// No description provided for @auth_termsPrefix.
  ///
  /// In fr, this message translates to:
  /// **'J’accepte les '**
  String get auth_termsPrefix;

  /// No description provided for @auth_termsLink.
  ///
  /// In fr, this message translates to:
  /// **'conditions d’utilisation'**
  String get auth_termsLink;

  /// No description provided for @auth_privacyPrefix.
  ///
  /// In fr, this message translates to:
  /// **'J’accepte la '**
  String get auth_privacyPrefix;

  /// No description provided for @auth_privacyLink.
  ///
  /// In fr, this message translates to:
  /// **'politique de confidentialité'**
  String get auth_privacyLink;

  /// No description provided for @auth_consentRequired.
  ///
  /// In fr, this message translates to:
  /// **'Votre accord est nécessaire pour créer un compte.'**
  String get auth_consentRequired;

  /// No description provided for @validation_required.
  ///
  /// In fr, this message translates to:
  /// **'Ce champ est obligatoire.'**
  String get validation_required;

  /// No description provided for @validation_email.
  ///
  /// In fr, this message translates to:
  /// **'Saisissez une adresse e-mail valide.'**
  String get validation_email;

  /// No description provided for @validation_password.
  ///
  /// In fr, this message translates to:
  /// **'Mot de passe trop court : au moins 8 octets UTF-8.'**
  String get validation_password;

  /// No description provided for @validation_passwordTooLong.
  ///
  /// In fr, this message translates to:
  /// **'Mot de passe trop long : au maximum 72 octets UTF-8.'**
  String get validation_passwordTooLong;

  /// No description provided for @validation_phone.
  ///
  /// In fr, this message translates to:
  /// **'Utilisez le format international, par exemple +33612345678.'**
  String get validation_phone;

  /// No description provided for @validation_country.
  ///
  /// In fr, this message translates to:
  /// **'Utilisez un code pays à deux lettres, par exemple FR.'**
  String get validation_country;

  /// No description provided for @passwordReset_title.
  ///
  /// In fr, this message translates to:
  /// **'Réinitialiser le mot de passe'**
  String get passwordReset_title;

  /// No description provided for @passwordReset_description.
  ///
  /// In fr, this message translates to:
  /// **'Saisissez l’adresse e-mail de votre compte pour demander un lien de réinitialisation.'**
  String get passwordReset_description;

  /// No description provided for @passwordReset_send.
  ///
  /// In fr, this message translates to:
  /// **'Envoyer le lien'**
  String get passwordReset_send;

  /// No description provided for @connection_title.
  ///
  /// In fr, this message translates to:
  /// **'Votre connexion'**
  String get connection_title;

  /// No description provided for @connection_subtitle.
  ///
  /// In fr, this message translates to:
  /// **'Choisissez une destination, puis activez votre VPN.'**
  String get connection_subtitle;

  /// No description provided for @connection_prepare.
  ///
  /// In fr, this message translates to:
  /// **'Prêt à vous connecter ?'**
  String get connection_prepare;

  /// No description provided for @connection_advancedOptions.
  ///
  /// In fr, this message translates to:
  /// **'Options avancées'**
  String get connection_advancedOptions;

  /// No description provided for @connection_location.
  ///
  /// In fr, this message translates to:
  /// **'Emplacement'**
  String get connection_location;

  /// No description provided for @connection_chooseLocation.
  ///
  /// In fr, this message translates to:
  /// **'Choisissez un emplacement'**
  String get connection_chooseLocation;

  /// No description provided for @connection_protocol.
  ///
  /// In fr, this message translates to:
  /// **'Protocole'**
  String get connection_protocol;

  /// No description provided for @connection_connect.
  ///
  /// In fr, this message translates to:
  /// **'Se connecter'**
  String get connection_connect;

  /// No description provided for @connection_connecting.
  ///
  /// In fr, this message translates to:
  /// **'Connexion en cours…'**
  String get connection_connecting;

  /// No description provided for @connection_disconnect.
  ///
  /// In fr, this message translates to:
  /// **'Se déconnecter'**
  String get connection_disconnect;

  /// No description provided for @connection_disconnecting.
  ///
  /// In fr, this message translates to:
  /// **'Déconnexion en cours'**
  String get connection_disconnecting;

  /// No description provided for @connection_locationChange.
  ///
  /// In fr, this message translates to:
  /// **'Changement d’emplacement…'**
  String get connection_locationChange;

  /// No description provided for @connection_unavailable.
  ///
  /// In fr, this message translates to:
  /// **'{protocol} indisponible'**
  String connection_unavailable(Object protocol);

  /// No description provided for @connection_activeLocation.
  ///
  /// In fr, this message translates to:
  /// **'Emplacement actif'**
  String get connection_activeLocation;

  /// No description provided for @connection_duration.
  ///
  /// In fr, this message translates to:
  /// **'Durée'**
  String get connection_duration;

  /// No description provided for @connection_received.
  ///
  /// In fr, this message translates to:
  /// **'Reçus'**
  String get connection_received;

  /// No description provided for @connection_sent.
  ///
  /// In fr, this message translates to:
  /// **'Envoyés'**
  String get connection_sent;

  /// No description provided for @connection_lastHandshake.
  ///
  /// In fr, this message translates to:
  /// **'Dernier échange sécurisé'**
  String get connection_lastHandshake;

  /// No description provided for @connection_handshakeAgo.
  ///
  /// In fr, this message translates to:
  /// **'Il y a {duration}'**
  String connection_handshakeAgo(Object duration);

  /// No description provided for @verification_title.
  ///
  /// In fr, this message translates to:
  /// **'Confirmez votre adresse e-mail'**
  String get verification_title;

  /// No description provided for @verification_message.
  ///
  /// In fr, this message translates to:
  /// **'Confirmez votre adresse e-mail pour activer le VPN sur ce téléphone.'**
  String get verification_message;

  /// No description provided for @verification_resend.
  ///
  /// In fr, this message translates to:
  /// **'Renvoyer l’e-mail'**
  String get verification_resend;

  /// No description provided for @migration_title.
  ///
  /// In fr, this message translates to:
  /// **'Changement d’emplacement'**
  String get migration_title;

  /// No description provided for @migration_draining.
  ///
  /// In fr, this message translates to:
  /// **'Préparation du changement d’emplacement…'**
  String get migration_draining;

  /// No description provided for @migration_activating.
  ///
  /// In fr, this message translates to:
  /// **'Activation du nouveau serveur…'**
  String get migration_activating;

  /// No description provided for @migration_ready.
  ///
  /// In fr, this message translates to:
  /// **'Emplacement mis à jour.'**
  String get migration_ready;

  /// No description provided for @migration_blocked.
  ///
  /// In fr, this message translates to:
  /// **'Le changement nécessite une intervention serveur. Réessayez plus tard ou contactez le support.'**
  String get migration_blocked;

  /// No description provided for @migration_progress.
  ///
  /// In fr, this message translates to:
  /// **'Progression du changement d’emplacement'**
  String get migration_progress;

  /// No description provided for @migration_retryDelay.
  ///
  /// In fr, this message translates to:
  /// **'Délai entre deux vérifications : {seconds} s.'**
  String migration_retryDelay(Object seconds);

  /// No description provided for @migration_resume.
  ///
  /// In fr, this message translates to:
  /// **'Reprendre le changement'**
  String get migration_resume;

  /// No description provided for @status_authorizing.
  ///
  /// In fr, this message translates to:
  /// **'Autorisation requise'**
  String get status_authorizing;

  /// No description provided for @status_authorizingDetail.
  ///
  /// In fr, this message translates to:
  /// **'Acceptez la demande Android pour autoriser le VPN.'**
  String get status_authorizingDetail;

  /// No description provided for @status_preparing.
  ///
  /// In fr, this message translates to:
  /// **'Préparation'**
  String get status_preparing;

  /// No description provided for @status_preparingDetail.
  ///
  /// In fr, this message translates to:
  /// **'Votre connexion sécurisée se prépare.'**
  String get status_preparingDetail;

  /// No description provided for @status_reconnecting.
  ///
  /// In fr, this message translates to:
  /// **'Reconnexion…'**
  String get status_reconnecting;

  /// No description provided for @status_reconnectingDetail.
  ///
  /// In fr, this message translates to:
  /// **'Connexion interrompue. Le VPN tente de se reconnecter.'**
  String get status_reconnectingDetail;

  /// No description provided for @status_connecting.
  ///
  /// In fr, this message translates to:
  /// **'Connexion en cours'**
  String get status_connecting;

  /// No description provided for @status_connectingDetail.
  ///
  /// In fr, this message translates to:
  /// **'Connexion au serveur VPN…'**
  String get status_connectingDetail;

  /// No description provided for @status_connected.
  ///
  /// In fr, this message translates to:
  /// **'Connecté'**
  String get status_connected;

  /// No description provided for @status_connectedDetail.
  ///
  /// In fr, this message translates to:
  /// **'Votre connexion VPN est active.'**
  String get status_connectedDetail;

  /// No description provided for @status_disconnecting.
  ///
  /// In fr, this message translates to:
  /// **'Déconnexion en cours'**
  String get status_disconnecting;

  /// No description provided for @status_disconnectingDetail.
  ///
  /// In fr, this message translates to:
  /// **'Votre connexion VPN est en cours d’arrêt.'**
  String get status_disconnectingDetail;

  /// No description provided for @status_error.
  ///
  /// In fr, this message translates to:
  /// **'Connexion indisponible'**
  String get status_error;

  /// No description provided for @status_errorDetail.
  ///
  /// In fr, this message translates to:
  /// **'La connexion VPN n’est pas confirmée. Réessayez.'**
  String get status_errorDetail;

  /// No description provided for @status_idle.
  ///
  /// In fr, this message translates to:
  /// **'Déconnecté'**
  String get status_idle;

  /// No description provided for @status_idleDetail.
  ///
  /// In fr, this message translates to:
  /// **'Connectez le VPN pour protéger votre connexion.'**
  String get status_idleDetail;

  /// No description provided for @trust_note.
  ///
  /// In fr, this message translates to:
  /// **'Fermer l’application ne coupe pas le VPN. Pour l’arrêter, utilisez Se déconnecter.'**
  String get trust_note;

  /// No description provided for @locations_none.
  ///
  /// In fr, this message translates to:
  /// **'Aucun emplacement disponible pour le moment.'**
  String get locations_none;

  /// No description provided for @locations_available.
  ///
  /// In fr, this message translates to:
  /// **'Choisissez votre prochaine destination.'**
  String get locations_available;

  /// No description provided for @locations_selected.
  ///
  /// In fr, this message translates to:
  /// **'Emplacement sélectionné'**
  String get locations_selected;

  /// No description provided for @locations_select.
  ///
  /// In fr, this message translates to:
  /// **'Choisir cet emplacement'**
  String get locations_select;

  /// No description provided for @locations_lockedTunnel.
  ///
  /// In fr, this message translates to:
  /// **'Déconnectez le VPN pour changer d’emplacement.'**
  String get locations_lockedTunnel;

  /// No description provided for @locations_lockedMigration.
  ///
  /// In fr, this message translates to:
  /// **'Patientez jusqu’à la fin du changement d’emplacement.'**
  String get locations_lockedMigration;

  /// No description provided for @devices_title.
  ///
  /// In fr, this message translates to:
  /// **'Vos appareils'**
  String get devices_title;

  /// No description provided for @devices_used.
  ///
  /// In fr, this message translates to:
  /// **'{count} / {limit} appareils'**
  String devices_used(Object count, Object limit);

  /// No description provided for @devices_refresh.
  ///
  /// In fr, this message translates to:
  /// **'Actualiser les appareils'**
  String get devices_refresh;

  /// No description provided for @devices_empty.
  ///
  /// In fr, this message translates to:
  /// **'Aucun appareil VPN n’est encore enregistré.'**
  String get devices_empty;

  /// No description provided for @devices_firstConnection.
  ///
  /// In fr, this message translates to:
  /// **'Votre téléphone sera ajouté lors de la première connexion.'**
  String get devices_firstConnection;

  /// No description provided for @devices_thisDevice.
  ///
  /// In fr, this message translates to:
  /// **'Cet appareil'**
  String get devices_thisDevice;

  /// No description provided for @devices_added.
  ///
  /// In fr, this message translates to:
  /// **'Ajouté le {date}'**
  String devices_added(Object date);

  /// No description provided for @action_remove.
  ///
  /// In fr, this message translates to:
  /// **'Retirer'**
  String get action_remove;

  /// No description provided for @settings_title.
  ///
  /// In fr, this message translates to:
  /// **'Réglages'**
  String get settings_title;

  /// No description provided for @settings_subtitle.
  ///
  /// In fr, this message translates to:
  /// **'Vos préférences et votre compte, au même endroit.'**
  String get settings_subtitle;

  /// No description provided for @settings_appearance.
  ///
  /// In fr, this message translates to:
  /// **'Apparence'**
  String get settings_appearance;

  /// No description provided for @settings_language.
  ///
  /// In fr, this message translates to:
  /// **'Langue'**
  String get settings_language;

  /// No description provided for @settings_languageDescription.
  ///
  /// In fr, this message translates to:
  /// **'La langue choisie s’applique aussi aux notifications VPN.'**
  String get settings_languageDescription;

  /// No description provided for @settings_account.
  ///
  /// In fr, this message translates to:
  /// **'Compte'**
  String get settings_account;

  /// No description provided for @settings_signOut.
  ///
  /// In fr, this message translates to:
  /// **'Déconnecter le compte'**
  String get settings_signOut;

  /// No description provided for @settings_privacy.
  ///
  /// In fr, this message translates to:
  /// **'Politique de confidentialité'**
  String get settings_privacy;

  /// No description provided for @settings_terms.
  ///
  /// In fr, this message translates to:
  /// **'Conditions d’utilisation'**
  String get settings_terms;

  /// No description provided for @settings_security.
  ///
  /// In fr, this message translates to:
  /// **'Sécurité et transparence'**
  String get settings_security;

  /// No description provided for @settings_licenses.
  ///
  /// In fr, this message translates to:
  /// **'Licences des composants'**
  String get settings_licenses;

  /// No description provided for @settings_licensesDetail.
  ///
  /// In fr, this message translates to:
  /// **'Logiciels utilisés dans l’application'**
  String get settings_licensesDetail;

  /// No description provided for @settings_background.
  ///
  /// In fr, this message translates to:
  /// **'Le VPN reste actif quand vous quittez l’application. Pour l’arrêter, utilisez Se déconnecter dans l’onglet Connexion.'**
  String get settings_background;

  /// No description provided for @theme_system.
  ///
  /// In fr, this message translates to:
  /// **'Système'**
  String get theme_system;

  /// No description provided for @theme_light.
  ///
  /// In fr, this message translates to:
  /// **'Clair'**
  String get theme_light;

  /// No description provided for @theme_dark.
  ///
  /// In fr, this message translates to:
  /// **'Sombre'**
  String get theme_dark;

  /// No description provided for @language_system.
  ///
  /// In fr, this message translates to:
  /// **'Langue du téléphone'**
  String get language_system;

  /// No description provided for @language_fr.
  ///
  /// In fr, this message translates to:
  /// **'Français'**
  String get language_fr;

  /// No description provided for @language_en.
  ///
  /// In fr, this message translates to:
  /// **'English'**
  String get language_en;

  /// No description provided for @language_es.
  ///
  /// In fr, this message translates to:
  /// **'Español'**
  String get language_es;

  /// No description provided for @language_de.
  ///
  /// In fr, this message translates to:
  /// **'Deutsch'**
  String get language_de;

  /// No description provided for @dialog_removeDevice.
  ///
  /// In fr, this message translates to:
  /// **'Retirer cet appareil ?'**
  String get dialog_removeDevice;

  /// No description provided for @dialog_removeCurrent.
  ///
  /// In fr, this message translates to:
  /// **'Ce téléphone sera déconnecté du VPN et perdra son accès. Ses données de connexion VPN seront effacées après confirmation du serveur.'**
  String get dialog_removeCurrent;

  /// No description provided for @dialog_removeOther.
  ///
  /// In fr, this message translates to:
  /// **'L’accès VPN de « {name} » sera révoqué. Cette action ne peut pas être annulée.'**
  String dialog_removeOther(Object name);

  /// No description provided for @dialog_signOut.
  ///
  /// In fr, this message translates to:
  /// **'Déconnecter le compte ?'**
  String get dialog_signOut;

  /// No description provided for @dialog_signOutMessage.
  ///
  /// In fr, this message translates to:
  /// **'Le VPN sera arrêté et vous devrez vous reconnecter à votre compte. Les clés VPN chiffrées resteront sur ce téléphone pour votre prochaine connexion.'**
  String get dialog_signOutMessage;

  /// No description provided for @action_cancel.
  ///
  /// In fr, this message translates to:
  /// **'Annuler'**
  String get action_cancel;

  /// No description provided for @action_signOut.
  ///
  /// In fr, this message translates to:
  /// **'Déconnecter'**
  String get action_signOut;

  /// No description provided for @notice_close.
  ///
  /// In fr, this message translates to:
  /// **'Fermer le message'**
  String get notice_close;

  /// No description provided for @notice_sessionExpired_title.
  ///
  /// In fr, this message translates to:
  /// **'Session expirée'**
  String get notice_sessionExpired_title;

  /// No description provided for @notice_sessionExpired_message.
  ///
  /// In fr, this message translates to:
  /// **'Votre session a expiré. Connectez-vous de nouveau.'**
  String get notice_sessionExpired_message;

  /// No description provided for @notice_connectionFailed_title.
  ///
  /// In fr, this message translates to:
  /// **'Connexion impossible'**
  String get notice_connectionFailed_title;

  /// No description provided for @notice_invalidCredentials_message.
  ///
  /// In fr, this message translates to:
  /// **'L’adresse e-mail ou le mot de passe est incorrect.'**
  String get notice_invalidCredentials_message;

  /// No description provided for @notice_emailVerification_title.
  ///
  /// In fr, this message translates to:
  /// **'Adresse e-mail à confirmer'**
  String get notice_emailVerification_title;

  /// No description provided for @notice_emailVerification_message.
  ///
  /// In fr, this message translates to:
  /// **'Confirmez votre adresse e-mail avant d’ajouter un appareil VPN.'**
  String get notice_emailVerification_message;

  /// No description provided for @notice_rateLimited_title.
  ///
  /// In fr, this message translates to:
  /// **'Trop de tentatives'**
  String get notice_rateLimited_title;

  /// No description provided for @notice_deviceLimit_title.
  ///
  /// In fr, this message translates to:
  /// **'Limite de 2 appareils atteinte'**
  String get notice_deviceLimit_title;

  /// No description provided for @notice_deviceLimit_message.
  ///
  /// In fr, this message translates to:
  /// **'Retirez un appareil existant avant d’en ajouter un autre.'**
  String get notice_deviceLimit_message;

  /// No description provided for @notice_identityRenewal_title.
  ///
  /// In fr, this message translates to:
  /// **'Identité VPN à renouveler'**
  String get notice_identityRenewal_title;

  /// No description provided for @notice_identityRenewal_message.
  ///
  /// In fr, this message translates to:
  /// **'Cette identité a été retirée. Créez une nouvelle identité locale.'**
  String get notice_identityRenewal_message;

  /// No description provided for @notice_migrationPending_title.
  ///
  /// In fr, this message translates to:
  /// **'Changement d’emplacement en cours'**
  String get notice_migrationPending_title;

  /// No description provided for @notice_migrationPending_message.
  ///
  /// In fr, this message translates to:
  /// **'Un changement d’emplacement est déjà en cours.'**
  String get notice_migrationPending_message;

  /// No description provided for @notice_migrationBlocked_title.
  ///
  /// In fr, this message translates to:
  /// **'Changement d’emplacement bloqué'**
  String get notice_migrationBlocked_title;

  /// No description provided for @notice_migrationBlocked_message.
  ///
  /// In fr, this message translates to:
  /// **'Le changement d’emplacement nécessite une intervention serveur. Réessayez plus tard ou contactez le support.'**
  String get notice_migrationBlocked_message;

  /// No description provided for @notice_targetUnavailable_title.
  ///
  /// In fr, this message translates to:
  /// **'Serveur temporairement indisponible'**
  String get notice_targetUnavailable_title;

  /// No description provided for @notice_targetUnavailable_message.
  ///
  /// In fr, this message translates to:
  /// **'Ce serveur est temporairement indisponible.'**
  String get notice_targetUnavailable_message;

  /// No description provided for @notice_networkUnavailable_title.
  ///
  /// In fr, this message translates to:
  /// **'Connexion Internet indisponible'**
  String get notice_networkUnavailable_title;

  /// No description provided for @notice_networkUnavailable_message.
  ///
  /// In fr, this message translates to:
  /// **'Vérifiez votre connexion puis réessayez.'**
  String get notice_networkUnavailable_message;

  /// No description provided for @notice_permissionDenied_title.
  ///
  /// In fr, this message translates to:
  /// **'Autorisation VPN refusée'**
  String get notice_permissionDenied_title;

  /// No description provided for @notice_permissionDenied_message.
  ///
  /// In fr, this message translates to:
  /// **'Relancez la connexion et acceptez la demande d’autorisation Android.'**
  String get notice_permissionDenied_message;

  /// No description provided for @notice_wireguardTimeout_title.
  ///
  /// In fr, this message translates to:
  /// **'Le serveur ne répond pas'**
  String get notice_wireguardTimeout_title;

  /// No description provided for @notice_wireguardTimeout_message.
  ///
  /// In fr, this message translates to:
  /// **'La connexion WireGuard n’a pas abouti à temps. Réessayez ou choisissez un autre emplacement.'**
  String get notice_wireguardTimeout_message;

  /// No description provided for @notice_tlsFailed_title.
  ///
  /// In fr, this message translates to:
  /// **'Connexion sécurisée refusée'**
  String get notice_tlsFailed_title;

  /// No description provided for @notice_tlsFailed_message.
  ///
  /// In fr, this message translates to:
  /// **'Le serveur n’a pas accepté la connexion OpenVPN. Réessayez. Si le problème persiste, lancez un diagnostic.'**
  String get notice_tlsFailed_message;

  /// No description provided for @notice_tunRejected_title.
  ///
  /// In fr, this message translates to:
  /// **'Interface VPN refusée par Android'**
  String get notice_tunRejected_title;

  /// No description provided for @notice_tunRejected_message.
  ///
  /// In fr, this message translates to:
  /// **'Android a refusé la configuration réseau demandée par OpenVPN.'**
  String get notice_tunRejected_message;

  /// No description provided for @notice_openvpnStart_title.
  ///
  /// In fr, this message translates to:
  /// **'Démarrage OpenVPN impossible'**
  String get notice_openvpnStart_title;

  /// No description provided for @notice_openvpnStart_message.
  ///
  /// In fr, this message translates to:
  /// **'Le moteur OpenVPN n’a pas pu terminer le démarrage. Réessayez. Si le problème persiste, contactez le support.'**
  String get notice_openvpnStart_message;

  /// No description provided for @notice_diagnosticCode.
  ///
  /// In fr, this message translates to:
  /// **'Code diagnostic : {code}'**
  String notice_diagnosticCode(Object code);

  /// No description provided for @notice_generic_title.
  ///
  /// In fr, this message translates to:
  /// **'Connexion VPN impossible'**
  String get notice_generic_title;

  /// No description provided for @notice_generic_message.
  ///
  /// In fr, this message translates to:
  /// **'Une erreur est survenue. Réessayez plus tard.'**
  String get notice_generic_message;

  /// No description provided for @notice_controller_title.
  ///
  /// In fr, this message translates to:
  /// **'{code, select, account_created_email_unavailable{Compte créé} password_reset_sent{Demande de réinitialisation reçue} verification_email_sent{E-mail de vérification envoyé} location_migration_pending{Changement d’emplacement en cours} vpn_sign_in_required{Connexion requise} protocol_unavailable_at_location{Protocole indisponible} vpn_permission_denied{Autorisation VPN refusée} revoked_identity_device_limit{Limite de 2 appareils atteinte} tunnel_start_unexpected{Démarrage VPN impossible} flutter_disconnect_timeout{Déconnexion non confirmée} flutter_disconnect_unexpected{Déconnexion impossible} device_revoked{Appareil retiré} revoke_unexpected{Suppression impossible} identity_renewal_unexpected{Renouvellement impossible} openvpn_renewal_unexpected{Renouvellement OpenVPN impossible} location_migration_blocked{Changement d’emplacement bloqué} location_migration_slow{Changement toujours en cours} location_migration_conflict{Changement d’emplacement à actualiser} location_migration_verification_failed{Changement non confirmé} location_migration_device_changed{Appareil modifié pendant le changement} tunnel_stop_failed{Changement impossible} other{Opération impossible}}'**
  String notice_controller_title(String code);

  /// No description provided for @notice_controller_message.
  ///
  /// In fr, this message translates to:
  /// **'{code, select, account_created_email_unavailable{Le compte a été créé, mais l’e-mail de vérification n’a pas pu être envoyé. Utilisez le renvoi depuis l’application.} password_reset_sent{Votre demande a été reçue. Si un compte correspond à cette adresse, un e-mail pourra vous parvenir. Vérifiez aussi vos courriers indésirables.} verification_email_sent{Un nouvel e-mail de vérification vient d’être envoyé.} location_migration_pending{La préparation du déplacement vers {target} est toujours en cours. Vous pouvez la reprendre sans recréer l’appareil.} vpn_sign_in_required{Connectez-vous à votre compte avant de démarrer le VPN.} protocol_unavailable_at_location{Le protocole sélectionné n’est pas proposé par cet emplacement. Actualisez les emplacements ou choisissez un autre protocole.} vpn_permission_denied{Android a refusé l’autorisation VPN. Relancez la connexion puis acceptez la demande système.} revoked_identity_device_limit{L’accès VPN de cet appareil a été retiré et la limite d’appareils est atteinte. Retirez un appareil dans Compte → Gérer mes appareils.} tunnel_start_unexpected{Une erreur inattendue a interrompu la préparation du tunnel. Consultez le code diagnostic puis réessayez.} flutter_disconnect_timeout{Android n’a pas confirmé l’arrêt du VPN à temps. Réessayez l’arrêt.} flutter_disconnect_unexpected{Une erreur inattendue a empêché la confirmation de l’arrêt du tunnel.} device_revoked{L’accès VPN de l’appareil a été révoqué et ses secrets locaux ont été supprimés.} revoke_unexpected{L’appareil n’a pas pu être retiré. Actualisez la liste puis réessayez.} identity_renewal_unexpected{La nouvelle identité VPN n’a pas pu être créée. Actualisez les appareils puis réessayez.} openvpn_renewal_unexpected{Le profil OpenVPN n’a pas pu être renouvelé. Réessayez ou consultez le code diagnostic.} location_migration_blocked{Le serveur ne peut pas terminer ce changement pour le moment. L’appareil et son identité locale ont été conservés.} location_migration_slow{Le serveur prépare encore le déplacement vers {target}. Utilisez Reprendre dans quelques instants.} location_migration_conflict{L’état de l’appareil a changé sur le serveur. Actualisez les appareils puis reprenez le changement.} location_migration_verification_failed{Le serveur n’a pas confirmé le nouvel emplacement. L’ancienne identité locale a été conservée.} location_migration_device_changed{L’appareil retourné par le serveur ne correspond plus à celui du changement. Actualisez les appareils avant de réessayer.} tunnel_stop_failed{Le tunnel précédent doit être complètement arrêté avant la nouvelle connexion.} other{L’opération n’a pas pu être terminée. Réessayez ou transmettez le code diagnostic au support.}}'**
  String notice_controller_message(String code, String target);

  /// No description provided for @notice_api_title.
  ///
  /// In fr, this message translates to:
  /// **'{code, select, unauthorized{Session expirée} invalid_credentials{Connexion impossible} email_verification_required{Adresse e-mail à confirmer} verification_email_cooldown{E-mail déjà envoyé} rate_limited{Trop de tentatives} invalid_registration{Informations à corriger} email_exists{Compte existant} invalid_profile{Profil invalide} invalid_device{Appareil invalide} invalid_location{Emplacement indisponible} device_limit{Limite d’appareils atteinte} device_exists{Identité VPN déjà utilisée} device_identity_revoked{Identité VPN à renouveler} device_location_locked{Changement d’emplacement à actualiser} location_migration_pending{Changement d’emplacement en cours} location_migration_blocked{Changement d’emplacement bloqué} target_ca_mismatch{Serveur OpenVPN non compatible} location_migration_conflict{Changement d’emplacement à actualiser} server_full{Serveur complet} capacity_unavailable{Emplacement temporairement indisponible} target_unavailable{Serveur temporairement indisponible} not_found{Élément introuvable} invalid_openvpn_csr{Identité OpenVPN invalide} openvpn_profile_exists{Profil OpenVPN existant} openvpn_profile_revoked{Profil OpenVPN révoqué} openvpn_operation_pending{Opération OpenVPN en cours} openvpn_operation_terminal{Opération OpenVPN interrompue} openvpn_address_unavailable{Adresse OpenVPN indisponible} openvpn_profile_conflict{Conflit OpenVPN} openvpn_signer_unavailable{OpenVPN indisponible} email_delivery_unavailable{E-mail indisponible} invalid_token{Lien invalide} network_unavailable{Connexion Internet indisponible} invalid_json{Demande invalide} invalid_api_response{Réponse serveur invalide} ipv6_unavailable{IPv6 indisponible} invalid_ip_families{Configuration réseau refusée} other{Service indisponible}}'**
  String notice_api_title(String code);

  /// No description provided for @notice_api_message.
  ///
  /// In fr, this message translates to:
  /// **'{code, select, unauthorized{Votre session a expiré. Connectez-vous de nouveau.} invalid_credentials{L’adresse e-mail ou le mot de passe est incorrect.} email_verification_required{Confirmez votre adresse e-mail avant d’ajouter un appareil VPN.} invalid_registration{Vérifiez les informations et les consentements demandés.} email_exists{Cette adresse e-mail possède déjà un compte.} invalid_profile{Vérifiez les informations de votre profil.} invalid_device{Le nom ou l’identité locale de cet appareil est invalide.} invalid_location{Actualisez la liste des emplacements puis réessayez.} device_limit{Retirez un appareil existant avant d’en ajouter un autre.} device_exists{Cette identité VPN est déjà liée à un autre compte.} device_identity_revoked{Cette identité a été retirée. Une nouvelle identité locale doit être créée.} device_location_locked{L’emplacement de cet appareil vient de changer. L’application va reprendre le changement en cours.} location_migration_pending{Un changement d’emplacement est déjà en cours.} location_migration_blocked{Le changement d’emplacement nécessite une intervention serveur. Réessayez plus tard ou contactez le support.} target_ca_mismatch{Ce serveur n’est pas encore compatible avec le profil OpenVPN actuel.} location_migration_conflict{Actualisez les appareils puis réessayez le changement d’emplacement.} server_full{Cet emplacement a atteint sa limite de connexions. Choisissez un autre emplacement ou réessayez plus tard.} capacity_unavailable{La disponibilité de cet emplacement ne peut pas être confirmée pour le moment. Choisissez un autre emplacement ou réessayez plus tard.} target_unavailable{Ce serveur est temporairement indisponible.} not_found{Cet élément n’est plus disponible sur votre compte.} invalid_openvpn_csr{Créez une nouvelle identité OpenVPN puis réessayez.} openvpn_profile_exists{Un profil OpenVPN existe déjà pour cet appareil.} openvpn_profile_revoked{Renouvelez le profil OpenVPN pour continuer.} openvpn_operation_pending{La modification est en cours de propagation. Réessayez plus tard.} openvpn_operation_terminal{Créez une nouvelle identité OpenVPN puis réessayez.} openvpn_address_unavailable{Aucune adresse OpenVPN n’est disponible pour le moment.} openvpn_profile_conflict{Le profil a changé. Actualisez les appareils puis réessayez.} openvpn_signer_unavailable{Le service OpenVPN est momentanément indisponible.} email_delivery_unavailable{L’e-mail n’a pas pu être envoyé. Réessayez plus tard.} invalid_token{Ce lien est invalide ou a expiré. Demandez-en un nouveau.} network_unavailable{Vérifiez votre connexion Internet puis réessayez.} invalid_json{Vérifiez les informations saisies puis réessayez.} invalid_api_response{Le serveur a renvoyé une réponse inattendue. Réessayez plus tard.} ipv6_unavailable{Le serveur ne peut pas activer IPv6 pour le moment. Réessayez plus tard.} invalid_ip_families{La configuration du tunnel est incomplète ou ne correspond pas aux adresses autorisées. Réessayez depuis l’application.} other{Une erreur serveur est survenue. Réessayez plus tard.}}'**
  String notice_api_message(String code);

  /// No description provided for @notice_retryLater.
  ///
  /// In fr, this message translates to:
  /// **'Réessayez dans quelques instants.'**
  String get notice_retryLater;

  /// No description provided for @notice_retryAfter.
  ///
  /// In fr, this message translates to:
  /// **'Réessayez dans {seconds} secondes.'**
  String notice_retryAfter(Object seconds);

  /// No description provided for @notice_native_title.
  ///
  /// In fr, this message translates to:
  /// **'{code, select, system_vpn_resume_unavailable{Reprise VPN système indisponible} system_vpn_resume_corrupt{Reprise VPN système invalide} system_vpn_resume_session_invalid{Session de reprise VPN invalide} system_vpn_resume_identity_changed{Identité VPN modifiée} system_vpn_resume_identity_invalid{Identité de reprise VPN invalide} system_vpn_resume_storage_failed{Stockage de reprise VPN indisponible} system_vpn_resume_network_timeout{Reprise VPN sans réseau} system_vpn_resume_blocked{Reprise VPN bloquée} system_vpn_resume_failed{Reprise VPN échouée} system_vpn_resume_error_invalid{Erreur de reprise VPN invalide} wireguard_identity_store_failed{Identité WireGuard non enregistrée} wireguard_identity_unavailable{Identité WireGuard indisponible} vpn_host_destroyed{Hôte VPN Android arrêté} vpn_host_unavailable{Hôte VPN Android indisponible} vpn_permission_required{Autorisation VPN requise} vpn_permission_denied{Autorisation VPN refusée} vpn_permission_request_failed{Demande d’autorisation impossible} wireguard_foreground_service_unavailable{Service WireGuard indisponible} wireguard_identity_invalid{Clé WireGuard locale invalide} wireguard_identity_in_use{Identité WireGuard déjà utilisée} wireguard_configuration_invalid{Configuration WireGuard invalide} wireguard_operation_pending{Opération WireGuard encore active} wireguard_start_failed{Démarrage WireGuard refusé} wireguard_stop_timeout{Arrêt WireGuard non confirmé} wireguard_handshake_timeout{WireGuard sans réponse} openvpn_connection_timeout{OpenVPN sans réponse} openvpn_core_unavailable{Moteur OpenVPN indisponible} openvpn_operation_pending{Session OpenVPN encore active} openvpn_stop_timeout{Arrêt OpenVPN non confirmé} openvpn_profile_unavailable{Profil OpenVPN local absent} openvpn_native_failed{Appel natif OpenVPN interrompu} openvpn_key_generation_failed{Clé OpenVPN P-256 impossible} openvpn_csr_generation_failed{CSR OpenVPN impossible} openvpn_identity_store_failed{Identité OpenVPN non enregistrée} openvpn_identity_clear_failed{Suppression OpenVPN incomplète} openvpn_identity_in_use{Identité OpenVPN encore utilisée} openvpn_tls_verification_required{Vérification TLS OpenVPN absente} openvpn_cipher_invalid{Chiffrement OpenVPN invalide} openvpn_profile_rejected{Profil OpenVPN refusé} openvpn_identity_inconsistent{Identité OpenVPN incohérente} tls_handshake_failed{Négociation OpenVPN refusée} tls_alert_unknown_ca{Certificat client OpenVPN non reconnu} tls_alert_bad_certificate{Certificat client OpenVPN refusé} tls_alert_unsupported_certificate{Certificat OpenVPN non compatible} tls_client_certificate_required{Certificat client OpenVPN requis} tls_alert_misc{Alerte TLS OpenVPN} tls_signature_algorithm_rejected{Signature OpenVPN non compatible} tls_handshake_rejected{Négociation TLS OpenVPN refusée} tls_version_rejected{Version TLS OpenVPN incompatible} tls_certificate_expired{Certificat TLS expiré} tls_certificate_revoked{Certificat TLS révoqué} transport_failed{Serveur OpenVPN injoignable} tun_configuration_rejected{Interface OpenVPN impossible} tun_setup_failed{Initialisation TUN OpenVPN échouée} tun_interface_create_failed{Création de l’interface OpenVPN échouée} tun_interface_disabled{Interface OpenVPN désactivée} tun_halted{Interface OpenVPN interrompue} tun_already_established{Interface OpenVPN déjà ouverte} tun_addresses_missing{Adresse OpenVPN absente} tun_routes_missing{Routes OpenVPN absentes} tun_dns_missing{DNS OpenVPN absent} tun_permission_revoked{Autorisation VPN révoquée} tun_establish_returned_null{Interface VPN refusée par Android} openvpn_service_start_failed{Service OpenVPN indisponible} openvpn_operation_timeout{Appel OpenVPN expiré} openvpn_start_failed{Démarrage OpenVPN refusé} openvpn_connection_failed{Connexion OpenVPN interrompue} openvpn_core_status_error{OpenVPN Core terminé en erreur} openvpn_stopped_before_connected{OpenVPN arrêté avant connexion} openvpn_auth_failed{Authentification OpenVPN refusée} openvpn_client_setup_failed{Préparation du client OpenVPN échouée} openvpn_client_halted{Client OpenVPN interrompu} openvpn_client_restart{Redémarrage OpenVPN demandé} openvpn_inactive_timeout{OpenVPN inactif trop longtemps} openvpn_session_expired{Session OpenVPN expirée} openvpn_credentials_required{Authentification OpenVPN non prise en charge} openvpn_proxy_failed{Transport intermédiaire OpenVPN en échec} openvpn_compression_failed{Compression OpenVPN refusée} openvpn_ntlm_crypto_unavailable{Chiffrement NTLM OpenVPN indisponible} openvpn_feature_unsupported{Fonction OpenVPN non prise en charge} network_unavailable{Connexion Internet indisponible} network_lost{Réseau indisponible} certificate_validation_failed{Certificat serveur refusé} openvpn_certificate_expired{Certificat OpenVPN expiré} tunnel_active_for_another_account{Tunnel d’un autre compte encore actif} tunnel_already_active{Tunnel natif déjà actif} tunnel_stop_timeout{Arrêt {protocol} non confirmé} tunnel_disconnected{{protocol} interrompu} native_bridge_unavailable{Bridge Android indisponible} native_operation_failed{Opération Android interrompue} invalid_arguments{Paramètres VPN incomplets} invalid_account_id{Compte VPN invalide} invalid_device_id{Identifiant d’appareil invalide} storage_key_not_allowed{Clé de stockage refusée} secure_storage_read_failed{Lecture sécurisée impossible} secure_storage_write_failed{Écriture sécurisée impossible} key_generation_failed{Génération WireGuard impossible} csr_generation_failed{Génération OpenVPN impossible} other{Erreur VPN native non classée}}'**
  String notice_native_title(String code, String protocol);

  /// No description provided for @notice_native_message.
  ///
  /// In fr, this message translates to:
  /// **'{code, select, system_vpn_resume_unavailable{Android ne trouve aucune reprise VPN utilisable. Démarrez une nouvelle connexion dans l’application.} system_vpn_resume_corrupt{Les données de reprise VPN enregistrées sont invalides et ne seront pas utilisées. Démarrez une nouvelle connexion.} system_vpn_resume_session_invalid{La session enregistrée ne permet plus de reprendre le VPN. Connectez-vous à nouveau dans l’application.} system_vpn_resume_identity_changed{L’identité VPN locale a changé. La reprise a été arrêtée; démarrez une nouvelle connexion.} system_vpn_resume_identity_invalid{L’identité prévue pour la reprise n’est pas valide. Démarrez une nouvelle connexion.} system_vpn_resume_storage_failed{Android n’a pas pu lire ou mettre à jour les données de reprise chiffrées. Démarrez une nouvelle connexion.} system_vpn_resume_network_timeout{Android n’a pas trouvé de réseau à temps pour reprendre le VPN. Réessayez lorsque le réseau est disponible.} system_vpn_resume_blocked{La reprise VPN est bloquée. Vérifiez les réglages Android puis démarrez une nouvelle connexion.} system_vpn_resume_failed{La reprise VPN par Android a échoué. Démarrez une nouvelle connexion dans l’application.} system_vpn_resume_error_invalid{Android a renvoyé une erreur de reprise non utilisable. Démarrez une nouvelle connexion.} wireguard_identity_store_failed{Android n’a pas pu enregistrer l’identité WireGuard chiffrée de ce compte.} wireguard_identity_unavailable{Aucune identité WireGuard utilisable n’est disponible pour cette connexion.} vpn_host_destroyed{Le composant Android qui hébergeait le VPN a été arrêté. Démarrez une nouvelle connexion.} vpn_host_unavailable{Android ne peut pas créer le composant qui héberge le VPN. Réessayez après avoir vérifié les réglages VPN.} openvpn_renewal_required{Le certificat nécessite une action dans l’application avant la connexion.} openvpn_recovery_failed{La reprise automatique a échoué. Relancez la connexion dans l’application.} openvpn_recovery_exhausted{La reprise automatique a déjà été utilisée. Relancez la connexion dans l’application.} vpn_permission_required{Android exige une nouvelle autorisation VPN avant le démarrage du tunnel.} vpn_permission_denied{Autorisez FuzeVPN dans la demande Android pour continuer.} vpn_permission_request_failed{Android n’a pas pu ouvrir l’écran d’autorisation VPN.} wireguard_foreground_service_unavailable{Android n’a pas pu maintenir le service WireGuard au premier plan.} wireguard_identity_invalid{La clé WireGuard chiffrée de ce compte est illisible ou invalide.} wireguard_identity_in_use{Une autre opération utilise encore la clé WireGuard de ce compte.} wireguard_configuration_invalid{L’adresse, le DNS, la clé serveur ou les routes WireGuard reçues sont invalides.} wireguard_operation_pending{La précédente opération WireGuard n’a pas encore libéré son service natif.} wireguard_start_failed{Le moteur WireGuard a refusé la mise en ligne de la configuration.} wireguard_stop_timeout{Le service WireGuard n’a pas confirmé la libération de l’interface VPN dans le délai imparti.} wireguard_handshake_timeout{Le tunnel n’a pas confirmé de handshake avec le serveur à temps.} openvpn_connection_timeout{OpenVPN n’a pas confirmé la connexion avec le serveur à temps.} openvpn_core_unavailable{Cette version de l’application ne contient pas un moteur OpenVPN utilisable.} openvpn_operation_pending{Le moteur natif conserve la session OpenVPN précédente et refuse d’en créer une seconde.} openvpn_stop_timeout{OpenVPN Core n’a pas confirmé l’arrêt et la destruction de sa session native dans le délai imparti.} openvpn_profile_unavailable{Aucun profil OpenVPN validé ne peut être relu pour cette connexion.} openvpn_native_failed{Une erreur de l’application a interrompu OpenVPN. Réessayez la connexion. Si le problème persiste, lancez un diagnostic.} openvpn_key_generation_failed{Android Keystore n’a pas pu créer ou relire la clé privée P-256 non exportable.} openvpn_csr_generation_failed{La clé Android Keystore n’a pas pu signer la demande de certificat OpenVPN.} openvpn_identity_store_failed{Le certificat ou le profil OpenVPN n’a pas pu être enregistré dans le stockage chiffré.} openvpn_identity_clear_failed{Android n’a pas pu supprimer toute l’identité OpenVPN locale de ce compte.} openvpn_identity_in_use{Une session OpenVPN native utilise encore la clé ou le certificat de cet appareil.} openvpn_tls_verification_required{Le profil ne demande pas explicitement la vérification du certificat serveur.} openvpn_cipher_invalid{Le serveur a fourni un algorithme de chiffrement absent de la liste autorisée.} openvpn_profile_rejected{Le profil reçu du serveur n’est pas compatible. Recréez cet appareil puis réessayez.} openvpn_identity_inconsistent{Le certificat ne correspond pas à l’identité sécurisée de ce téléphone. Aucun profil local n’a été remplacé.} tls_handshake_failed{Le serveur a refusé la négociation TLS. Recréez le profil si le problème persiste.} tls_alert_unknown_ca{Le serveur ne reconnaît pas l’autorité du certificat de cet appareil. Le serveur OpenVPN doit être vérifié.} tls_alert_bad_certificate{Le serveur a refusé le certificat de cet appareil. Recréez l’appareil avant un nouvel essai.} tls_alert_unsupported_certificate{Le serveur ne prend pas en charge le type de certificat sécurisé utilisé par Android.} tls_client_certificate_required{Le serveur exige un certificat client, mais OpenVPN Core n’a pas pu en présenter un.} tls_alert_misc{Le serveur a renvoyé une alerte TLS qui ne correspond pas aux catégories certificat ou version.} tls_signature_algorithm_rejected{Le serveur a refusé l’algorithme ECDSA P-256 de la clé Android Keystore.} tls_handshake_rejected{Le serveur a interrompu la négociation TLS avant la connexion.} tls_version_rejected{Le client et le serveur n’ont pas trouvé de version TLS commune.} tls_certificate_expired{Le certificat présenté pendant la connexion a expiré.} tls_certificate_revoked{Le certificat présenté pendant la connexion a été révoqué.} transport_failed{Le serveur OpenVPN ne répond pas sur le réseau actuel. Réessayez dans un instant.} tun_configuration_rejected{Android a refusé la configuration réseau demandée par OpenVPN.} tun_setup_failed{OpenVPN Core a refusé le plan réseau avant la création de l’interface Android.} tun_interface_create_failed{OpenVPN Core n’a pas pu obtenir l’interface TUN auprès du VpnService Android.} tun_interface_disabled{Android ou OpenVPN Core a désactivé l’interface TUN pendant la connexion.} tun_halted{OpenVPN Core a reçu une demande d’arrêt de l’interface TUN.} tun_already_established{OpenVPN a demandé une seconde interface dans la même connexion. Le tunnel a été arrêté par sécurité.} tun_addresses_missing{Le serveur n’a fourni aucune adresse utilisable pour le tunnel.} tun_routes_missing{Le serveur n’a fourni aucune route utilisable pour le tunnel.} tun_dns_missing{Le serveur n’a fourni aucun serveur DNS utilisable.} tun_permission_revoked{Android a retiré l’autorisation VPN pendant la connexion.} tun_establish_returned_null{Android n’a pas créé l’interface, généralement parce qu’un autre VPN est encore actif.} openvpn_service_start_failed{Android n’a pas pu démarrer le service OpenVPN au premier plan.} openvpn_operation_timeout{Un appel JNI vers OpenVPN Core a dépassé son délai maximal.} openvpn_start_failed{Le service Android est prêt, mais OpenVPN Core n’a pas accepté le démarrage du profil.} openvpn_connection_failed{OpenVPN Core s’est arrêté avant d’émettre l’événement CONNECTED.} openvpn_core_status_error{La boucle native OpenVPN s’est terminée en erreur sans événement terminal plus précis.} openvpn_stopped_before_connected{La boucle native OpenVPN s’est arrêtée avant l’événement CONNECTED, sans erreur Core explicite.} openvpn_auth_failed{Le serveur OpenVPN a refusé l’authentification du profil.} openvpn_client_setup_failed{OpenVPN Core n’a pas pu initialiser le client avant la connexion réseau.} openvpn_client_halted{OpenVPN Core a reçu un arrêt terminal du client.} openvpn_client_restart{OpenVPN Core a demandé le redémarrage de sa session de transport.} openvpn_inactive_timeout{OpenVPN Core a fermé la session après le délai d’inactivité.} openvpn_session_expired{Le serveur a signalé l’expiration de la session OpenVPN.} openvpn_credentials_required{Le serveur ou un proxy demande des identifiants interactifs absents de ce profil certificat.} openvpn_proxy_failed{OpenVPN Core a signalé un échec du proxy ou du relais configuré.} openvpn_compression_failed{OpenVPN Core a rejeté le mode de compression annoncé par le profil ou le serveur.} openvpn_ntlm_crypto_unavailable{Le profil demande un chiffrement NTLM qui n’est pas disponible dans cette version.} openvpn_feature_unsupported{Le profil ou le serveur demande une fonction absente de ce client Android.} network_unavailable{Aucun réseau physique utilisable n’est disponible.} network_lost{Le tunnel a été arrêté après la perte du réseau.} certificate_validation_failed{L’identité du serveur OpenVPN n’a pas pu être vérifiée.} openvpn_certificate_expired{Renouvelez le profil OpenVPN avant de vous reconnecter.} tunnel_active_for_another_account{Un tunnel appartenant à un autre compte doit être arrêté avant cette connexion.} tunnel_already_active{Android signale qu’une session VPN précédente utilise encore l’interface.} tunnel_stop_timeout{Le moteur {protocol} n’a pas confirmé la libération de l’interface VPN dans le délai imparti.} tunnel_disconnected{Le moteur natif a signalé la fin inattendue du tunnel après son démarrage.} native_bridge_unavailable{L’application ne peut pas accéder au service VPN Android. Fermez puis rouvrez l’application et réessayez.} native_operation_failed{Une erreur de l’application a interrompu l’opération VPN. Réessayez. Si le problème persiste, lancez un diagnostic.} invalid_arguments{Les informations nécessaires à cette opération VPN sont incomplètes. Réessayez. Si le problème persiste, lancez un diagnostic.} invalid_account_id{L’opération native n’est pas associée à un identifiant de compte valide.} invalid_device_id{L’identifiant d’appareil transmis au moteur natif est absent ou invalide.} storage_key_not_allowed{Le bridge Android a bloqué une clé qui n’appartient pas à la liste de stockage autorisée.} secure_storage_read_failed{Android Keystore n’a pas pu déchiffrer les données locales de ce compte.} secure_storage_write_failed{Android Keystore n’a pas pu chiffrer ou enregistrer les données locales.} key_generation_failed{Android n’a pas pu créer ou relire la clé WireGuard dans le stockage sécurisé.} csr_generation_failed{Android Keystore n’a pas pu créer ou signer le CSR P-256 OpenVPN.} other{Une branche native non documentée a échoué. Transmettez le code diagnostic affiché ci-dessous.}}'**
  String notice_native_message(String code, String protocol);

  /// No description provided for @notice_permissionRequestInProgress_title.
  ///
  /// In fr, this message translates to:
  /// **'Demande d’autorisation déjà ouverte'**
  String get notice_permissionRequestInProgress_title;

  /// No description provided for @notice_permissionRequestInProgress_message.
  ///
  /// In fr, this message translates to:
  /// **'La demande d’autorisation VPN Android est déjà affichée. Terminez-la avant de réessayer.'**
  String get notice_permissionRequestInProgress_message;

  /// No description provided for @notice_permissionRequestInterrupted_title.
  ///
  /// In fr, this message translates to:
  /// **'Autorisation VPN interrompue'**
  String get notice_permissionRequestInterrupted_title;

  /// No description provided for @notice_permissionRequestInterrupted_message.
  ///
  /// In fr, this message translates to:
  /// **'L’écran d’autorisation VPN a été fermé avant que l’application reçoive la réponse.'**
  String get notice_permissionRequestInterrupted_message;

  /// No description provided for @notice_openvpnProofMissing_title.
  ///
  /// In fr, this message translates to:
  /// **'Connexion OpenVPN non confirmée'**
  String get notice_openvpnProofMissing_title;

  /// No description provided for @notice_openvpnProofMissing_message.
  ///
  /// In fr, this message translates to:
  /// **'La connexion OpenVPN n’a pas pu être confirmée. Elle a été arrêtée par sécurité. Réessayez.'**
  String get notice_openvpnProofMissing_message;

  /// No description provided for @openvpnCleanup_title.
  ///
  /// In fr, this message translates to:
  /// **'Profil OpenVPN révoqué'**
  String get openvpnCleanup_title;

  /// No description provided for @openvpnCleanup_working.
  ///
  /// In fr, this message translates to:
  /// **'Arrêt et suppression du profil OpenVPN révoqué…'**
  String get openvpnCleanup_working;

  /// No description provided for @openvpnCleanup_stopFailed.
  ///
  /// In fr, this message translates to:
  /// **'L’arrêt d’OpenVPN n’est pas confirmé. Réessayez avant de créer un nouveau profil.'**
  String get openvpnCleanup_stopFailed;

  /// No description provided for @openvpnCleanup_cleanupFailed.
  ///
  /// In fr, this message translates to:
  /// **'Le profil OpenVPN révoqué n’a pas pu être entièrement supprimé. Réessayez le nettoyage.'**
  String get openvpnCleanup_cleanupFailed;

  /// No description provided for @openvpnCleanup_complete.
  ///
  /// In fr, this message translates to:
  /// **'Le profil OpenVPN révoqué a été supprimé. Appuyez sur Se connecter pour en créer un nouveau.'**
  String get openvpnCleanup_complete;

  /// No description provided for @network_title.
  ///
  /// In fr, this message translates to:
  /// **'Configuration réseau'**
  String get network_title;

  /// No description provided for @network_ipv4Fallback.
  ///
  /// In fr, this message translates to:
  /// **'IPv6 est momentanément indisponible. La préparation continue en IPv4.'**
  String get network_ipv4Fallback;

  /// No description provided for @network_rejectedTitle.
  ///
  /// In fr, this message translates to:
  /// **'Configuration réseau refusée'**
  String get network_rejectedTitle;

  /// No description provided for @network_rejectedMessage.
  ///
  /// In fr, this message translates to:
  /// **'La configuration du tunnel est incomplète ou ne correspond pas aux adresses autorisées. Réessayez depuis l’application.'**
  String get network_rejectedMessage;

  /// No description provided for @network_unreadableTitle.
  ///
  /// In fr, this message translates to:
  /// **'Configuration locale illisible'**
  String get network_unreadableTitle;

  /// No description provided for @network_unreadableMessage.
  ///
  /// In fr, this message translates to:
  /// **'La configuration réseau OpenVPN enregistrée ne peut pas être utilisée. Reconnectez-vous depuis l’application pour l’actualiser.'**
  String get network_unreadableMessage;

  /// No description provided for @network_ipv4.
  ///
  /// In fr, this message translates to:
  /// **'IPv4'**
  String get network_ipv4;

  /// No description provided for @network_dualStack.
  ///
  /// In fr, this message translates to:
  /// **'IPv4 + IPv6'**
  String get network_dualStack;

  /// No description provided for @protection_title.
  ///
  /// In fr, this message translates to:
  /// **'Protection réseau'**
  String get protection_title;

  /// No description provided for @protection_subtitle.
  ///
  /// In fr, this message translates to:
  /// **'Bloquez l’accès direct à Internet si le VPN s’interrompt.'**
  String get protection_subtitle;

  /// No description provided for @protection_active.
  ///
  /// In fr, this message translates to:
  /// **'Protection système active'**
  String get protection_active;

  /// No description provided for @protection_alwaysOnOnly.
  ///
  /// In fr, this message translates to:
  /// **'VPN permanent activé, blocage hors VPN à activer'**
  String get protection_alwaysOnOnly;

  /// No description provided for @protection_inactive.
  ///
  /// In fr, this message translates to:
  /// **'Protection système inactive'**
  String get protection_inactive;

  /// No description provided for @protection_unknown.
  ///
  /// In fr, this message translates to:
  /// **'Protection système à vérifier'**
  String get protection_unknown;

  /// No description provided for @protection_openSettings.
  ///
  /// In fr, this message translates to:
  /// **'Ouvrir les réglages Android'**
  String get protection_openSettings;

  /// No description provided for @protection_dialogTitle.
  ///
  /// In fr, this message translates to:
  /// **'Configurer la protection réseau'**
  String get protection_dialogTitle;

  /// No description provided for @protection_dialogMessage.
  ///
  /// In fr, this message translates to:
  /// **'Android gère le VPN permanent et le blocage des connexions hors VPN. Vérifiez que FuzeVPN est sélectionné et activez le blocage dans les réglages système.'**
  String get protection_dialogMessage;

  /// No description provided for @protection_dialogOpen.
  ///
  /// In fr, this message translates to:
  /// **'Ouvrir les réglages'**
  String get protection_dialogOpen;

  /// No description provided for @session_systemProtectionNote.
  ///
  /// In fr, this message translates to:
  /// **'Si Android bloque encore le trafic hors VPN, ouvrez les réglages système pour vérifier ou modifier cette protection.'**
  String get session_systemProtectionNote;

  /// No description provided for @diagnostics_title.
  ///
  /// In fr, this message translates to:
  /// **'Diagnostic'**
  String get diagnostics_title;

  /// No description provided for @diagnostics_settingsTitle.
  ///
  /// In fr, this message translates to:
  /// **'Diagnostic de l’application'**
  String get diagnostics_settingsTitle;

  /// No description provided for @diagnostics_automaticTitle.
  ///
  /// In fr, this message translates to:
  /// **'Envoyer les erreurs importantes'**
  String get diagnostics_automaticTitle;

  /// No description provided for @diagnostics_automaticDescription.
  ///
  /// In fr, this message translates to:
  /// **'Partagez un petit rapport technique lorsqu’une erreur importante survient.'**
  String get diagnostics_automaticDescription;

  /// No description provided for @diagnostics_privacy.
  ///
  /// In fr, this message translates to:
  /// **'Les rapports envoyés sont liés au compte connecté et conservés pendant 30 jours. Ils ne contiennent pas d’historique de navigation, de mots de passe ou de clés VPN.'**
  String get diagnostics_privacy;

  /// No description provided for @diagnostics_manualOpen.
  ///
  /// In fr, this message translates to:
  /// **'Lancer un diagnostic'**
  String get diagnostics_manualOpen;

  /// No description provided for @diagnostics_localDescription.
  ///
  /// In fr, this message translates to:
  /// **'Créez un rapport de l’état de l’application et du VPN. Votre connexion reste inchangée.'**
  String get diagnostics_localDescription;

  /// No description provided for @diagnostics_sendReport.
  ///
  /// In fr, this message translates to:
  /// **'Envoyer le rapport'**
  String get diagnostics_sendReport;

  /// No description provided for @diagnostics_sendHint.
  ///
  /// In fr, this message translates to:
  /// **'Laissez cette case décochée pour garder le rapport sur cet appareil.'**
  String get diagnostics_sendHint;

  /// No description provided for @diagnostics_signedOut.
  ///
  /// In fr, this message translates to:
  /// **'Connectez-vous à votre compte pour envoyer un rapport.'**
  String get diagnostics_signedOut;

  /// No description provided for @diagnostics_localLifetime.
  ///
  /// In fr, this message translates to:
  /// **'Pour conserver ce rapport après la fermeture de l’application, enregistrez-le sur votre téléphone.'**
  String get diagnostics_localLifetime;

  /// No description provided for @diagnostics_run.
  ///
  /// In fr, this message translates to:
  /// **'Lancer le diagnostic'**
  String get diagnostics_run;

  /// No description provided for @diagnostics_rerun.
  ///
  /// In fr, this message translates to:
  /// **'Refaire un diagnostic'**
  String get diagnostics_rerun;

  /// No description provided for @diagnostics_running.
  ///
  /// In fr, this message translates to:
  /// **'Vérifications en cours…'**
  String get diagnostics_running;

  /// No description provided for @diagnostics_sending.
  ///
  /// In fr, this message translates to:
  /// **'Envoi du rapport…'**
  String get diagnostics_sending;

  /// No description provided for @diagnostics_prepared.
  ///
  /// In fr, this message translates to:
  /// **'Rapport prêt sur cet appareil'**
  String get diagnostics_prepared;

  /// No description provided for @diagnostics_queued.
  ///
  /// In fr, this message translates to:
  /// **'Rapport en attente d’envoi'**
  String get diagnostics_queued;

  /// No description provided for @diagnostics_sent.
  ///
  /// In fr, this message translates to:
  /// **'Rapport reçu'**
  String get diagnostics_sent;

  /// No description provided for @diagnostics_failed.
  ///
  /// In fr, this message translates to:
  /// **'L’envoi a échoué. Votre rapport local reste disponible.'**
  String get diagnostics_failed;

  /// No description provided for @diagnostics_preparationFailed.
  ///
  /// In fr, this message translates to:
  /// **'Le diagnostic n’a pas pu être préparé. Réessayez.'**
  String get diagnostics_preparationFailed;

  /// No description provided for @diagnostics_authenticationRequired.
  ///
  /// In fr, this message translates to:
  /// **'Reconnectez-vous pour envoyer le rapport.'**
  String get diagnostics_authenticationRequired;

  /// No description provided for @diagnostics_retry.
  ///
  /// In fr, this message translates to:
  /// **'Réessayer l’envoi'**
  String get diagnostics_retry;

  /// No description provided for @diagnostics_export.
  ///
  /// In fr, this message translates to:
  /// **'Enregistrer le rapport'**
  String get diagnostics_export;

  /// No description provided for @diagnostics_exportFailed.
  ///
  /// In fr, this message translates to:
  /// **'L’export a échoué. Réessayez depuis le rapport local.'**
  String get diagnostics_exportFailed;

  /// No description provided for @diagnostics_preferenceFailed.
  ///
  /// In fr, this message translates to:
  /// **'Ce réglage n’a pas pu être enregistré. Réessayez.'**
  String get diagnostics_preferenceFailed;

  /// No description provided for @diagnostics_receipt.
  ///
  /// In fr, this message translates to:
  /// **'Référence : {id}'**
  String diagnostics_receipt(Object id);

  /// No description provided for @diagnostics_received.
  ///
  /// In fr, this message translates to:
  /// **'Reçu le {date}'**
  String diagnostics_received(Object date);

  /// No description provided for @diagnostics_expires.
  ///
  /// In fr, this message translates to:
  /// **'Conservé jusqu’au {date}'**
  String diagnostics_expires(Object date);

  /// No description provided for @diagnostics_duplicate.
  ///
  /// In fr, this message translates to:
  /// **'Ce rapport avait déjà été reçu.'**
  String get diagnostics_duplicate;

  /// No description provided for @diagnostics_preview.
  ///
  /// In fr, this message translates to:
  /// **'Aperçu du rapport'**
  String get diagnostics_preview;

  /// No description provided for @diagnostics_eventCount.
  ///
  /// In fr, this message translates to:
  /// **'{count, plural, =0{Aucun événement technique joint} =1{1 événement technique joint} other{{count} événements techniques joints}}'**
  String diagnostics_eventCount(int count);

  /// No description provided for @diagnostics_technical.
  ///
  /// In fr, this message translates to:
  /// **'Détails techniques'**
  String get diagnostics_technical;

  /// No description provided for @diagnostics_empty.
  ///
  /// In fr, this message translates to:
  /// **'Aucun diagnostic n’a encore été préparé.'**
  String get diagnostics_empty;

  /// No description provided for @diagnostics_checkName.
  ///
  /// In fr, this message translates to:
  /// **'{id, select, tunnel_connection{État du tunnel} handshake{Confirmation de connexion} certificate{Certificat VPN} kill_switch{Protection Android} connectivity{Réseau disponible} api_reachability{Accès au service} secure_storage{Stockage sécurisé} other{Vérification locale}}'**
  String diagnostics_checkName(String id);

  /// No description provided for @diagnostics_checkResult.
  ///
  /// In fr, this message translates to:
  /// **'{result, select, passed{Vérifié} failed{À vérifier} skipped{Non testé — aucune sonde active} unknown{Information indisponible} other{Information indisponible}}'**
  String diagnostics_checkResult(String result);

  /// No description provided for @auth_welcome.
  ///
  /// In fr, this message translates to:
  /// **'Bienvenue chez FuzeVPN'**
  String get auth_welcome;

  /// No description provided for @connection_changeLocation.
  ///
  /// In fr, this message translates to:
  /// **'Changer d’emplacement'**
  String get connection_changeLocation;

  /// No description provided for @connection_details.
  ///
  /// In fr, this message translates to:
  /// **'Détails de la connexion'**
  String get connection_details;

  /// No description provided for @locations_searchLabel.
  ///
  /// In fr, this message translates to:
  /// **'Rechercher une ville ou un pays'**
  String get locations_searchLabel;

  /// No description provided for @locations_clearSearch.
  ///
  /// In fr, this message translates to:
  /// **'Effacer la recherche'**
  String get locations_clearSearch;

  /// No description provided for @locations_filterAll.
  ///
  /// In fr, this message translates to:
  /// **'Tous'**
  String get locations_filterAll;

  /// No description provided for @locations_filterFavorites.
  ///
  /// In fr, this message translates to:
  /// **'Favoris'**
  String get locations_filterFavorites;

  /// No description provided for @locations_results.
  ///
  /// In fr, this message translates to:
  /// **'{count, plural, one{{count} destination} other{{count} destinations}}'**
  String locations_results(int count);

  /// No description provided for @locations_noResults.
  ///
  /// In fr, this message translates to:
  /// **'Aucune destination trouvée'**
  String get locations_noResults;

  /// No description provided for @locations_noResultsHint.
  ///
  /// In fr, this message translates to:
  /// **'Essayez une autre ville ou un autre pays.'**
  String get locations_noResultsHint;

  /// No description provided for @locations_noFavorites.
  ///
  /// In fr, this message translates to:
  /// **'Vos favoris, à portée de main'**
  String get locations_noFavorites;

  /// No description provided for @locations_noFavoritesHint.
  ///
  /// In fr, this message translates to:
  /// **'Touchez l’étoile d’une destination pour la retrouver ici.'**
  String get locations_noFavoritesHint;

  /// No description provided for @locations_showAll.
  ///
  /// In fr, this message translates to:
  /// **'Voir toutes les destinations'**
  String get locations_showAll;

  /// No description provided for @locations_addFavorite.
  ///
  /// In fr, this message translates to:
  /// **'Ajouter {name} aux favoris'**
  String locations_addFavorite(String name);

  /// No description provided for @locations_removeFavorite.
  ///
  /// In fr, this message translates to:
  /// **'Retirer {name} des favoris'**
  String locations_removeFavorite(String name);

  /// No description provided for @locations_favoriteSaveFailed.
  ///
  /// In fr, this message translates to:
  /// **'Le favori n’a pas pu être enregistré. Réessayez.'**
  String get locations_favoriteSaveFailed;

  /// No description provided for @locations_emptyTitle.
  ///
  /// In fr, this message translates to:
  /// **'Aucune destination disponible'**
  String get locations_emptyTitle;

  /// No description provided for @locations_emptyHint.
  ///
  /// In fr, this message translates to:
  /// **'Actualisez la liste pour réessayer.'**
  String get locations_emptyHint;

  /// No description provided for @devices_manage.
  ///
  /// In fr, this message translates to:
  /// **'Gérer mes appareils'**
  String get devices_manage;

  /// No description provided for @settings_personalization.
  ///
  /// In fr, this message translates to:
  /// **'À votre goût'**
  String get settings_personalization;

  /// No description provided for @settings_safety.
  ///
  /// In fr, this message translates to:
  /// **'Protection'**
  String get settings_safety;

  /// No description provided for @settings_help.
  ///
  /// In fr, this message translates to:
  /// **'Besoin d’aide ?'**
  String get settings_help;

  /// No description provided for @settings_about.
  ///
  /// In fr, this message translates to:
  /// **'À propos de FuzeVPN'**
  String get settings_about;

  /// No description provided for @diagnostics_heading.
  ///
  /// In fr, this message translates to:
  /// **'Comprendre un problème de connexion'**
  String get diagnostics_heading;

  /// No description provided for @devices_profileStatus.
  ///
  /// In fr, this message translates to:
  /// **'{status, select, active{Disponible} pending{En préparation} revoked{Retiré} expired{Expiré} other{Statut indisponible}}'**
  String devices_profileStatus(String status);

  /// No description provided for @notice_preferenceSave_title.
  ///
  /// In fr, this message translates to:
  /// **'Préférence non enregistrée'**
  String get notice_preferenceSave_title;

  /// No description provided for @notice_preferenceSave_message.
  ///
  /// In fr, this message translates to:
  /// **'Votre choix est appliqué pour le moment, mais n’a pas pu être enregistré. Réessayez pour le conserver après la fermeture de l’application.'**
  String get notice_preferenceSave_message;

  /// No description provided for @connection_androidDisconnectHint.
  ///
  /// In fr, this message translates to:
  /// **'Si Android maintient le VPN actif, désactivez « VPN permanent » dans les réglages qui s’ouvrent.'**
  String get connection_androidDisconnectHint;

  /// No description provided for @protection_learnMore.
  ///
  /// In fr, this message translates to:
  /// **'Comprendre la protection Android'**
  String get protection_learnMore;

  /// No description provided for @protection_guideWhy.
  ///
  /// In fr, this message translates to:
  /// **'Cette protection évite que vos applications utilisent directement Internet si le VPN s’interrompt. Elle se règle dans Android.'**
  String get protection_guideWhy;

  /// No description provided for @protection_guideAlwaysOnTitle.
  ///
  /// In fr, this message translates to:
  /// **'VPN permanent'**
  String get protection_guideAlwaysOnTitle;

  /// No description provided for @protection_guideAlwaysOn.
  ///
  /// In fr, this message translates to:
  /// **'Android maintient le service VPN actif et peut le relancer après un redémarrage du téléphone.'**
  String get protection_guideAlwaysOn;

  /// No description provided for @protection_guideBlockTitle.
  ///
  /// In fr, this message translates to:
  /// **'Bloquer les connexions sans VPN'**
  String get protection_guideBlockTitle;

  /// No description provided for @protection_guideBlock.
  ///
  /// In fr, this message translates to:
  /// **'Ce réglage empêche le trafic de passer en dehors du VPN, y compris pendant une interruption de la connexion.'**
  String get protection_guideBlock;

  /// No description provided for @protection_guideWarning.
  ///
  /// In fr, this message translates to:
  /// **'Avec ce blocage activé, Internet reste coupé tant que le VPN n’est pas connecté.'**
  String get protection_guideWarning;

  /// No description provided for @protection_guideStepsTitle.
  ///
  /// In fr, this message translates to:
  /// **'Activer la protection'**
  String get protection_guideStepsTitle;

  /// No description provided for @protection_guideStep1.
  ///
  /// In fr, this message translates to:
  /// **'Ouvrez les réglages VPN Android avec le bouton ci-dessous.'**
  String get protection_guideStep1;

  /// No description provided for @protection_guideStep2.
  ///
  /// In fr, this message translates to:
  /// **'À côté de FuzeVPN, ouvrez les options avec la roue dentée.'**
  String get protection_guideStep2;

  /// No description provided for @protection_guideStep3.
  ///
  /// In fr, this message translates to:
  /// **'Activez « VPN permanent », puis « Bloquer les connexions sans VPN », si ces options sont proposées.'**
  String get protection_guideStep3;

  /// No description provided for @protection_guideManufacturers.
  ///
  /// In fr, this message translates to:
  /// **'Les noms varient selon le téléphone. Si nécessaire, recherchez « VPN » dans les paramètres, souvent dans Réseau et Internet.'**
  String get protection_guideManufacturers;

  /// No description provided for @protection_guideDisableTitle.
  ///
  /// In fr, this message translates to:
  /// **'Désactiver cette protection'**
  String get protection_guideDisableTitle;

  /// No description provided for @protection_guideDisable.
  ///
  /// In fr, this message translates to:
  /// **'Dans les mêmes réglages, désactivez le blocage sans VPN pour autoriser Internet sans VPN. Désactivez aussi le VPN permanent si vous ne voulez plus qu’Android le relance.'**
  String get protection_guideDisable;

  /// No description provided for @protection_guideManual.
  ///
  /// In fr, this message translates to:
  /// **'Vous choisissez ces réglages dans Android. FuzeVPN ne les modifie pas à votre place.'**
  String get protection_guideManual;

  /// No description provided for @locations_changeTitle.
  ///
  /// In fr, this message translates to:
  /// **'Changer d’emplacement ?'**
  String get locations_changeTitle;

  /// No description provided for @locations_changeActive.
  ///
  /// In fr, this message translates to:
  /// **'Le VPN va se déconnecter, puis tenter une connexion à {name}.'**
  String locations_changeActive(String name);

  /// No description provided for @locations_changeIdle.
  ///
  /// In fr, this message translates to:
  /// **'Le VPN va tenter une connexion à {name}.'**
  String locations_changeIdle(String name);

  /// No description provided for @locations_confirmChange.
  ///
  /// In fr, this message translates to:
  /// **'Changer et se connecter'**
  String get locations_confirmChange;

  /// No description provided for @locations_changeBusy.
  ///
  /// In fr, this message translates to:
  /// **'Un changement est en cours. Patientez avant de choisir un autre emplacement.'**
  String get locations_changeBusy;

  /// No description provided for @locations_automaticSelection.
  ///
  /// In fr, this message translates to:
  /// **'Sélection automatique'**
  String get locations_automaticSelection;

  /// No description provided for @locations_cities.
  ///
  /// In fr, this message translates to:
  /// **'Villes'**
  String get locations_cities;

  /// No description provided for @locations_servers.
  ///
  /// In fr, this message translates to:
  /// **'Serveurs'**
  String get locations_servers;

  /// No description provided for @locations_viewCities.
  ///
  /// In fr, this message translates to:
  /// **'Voir les villes de {name}'**
  String locations_viewCities(String name);

  /// No description provided for @locations_viewServers.
  ///
  /// In fr, this message translates to:
  /// **'Voir les serveurs de {name}'**
  String locations_viewServers(String name);

  /// No description provided for @locations_countryCount.
  ///
  /// In fr, this message translates to:
  /// **'{count, plural, one{{count} pays} other{{count} pays}}'**
  String locations_countryCount(int count);

  /// No description provided for @locations_cityCount.
  ///
  /// In fr, this message translates to:
  /// **'{count, plural, =0{0 villes} one{{count} ville} other{{count} villes}}'**
  String locations_cityCount(int count);

  /// No description provided for @locations_serverCount.
  ///
  /// In fr, this message translates to:
  /// **'{count, plural, =0{0 serveurs} one{{count} serveur} other{{count} serveurs}}'**
  String locations_serverCount(int count);

  /// No description provided for @locations_allCountries.
  ///
  /// In fr, this message translates to:
  /// **'Tous les pays'**
  String get locations_allCountries;

  /// No description provided for @locations_backToCountries.
  ///
  /// In fr, this message translates to:
  /// **'Retour aux pays'**
  String get locations_backToCountries;

  /// No description provided for @locations_backToCities.
  ///
  /// In fr, this message translates to:
  /// **'Retour aux villes de {name}'**
  String locations_backToCities(String name);

  /// No description provided for @locations_chooseCountry.
  ///
  /// In fr, this message translates to:
  /// **'Choisir {name}'**
  String locations_chooseCountry(String name);

  /// No description provided for @locations_chooseCity.
  ///
  /// In fr, this message translates to:
  /// **'Choisir {name}'**
  String locations_chooseCity(String name);

  /// No description provided for @locations_noCompatibleServer.
  ///
  /// In fr, this message translates to:
  /// **'Aucun serveur compatible disponible.'**
  String get locations_noCompatibleServer;

  /// No description provided for @externalLink_failed.
  ///
  /// In fr, this message translates to:
  /// **'Impossible d’ouvrir ce lien. Vous pouvez le copier pour l’ouvrir dans votre navigateur.'**
  String get externalLink_failed;

  /// No description provided for @externalLink_copy.
  ///
  /// In fr, this message translates to:
  /// **'Copier le lien'**
  String get externalLink_copy;

  /// No description provided for @externalLink_copied.
  ///
  /// In fr, this message translates to:
  /// **'Lien copié'**
  String get externalLink_copied;

  /// No description provided for @externalLink_copyFailed.
  ///
  /// In fr, this message translates to:
  /// **'Impossible de copier le lien. Sélectionnez l’adresse ci-dessous.'**
  String get externalLink_copyFailed;

  /// No description provided for @settings_deleteAccount.
  ///
  /// In fr, this message translates to:
  /// **'Supprimer mon compte'**
  String get settings_deleteAccount;

  /// No description provided for @settings_deleteAccountDetail.
  ///
  /// In fr, this message translates to:
  /// **'Consulter la procédure de demande de suppression'**
  String get settings_deleteAccountDetail;

  /// No description provided for @billing_title.
  ///
  /// In fr, this message translates to:
  /// **'Fuze Premium'**
  String get billing_title;

  /// No description provided for @billing_subtitle.
  ///
  /// In fr, this message translates to:
  /// **'Choisissez votre abonnement VPN.'**
  String get billing_subtitle;

  /// No description provided for @billing_subscribe.
  ///
  /// In fr, this message translates to:
  /// **'S’abonner'**
  String get billing_subscribe;

  /// No description provided for @billing_choosePlan.
  ///
  /// In fr, this message translates to:
  /// **'Choisissez une formule pour continuer.'**
  String get billing_choosePlan;

  /// No description provided for @billing_monthly.
  ///
  /// In fr, this message translates to:
  /// **'Mensuel'**
  String get billing_monthly;

  /// No description provided for @billing_yearly.
  ///
  /// In fr, this message translates to:
  /// **'Annuel'**
  String get billing_yearly;

  /// No description provided for @billing_continue.
  ///
  /// In fr, this message translates to:
  /// **'Continuer avec Google Play'**
  String get billing_continue;

  /// No description provided for @billing_restore.
  ///
  /// In fr, this message translates to:
  /// **'Restaurer les achats'**
  String get billing_restore;

  /// No description provided for @billing_manage.
  ///
  /// In fr, this message translates to:
  /// **'Gérer l’abonnement'**
  String get billing_manage;

  /// No description provided for @billing_deleteAccountWarning.
  ///
  /// In fr, this message translates to:
  /// **'Si vous avez un abonnement Google Play, supprimer votre compte FuzeVPN n\'annule pas son renouvellement. Gérez ou annulez ce renouvellement séparément dans Google Play.'**
  String get billing_deleteAccountWarning;

  /// No description provided for @billing_deleteAccountContinue.
  ///
  /// In fr, this message translates to:
  /// **'Continuer vers la demande de suppression'**
  String get billing_deleteAccountContinue;

  /// No description provided for @billing_refresh.
  ///
  /// In fr, this message translates to:
  /// **'Actualiser l’accès'**
  String get billing_refresh;

  /// No description provided for @billing_loadingPlans.
  ///
  /// In fr, this message translates to:
  /// **'Chargement des offres…'**
  String get billing_loadingPlans;

  /// No description provided for @billing_unavailable.
  ///
  /// In fr, this message translates to:
  /// **'Aucune offre disponible actuellement. Réessayez plus tard.'**
  String get billing_unavailable;

  /// No description provided for @billing_comingSoon.
  ///
  /// In fr, this message translates to:
  /// **'Abonnements bientôt disponibles.'**
  String get billing_comingSoon;

  /// No description provided for @billing_priceDisclosure.
  ///
  /// In fr, this message translates to:
  /// **'Prix fourni par Google Play. Le montant final et les taxes applicables sont confirmés avant votre validation.'**
  String get billing_priceDisclosure;

  /// No description provided for @billing_renewalMonthly.
  ///
  /// In fr, this message translates to:
  /// **'Renouvellement automatique chaque mois, sauf résiliation. Vous pouvez résilier à tout moment dans les abonnements Google Play.'**
  String get billing_renewalMonthly;

  /// No description provided for @billing_renewalYearly.
  ///
  /// In fr, this message translates to:
  /// **'Renouvellement automatique chaque année, sauf résiliation. Vous pouvez résilier à tout moment dans les abonnements Google Play.'**
  String get billing_renewalYearly;

  /// No description provided for @billing_active.
  ///
  /// In fr, this message translates to:
  /// **'Votre accès Premium est actif'**
  String get billing_active;

  /// No description provided for @billing_accessUntil.
  ///
  /// In fr, this message translates to:
  /// **'Accès jusqu’au {date}.'**
  String billing_accessUntil(String date);

  /// No description provided for @billing_webManaged.
  ///
  /// In fr, this message translates to:
  /// **'Votre abonnement est géré sur le site FuzeVPN.'**
  String get billing_webManaged;

  /// No description provided for @billing_playManaged.
  ///
  /// In fr, this message translates to:
  /// **'Votre abonnement est géré par Google Play.'**
  String get billing_playManaged;

  /// No description provided for @billing_inactive.
  ///
  /// In fr, this message translates to:
  /// **'Aucun abonnement actif.'**
  String get billing_inactive;

  /// No description provided for @billing_checkingAccess.
  ///
  /// In fr, this message translates to:
  /// **'Vérification de votre accès…'**
  String get billing_checkingAccess;

  /// No description provided for @billing_restoring.
  ///
  /// In fr, this message translates to:
  /// **'Restauration des achats…'**
  String get billing_restoring;

  /// No description provided for @billing_pending.
  ///
  /// In fr, this message translates to:
  /// **'Le paiement est en attente. Votre accès sera activé après confirmation.'**
  String get billing_pending;

  /// No description provided for @billing_cancelled.
  ///
  /// In fr, this message translates to:
  /// **'Achat annulé. Aucun nouvel abonnement n’a été activé.'**
  String get billing_cancelled;

  /// No description provided for @billing_verifying.
  ///
  /// In fr, this message translates to:
  /// **'Vérification de l’achat…'**
  String get billing_verifying;

  /// No description provided for @billing_success.
  ///
  /// In fr, this message translates to:
  /// **'Abonnement activé. Votre accès Premium est prêt.'**
  String get billing_success;

  /// No description provided for @billing_restored.
  ///
  /// In fr, this message translates to:
  /// **'Vos achats ont été restaurés.'**
  String get billing_restored;

  /// No description provided for @billing_restoreEmpty.
  ///
  /// In fr, this message translates to:
  /// **'Aucun achat à restaurer pour ce compte Google Play.'**
  String get billing_restoreEmpty;

  /// No description provided for @billing_catalogError.
  ///
  /// In fr, this message translates to:
  /// **'Impossible de charger les offres. Réessayez.'**
  String get billing_catalogError;

  /// No description provided for @billing_purchaseError.
  ///
  /// In fr, this message translates to:
  /// **'Impossible de démarrer l’achat. Réessayez.'**
  String get billing_purchaseError;

  /// No description provided for @billing_verificationError.
  ///
  /// In fr, this message translates to:
  /// **'La vérification de l’achat est temporairement indisponible. Restaurez les achats pour réessayer.'**
  String get billing_verificationError;

  /// No description provided for @billing_restoreError.
  ///
  /// In fr, this message translates to:
  /// **'Impossible de restaurer les achats. Réessayez.'**
  String get billing_restoreError;

  /// No description provided for @billing_managementError.
  ///
  /// In fr, this message translates to:
  /// **'Impossible d’ouvrir la gestion des abonnements. Réessayez.'**
  String get billing_managementError;

  /// No description provided for @billing_storeUnavailable.
  ///
  /// In fr, this message translates to:
  /// **'Google Play n’est pas disponible sur cet appareil.'**
  String get billing_storeUnavailable;

  /// No description provided for @welcome_title.
  ///
  /// In fr, this message translates to:
  /// **'Votre VPN, simplement.'**
  String get welcome_title;

  /// No description provided for @welcome_description.
  ///
  /// In fr, this message translates to:
  /// **'Protégez votre connexion. Gardez le contrôle sur votre vie privée.'**
  String get welcome_description;

  /// No description provided for @welcome_start.
  ///
  /// In fr, this message translates to:
  /// **'Démarrer'**
  String get welcome_start;

  /// No description provided for @welcome_alreadyPurchased.
  ///
  /// In fr, this message translates to:
  /// **'Déjà acheté ?'**
  String get welcome_alreadyPurchased;

  /// No description provided for @welcome_noAccountRequired.
  ///
  /// In fr, this message translates to:
  /// **'Aucun compte à créer pour commencer.'**
  String get welcome_noAccountRequired;

  /// No description provided for @guest_accountTitle.
  ///
  /// In fr, this message translates to:
  /// **'Compte non rattaché'**
  String get guest_accountTitle;

  /// No description provided for @guest_accountDescription.
  ///
  /// In fr, this message translates to:
  /// **'Vos achats peuvent être restaurés sur un autre appareil avec le même compte Google Play.'**
  String get guest_accountDescription;

  /// No description provided for @guest_existingSubscriberSignIn.
  ///
  /// In fr, this message translates to:
  /// **'Déjà abonné ? Se connecter'**
  String get guest_existingSubscriberSignIn;

  /// No description provided for @guest_claimTitle.
  ///
  /// In fr, this message translates to:
  /// **'Retrouvez FuzeVPN partout'**
  String get guest_claimTitle;

  /// No description provided for @guest_claimDescription.
  ///
  /// In fr, this message translates to:
  /// **'Créez votre compte pour retrouver votre abonnement sur vos autres appareils. Cette étape est facultative.'**
  String get guest_claimDescription;

  /// No description provided for @guest_skip.
  ///
  /// In fr, this message translates to:
  /// **'Plus tard'**
  String get guest_skip;

  /// No description provided for @guest_activationTitle.
  ///
  /// In fr, this message translates to:
  /// **'Fuze Premium est activé'**
  String get guest_activationTitle;

  /// No description provided for @guest_activationDescription.
  ///
  /// In fr, this message translates to:
  /// **'Votre abonnement est prêt. Vous pouvez utiliser votre VPN et créer votre compte quand vous le souhaitez.'**
  String get guest_activationDescription;

  /// No description provided for @guest_useVpn.
  ///
  /// In fr, this message translates to:
  /// **'Utiliser mon VPN'**
  String get guest_useVpn;

  /// No description provided for @guest_loginRequired.
  ///
  /// In fr, this message translates to:
  /// **'Cet achat est déjà rattaché à un compte FuzeVPN. Connectez-vous à ce compte pour retrouver votre abonnement.'**
  String get guest_loginRequired;

  /// No description provided for @guest_signOutWarning.
  ///
  /// In fr, this message translates to:
  /// **'Vous pourrez retrouver votre abonnement en restaurant vos achats avec le même compte Google Play.'**
  String get guest_signOutWarning;

  /// No description provided for @guest_profileUnavailable.
  ///
  /// In fr, this message translates to:
  /// **'Votre compte est déjà rattaché. Connectez-vous pour afficher et gérer vos informations.'**
  String get guest_profileUnavailable;

  /// No description provided for @billing_acceptance.
  ///
  /// In fr, this message translates to:
  /// **'En continuant, vous acceptez les Conditions d’utilisation et la Politique de confidentialité.'**
  String get billing_acceptance;

  /// No description provided for @guest_verifyEmailReminder.
  ///
  /// In fr, this message translates to:
  /// **'Confirmez votre adresse e-mail pour sécuriser votre compte. Vous pouvez continuer à utiliser votre VPN.'**
  String get guest_verifyEmailReminder;

  /// No description provided for @guest_serviceUnavailable.
  ///
  /// In fr, this message translates to:
  /// **'Le service est temporairement indisponible. Réessayez dans un instant.'**
  String get guest_serviceUnavailable;

  /// No description provided for @guest_restoreError.
  ///
  /// In fr, this message translates to:
  /// **'Impossible de restaurer vos achats. Réessayez avec le compte Google Play utilisé pour l’achat.'**
  String get guest_restoreError;

  /// No description provided for @guest_claimSuccess.
  ///
  /// In fr, this message translates to:
  /// **'Votre compte a été créé. Votre abonnement et votre accès VPN sont conservés.'**
  String get guest_claimSuccess;

  /// No description provided for @guest_emailExists.
  ///
  /// In fr, this message translates to:
  /// **'Cette adresse est déjà utilisée. Choisissez une autre adresse ou connectez-vous à votre compte existant. Votre achat reste disponible avec Google Play.'**
  String get guest_emailExists;

  /// No description provided for @guest_claimError.
  ///
  /// In fr, this message translates to:
  /// **'Votre compte n’a pas pu être créé. Vous pouvez continuer à utiliser votre VPN et réessayer plus tard.'**
  String get guest_claimError;

  /// No description provided for @guest_secureStorageError.
  ///
  /// In fr, this message translates to:
  /// **'Impossible de sécuriser votre session sur cet appareil. Réessayez.'**
  String get guest_secureStorageError;

  /// No description provided for @guest_premiumRequired.
  ///
  /// In fr, this message translates to:
  /// **'Choisissez un abonnement pour activer votre VPN.'**
  String get guest_premiumRequired;

  /// No description provided for @welcome_viewPlans.
  ///
  /// In fr, this message translates to:
  /// **'Voir les formules'**
  String get welcome_viewPlans;

  /// No description provided for @google_continue.
  ///
  /// In fr, this message translates to:
  /// **'Continuer avec Google'**
  String get google_continue;

  /// No description provided for @google_or.
  ///
  /// In fr, this message translates to:
  /// **'ou'**
  String get google_or;

  /// No description provided for @google_title.
  ///
  /// In fr, this message translates to:
  /// **'Votre compte FuzeVPN'**
  String get google_title;

  /// No description provided for @google_settingUp.
  ///
  /// In fr, this message translates to:
  /// **'Finalisez votre compte'**
  String get google_settingUp;

  /// No description provided for @google_country.
  ///
  /// In fr, this message translates to:
  /// **'Pays de résidence'**
  String get google_country;

  /// No description provided for @google_profileDescription.
  ///
  /// In fr, this message translates to:
  /// **'Choisissez votre pays et consultez les deux documents pour créer votre compte FuzeVPN.'**
  String get google_profileDescription;

  /// No description provided for @google_claimDescription.
  ///
  /// In fr, this message translates to:
  /// **'Rattachez votre compte invité à Google. Votre abonnement et votre appareil restent associés à ce compte.'**
  String get google_claimDescription;

  /// No description provided for @google_linkTitle.
  ///
  /// In fr, this message translates to:
  /// **'Associer Google à FuzeVPN'**
  String get google_linkTitle;

  /// No description provided for @google_linkDescription.
  ///
  /// In fr, this message translates to:
  /// **'Confirmez l’accès à votre compte FuzeVPN existant. Cette étape ne demande pas votre mot de passe Google.'**
  String get google_linkDescription;

  /// No description provided for @google_password.
  ///
  /// In fr, this message translates to:
  /// **'Mot de passe FuzeVPN'**
  String get google_password;

  /// No description provided for @google_linkAccount.
  ///
  /// In fr, this message translates to:
  /// **'Confirmer l’association'**
  String get google_linkAccount;

  /// No description provided for @google_requestEmail.
  ///
  /// In fr, this message translates to:
  /// **'Recevoir un e-mail de confirmation'**
  String get google_requestEmail;

  /// No description provided for @google_emailInstructions.
  ///
  /// In fr, this message translates to:
  /// **'Ouvrez l’e-mail de FuzeVPN et saisissez le code de confirmation.'**
  String get google_emailInstructions;

  /// No description provided for @google_emailCode.
  ///
  /// In fr, this message translates to:
  /// **'Code de confirmation par e-mail'**
  String get google_emailCode;

  /// No description provided for @google_confirmEmail.
  ///
  /// In fr, this message translates to:
  /// **'Confirmer le code'**
  String get google_confirmEmail;

  /// No description provided for @google_restart.
  ///
  /// In fr, this message translates to:
  /// **'Choisir un autre compte Google'**
  String get google_restart;

  /// No description provided for @google_resume.
  ///
  /// In fr, this message translates to:
  /// **'Vérifier cette tentative'**
  String get google_resume;

  /// No description provided for @google_unavailable.
  ///
  /// In fr, this message translates to:
  /// **'La connexion Google est indisponible. Vous pouvez utiliser votre e-mail et votre mot de passe.'**
  String get google_unavailable;

  /// No description provided for @google_expired.
  ///
  /// In fr, this message translates to:
  /// **'Cette tentative a expiré. Annulez-la puis recommencez.'**
  String get google_expired;

  /// No description provided for @google_conflict.
  ///
  /// In fr, this message translates to:
  /// **'Ce compte Google est déjà associé ailleurs. Votre compte et votre abonnement actuels sont conservés.'**
  String get google_conflict;

  /// No description provided for @google_error.
  ///
  /// In fr, this message translates to:
  /// **'La connexion Google a échoué. Réessayez ; votre accès actuel est conservé.'**
  String get google_error;

  /// No description provided for @google_uncertain.
  ///
  /// In fr, this message translates to:
  /// **'Le résultat n’a pas pu être confirmé. Vérifiez cette tentative ou annulez-la avant de recommencer.'**
  String get google_uncertain;

  /// No description provided for @google_cancelFailed.
  ///
  /// In fr, this message translates to:
  /// **'L’annulation n’a pas pu être confirmée. Réessayez d’annuler avant de quitter cet écran.'**
  String get google_cancelFailed;

  /// No description provided for @google_cancelled.
  ///
  /// In fr, this message translates to:
  /// **'Connexion Google annulée.'**
  String get google_cancelled;

  /// No description provided for @google_selecting.
  ///
  /// In fr, this message translates to:
  /// **'Choisissez votre compte Google…'**
  String get google_selecting;

  /// No description provided for @google_verifying.
  ///
  /// In fr, this message translates to:
  /// **'Vérification de votre compte…'**
  String get google_verifying;

  /// No description provided for @google_emailUnavailable.
  ///
  /// In fr, this message translates to:
  /// **'L’e-mail de confirmation n’a pas pu être envoyé. Réessayez plus tard.'**
  String get google_emailUnavailable;

  /// No description provided for @google_emailSent.
  ///
  /// In fr, this message translates to:
  /// **'E-mail de confirmation envoyé. Consultez votre messagerie.'**
  String get google_emailSent;

  /// No description provided for @google_rateLimited.
  ///
  /// In fr, this message translates to:
  /// **'Veuillez patienter avant de réessayer.'**
  String get google_rateLimited;

  /// No description provided for @google_invalidPassword.
  ///
  /// In fr, this message translates to:
  /// **'Le mot de passe FuzeVPN est incorrect. Votre compte actuel est conservé.'**
  String get google_invalidPassword;

  /// No description provided for @google_invalidCode.
  ///
  /// In fr, this message translates to:
  /// **'Le code de confirmation est invalide ou expiré.'**
  String get google_invalidCode;

  /// No description provided for @google_accountChanged.
  ///
  /// In fr, this message translates to:
  /// **'La session a changé. Annulez cette tentative avant de recommencer.'**
  String get google_accountChanged;

  /// No description provided for @google_invalidResponse.
  ///
  /// In fr, this message translates to:
  /// **'Impossible de valider la réponse. Votre accès actuel est conservé.'**
  String get google_invalidResponse;

  /// No description provided for @google_invalidRegistration.
  ///
  /// In fr, this message translates to:
  /// **'Vérifiez le pays et les consentements.'**
  String get google_invalidRegistration;

  /// No description provided for @google_consentRequired.
  ///
  /// In fr, this message translates to:
  /// **'Choisissez votre pays et acceptez les deux documents pour continuer.'**
  String get google_consentRequired;

  /// No description provided for @google_challengeRequired.
  ///
  /// In fr, this message translates to:
  /// **'Une vérification de sécurité supplémentaire est requise. Votre accès actuel est conservé.'**
  String get google_challengeRequired;

  /// No description provided for @google_challengeUnavailable.
  ///
  /// In fr, this message translates to:
  /// **'La vérification de sécurité est indisponible. Réessayez plus tard.'**
  String get google_challengeUnavailable;

  /// No description provided for @billing_trialTitle.
  ///
  /// In fr, this message translates to:
  /// **'Essayez Fuze Premium gratuitement'**
  String get billing_trialTitle;

  /// No description provided for @billing_trialSubtitle.
  ///
  /// In fr, this message translates to:
  /// **'Protégez votre connexion dès aujourd’hui.'**
  String get billing_trialSubtitle;

  /// No description provided for @billing_trialWeeks.
  ///
  /// In fr, this message translates to:
  /// **'2 semaines d’essai gratuit'**
  String get billing_trialWeeks;

  /// Free trial duration returned by Google Play, in days.
  ///
  /// In fr, this message translates to:
  /// **'{days} jours d’essai gratuit'**
  String billing_trialDays(String days);

  /// No description provided for @billing_trialStart.
  ///
  /// In fr, this message translates to:
  /// **'Commencer mon essai gratuit'**
  String get billing_trialStart;

  /// Estimated first charge date when starting today; Google Play confirms before purchase.
  ///
  /// In fr, this message translates to:
  /// **'Si vous commencez aujourd’hui, premier débit prévu le {date}.'**
  String billing_trialFirstCharge(String date);

  /// No description provided for @billing_trialTerms.
  ///
  /// In fr, this message translates to:
  /// **'Renouvellement automatique au tarif indiqué. Pour éviter un débit, annulez dans Google Play avant la fin de l’essai.'**
  String get billing_trialTerms;

  /// Exact localized recurring monthly price returned by Google Play.
  ///
  /// In fr, this message translates to:
  /// **'Puis {price} par mois'**
  String billing_trialThenMonthly(String price);

  /// Exact localized recurring annual price returned by Google Play.
  ///
  /// In fr, this message translates to:
  /// **'Puis {price} par an'**
  String billing_trialThenYearly(String price);

  /// No description provided for @billing_choosePeriod.
  ///
  /// In fr, this message translates to:
  /// **'Choisissez votre formule'**
  String get billing_choosePeriod;

  /// No description provided for @billing_selectionHint.
  ///
  /// In fr, this message translates to:
  /// **'Sélectionnez une formule pour continuer.'**
  String get billing_selectionHint;

  /// No description provided for @billing_benefitConnection.
  ///
  /// In fr, this message translates to:
  /// **'Connexion chiffrée'**
  String get billing_benefitConnection;

  /// No description provided for @billing_benefitPrivacy.
  ///
  /// In fr, this message translates to:
  /// **'Confidentialité en ligne'**
  String get billing_benefitPrivacy;

  /// No description provided for @billing_benefitNoAccount.
  ///
  /// In fr, this message translates to:
  /// **'Sans inscription obligatoire'**
  String get billing_benefitNoAccount;

  /// No description provided for @billing_cancellation.
  ///
  /// In fr, this message translates to:
  /// **'Annulation dans Google Play'**
  String get billing_cancellation;

  /// No description provided for @billing_premiumTitle.
  ///
  /// In fr, this message translates to:
  /// **'Votre connexion, mieux protégée.'**
  String get billing_premiumTitle;

  /// No description provided for @billing_premiumSubtitle.
  ///
  /// In fr, this message translates to:
  /// **'Protégez votre connexion, à votre rythme.'**
  String get billing_premiumSubtitle;

  /// No description provided for @billing_priceMonthly.
  ///
  /// In fr, this message translates to:
  /// **'par mois'**
  String get billing_priceMonthly;

  /// No description provided for @billing_priceYearly.
  ///
  /// In fr, this message translates to:
  /// **'par an'**
  String get billing_priceYearly;

  /// No description provided for @billing_trialToday.
  ///
  /// In fr, this message translates to:
  /// **'Aujourd’hui, rien à payer'**
  String get billing_trialToday;

  /// No description provided for @billing_trialConfirmation.
  ///
  /// In fr, this message translates to:
  /// **'Google Play confirme les dates, le montant final et les taxes applicables avant votre validation.'**
  String get billing_trialConfirmation;

  /// No description provided for @billing_offerChanged.
  ///
  /// In fr, this message translates to:
  /// **'Les conditions de cette offre ont changé. Actualisez les formules et choisissez à nouveau.'**
  String get billing_offerChanged;

  /// No description provided for @status_waitingNetwork.
  ///
  /// In fr, this message translates to:
  /// **'En attente de réseau'**
  String get status_waitingNetwork;

  /// No description provided for @status_waitingNetworkDetail.
  ///
  /// In fr, this message translates to:
  /// **'Aucun réseau disponible. Le VPN vérifiera la connexion au retour du réseau.'**
  String get status_waitingNetworkDetail;

  /// No description provided for @locations_favoriteLoadFailed.
  ///
  /// In fr, this message translates to:
  /// **'Les favoris n’ont pas pu être chargés. Réessayez.'**
  String get locations_favoriteLoadFailed;

  /// No description provided for @locations_favoritesLoading.
  ///
  /// In fr, this message translates to:
  /// **'Chargement des favoris…'**
  String get locations_favoritesLoading;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>[
    'ar',
    'cs',
    'da',
    'de',
    'el',
    'en',
    'es',
    'fa',
    'fil',
    'fr',
    'hi',
    'id',
    'it',
    'ja',
    'ko',
    'ms',
    'nb',
    'nl',
    'pl',
    'pt',
    'ro',
    'ru',
    'sv',
    'th',
    'tr',
    'uk',
    'ur',
    'vi',
    'zh',
  ].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when language+script codes are specified.
  switch (locale.languageCode) {
    case 'zh':
      {
        switch (locale.scriptCode) {
          case 'Hans':
            return AppLocalizationsZhHans();
          case 'Hant':
            return AppLocalizationsZhHant();
        }
        break;
      }
  }

  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'cs':
      return AppLocalizationsCs();
    case 'da':
      return AppLocalizationsDa();
    case 'de':
      return AppLocalizationsDe();
    case 'el':
      return AppLocalizationsEl();
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
    case 'fa':
      return AppLocalizationsFa();
    case 'fil':
      return AppLocalizationsFil();
    case 'fr':
      return AppLocalizationsFr();
    case 'hi':
      return AppLocalizationsHi();
    case 'id':
      return AppLocalizationsId();
    case 'it':
      return AppLocalizationsIt();
    case 'ja':
      return AppLocalizationsJa();
    case 'ko':
      return AppLocalizationsKo();
    case 'ms':
      return AppLocalizationsMs();
    case 'nb':
      return AppLocalizationsNb();
    case 'nl':
      return AppLocalizationsNl();
    case 'pl':
      return AppLocalizationsPl();
    case 'pt':
      return AppLocalizationsPt();
    case 'ro':
      return AppLocalizationsRo();
    case 'ru':
      return AppLocalizationsRu();
    case 'sv':
      return AppLocalizationsSv();
    case 'th':
      return AppLocalizationsTh();
    case 'tr':
      return AppLocalizationsTr();
    case 'uk':
      return AppLocalizationsUk();
    case 'ur':
      return AppLocalizationsUr();
    case 'vi':
      return AppLocalizationsVi();
    case 'zh':
      return AppLocalizationsZh();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
