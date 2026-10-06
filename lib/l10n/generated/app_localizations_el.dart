// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Modern Greek (`el`).
class AppLocalizationsEl extends AppLocalizations {
  AppLocalizationsEl([String locale = 'el']) : super(locale);

  @override
  String get accountRestoration_title =>
      'Ο λογαριασμός δεν είναι προσωρινά διαθέσιμος';

  @override
  String get accountRestoration_message =>
      'Η συνεδρία σας έχει διατηρηθεί. Δοκιμάστε ξανά για να επαναφέρετε τον λογαριασμό σας· μπορείτε ακόμη να διαχειριστείτε εδώ τη σύνδεση VPN.';

  @override
  String get action_retry => 'Δοκιμή ξανά';

  @override
  String get session_endingTitle => 'Τερματισμός συνεδρίας';

  @override
  String get session_ending =>
      'Η συνεδρία σας έχει ακυρωθεί. Διακοπή του VPN και εκκαθάριση της συνεδρίας…';

  @override
  String get session_stopFailed =>
      'Ο τερματισμός του VPN δεν έχει επιβεβαιωθεί. Δοκιμάστε ξανά πριν συνδεθείτε.';

  @override
  String get session_cleanupFailed =>
      'Το VPN έχει σταματήσει, αλλά η αφαίρεση της συνεδρίας δεν έχει επιβεβαιωθεί. Δοκιμάστε ξανά την εκκαθάριση.';

  @override
  String get session_retryStop => 'Δοκιμή τερματισμού ξανά';

  @override
  String get session_retryCleanup => 'Δοκιμή εκκαθάρισης ξανά';

  @override
  String get appTitle => 'FuzeVPN';

  @override
  String get startup => 'Ασφαλής προετοιμασία του FuzeVPN…';

  @override
  String get nav_connection => 'Σύνδεση';

  @override
  String get nav_locations => 'Τοποθεσίες';

  @override
  String get nav_account => 'Λογαριασμός';

  @override
  String get nav_devices => 'Συσκευές';

  @override
  String get nav_settings => 'Ρυθμίσεις';

  @override
  String get action_refresh => 'Ανανέωση';

  @override
  String get auth_tab_login => 'Σύνδεση';

  @override
  String get auth_tab_register => 'Εγγραφή';

  @override
  String get auth_stepAccount => 'Λογαριασμός';

  @override
  String get auth_stepIdentity => 'Ταυτότητα';

  @override
  String get auth_stepAddress => 'Διεύθυνση και συμφωνίες';

  @override
  String auth_stepProgress(Object current, Object total) {
    return 'Βήμα $current από $total';
  }

  @override
  String get auth_tagline => 'Το VPN σας, απλά.';

  @override
  String get auth_keysLocal =>
      'Τα ιδιωτικά κλειδιά VPN σας παραμένουν σε αυτή τη συσκευή.';

  @override
  String get form_email => 'Διεύθυνση ηλεκτρονικού ταχυδρομείου';

  @override
  String get form_password => 'Κωδικός πρόσβασης';

  @override
  String get form_showPassword => 'Εμφάνιση κωδικού πρόσβασης';

  @override
  String get form_hidePassword => 'Απόκρυψη κωδικού πρόσβασης';

  @override
  String get form_passwordMin =>
      '8–72 byte UTF-8. Ορισμένοι χαρακτήρες καταλαμβάνουν περισσότερα από ένα byte.';

  @override
  String get form_firstName => 'Όνομα';

  @override
  String get form_lastName => 'Επώνυμο';

  @override
  String get form_phone => 'Τηλέφωνο (+33612345678)';

  @override
  String get form_address => 'Διεύθυνση';

  @override
  String get form_address2 => 'Γραμμή διεύθυνσης 2 (προαιρετικό)';

  @override
  String get form_postalCode => 'Ταχυδρομικός κώδικας';

  @override
  String get form_city => 'Πόλη';

  @override
  String get form_country => 'Κωδικός χώρας (π.χ. FR)';

  @override
  String get action_login => 'Σύνδεση';

  @override
  String get action_createAccount => 'Δημιουργία λογαριασμού';

  @override
  String get action_createMyAccount => 'Δημιουργία του λογαριασμού μου';

  @override
  String get action_next => 'Συνέχεια';

  @override
  String get action_previous => 'Πίσω';

  @override
  String get action_forgotPassword => 'Ξεχάσατε τον κωδικό πρόσβασης;';

  @override
  String get auth_noAccount => 'Δεν έχετε ακόμη λογαριασμό;';

  @override
  String get auth_requiredInformation =>
      'Δημιουργήστε τον λογαριασμό σας σε τρία βήματα.';

  @override
  String get auth_termsPrefix => 'Αποδέχομαι τους ';

  @override
  String get auth_termsLink => 'όρους χρήσης';

  @override
  String get auth_privacyPrefix => 'Αποδέχομαι την ';

  @override
  String get auth_privacyLink => 'πολιτική απορρήτου';

  @override
  String get auth_consentRequired =>
      'Απαιτείται η συγκατάθεσή σας για τη δημιουργία λογαριασμού.';

  @override
  String get validation_required => 'Αυτό το πεδίο είναι υποχρεωτικό.';

  @override
  String get validation_email =>
      'Εισαγάγετε έγκυρη διεύθυνση ηλεκτρονικού ταχυδρομείου.';

  @override
  String get validation_password =>
      'Ο κωδικός πρόσβασης είναι πολύ σύντομος: τουλάχιστον 8 byte UTF-8.';

  @override
  String get validation_passwordTooLong =>
      'Ο κωδικός πρόσβασης είναι πολύ μεγάλος: έως 72 byte UTF-8.';

  @override
  String get validation_phone =>
      'Χρησιμοποιήστε διεθνή μορφή, για παράδειγμα +33612345678.';

  @override
  String get validation_country =>
      'Χρησιμοποιήστε διγράμματο κωδικό χώρας, για παράδειγμα FR.';

  @override
  String get passwordReset_title => 'Επαναφορά κωδικού πρόσβασης';

  @override
  String get passwordReset_description =>
      'Εισαγάγετε τη διεύθυνση ηλεκτρονικού ταχυδρομείου του λογαριασμού σας για να ζητήσετε σύνδεσμο επαναφοράς κωδικού πρόσβασης.';

  @override
  String get passwordReset_send => 'Αποστολή συνδέσμου';

  @override
  String get connection_title => 'Η σύνδεσή σας';

  @override
  String get connection_subtitle =>
      'Επιλέξτε τοποθεσία και, στη συνέχεια, ενεργοποιήστε το VPN.';

  @override
  String get connection_prepare => 'Είστε έτοιμοι για σύνδεση;';

  @override
  String get connection_advancedOptions => 'Σύνθετες επιλογές';

  @override
  String get connection_location => 'Τοποθεσία';

  @override
  String get connection_chooseLocation => 'Επιλέξτε τοποθεσία';

  @override
  String get connection_protocol => 'Πρωτόκολλο';

  @override
  String get connection_connect => 'Σύνδεση';

  @override
  String get connection_connecting => 'Γίνεται σύνδεση…';

  @override
  String get connection_disconnect => 'Αποσύνδεση';

  @override
  String get connection_disconnecting => 'Γίνεται αποσύνδεση';

  @override
  String get connection_locationChange => 'Αλλαγή τοποθεσίας…';

  @override
  String connection_unavailable(Object protocol) {
    return 'Το $protocol δεν είναι διαθέσιμο';
  }

  @override
  String get connection_activeLocation => 'Ενεργή τοποθεσία';

  @override
  String get connection_duration => 'Διάρκεια';

  @override
  String get connection_received => 'Λήφθηκαν';

  @override
  String get connection_sent => 'Στάλθηκαν';

  @override
  String get connection_lastHandshake => 'Τελευταία ασφαλής ανταλλαγή';

  @override
  String connection_handshakeAgo(Object duration) {
    return 'πριν από $duration';
  }

  @override
  String get verification_title =>
      'Επιβεβαιώστε τη διεύθυνση ηλεκτρονικού ταχυδρομείου σας';

  @override
  String get verification_message =>
      'Επιβεβαιώστε τη διεύθυνση ηλεκτρονικού ταχυδρομείου σας για να χρησιμοποιήσετε το VPN σε αυτό το τηλέφωνο.';

  @override
  String get verification_resend =>
      'Νέα αποστολή μηνύματος ηλεκτρονικού ταχυδρομείου';

  @override
  String get migration_title => 'Αλλαγή τοποθεσίας';

  @override
  String get migration_draining => 'Προετοιμασία αλλαγής τοποθεσίας…';

  @override
  String get migration_activating => 'Ενεργοποίηση νέου διακομιστή…';

  @override
  String get migration_ready => 'Η τοποθεσία ενημερώθηκε.';

  @override
  String get migration_blocked =>
      'Η αλλαγή τοποθεσίας απαιτεί παρέμβαση στον διακομιστή. Δοκιμάστε ξανά αργότερα ή επικοινωνήστε με την υποστήριξη.';

  @override
  String get migration_progress => 'Πρόοδος αλλαγής τοποθεσίας';

  @override
  String migration_retryDelay(Object seconds) {
    return 'Καθυστέρηση μεταξύ ελέγχων: ${seconds}s.';
  }

  @override
  String get migration_resume => 'Συνέχιση αλλαγής τοποθεσίας';

  @override
  String get status_authorizing => 'Απαιτείται άδεια';

  @override
  String get status_authorizingDetail =>
      'Αποδεχτείτε το αίτημα Android για να επιτρέψετε το VPN.';

  @override
  String get status_preparing => 'Προετοιμασία';

  @override
  String get status_preparingDetail =>
      'Προετοιμασία της ασφαλούς σύνδεσής σας.';

  @override
  String get status_reconnecting => 'Επανασύνδεση…';

  @override
  String get status_reconnectingDetail =>
      'Η σύνδεση διακόπηκε. Το VPN προσπαθεί να επανασυνδεθεί.';

  @override
  String get status_connecting => 'Γίνεται σύνδεση';

  @override
  String get status_connectingDetail => 'Σύνδεση με τον διακομιστή VPN…';

  @override
  String get status_connected => 'Συνδεδεμένο';

  @override
  String get status_connectedDetail => 'Η σύνδεση VPN σας είναι ενεργή.';

  @override
  String get status_disconnecting => 'Γίνεται αποσύνδεση';

  @override
  String get status_disconnectingDetail => 'Η σύνδεση VPN σας τερματίζεται.';

  @override
  String get status_error => 'Η σύνδεση δεν είναι διαθέσιμη';

  @override
  String get status_errorDetail =>
      'Η σύνδεση VPN δεν έχει επιβεβαιωθεί. Δοκιμάστε ξανά.';

  @override
  String get status_idle => 'Αποσυνδεδεμένο';

  @override
  String get status_idleDetail =>
      'Συνδέστε το VPN για να προστατεύσετε τη σύνδεσή σας.';

  @override
  String get trust_note =>
      'Το κλείσιμο της εφαρμογής δεν σταματά το VPN. Για να το σταματήσετε, χρησιμοποιήστε την επιλογή Αποσύνδεση.';

  @override
  String get locations_none =>
      'Δεν υπάρχουν διαθέσιμες τοποθεσίες αυτή τη στιγμή.';

  @override
  String get locations_available => 'Επιλέξτε την επόμενη τοποθεσία σας.';

  @override
  String get locations_selected => 'Επιλεγμένη τοποθεσία';

  @override
  String get locations_select => 'Επιλογή αυτής της τοποθεσίας';

  @override
  String get locations_lockedTunnel =>
      'Αποσυνδέστε το VPN για να αλλάξετε τοποθεσία.';

  @override
  String get locations_lockedMigration =>
      'Περιμένετε να ολοκληρωθεί η αλλαγή τοποθεσίας.';

  @override
  String get devices_title => 'Οι συσκευές σας';

  @override
  String devices_used(Object count, Object limit) {
    return '$count / $limit συσκευές';
  }

  @override
  String get devices_refresh => 'Ανανέωση συσκευών';

  @override
  String get devices_empty => 'Δεν έχει καταχωριστεί ακόμη συσκευή VPN.';

  @override
  String get devices_firstConnection =>
      'Το τηλέφωνό σας θα προστεθεί κατά την πρώτη σύνδεση.';

  @override
  String get devices_thisDevice => 'Αυτή η συσκευή';

  @override
  String devices_added(Object date) {
    return 'Προστέθηκε στις $date';
  }

  @override
  String get action_remove => 'Αφαίρεση';

  @override
  String get settings_title => 'Ρυθμίσεις';

  @override
  String get settings_subtitle =>
      'Οι προτιμήσεις και ο λογαριασμός σας, όλα σε ένα μέρος.';

  @override
  String get settings_appearance => 'Εμφάνιση';

  @override
  String get settings_language => 'Γλώσσα';

  @override
  String get settings_languageDescription =>
      'Η γλώσσα που επιλέξατε εφαρμόζεται επίσης στις ειδοποιήσεις VPN.';

  @override
  String get settings_account => 'Λογαριασμός';

  @override
  String get settings_signOut => 'Αποσύνδεση';

  @override
  String get settings_privacy => 'Πολιτική απορρήτου';

  @override
  String get settings_terms => 'Όροι χρήσης';

  @override
  String get settings_security => 'Ασφάλεια και διαφάνεια';

  @override
  String get settings_licenses => 'Άδειες στοιχείων';

  @override
  String get settings_licensesDetail =>
      'Λογισμικό που χρησιμοποιείται στην εφαρμογή';

  @override
  String get settings_background =>
      'Το VPN παραμένει ενεργό όταν φεύγετε από την εφαρμογή. Για να το σταματήσετε, χρησιμοποιήστε την επιλογή Αποσύνδεση στην καρτέλα Σύνδεση.';

  @override
  String get theme_system => 'Σύστημα';

  @override
  String get theme_light => 'Φωτεινό';

  @override
  String get theme_dark => 'Σκοτεινό';

  @override
  String get language_system => 'Γλώσσα τηλεφώνου';

  @override
  String get language_fr => 'Français';

  @override
  String get language_en => 'English';

  @override
  String get language_es => 'Español';

  @override
  String get language_de => 'Deutsch';

  @override
  String get dialog_removeDevice => 'Να αφαιρεθεί αυτή η συσκευή;';

  @override
  String get dialog_removeCurrent =>
      'Αυτό το τηλέφωνο θα αποσυνδεθεί από το VPN και θα χάσει την πρόσβαση. Τα δεδομένα σύνδεσης VPN θα αφαιρεθούν αφού το επιβεβαιώσει ο διακομιστής.';

  @override
  String dialog_removeOther(Object name) {
    return 'Η πρόσβαση VPN για το «$name» θα ανακληθεί. Αυτή η ενέργεια δεν μπορεί να αναιρεθεί.';
  }

  @override
  String get dialog_signOut => 'Να γίνει αποσύνδεση;';

  @override
  String get dialog_signOutMessage =>
      'Το VPN θα σταματήσει και θα χρειαστεί να συνδεθείτε ξανά. Τα κρυπτογραφημένα κλειδιά VPN σας θα παραμείνουν σε αυτό το τηλέφωνο για την επόμενη σύνδεσή σας.';

  @override
  String get action_cancel => 'Ακύρωση';

  @override
  String get action_signOut => 'Αποσύνδεση';

  @override
  String get notice_close => 'Απόρριψη μηνύματος';

  @override
  String get notice_sessionExpired_title => 'Η συνεδρία έληξε';

  @override
  String get notice_sessionExpired_message =>
      'Η συνεδρία σας έληξε. Συνδεθείτε ξανά.';

  @override
  String get notice_connectionFailed_title => 'Η σύνδεση απέτυχε';

  @override
  String get notice_invalidCredentials_message =>
      'Η διεύθυνση ηλεκτρονικού ταχυδρομείου ή ο κωδικός πρόσβασης είναι λανθασμένος.';

  @override
  String get notice_emailVerification_title =>
      'Απαιτείται επιβεβαίωση ηλεκτρονικού ταχυδρομείου';

  @override
  String get notice_emailVerification_message =>
      'Επιβεβαιώστε τη διεύθυνση ηλεκτρονικού ταχυδρομείου σας πριν προσθέσετε συσκευή VPN.';

  @override
  String get notice_rateLimited_title => 'Υπερβολικά πολλές προσπάθειες';

  @override
  String get notice_deviceLimit_title => 'Συμπληρώθηκε το όριο των 2 συσκευών';

  @override
  String get notice_deviceLimit_message =>
      'Αφαιρέστε μια υπάρχουσα συσκευή πριν προσθέσετε άλλη.';

  @override
  String get notice_identityRenewal_title =>
      'Απαιτείται ανανέωση της ταυτότητας VPN';

  @override
  String get notice_identityRenewal_message =>
      'Αυτή η ταυτότητα αφαιρέθηκε. Δημιουργήστε μια νέα τοπική ταυτότητα.';

  @override
  String get notice_migrationPending_title =>
      'Η αλλαγή τοποθεσίας βρίσκεται σε εξέλιξη';

  @override
  String get notice_migrationPending_message =>
      'Μια αλλαγή τοποθεσίας βρίσκεται ήδη σε εξέλιξη.';

  @override
  String get notice_migrationBlocked_title =>
      'Η αλλαγή τοποθεσίας αποκλείστηκε';

  @override
  String get notice_migrationBlocked_message =>
      'Η αλλαγή τοποθεσίας απαιτεί παρέμβαση στον διακομιστή. Δοκιμάστε ξανά αργότερα ή επικοινωνήστε με την υποστήριξη.';

  @override
  String get notice_targetUnavailable_title =>
      'Ο διακομιστής δεν είναι προσωρινά διαθέσιμος';

  @override
  String get notice_targetUnavailable_message =>
      'Αυτός ο διακομιστής δεν είναι προσωρινά διαθέσιμος.';

  @override
  String get notice_networkUnavailable_title =>
      'Η σύνδεση στο διαδίκτυο δεν είναι διαθέσιμη';

  @override
  String get notice_networkUnavailable_message =>
      'Ελέγξτε τη σύνδεσή σας και δοκιμάστε ξανά.';

  @override
  String get notice_permissionDenied_title => 'Η άδεια VPN απορρίφθηκε';

  @override
  String get notice_permissionDenied_message =>
      'Ξεκινήστε ξανά τη σύνδεση και αποδεχτείτε το αίτημα άδειας Android.';

  @override
  String get notice_wireguardTimeout_title =>
      'Ο διακομιστής δεν ανταποκρίνεται';

  @override
  String get notice_wireguardTimeout_message =>
      'Η σύνδεση WireGuard διήρκεσε υπερβολικά. Δοκιμάστε ξανά ή επιλέξτε άλλη τοποθεσία.';

  @override
  String get notice_tlsFailed_title => 'Η ασφαλής σύνδεση απορρίφθηκε';

  @override
  String get notice_tlsFailed_message =>
      'Ο διακομιστής δεν αποδέχτηκε τη σύνδεση OpenVPN. Δοκιμάστε ξανά. Αν το πρόβλημα συνεχιστεί, εκτελέστε διαγνωστικό έλεγχο.';

  @override
  String get notice_tunRejected_title => 'Το Android απέρριψε τη διεπαφή VPN';

  @override
  String get notice_tunRejected_message =>
      'Το Android απέρριψε τη διαμόρφωση δικτύου που ζητήθηκε από το OpenVPN.';

  @override
  String get notice_openvpnStart_title => 'Το OpenVPN δεν μπόρεσε να ξεκινήσει';

  @override
  String get notice_openvpnStart_message =>
      'Η μηχανή OpenVPN δεν μπόρεσε να ολοκληρώσει την εκκίνηση. Δοκιμάστε ξανά. Αν το πρόβλημα παραμένει, επικοινωνήστε με την υποστήριξη.';

  @override
  String notice_diagnosticCode(Object code) {
    return 'Κωδικός διαγνωστικού ελέγχου: $code';
  }

  @override
  String get notice_generic_title => 'Η σύνδεση VPN απέτυχε';

  @override
  String get notice_generic_message =>
      'Παρουσιάστηκε σφάλμα. Δοκιμάστε ξανά αργότερα.';

  @override
  String notice_controller_title(String code) {
    String _temp0 = intl.Intl.selectLogic(code, {
      'account_created_email_unavailable': 'Ο λογαριασμός δημιουργήθηκε',
      'password_reset_sent': 'Το αίτημα επαναφοράς κωδικού πρόσβασης ελήφθη',
      'verification_email_sent': 'Το μήνυμα επιβεβαίωσης στάλθηκε',
      'location_migration_pending': 'Η αλλαγή τοποθεσίας βρίσκεται σε εξέλιξη',
      'vpn_sign_in_required': 'Απαιτείται σύνδεση',
      'protocol_unavailable_at_location': 'Το πρωτόκολλο δεν είναι διαθέσιμο',
      'vpn_permission_denied': 'Η άδεια VPN απορρίφθηκε',
      'revoked_identity_device_limit': 'Συμπληρώθηκε το όριο των 2 συσκευών',
      'tunnel_start_unexpected': 'Δεν ήταν δυνατή η εκκίνηση του VPN',
      'flutter_disconnect_timeout': 'Η αποσύνδεση δεν επιβεβαιώθηκε',
      'flutter_disconnect_unexpected': 'Δεν ήταν δυνατή η αποσύνδεση',
      'device_revoked': 'Η συσκευή αφαιρέθηκε',
      'revoke_unexpected': 'Δεν ήταν δυνατή η αφαίρεση της συσκευής',
      'identity_renewal_unexpected':
          'Δεν ήταν δυνατή η ανανέωση της ταυτότητας',
      'openvpn_renewal_unexpected': 'Δεν ήταν δυνατή η ανανέωση του OpenVPN',
      'location_migration_blocked': 'Η αλλαγή τοποθεσίας αποκλείστηκε',
      'location_migration_slow':
          'Η αλλαγή τοποθεσίας βρίσκεται ακόμη σε εξέλιξη',
      'location_migration_conflict': 'Η αλλαγή τοποθεσίας χρειάζεται ανανέωση',
      'location_migration_verification_failed':
          'Η αλλαγή τοποθεσίας δεν επιβεβαιώθηκε',
      'location_migration_device_changed':
          'Η συσκευή άλλαξε κατά την αλλαγή τοποθεσίας',
      'tunnel_stop_failed': 'Η αλλαγή τοποθεσίας δεν είναι διαθέσιμη',
      'other': 'Η λειτουργία απέτυχε',
    });
    return '$_temp0';
  }

  @override
  String notice_controller_message(String code, String target) {
    String _temp0 = intl.Intl.selectLogic(code, {
      'account_created_email_unavailable':
          'Ο λογαριασμός δημιουργήθηκε, αλλά δεν ήταν δυνατή η αποστολή του μηνύματος επιβεβαίωσης. Χρησιμοποιήστε την επιλογή νέας αποστολής στην εφαρμογή.',
      'password_reset_sent':
          'Το αίτημά σας ελήφθη. Αν υπάρχει λογαριασμός με αυτή τη διεύθυνση, ενδέχεται να λάβετε μήνυμα ηλεκτρονικού ταχυδρομείου. Ελέγξτε επίσης τον φάκελο ανεπιθύμητης αλληλογραφίας.',
      'verification_email_sent': 'Μόλις στάλθηκε νέο μήνυμα επιβεβαίωσης.',
      'location_migration_pending':
          'Η μετάβαση στο $target προετοιμάζεται ακόμη. Μπορείτε να τη συνεχίσετε χωρίς να δημιουργήσετε ξανά τη συσκευή.',
      'vpn_sign_in_required':
          'Συνδεθείτε στον λογαριασμό σας πριν ξεκινήσετε το VPN.',
      'protocol_unavailable_at_location':
          'Το επιλεγμένο πρωτόκολλο δεν προσφέρεται από αυτή την τοποθεσία. Ανανεώστε τις τοποθεσίες ή επιλέξτε άλλο πρωτόκολλο.',
      'vpn_permission_denied':
          'Το Android απέρριψε την άδεια VPN. Ξεκινήστε ξανά τη σύνδεση και αποδεχτείτε το αίτημα του συστήματος.',
      'revoked_identity_device_limit':
          'Η πρόσβαση VPN αυτής της συσκευής αφαιρέθηκε και συμπληρώθηκε το όριο συσκευών. Αφαιρέστε μια συσκευή από τον Λογαριασμό → Διαχείριση των συσκευών μου.',
      'tunnel_start_unexpected':
          'Ένα απρόσμενο σφάλμα διέκοψε την προετοιμασία της σήραγγας. Ελέγξτε τον κωδικό διαγνωστικού ελέγχου και δοκιμάστε ξανά.',
      'flutter_disconnect_timeout':
          'Το Android δεν επιβεβαίωσε εγκαίρως ότι το VPN σταμάτησε. Δοκιμάστε να το σταματήσετε ξανά.',
      'flutter_disconnect_unexpected':
          'Ένα απρόσμενο σφάλμα εμπόδισε την επιβεβαίωση ότι η σήραγγα σταμάτησε.',
      'device_revoked':
          'Η πρόσβαση VPN της συσκευής ανακλήθηκε και τα τοπικά μυστικά της αφαιρέθηκαν.',
      'revoke_unexpected':
          'Δεν ήταν δυνατή η αφαίρεση της συσκευής. Ανανεώστε τη λίστα και δοκιμάστε ξανά.',
      'identity_renewal_unexpected':
          'Δεν ήταν δυνατή η δημιουργία της νέας ταυτότητας VPN. Ανανεώστε τις συσκευές και δοκιμάστε ξανά.',
      'openvpn_renewal_unexpected':
          'Δεν ήταν δυνατή η ανανέωση του προφίλ OpenVPN. Δοκιμάστε ξανά ή ελέγξτε τον κωδικό διαγνωστικού ελέγχου.',
      'location_migration_blocked':
          'Ο διακομιστής δεν μπορεί να ολοκληρώσει αυτή την αλλαγή τώρα. Η συσκευή και η τοπική της ταυτότητα διατηρήθηκαν.',
      'location_migration_slow':
          'Ο διακομιστής προετοιμάζει ακόμη τη μετάβαση στο $target. Χρησιμοποιήστε την επιλογή Συνέχιση σε λίγα λεπτά.',
      'location_migration_conflict':
          'Η κατάσταση της συσκευής άλλαξε στον διακομιστή. Ανανεώστε τις συσκευές και, στη συνέχεια, συνεχίστε την αλλαγή.',
      'location_migration_verification_failed':
          'Ο διακομιστής δεν επιβεβαίωσε τη νέα τοποθεσία. Η προηγούμενη τοπική ταυτότητα διατηρήθηκε.',
      'location_migration_device_changed':
          'Η συσκευή που επέστρεψε ο διακομιστής δεν αντιστοιχεί πλέον σε αυτή που αλλάζει. Ανανεώστε τις συσκευές πριν δοκιμάσετε ξανά.',
      'tunnel_stop_failed':
          'Η προηγούμενη σήραγγα πρέπει να σταματήσει πλήρως πριν από τη νέα σύνδεση.',
      'other':
          'Δεν ήταν δυνατή η ολοκλήρωση της λειτουργίας. Δοκιμάστε ξανά ή στείλτε τον κωδικό διαγνωστικού ελέγχου στην υποστήριξη.',
    });
    return '$_temp0';
  }

  @override
  String notice_api_title(String code) {
    String _temp0 = intl.Intl.selectLogic(code, {
      'unauthorized': 'Η συνεδρία έληξε',
      'invalid_credentials': 'Η σύνδεση απέτυχε',
      'email_verification_required':
          'Απαιτείται επιβεβαίωση ηλεκτρονικού ταχυδρομείου',
      'verification_email_cooldown': 'Το μήνυμα έχει ήδη σταλεί',
      'rate_limited': 'Υπερβολικά πολλές προσπάθειες',
      'invalid_registration': 'Οι πληροφορίες πρέπει να διορθωθούν',
      'email_exists': 'Ο λογαριασμός υπάρχει ήδη',
      'invalid_profile': 'Μη έγκυρο προφίλ',
      'invalid_device': 'Μη έγκυρη συσκευή',
      'invalid_location': 'Η τοποθεσία δεν είναι διαθέσιμη',
      'device_limit': 'Συμπληρώθηκε το όριο των 2 συσκευών',
      'device_exists': 'Η ταυτότητα VPN χρησιμοποιείται ήδη',
      'device_identity_revoked': 'Απαιτείται ανανέωση της ταυτότητας VPN',
      'device_location_locked': 'Η αλλαγή τοποθεσίας χρειάζεται ανανέωση',
      'location_migration_pending': 'Η αλλαγή τοποθεσίας βρίσκεται σε εξέλιξη',
      'location_migration_blocked': 'Η αλλαγή τοποθεσίας αποκλείστηκε',
      'target_ca_mismatch': 'Μη συμβατός διακομιστής OpenVPN',
      'location_migration_conflict': 'Η αλλαγή τοποθεσίας χρειάζεται ανανέωση',
      'server_full': 'Ο διακομιστής είναι πλήρης',
      'capacity_unavailable': 'Η τοποθεσία δεν είναι προσωρινά διαθέσιμη',
      'target_unavailable': 'Ο διακομιστής δεν είναι προσωρινά διαθέσιμος',
      'not_found': 'Το στοιχείο δεν βρέθηκε',
      'invalid_openvpn_csr': 'Μη έγκυρη ταυτότητα OpenVPN',
      'openvpn_profile_exists': 'Το προφίλ OpenVPN υπάρχει ήδη',
      'openvpn_profile_revoked': 'Το προφίλ OpenVPN ανακλήθηκε',
      'openvpn_operation_pending': 'Η λειτουργία OpenVPN βρίσκεται σε εξέλιξη',
      'openvpn_operation_terminal': 'Η λειτουργία OpenVPN διακόπηκε',
      'openvpn_address_unavailable': 'Η διεύθυνση OpenVPN δεν είναι διαθέσιμη',
      'openvpn_profile_conflict': 'Σύγκρουση OpenVPN',
      'openvpn_signer_unavailable': 'Το OpenVPN δεν είναι διαθέσιμο',
      'email_delivery_unavailable':
          'Το ηλεκτρονικό ταχυδρομείο δεν είναι διαθέσιμο',
      'invalid_token': 'Μη έγκυρος σύνδεσμος',
      'network_unavailable': 'Η σύνδεση στο διαδίκτυο δεν είναι διαθέσιμη',
      'invalid_json': 'Μη έγκυρο αίτημα',
      'invalid_api_response': 'Μη έγκυρη απάντηση διακομιστή',
      'ipv6_unavailable': 'Το IPv6 δεν είναι διαθέσιμο',
      'invalid_ip_families': 'Η διαμόρφωση δικτύου απορρίφθηκε',
      'other': 'Η υπηρεσία δεν είναι διαθέσιμη',
    });
    return '$_temp0';
  }

  @override
  String notice_api_message(String code) {
    String _temp0 = intl.Intl.selectLogic(code, {
      'unauthorized': 'Η συνεδρία σας έληξε. Συνδεθείτε ξανά.',
      'invalid_credentials':
          'Η διεύθυνση ηλεκτρονικού ταχυδρομείου ή ο κωδικός πρόσβασης είναι λανθασμένος.',
      'email_verification_required':
          'Επιβεβαιώστε τη διεύθυνση ηλεκτρονικού ταχυδρομείου σας πριν προσθέσετε συσκευή VPN.',
      'invalid_registration':
          'Ελέγξτε τις ζητούμενες πληροφορίες και τις συγκαταθέσεις.',
      'email_exists':
          'Ένας λογαριασμός χρησιμοποιεί ήδη αυτή τη διεύθυνση ηλεκτρονικού ταχυδρομείου.',
      'invalid_profile': 'Ελέγξτε τα στοιχεία του προφίλ σας.',
      'invalid_device':
          'Το όνομα ή η τοπική ταυτότητα αυτής της συσκευής δεν είναι έγκυρα.',
      'invalid_location': 'Ανανεώστε τη λίστα τοποθεσιών και δοκιμάστε ξανά.',
      'device_limit': 'Αφαιρέστε μια υπάρχουσα συσκευή πριν προσθέσετε άλλη.',
      'device_exists':
          'Αυτή η ταυτότητα VPN είναι ήδη συνδεδεμένη με άλλον λογαριασμό.',
      'device_identity_revoked':
          'Αυτή η ταυτότητα αφαιρέθηκε. Πρέπει να δημιουργηθεί νέα τοπική ταυτότητα.',
      'device_location_locked':
          'Η τοποθεσία αυτής της συσκευής μόλις άλλαξε. Η εφαρμογή θα συνεχίσει την αλλαγή που βρίσκεται σε εξέλιξη.',
      'location_migration_pending':
          'Μια αλλαγή τοποθεσίας βρίσκεται ήδη σε εξέλιξη.',
      'location_migration_blocked':
          'Η αλλαγή τοποθεσίας απαιτεί παρέμβαση στον διακομιστή. Δοκιμάστε ξανά αργότερα ή επικοινωνήστε με την υποστήριξη.',
      'target_ca_mismatch':
          'Αυτός ο διακομιστής δεν είναι ακόμη συμβατός με το τρέχον προφίλ OpenVPN.',
      'location_migration_conflict':
          'Ανανεώστε τις συσκευές και, στη συνέχεια, δοκιμάστε ξανά την αλλαγή τοποθεσίας.',
      'server_full':
          'Αυτή η τοποθεσία έφτασε το όριο συνδέσεών της. Επιλέξτε άλλη τοποθεσία ή δοκιμάστε ξανά αργότερα.',
      'capacity_unavailable':
          'Δεν μπορούμε να επιβεβαιώσουμε αν αυτή η τοποθεσία είναι διαθέσιμη τώρα. Επιλέξτε άλλη τοποθεσία ή δοκιμάστε ξανά αργότερα.',
      'target_unavailable':
          'Αυτός ο διακομιστής δεν είναι προσωρινά διαθέσιμος.',
      'not_found':
          'Αυτό το στοιχείο δεν είναι πλέον διαθέσιμο στον λογαριασμό σας.',
      'invalid_openvpn_csr':
          'Δημιουργήστε νέα ταυτότητα OpenVPN και δοκιμάστε ξανά.',
      'openvpn_profile_exists':
          'Υπάρχει ήδη προφίλ OpenVPN για αυτή τη συσκευή.',
      'openvpn_profile_revoked':
          'Ανανεώστε το προφίλ OpenVPN για να συνεχίσετε.',
      'openvpn_operation_pending':
          'Η αλλαγή εξακολουθεί να διαδίδεται. Δοκιμάστε ξανά αργότερα.',
      'openvpn_operation_terminal':
          'Δημιουργήστε νέα ταυτότητα OpenVPN και δοκιμάστε ξανά.',
      'openvpn_address_unavailable':
          'Δεν υπάρχει διαθέσιμη διεύθυνση OpenVPN αυτή τη στιγμή.',
      'openvpn_profile_conflict':
          'Το προφίλ άλλαξε. Ανανεώστε τις συσκευές και δοκιμάστε ξανά.',
      'openvpn_signer_unavailable':
          'Η υπηρεσία OpenVPN δεν είναι προσωρινά διαθέσιμη.',
      'email_delivery_unavailable':
          'Δεν ήταν δυνατή η αποστολή του μηνύματος ηλεκτρονικού ταχυδρομείου. Δοκιμάστε ξανά αργότερα.',
      'invalid_token':
          'Αυτός ο σύνδεσμος δεν είναι έγκυρος ή έχει λήξει. Ζητήστε νέο.',
      'network_unavailable':
          'Ελέγξτε τη σύνδεσή σας στο διαδίκτυο και δοκιμάστε ξανά.',
      'invalid_json':
          'Ελέγξτε τις πληροφορίες που καταχωρίσατε και δοκιμάστε ξανά.',
      'invalid_api_response':
          'Ο διακομιστής επέστρεψε απρόσμενη απάντηση. Δοκιμάστε ξανά αργότερα.',
      'ipv6_unavailable':
          'Ο διακομιστής δεν μπορεί να ενεργοποιήσει το IPv6 αυτή τη στιγμή. Δοκιμάστε ξανά αργότερα.',
      'invalid_ip_families':
          'Η διαμόρφωση της σήραγγας είναι ελλιπής ή δεν αντιστοιχεί στις εγκεκριμένες διευθύνσεις. Δοκιμάστε ξανά από την εφαρμογή.',
      'other': 'Παρουσιάστηκε σφάλμα διακομιστή. Δοκιμάστε ξανά αργότερα.',
    });
    return '$_temp0';
  }

  @override
  String get notice_retryLater => 'Δοκιμάστε ξανά σε λίγα λεπτά.';

  @override
  String notice_retryAfter(Object seconds) {
    return 'Δοκιμάστε ξανά σε $seconds δευτερόλεπτα.';
  }

  @override
  String notice_native_title(String code, String protocol) {
    String _temp0 = intl.Intl.selectLogic(code, {
      'system_vpn_resume_unavailable':
          'Η συνέχιση του VPN συστήματος δεν είναι διαθέσιμη',
      'system_vpn_resume_corrupt': 'Μη έγκυρη συνέχιση VPN συστήματος',
      'system_vpn_resume_session_invalid': 'Μη έγκυρη συνεδρία συνέχισης VPN',
      'system_vpn_resume_identity_changed': 'Η ταυτότητα VPN άλλαξε',
      'system_vpn_resume_identity_invalid': 'Μη έγκυρη ταυτότητα συνέχισης VPN',
      'system_vpn_resume_storage_failed':
          'Ο χώρος αποθήκευσης συνέχισης VPN δεν είναι διαθέσιμος',
      'system_vpn_resume_network_timeout': 'Η συνέχιση του VPN δεν έχει δίκτυο',
      'system_vpn_resume_blocked': 'Η συνέχιση του VPN αποκλείστηκε',
      'system_vpn_resume_failed': 'Η συνέχιση του VPN απέτυχε',
      'system_vpn_resume_error_invalid': 'Μη έγκυρο σφάλμα συνέχισης VPN',
      'wireguard_identity_store_failed':
          'Η ταυτότητα WireGuard δεν αποθηκεύτηκε',
      'wireguard_identity_unavailable':
          'Η ταυτότητα WireGuard δεν είναι διαθέσιμη',
      'vpn_host_destroyed': 'Ο κεντρικός υπολογιστής VPN του Android σταμάτησε',
      'vpn_host_unavailable':
          'Ο κεντρικός υπολογιστής VPN του Android δεν είναι διαθέσιμος',
      'vpn_permission_required': 'Απαιτείται άδεια VPN',
      'vpn_permission_denied': 'Η άδεια VPN απορρίφθηκε',
      'vpn_permission_request_failed': 'Δεν ήταν δυνατή η αίτηση άδειας',
      'wireguard_foreground_service_unavailable':
          'Η υπηρεσία WireGuard δεν είναι διαθέσιμη',
      'wireguard_identity_invalid': 'Μη έγκυρο τοπικό κλειδί WireGuard',
      'wireguard_identity_in_use': 'Η ταυτότητα WireGuard χρησιμοποιείται ήδη',
      'wireguard_configuration_invalid': 'Μη έγκυρη διαμόρφωση WireGuard',
      'wireguard_operation_pending': 'Η λειτουργία WireGuard παραμένει ενεργή',
      'wireguard_start_failed': 'Η εκκίνηση του WireGuard απορρίφθηκε',
      'wireguard_stop_timeout': 'Ο τερματισμός του WireGuard δεν επιβεβαιώθηκε',
      'wireguard_handshake_timeout': 'Το WireGuard δεν ανταποκρίθηκε',
      'openvpn_connection_timeout': 'Το OpenVPN δεν ανταποκρίθηκε',
      'openvpn_core_unavailable': 'Η μηχανή OpenVPN δεν είναι διαθέσιμη',
      'openvpn_operation_pending': 'Η συνεδρία OpenVPN παραμένει ενεργή',
      'openvpn_stop_timeout': 'Ο τερματισμός του OpenVPN δεν επιβεβαιώθηκε',
      'openvpn_profile_unavailable': 'Λείπει το τοπικό προφίλ OpenVPN',
      'openvpn_native_failed': 'Η εγγενής κλήση OpenVPN διακόπηκε',
      'openvpn_key_generation_failed':
          'Δεν ήταν δυνατή η δημιουργία κλειδιού OpenVPN P-256',
      'openvpn_csr_generation_failed':
          'Δεν ήταν δυνατή η δημιουργία CSR OpenVPN',
      'openvpn_identity_store_failed': 'Η ταυτότητα OpenVPN δεν αποθηκεύτηκε',
      'openvpn_identity_clear_failed':
          'Η αφαίρεση του OpenVPN δεν ολοκληρώθηκε',
      'openvpn_identity_in_use': 'Η ταυτότητα OpenVPN χρησιμοποιείται ακόμη',
      'openvpn_tls_verification_required':
          'Λείπει η επαλήθευση TLS του OpenVPN',
      'openvpn_cipher_invalid': 'Μη έγκυρος κρυπτογραφικός αλγόριθμος OpenVPN',
      'openvpn_profile_rejected': 'Το προφίλ OpenVPN απορρίφθηκε',
      'openvpn_identity_inconsistent': 'Ασυνεπής ταυτότητα OpenVPN',
      'tls_handshake_failed': 'Η διαπραγμάτευση OpenVPN απορρίφθηκε',
      'tls_alert_unknown_ca':
          'Το πιστοποιητικό πελάτη OpenVPN δεν αναγνωρίστηκε',
      'tls_alert_bad_certificate':
          'Το πιστοποιητικό πελάτη OpenVPN απορρίφθηκε',
      'tls_alert_unsupported_certificate':
          'Το πιστοποιητικό OpenVPN δεν υποστηρίζεται',
      'tls_client_certificate_required':
          'Απαιτείται πιστοποιητικό πελάτη OpenVPN',
      'tls_alert_misc': 'Ειδοποίηση TLS OpenVPN',
      'tls_signature_algorithm_rejected':
          'Η υπογραφή OpenVPN δεν υποστηρίζεται',
      'tls_handshake_rejected': 'Η διαπραγμάτευση TLS OpenVPN απορρίφθηκε',
      'tls_version_rejected': 'Μη συμβατή έκδοση TLS OpenVPN',
      'tls_certificate_expired': 'Το πιστοποιητικό TLS έληξε',
      'tls_certificate_revoked': 'Το πιστοποιητικό TLS ανακλήθηκε',
      'transport_failed': 'Ο διακομιστής OpenVPN δεν είναι προσβάσιμος',
      'tun_configuration_rejected':
          'Δεν ήταν δυνατή η δημιουργία διεπαφής OpenVPN',
      'tun_setup_failed': 'Η ρύθμιση TUN του OpenVPN απέτυχε',
      'tun_interface_create_failed': 'Η δημιουργία διεπαφής OpenVPN απέτυχε',
      'tun_interface_disabled': 'Η διεπαφή OpenVPN απενεργοποιήθηκε',
      'tun_halted': 'Η διεπαφή OpenVPN διακόπηκε',
      'tun_already_established': 'Η διεπαφή OpenVPN είναι ήδη ανοιχτή',
      'tun_addresses_missing': 'Λείπει η διεύθυνση OpenVPN',
      'tun_routes_missing': 'Λείπουν οι διαδρομές OpenVPN',
      'tun_dns_missing': 'Λείπει το DNS του OpenVPN',
      'tun_permission_revoked': 'Η άδεια VPN ανακλήθηκε',
      'tun_establish_returned_null': 'Το Android απέρριψε τη διεπαφή VPN',
      'openvpn_service_start_failed': 'Η υπηρεσία OpenVPN δεν είναι διαθέσιμη',
      'openvpn_operation_timeout': 'Η κλήση OpenVPN έληξε λόγω χρονικού ορίου',
      'openvpn_start_failed': 'Η εκκίνηση του OpenVPN απορρίφθηκε',
      'openvpn_connection_failed': 'Η σύνδεση OpenVPN διακόπηκε',
      'openvpn_core_status_error':
          'Η βασική λειτουργία OpenVPN τερματίστηκε με σφάλμα',
      'openvpn_stopped_before_connected': 'Το OpenVPN σταμάτησε πριν συνδεθεί',
      'openvpn_auth_failed': 'Η πιστοποίηση OpenVPN απορρίφθηκε',
      'openvpn_client_setup_failed': 'Η ρύθμιση πελάτη OpenVPN απέτυχε',
      'openvpn_client_halted': 'Ο πελάτης OpenVPN διακόπηκε',
      'openvpn_client_restart': 'Ζητήθηκε επανεκκίνηση του OpenVPN',
      'openvpn_inactive_timeout':
          'Το OpenVPN έμεινε ανενεργό για υπερβολικά μεγάλο διάστημα',
      'openvpn_session_expired': 'Η συνεδρία OpenVPN έληξε',
      'openvpn_credentials_required': 'Η πιστοποίηση OpenVPN δεν υποστηρίζεται',
      'openvpn_proxy_failed': 'Η ενδιάμεση μεταφορά OpenVPN απέτυχε',
      'openvpn_compression_failed': 'Η συμπίεση OpenVPN απορρίφθηκε',
      'openvpn_ntlm_crypto_unavailable':
          'Η κρυπτογράφηση NTLM του OpenVPN δεν είναι διαθέσιμη',
      'openvpn_feature_unsupported': 'Η λειτουργία OpenVPN δεν υποστηρίζεται',
      'network_unavailable': 'Η σύνδεση στο διαδίκτυο δεν είναι διαθέσιμη',
      'network_lost': 'Το δίκτυο δεν είναι διαθέσιμο',
      'certificate_validation_failed':
          'Το πιστοποιητικό διακομιστή απορρίφθηκε',
      'openvpn_certificate_expired': 'Το πιστοποιητικό OpenVPN έληξε',
      'tunnel_active_for_another_account':
          'Η σήραγγα άλλου λογαριασμού είναι ακόμη ενεργή',
      'tunnel_already_active': 'Η εγγενής σήραγγα είναι ήδη ενεργή',
      'tunnel_stop_timeout': 'Ο τερματισμός του $protocol δεν επιβεβαιώθηκε',
      'tunnel_disconnected': 'Το $protocol διακόπηκε',
      'native_bridge_unavailable': 'Η γέφυρα Android δεν είναι διαθέσιμη',
      'native_operation_failed': 'Η λειτουργία Android διακόπηκε',
      'invalid_arguments': 'Ελλιπείς παράμετροι VPN',
      'invalid_account_id': 'Μη έγκυρος λογαριασμός VPN',
      'invalid_device_id': 'Μη έγκυρο αναγνωριστικό συσκευής',
      'storage_key_not_allowed': 'Το κλειδί αποθήκευσης απορρίφθηκε',
      'secure_storage_read_failed': 'Η ασφαλής ανάγνωση απέτυχε',
      'secure_storage_write_failed': 'Η ασφαλής εγγραφή απέτυχε',
      'key_generation_failed':
          'Δεν ήταν δυνατή η δημιουργία κλειδιού WireGuard',
      'csr_generation_failed': 'Δεν ήταν δυνατή η δημιουργία CSR OpenVPN',
      'other': 'Μη ταξινομημένο εγγενές σφάλμα VPN',
    });
    return '$_temp0';
  }

  @override
  String notice_native_message(String code, String protocol) {
    String _temp0 = intl.Intl.selectLogic(code, {
      'system_vpn_resume_unavailable':
          'Το Android δεν μπορεί να βρει συνεδρία VPN που μπορεί να συνεχιστεί. Ξεκινήστε νέα σύνδεση στην εφαρμογή.',
      'system_vpn_resume_corrupt':
          'Τα αποθηκευμένα δεδομένα συνέχισης VPN δεν είναι έγκυρα και δεν θα χρησιμοποιηθούν. Ξεκινήστε νέα σύνδεση.',
      'system_vpn_resume_session_invalid':
          'Η αποθηκευμένη συνεδρία δεν μπορεί πλέον να συνεχίσει το VPN. Συνδεθείτε ξανά στην εφαρμογή.',
      'system_vpn_resume_identity_changed':
          'Η τοπική ταυτότητα VPN άλλαξε. Η συνέχιση σταμάτησε· ξεκινήστε νέα σύνδεση.',
      'system_vpn_resume_identity_invalid':
          'Η ταυτότητα για τη συνέχιση δεν είναι έγκυρη. Ξεκινήστε νέα σύνδεση.',
      'system_vpn_resume_storage_failed':
          'Το Android δεν μπόρεσε να διαβάσει ή να ενημερώσει τα κρυπτογραφημένα δεδομένα συνέχισης. Ξεκινήστε νέα σύνδεση.',
      'system_vpn_resume_network_timeout':
          'Το Android δεν βρήκε εγκαίρως δίκτυο για να συνεχίσει το VPN. Δοκιμάστε ξανά όταν υπάρχει διαθέσιμο δίκτυο.',
      'system_vpn_resume_blocked':
          'Η συνέχιση του VPN αποκλείστηκε. Ελέγξτε τις ρυθμίσεις Android και, στη συνέχεια, ξεκινήστε νέα σύνδεση.',
      'system_vpn_resume_failed':
          'Η συνέχιση του VPN στο Android απέτυχε. Ξεκινήστε νέα σύνδεση στην εφαρμογή.',
      'system_vpn_resume_error_invalid':
          'Το Android επέστρεψε μη χρησιμοποιήσιμο σφάλμα συνέχισης. Ξεκινήστε νέα σύνδεση.',
      'wireguard_identity_store_failed':
          'Το Android δεν μπόρεσε να αποθηκεύσει την κρυπτογραφημένη ταυτότητα WireGuard αυτού του λογαριασμού.',
      'wireguard_identity_unavailable':
          'Δεν υπάρχει διαθέσιμη αξιοποιήσιμη ταυτότητα WireGuard για αυτή τη σύνδεση.',
      'vpn_host_destroyed':
          'Το στοιχείο Android που φιλοξενούσε το VPN σταμάτησε. Ξεκινήστε νέα σύνδεση.',
      'vpn_host_unavailable':
          'Το Android δεν μπορεί να δημιουργήσει το στοιχείο που φιλοξενεί το VPN. Δοκιμάστε ξανά αφού ελέγξετε τις ρυθμίσεις VPN.',
      'openvpn_renewal_required':
          'Το πιστοποιητικό απαιτεί ενέργεια στην εφαρμογή πριν από τη σύνδεση.',
      'openvpn_recovery_failed':
          'Η αυτόματη ανάκτηση απέτυχε. Ξεκινήστε νέα σύνδεση στην εφαρμογή.',
      'openvpn_recovery_exhausted':
          'Η αυτόματη ανάκτηση έχει ήδη χρησιμοποιηθεί. Ξεκινήστε νέα σύνδεση στην εφαρμογή.',
      'vpn_permission_required':
          'Το Android απαιτεί νέα εξουσιοδότηση VPN πριν από την εκκίνηση της σήραγγας.',
      'vpn_permission_denied':
          'Επιτρέψτε το FuzeVPN στο αίτημα Android για να συνεχίσετε.',
      'vpn_permission_request_failed':
          'Το Android δεν μπόρεσε να ανοίξει την οθόνη άδειας VPN.',
      'wireguard_foreground_service_unavailable':
          'Το Android δεν μπόρεσε να διατηρήσει την υπηρεσία WireGuard στο προσκήνιο.',
      'wireguard_identity_invalid':
          'Το κρυπτογραφημένο κλειδί WireGuard αυτού του λογαριασμού δεν είναι αναγνώσιμο ή έγκυρο.',
      'wireguard_identity_in_use':
          'Μια άλλη λειτουργία χρησιμοποιεί ακόμη το κλειδί WireGuard αυτού του λογαριασμού.',
      'wireguard_configuration_invalid':
          'Η ληφθείσα διεύθυνση WireGuard, το DNS, το κλειδί διακομιστή ή οι διαδρομές δεν είναι έγκυρα.',
      'wireguard_operation_pending':
          'Η προηγούμενη λειτουργία WireGuard δεν έχει ακόμη απελευθερώσει την εγγενή υπηρεσία.',
      'wireguard_start_failed':
          'Η μηχανή WireGuard απέρριψε την ενεργοποίηση της διαμόρφωσης.',
      'wireguard_stop_timeout':
          'Η υπηρεσία WireGuard δεν επιβεβαίωσε την απελευθέρωση της διεπαφής VPN εντός του χρονικού ορίου.',
      'wireguard_handshake_timeout':
          'Η σήραγγα δεν επιβεβαίωσε εγκαίρως χειραψία με τον διακομιστή.',
      'openvpn_connection_timeout':
          'Το OpenVPN δεν επιβεβαίωσε εγκαίρως τη σύνδεση με τον διακομιστή.',
      'openvpn_core_unavailable':
          'Αυτή η έκδοση της εφαρμογής δεν περιέχει αξιοποιήσιμη μηχανή OpenVPN.',
      'openvpn_operation_pending':
          'Η εγγενής μηχανή διατηρεί ακόμη την προηγούμενη συνεδρία OpenVPN και αρνείται να δημιουργήσει δεύτερη.',
      'openvpn_stop_timeout':
          'Το OpenVPN Core δεν επιβεβαίωσε ότι η εγγενής συνεδρία του σταμάτησε και καταστράφηκε εντός του χρονικού ορίου.',
      'openvpn_profile_unavailable':
          'Δεν είναι δυνατή η ανάγνωση επικυρωμένου προφίλ OpenVPN για αυτή τη σύνδεση.',
      'openvpn_native_failed':
          'Σφάλμα της εφαρμογής διέκοψε το OpenVPN. Δοκιμάστε να συνδεθείτε ξανά. Αν το πρόβλημα συνεχιστεί, εκτελέστε διαγνωστικό έλεγχο.',
      'openvpn_key_generation_failed':
          'Το Android Keystore δεν μπόρεσε να δημιουργήσει ή να διαβάσει το μη εξαγώγιμο ιδιωτικό κλειδί P-256.',
      'openvpn_csr_generation_failed':
          'Το κλειδί Android Keystore δεν μπόρεσε να υπογράψει το αίτημα πιστοποιητικού OpenVPN.',
      'openvpn_identity_store_failed':
          'Δεν ήταν δυνατή η αποθήκευση του πιστοποιητικού ή του προφίλ OpenVPN σε κρυπτογραφημένο χώρο αποθήκευσης.',
      'openvpn_identity_clear_failed':
          'Το Android δεν μπόρεσε να αφαιρέσει ολόκληρη την τοπική ταυτότητα OpenVPN αυτού του λογαριασμού.',
      'openvpn_identity_in_use':
          'Μια εγγενής συνεδρία OpenVPN χρησιμοποιεί ακόμη το κλειδί ή το πιστοποιητικό αυτής της συσκευής.',
      'openvpn_tls_verification_required':
          'Το προφίλ δεν απαιτεί ρητά επαλήθευση πιστοποιητικού διακομιστή.',
      'openvpn_cipher_invalid':
          'Ο διακομιστής παρέχει αλγόριθμο κρυπτογράφησης που δεν περιλαμβάνεται στη λίστα επιτρεπόμενων.',
      'openvpn_profile_rejected':
          'Το προφίλ που ελήφθη από τον διακομιστή δεν είναι συμβατό. Δημιουργήστε ξανά αυτή τη συσκευή και δοκιμάστε ξανά.',
      'openvpn_identity_inconsistent':
          'Το πιστοποιητικό δεν αντιστοιχεί στην ασφαλή ταυτότητα αυτού του τηλεφώνου. Κανένα τοπικό προφίλ δεν αντικαταστάθηκε.',
      'tls_handshake_failed':
          'Ο διακομιστής απέρριψε τη διαπραγμάτευση TLS. Δημιουργήστε ξανά το προφίλ αν το πρόβλημα συνεχιστεί.',
      'tls_alert_unknown_ca':
          'Ο διακομιστής δεν αναγνωρίζει την αρχή έκδοσης του πιστοποιητικού αυτής της συσκευής. Πρέπει να ελεγχθεί ο διακομιστής OpenVPN.',
      'tls_alert_bad_certificate':
          'Ο διακομιστής απέρριψε το πιστοποιητικό αυτής της συσκευής. Δημιουργήστε ξανά τη συσκευή πριν δοκιμάσετε ξανά.',
      'tls_alert_unsupported_certificate':
          'Ο διακομιστής δεν υποστηρίζει τον ασφαλή τύπο πιστοποιητικού που χρησιμοποιεί το Android.',
      'tls_client_certificate_required':
          'Ο διακομιστής απαιτεί πιστοποιητικό πελάτη, αλλά το OpenVPN Core δεν μπόρεσε να παρουσιάσει κάποιο.',
      'tls_alert_misc':
          'Ο διακομιστής επέστρεψε ειδοποίηση TLS εκτός των κατηγοριών πιστοποιητικού και έκδοσης.',
      'tls_signature_algorithm_rejected':
          'Ο διακομιστής απέρριψε τον αλγόριθμο ECDSA P-256 του κλειδιού Android Keystore.',
      'tls_handshake_rejected':
          'Ο διακομιστής διέκοψε τη διαπραγμάτευση TLS πριν από τη σύνδεση.',
      'tls_version_rejected':
          'Ο πελάτης και ο διακομιστής δεν βρήκαν κοινή έκδοση TLS.',
      'tls_certificate_expired':
          'Το πιστοποιητικό που παρουσιάστηκε κατά τη σύνδεση έχει λήξει.',
      'tls_certificate_revoked':
          'Το πιστοποιητικό που παρουσιάστηκε κατά τη σύνδεση έχει ανακληθεί.',
      'transport_failed':
          'Ο διακομιστής OpenVPN δεν ανταποκρίνεται στο τρέχον δίκτυο. Δοκιμάστε ξανά σύντομα.',
      'tun_configuration_rejected':
          'Το Android απέρριψε τη διαμόρφωση δικτύου που ζητήθηκε από το OpenVPN.',
      'tun_setup_failed':
          'Το OpenVPN Core απέρριψε το σχέδιο δικτύου πριν δημιουργήσει τη διεπαφή Android.',
      'tun_interface_create_failed':
          'Το OpenVPN Core δεν μπόρεσε να λάβει τη διεπαφή TUN από το Android VpnService.',
      'tun_interface_disabled':
          'Το Android ή το OpenVPN Core απενεργοποίησε τη διεπαφή TUN κατά τη σύνδεση.',
      'tun_halted': 'Το OpenVPN Core έλαβε αίτημα διακοπής της διεπαφής TUN.',
      'tun_already_established':
          'Το OpenVPN ζήτησε δεύτερη διεπαφή στην ίδια σύνδεση. Η σήραγγα σταμάτησε για λόγους ασφαλείας.',
      'tun_addresses_missing':
          'Ο διακομιστής δεν παρείχε αξιοποιήσιμη διεύθυνση σήραγγας.',
      'tun_routes_missing':
          'Ο διακομιστής δεν παρείχε αξιοποιήσιμες διαδρομές σήραγγας.',
      'tun_dns_missing':
          'Ο διακομιστής δεν παρείχε αξιοποιήσιμο διακομιστή DNS.',
      'tun_permission_revoked':
          'Το Android ανακάλεσε την άδεια VPN κατά τη σύνδεση.',
      'tun_establish_returned_null':
          'Το Android δεν δημιούργησε τη διεπαφή, συνήθως επειδή ένα άλλο VPN είναι ακόμη ενεργό.',
      'openvpn_service_start_failed':
          'Το Android δεν μπόρεσε να ξεκινήσει την υπηρεσία OpenVPN στο προσκήνιο.',
      'openvpn_operation_timeout':
          'Μια κλήση JNI στο OpenVPN Core ξεπέρασε τη μέγιστη διάρκειά της.',
      'openvpn_start_failed':
          'Η υπηρεσία Android είναι έτοιμη, αλλά το OpenVPN Core δεν αποδέχτηκε την εκκίνηση του προφίλ.',
      'openvpn_connection_failed':
          'Το OpenVPN Core σταμάτησε πριν εκπέμψει το συμβάν CONNECTED.',
      'openvpn_core_status_error':
          'Ο εγγενής βρόχος OpenVPN τερματίστηκε με σφάλμα και χωρίς πιο συγκεκριμένο τελικό συμβάν.',
      'openvpn_stopped_before_connected':
          'Ο εγγενής βρόχος OpenVPN σταμάτησε πριν από το CONNECTED, χωρίς ρητό σφάλμα του Core.',
      'openvpn_auth_failed':
          'Ο διακομιστής OpenVPN απέρριψε την πιστοποίηση του προφίλ.',
      'openvpn_client_setup_failed':
          'Το OpenVPN Core δεν μπόρεσε να αρχικοποιήσει τον πελάτη πριν από τη σύνδεση δικτύου.',
      'openvpn_client_halted':
          'Το OpenVPN Core έλαβε εντολή οριστικής διακοπής του πελάτη.',
      'openvpn_client_restart':
          'Το OpenVPN Core ζήτησε επανεκκίνηση της συνεδρίας μεταφοράς.',
      'openvpn_inactive_timeout':
          'Το OpenVPN Core έκλεισε τη συνεδρία μετά τη λήξη του χρονικού ορίου αδράνειας.',
      'openvpn_session_expired':
          'Ο διακομιστής ανέφερε ότι η συνεδρία OpenVPN έληξε.',
      'openvpn_credentials_required':
          'Ο διακομιστής ή ένας διακομιστής μεσολάβησης ζητά διαδραστικά διαπιστευτήρια που δεν περιλαμβάνονται σε αυτό το προφίλ πιστοποιητικού.',
      'openvpn_proxy_failed':
          'Το OpenVPN Core ανέφερε αποτυχία του διαμορφωμένου διακομιστή μεσολάβησης ή αναμεταδότη.',
      'openvpn_compression_failed':
          'Το OpenVPN Core απέρριψε τη λειτουργία συμπίεσης που ανακοινώθηκε από το προφίλ ή τον διακομιστή.',
      'openvpn_ntlm_crypto_unavailable':
          'Το προφίλ ζητά κρυπτογράφηση NTLM, η οποία δεν είναι διαθέσιμη σε αυτή την έκδοση.',
      'openvpn_feature_unsupported':
          'Το προφίλ ή ο διακομιστής απαιτεί λειτουργία που λείπει από αυτόν τον πελάτη Android.',
      'network_unavailable':
          'Δεν υπάρχει διαθέσιμο αξιοποιήσιμο φυσικό δίκτυο.',
      'network_lost': 'Η σήραγγα διακόπηκε μετά την απώλεια του δικτύου.',
      'certificate_validation_failed':
          'Δεν ήταν δυνατή η επαλήθευση της ταυτότητας του διακομιστή OpenVPN.',
      'openvpn_certificate_expired':
          'Ανανεώστε το προφίλ OpenVPN πριν επανασυνδεθείτε.',
      'tunnel_active_for_another_account':
          'Μια σήραγγα που ανήκει σε άλλον λογαριασμό πρέπει να σταματήσει πριν από αυτή τη σύνδεση.',
      'tunnel_already_active':
          'Το Android αναφέρει ότι μια προηγούμενη συνεδρία VPN εξακολουθεί να χρησιμοποιεί τη διεπαφή.',
      'tunnel_stop_timeout':
          'Η μηχανή $protocol δεν επιβεβαίωσε την αποδέσμευση της διεπαφής VPN εντός του χρονικού ορίου.',
      'tunnel_disconnected':
          'Η εγγενής μηχανή ανέφερε ότι η σήραγγα τερματίστηκε απροσδόκητα μετά την εκκίνηση.',
      'native_bridge_unavailable':
          'Η εφαρμογή δεν μπορεί να αποκτήσει πρόσβαση στην υπηρεσία VPN του Android. Κλείστε και ανοίξτε ξανά την εφαρμογή και, στη συνέχεια, δοκιμάστε ξανά.',
      'native_operation_failed':
          'Ένα σφάλμα της εφαρμογής διέκοψε τη λειτουργία VPN. Δοκιμάστε ξανά. Αν το πρόβλημα συνεχιστεί, εκτελέστε διαγνωστικό έλεγχο.',
      'invalid_arguments':
          'Οι πληροφορίες που απαιτούνται για αυτή τη λειτουργία VPN είναι ελλιπείς. Δοκιμάστε ξανά. Αν το πρόβλημα συνεχιστεί, εκτελέστε διαγνωστικό έλεγχο.',
      'invalid_account_id':
          'Η εγγενής λειτουργία δεν σχετίζεται με έγκυρο αναγνωριστικό λογαριασμού.',
      'invalid_device_id':
          'Το αναγνωριστικό συσκευής που στάλθηκε στην εγγενή μηχανή λείπει ή δεν είναι έγκυρο.',
      'storage_key_not_allowed':
          'Η γέφυρα Android απέκλεισε ένα κλειδί εκτός της επιτρεπόμενης λίστας αποθήκευσης.',
      'secure_storage_read_failed':
          'Το Android Keystore δεν μπόρεσε να αποκρυπτογραφήσει τα τοπικά δεδομένα αυτού του λογαριασμού.',
      'secure_storage_write_failed':
          'Το Android Keystore δεν μπόρεσε να κρυπτογραφήσει ή να αποθηκεύσει τα τοπικά δεδομένα.',
      'key_generation_failed':
          'Το Android δεν μπόρεσε να δημιουργήσει ή να διαβάσει το κλειδί WireGuard από την ασφαλή αποθήκευση.',
      'csr_generation_failed':
          'Το Android Keystore δεν μπόρεσε να δημιουργήσει ή να υπογράψει το CSR OpenVPN P-256.',
      'other':
          'Απέτυχε ένας μη τεκμηριωμένος εγγενής κλάδος. Στείλτε στην υποστήριξη τον διαγνωστικό κωδικό που εμφανίζεται παρακάτω.',
    });
    return '$_temp0';
  }

  @override
  String get notice_permissionRequestInProgress_title =>
      'Το αίτημα άδειας είναι ήδη ανοιχτό';

  @override
  String get notice_permissionRequestInProgress_message =>
      'Το αίτημα άδειας VPN του Android εμφανίζεται ήδη. Ολοκληρώστε το πριν δοκιμάσετε ξανά.';

  @override
  String get notice_permissionRequestInterrupted_title =>
      'Το αίτημα άδειας VPN διακόπηκε';

  @override
  String get notice_permissionRequestInterrupted_message =>
      'Η οθόνη άδειας VPN έκλεισε πριν λάβει απάντηση η εφαρμογή.';

  @override
  String get notice_openvpnProofMissing_title =>
      'Η σύνδεση OpenVPN δεν επιβεβαιώθηκε';

  @override
  String get notice_openvpnProofMissing_message =>
      'Η σύνδεση OpenVPN δεν ήταν δυνατό να επιβεβαιωθεί. Σταμάτησε για λόγους ασφαλείας. Δοκιμάστε ξανά.';

  @override
  String get openvpnCleanup_title => 'Το προφίλ OpenVPN ανακλήθηκε';

  @override
  String get openvpnCleanup_working =>
      'Διακοπή και αφαίρεση του ανακληθέντος προφίλ OpenVPN…';

  @override
  String get openvpnCleanup_stopFailed =>
      'Ο τερματισμός του OpenVPN δεν έχει επιβεβαιωθεί. Δοκιμάστε ξανά πριν δημιουργήσετε νέο προφίλ.';

  @override
  String get openvpnCleanup_cleanupFailed =>
      'Το ανακληθέν προφίλ OpenVPN δεν ήταν δυνατό να αφαιρεθεί πλήρως. Δοκιμάστε ξανά την εκκαθάριση.';

  @override
  String get openvpnCleanup_complete =>
      'Το ανακληθέν προφίλ OpenVPN αφαιρέθηκε. Πατήστε Σύνδεση για να δημιουργήσετε νέο.';

  @override
  String get network_title => 'Διαμόρφωση δικτύου';

  @override
  String get network_ipv4Fallback =>
      'Το IPv6 δεν είναι προσωρινά διαθέσιμο. Η προετοιμασία συνεχίζεται με IPv4.';

  @override
  String get network_rejectedTitle => 'Η διαμόρφωση δικτύου απορρίφθηκε';

  @override
  String get network_rejectedMessage =>
      'Η διαμόρφωση της σήραγγας είναι ελλιπής ή δεν αντιστοιχεί στις εγκεκριμένες διευθύνσεις. Δοκιμάστε ξανά από την εφαρμογή.';

  @override
  String get network_unreadableTitle =>
      'Η τοπική διαμόρφωση δεν είναι αναγνώσιμη';

  @override
  String get network_unreadableMessage =>
      'Η αποθηκευμένη διαμόρφωση δικτύου OpenVPN δεν μπορεί να χρησιμοποιηθεί. Συνδεθείτε ξανά από την εφαρμογή για να την ενημερώσετε.';

  @override
  String get network_ipv4 => 'IPv4';

  @override
  String get network_dualStack => 'IPv4 + IPv6';

  @override
  String get protection_title => 'Προστασία δικτύου';

  @override
  String get protection_subtitle =>
      'Αποκλεισμός άμεσης πρόσβασης στο διαδίκτυο αν αποσυνδεθεί το VPN.';

  @override
  String get protection_active => 'Η προστασία συστήματος είναι ενεργή';

  @override
  String get protection_alwaysOnOnly =>
      'Το VPN σε μόνιμη λειτουργία είναι ενεργοποιημένο· ενεργοποιήστε τον αποκλεισμό εκτός VPN';

  @override
  String get protection_inactive => 'Η προστασία συστήματος είναι ανενεργή';

  @override
  String get protection_unknown => 'Έλεγχος προστασίας συστήματος';

  @override
  String get protection_openSettings => 'Άνοιγμα ρυθμίσεων Android';

  @override
  String get protection_dialogTitle => 'Ρύθμιση προστασίας δικτύου';

  @override
  String get protection_dialogMessage =>
      'Το Android διαχειρίζεται το VPN σε μόνιμη λειτουργία και τον αποκλεισμό συνδέσεων εκτός VPN. Ελέγξτε ότι έχει επιλεγεί το FuzeVPN και ενεργοποιήστε τον αποκλεισμό στις ρυθμίσεις συστήματος.';

  @override
  String get protection_dialogOpen => 'Άνοιγμα ρυθμίσεων';

  @override
  String get session_systemProtectionNote =>
      'Αν το Android εξακολουθεί να αποκλείει την κίνηση εκτός VPN, ανοίξτε τις ρυθμίσεις συστήματος για να ελέγξετε ή να αλλάξετε αυτή την προστασία.';

  @override
  String get diagnostics_title => 'Διαγνωστικοί έλεγχοι';

  @override
  String get diagnostics_settingsTitle => 'Διαγνωστικοί έλεγχοι εφαρμογής';

  @override
  String get diagnostics_automaticTitle => 'Αποστολή σημαντικών σφαλμάτων';

  @override
  String get diagnostics_automaticDescription =>
      'Κοινή χρήση μιας σύντομης τεχνικής αναφοράς όταν προκύπτει σημαντικό σφάλμα.';

  @override
  String get diagnostics_privacy =>
      'Οι αναφορές που αποστέλλονται συνδέονται με τον συνδεδεμένο λογαριασμό και διατηρούνται για 30 ημέρες. Δεν περιέχουν ιστορικό περιήγησης, κωδικούς πρόσβασης ή κλειδιά VPN.';

  @override
  String get diagnostics_manualOpen => 'Εκτέλεση διαγνωστικού ελέγχου';

  @override
  String get diagnostics_localDescription =>
      'Δημιουργία αναφοράς για την εφαρμογή και την κατάσταση του VPN. Η σύνδεσή σας παραμένει αμετάβλητη.';

  @override
  String get diagnostics_sendReport => 'Αποστολή αναφοράς';

  @override
  String get diagnostics_sendHint =>
      'Αφήστε αυτό το πλαίσιο μη επιλεγμένο για να διατηρήσετε την αναφορά σε αυτή τη συσκευή.';

  @override
  String get diagnostics_signedOut =>
      'Συνδεθείτε στον λογαριασμό σας για να στείλετε αναφορά.';

  @override
  String get diagnostics_localLifetime =>
      'Αποθηκεύστε αυτή την αναφορά στο τηλέφωνό σας για να τη διατηρήσετε μετά το κλείσιμο της εφαρμογής.';

  @override
  String get diagnostics_run => 'Εκτέλεση διαγνωστικού ελέγχου';

  @override
  String get diagnostics_rerun => 'Εκτέλεση διαγνωστικού ελέγχου ξανά';

  @override
  String get diagnostics_running => 'Έλεγχος…';

  @override
  String get diagnostics_sending => 'Αποστολή αναφοράς…';

  @override
  String get diagnostics_prepared =>
      'Η αναφορά είναι έτοιμη σε αυτή τη συσκευή';

  @override
  String get diagnostics_queued => 'Η αναφορά αναμένει αποστολή';

  @override
  String get diagnostics_sent => 'Η αναφορά ελήφθη';

  @override
  String get diagnostics_failed =>
      'Η αποστολή απέτυχε. Η τοπική αναφορά σας είναι ακόμη διαθέσιμη.';

  @override
  String get diagnostics_preparationFailed =>
      'Η διαγνωστική αναφορά δεν ήταν δυνατό να προετοιμαστεί. Δοκιμάστε ξανά.';

  @override
  String get diagnostics_authenticationRequired =>
      'Συνδεθείτε ξανά για να στείλετε την αναφορά.';

  @override
  String get diagnostics_retry => 'Δοκιμή αποστολής ξανά';

  @override
  String get diagnostics_export => 'Αποθήκευση αναφοράς';

  @override
  String get diagnostics_exportFailed =>
      'Η εξαγωγή απέτυχε. Δοκιμάστε ξανά από την τοπική αναφορά.';

  @override
  String get diagnostics_preferenceFailed =>
      'Δεν ήταν δυνατή η αποθήκευση αυτής της ρύθμισης. Δοκιμάστε ξανά.';

  @override
  String diagnostics_receipt(Object id) {
    return 'Αναγνωριστικό: $id';
  }

  @override
  String diagnostics_received(Object date) {
    return 'Ελήφθη στις $date';
  }

  @override
  String diagnostics_expires(Object date) {
    return 'Διατηρείται έως τις $date';
  }

  @override
  String get diagnostics_duplicate => 'Αυτή η αναφορά είχε ήδη ληφθεί.';

  @override
  String get diagnostics_preview => 'Προεπισκόπηση αναφοράς';

  @override
  String diagnostics_eventCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count τεχνικά συμβάντα επισυνάφθηκαν',
      one: '$count τεχνικό συμβάν επισυνάφθηκε',
      zero: 'Δεν επισυνάφθηκαν τεχνικά συμβάντα',
    );
    return '$_temp0';
  }

  @override
  String get diagnostics_technical => 'Τεχνικές λεπτομέρειες';

  @override
  String get diagnostics_empty =>
      'Δεν έχει προετοιμαστεί ακόμη διαγνωστική αναφορά.';

  @override
  String diagnostics_checkName(String id) {
    String _temp0 = intl.Intl.selectLogic(id, {
      'tunnel_connection': 'Κατάσταση σήραγγας',
      'handshake': 'Επιβεβαίωση σύνδεσης',
      'certificate': 'Πιστοποιητικό VPN',
      'kill_switch': 'Προστασία Android',
      'connectivity': 'Διαθέσιμο δίκτυο',
      'api_reachability': 'Πρόσβαση στην υπηρεσία',
      'secure_storage': 'Ασφαλής αποθήκευση',
      'other': 'Τοπικός έλεγχος',
    });
    return '$_temp0';
  }

  @override
  String diagnostics_checkResult(String result) {
    String _temp0 = intl.Intl.selectLogic(result, {
      'passed': 'Ελέγχθηκε',
      'failed': 'Χρειάζεται προσοχή',
      'skipped': 'Δεν ελέγχθηκε — δεν υπάρχει ενεργός έλεγχος',
      'unknown': 'Οι πληροφορίες δεν είναι διαθέσιμες',
      'other': 'Οι πληροφορίες δεν είναι διαθέσιμες',
    });
    return '$_temp0';
  }

  @override
  String get auth_welcome => 'Καλώς ήρθατε στο FuzeVPN';

  @override
  String get connection_changeLocation => 'Αλλαγή τοποθεσίας';

  @override
  String get connection_details => 'Λεπτομέρειες σύνδεσης';

  @override
  String get locations_searchLabel => 'Αναζήτηση πόλης ή χώρας';

  @override
  String get locations_clearSearch => 'Εκκαθάριση αναζήτησης';

  @override
  String get locations_filterAll => 'Όλες';

  @override
  String get locations_filterFavorites => 'Αγαπημένες';

  @override
  String locations_results(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count τοποθεσίες',
      one: '$count τοποθεσία',
    );
    return '$_temp0';
  }

  @override
  String get locations_noResults => 'Δεν βρέθηκαν τοποθεσίες';

  @override
  String get locations_noResultsHint => 'Δοκιμάστε άλλη πόλη ή χώρα.';

  @override
  String get locations_noFavorites => 'Οι αγαπημένες σας, πάντα κοντά σας';

  @override
  String get locations_noFavoritesHint =>
      'Πατήστε το αστέρι δίπλα σε μια τοποθεσία για να την αποθηκεύσετε εδώ.';

  @override
  String get locations_showAll => 'Προβολή όλων των τοποθεσιών';

  @override
  String locations_addFavorite(String name) {
    return 'Προσθήκη του $name στις αγαπημένες';
  }

  @override
  String locations_removeFavorite(String name) {
    return 'Αφαίρεση του $name από τις αγαπημένες';
  }

  @override
  String get locations_favoriteSaveFailed =>
      'Δεν ήταν δυνατή η αποθήκευση της αγαπημένης. Δοκιμάστε ξανά.';

  @override
  String get locations_emptyTitle => 'Δεν υπάρχουν διαθέσιμες τοποθεσίες';

  @override
  String get locations_emptyHint =>
      'Ανανεώστε τη λίστα για να δοκιμάσετε ξανά.';

  @override
  String get devices_manage => 'Διαχείριση των συσκευών μου';

  @override
  String get settings_personalization => 'Κάντε το δικό σας';

  @override
  String get settings_safety => 'Προστασία';

  @override
  String get settings_help => 'Χρειάζεστε βοήθεια;';

  @override
  String get settings_about => 'Σχετικά με το FuzeVPN';

  @override
  String get diagnostics_heading => 'Κατανόηση προβλήματος σύνδεσης';

  @override
  String devices_profileStatus(String status) {
    String _temp0 = intl.Intl.selectLogic(status, {
      'active': 'Διαθέσιμο',
      'pending': 'Προετοιμασία',
      'revoked': 'Αφαιρέθηκε',
      'expired': 'Έληξε',
      'other': 'Η κατάσταση δεν είναι διαθέσιμη',
    });
    return '$_temp0';
  }

  @override
  String get notice_preferenceSave_title => 'Η προτίμηση δεν αποθηκεύτηκε';

  @override
  String get notice_preferenceSave_message =>
      'Η επιλογή σας εφαρμόστηκε προς το παρόν, αλλά δεν ήταν δυνατή η αποθήκευσή της. Δοκιμάστε ξανά για να διατηρηθεί μετά το κλείσιμο της εφαρμογής.';

  @override
  String get connection_androidDisconnectHint =>
      'Αν το Android διατηρεί ενεργό το VPN, απενεργοποιήστε το VPN σε μόνιμη λειτουργία από τις ρυθμίσεις που ανοίγουν.';

  @override
  String get protection_learnMore => 'Μάθετε για την προστασία Android';

  @override
  String get protection_guideWhy =>
      'Αυτή η προστασία εμποδίζει τις εφαρμογές να χρησιμοποιούν απευθείας το διαδίκτυο αν αποσυνδεθεί το VPN. Διαμορφώνεται στο Android.';

  @override
  String get protection_guideAlwaysOnTitle => 'VPN σε μόνιμη λειτουργία';

  @override
  String get protection_guideAlwaysOn =>
      'Το Android διατηρεί ενεργή την υπηρεσία VPN και μπορεί να την επανεκκινήσει μετά την επανεκκίνηση του τηλεφώνου.';

  @override
  String get protection_guideBlockTitle => 'Αποκλεισμός συνδέσεων χωρίς VPN';

  @override
  String get protection_guideBlock =>
      'Αυτή η ρύθμιση εμποδίζει την παράκαμψη του VPN από την κίνηση, ακόμη και όσο η σύνδεση έχει διακοπεί.';

  @override
  String get protection_guideWarning =>
      'Με ενεργοποιημένο αυτόν τον αποκλεισμό, η πρόσβαση στο διαδίκτυο παραμένει απενεργοποιημένη μέχρι να συνδεθεί το VPN.';

  @override
  String get protection_guideStepsTitle => 'Ενεργοποίηση προστασίας';

  @override
  String get protection_guideStep1 =>
      'Ανοίξτε τις ρυθμίσεις VPN του Android με το παρακάτω κουμπί.';

  @override
  String get protection_guideStep2 =>
      'Ανοίξτε τις επιλογές χρησιμοποιώντας το εικονίδιο γραναζιού δίπλα στο FuzeVPN.';

  @override
  String get protection_guideStep3 =>
      'Ενεργοποιήστε το VPN σε μόνιμη λειτουργία και, στη συνέχεια, τον αποκλεισμό συνδέσεων χωρίς VPN, αν αυτές οι επιλογές είναι διαθέσιμες.';

  @override
  String get protection_guideManufacturers =>
      'Οι ονομασίες διαφέρουν ανά τηλέφωνο. Αν χρειάζεται, αναζητήστε το VPN στις Ρυθμίσεις, συνήθως στην ενότητα Δίκτυο και διαδίκτυο.';

  @override
  String get protection_guideDisableTitle =>
      'Απενεργοποίηση αυτής της προστασίας';

  @override
  String get protection_guideDisable =>
      'Στις ίδιες ρυθμίσεις, απενεργοποιήστε τον αποκλεισμό χωρίς VPN για να επιτρέψετε την πρόσβαση στο διαδίκτυο χωρίς το VPN. Απενεργοποιήστε επίσης το VPN σε μόνιμη λειτουργία αν δεν θέλετε πλέον το Android να το επανεκκινεί.';

  @override
  String get protection_guideManual =>
      'Εσείς επιλέγετε αυτές τις ρυθμίσεις στο Android. Το FuzeVPN δεν τις αλλάζει για εσάς.';

  @override
  String get locations_changeTitle => 'Αλλαγή τοποθεσίας;';

  @override
  String locations_changeActive(String name) {
    return 'Το VPN θα αποσυνδεθεί και, στη συνέχεια, θα προσπαθήσει να συνδεθεί στο $name.';
  }

  @override
  String locations_changeIdle(String name) {
    return 'Το VPN θα προσπαθήσει να συνδεθεί στο $name.';
  }

  @override
  String get locations_confirmChange => 'Αλλαγή και σύνδεση';

  @override
  String get locations_changeBusy =>
      'Μια αλλαγή βρίσκεται σε εξέλιξη. Περιμένετε πριν επιλέξετε άλλη τοποθεσία.';

  @override
  String get locations_automaticSelection => 'Αυτόματη επιλογή';

  @override
  String get locations_cities => 'Πόλεις';

  @override
  String get locations_servers => 'Διακομιστές';

  @override
  String locations_viewCities(String name) {
    return 'Προβολή πόλεων στο $name';
  }

  @override
  String locations_viewServers(String name) {
    return 'Προβολή διακομιστών στο $name';
  }

  @override
  String locations_countryCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count χώρες',
      one: '$count χώρα',
    );
    return '$_temp0';
  }

  @override
  String locations_cityCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count πόλεις',
      one: '$count πόλη',
    );
    return '$_temp0';
  }

  @override
  String locations_serverCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count διακομιστές',
      one: '$count διακομιστής',
    );
    return '$_temp0';
  }

  @override
  String get locations_allCountries => 'Όλες οι χώρες';

  @override
  String get locations_backToCountries => 'Επιστροφή στις χώρες';

  @override
  String locations_backToCities(String name) {
    return 'Επιστροφή στις πόλεις του $name';
  }

  @override
  String locations_chooseCountry(String name) {
    return 'Επιλογή του $name';
  }

  @override
  String locations_chooseCity(String name) {
    return 'Επιλογή του $name';
  }

  @override
  String get locations_noCompatibleServer =>
      'Δεν υπάρχει διαθέσιμος συμβατός διακομιστής.';

  @override
  String get externalLink_failed =>
      'Δεν ήταν δυνατό το άνοιγμα του συνδέσμου. Μπορείτε να τον αντιγράψετε και να τον ανοίξετε στο πρόγραμμα περιήγησης.';

  @override
  String get externalLink_copy => 'Αντιγραφή συνδέσμου';

  @override
  String get externalLink_copied => 'Ο σύνδεσμος αντιγράφηκε';

  @override
  String get externalLink_copyFailed =>
      'Δεν ήταν δυνατή η αντιγραφή του συνδέσμου. Επιλέξτε τη διεύθυνση παρακάτω.';

  @override
  String get settings_deleteAccount => 'Διαγραφή του λογαριασμού μου';

  @override
  String get settings_deleteAccountDetail =>
      'Δείτε πώς να ζητήσετε διαγραφή λογαριασμού';

  @override
  String get billing_title => 'Fuze Premium';

  @override
  String get billing_subtitle => 'Επιλέξτε τη συνδρομή VPN σας.';

  @override
  String get billing_subscribe => 'Εγγραφή';

  @override
  String get billing_choosePlan => 'Επιλέξτε ένα πρόγραμμα για να συνεχίσετε.';

  @override
  String get billing_monthly => 'Μηνιαίο';

  @override
  String get billing_yearly => 'Ετήσιο';

  @override
  String get billing_continue => 'Συνέχεια με το Google Play';

  @override
  String get billing_restore => 'Επαναφορά αγορών';

  @override
  String get billing_manage => 'Διαχείριση συνδρομής';

  @override
  String get billing_deleteAccountWarning =>
      'Αν έχετε συνδρομή μέσω Google Play, η διαγραφή του λογαριασμού σας στο FuzeVPN δεν ακυρώνει την ανανέωσή της. Διαχειριστείτε ή ακυρώστε την ανανέωση ξεχωριστά στο Google Play.';

  @override
  String get billing_deleteAccountContinue =>
      'Συνέχεια στο αίτημα διαγραφής λογαριασμού';

  @override
  String get billing_refresh => 'Ανανέωση πρόσβασης';

  @override
  String get billing_loadingPlans => 'Φόρτωση προγραμμάτων…';

  @override
  String get billing_unavailable =>
      'Δεν υπάρχουν διαθέσιμα προγράμματα αυτήν τη στιγμή. Δοκιμάστε αργότερα.';

  @override
  String get billing_comingSoon => 'Οι συνδρομές θα είναι σύντομα διαθέσιμες.';

  @override
  String get billing_priceDisclosure =>
      'Η τιμή παρέχεται από το Google Play. Το τελικό ποσό επιβεβαιώνεται πριν από την πληρωμή.';

  @override
  String get billing_renewalMonthly =>
      'Ανανεώνεται αυτόματα κάθε μήνα, εκτός αν ακυρωθεί. Μπορείτε να ακυρώσετε οποτεδήποτε στις συνδρομές του Google Play.';

  @override
  String get billing_renewalYearly =>
      'Ανανεώνεται αυτόματα κάθε έτος, εκτός αν ακυρωθεί. Μπορείτε να ακυρώσετε οποτεδήποτε στις συνδρομές του Google Play.';

  @override
  String get billing_active => 'Η πρόσβαση Premium είναι ενεργή';

  @override
  String billing_accessUntil(String date) {
    return 'Πρόσβαση έως $date.';
  }

  @override
  String get billing_webManaged =>
      'Η συνδρομή σας διαχειρίζεται στον ιστότοπο FuzeVPN.';

  @override
  String get billing_playManaged =>
      'Η συνδρομή σας διαχειρίζεται μέσω Google Play.';

  @override
  String get billing_inactive => 'Καμία ενεργή συνδρομή.';

  @override
  String get billing_checkingAccess => 'Έλεγχος της πρόσβασής σας…';

  @override
  String get billing_restoring => 'Επαναφορά αγορών…';

  @override
  String get billing_pending =>
      'Η πληρωμή εκκρεμεί. Η πρόσβασή σας θα ενεργοποιηθεί μετά την επιβεβαίωση.';

  @override
  String get billing_cancelled =>
      'Η αγορά ακυρώθηκε. Δεν ενεργοποιήθηκε νέα συνδρομή.';

  @override
  String get billing_verifying => 'Επαλήθευση αγοράς…';

  @override
  String get billing_success =>
      'Η συνδρομή ενεργοποιήθηκε. Η πρόσβαση Premium είναι έτοιμη.';

  @override
  String get billing_restored => 'Οι αγορές σας επαναφέρθηκαν.';

  @override
  String get billing_restoreEmpty =>
      'Δεν υπάρχουν αγορές για επαναφορά σε αυτόν τον λογαριασμό Google Play.';

  @override
  String get billing_catalogError =>
      'Αδυναμία φόρτωσης προγραμμάτων. Δοκιμάστε ξανά.';

  @override
  String get billing_purchaseError =>
      'Αδυναμία έναρξης αγοράς. Δοκιμάστε ξανά.';

  @override
  String get billing_verificationError =>
      'Η επαλήθευση αγοράς είναι προσωρινά μη διαθέσιμη. Επαναφέρετε τις αγορές για να δοκιμάσετε ξανά.';

  @override
  String get billing_restoreError =>
      'Αδυναμία επαναφοράς αγορών. Δοκιμάστε ξανά.';

  @override
  String get billing_managementError =>
      'Αδυναμία ανοίγματος της διαχείρισης συνδρομών. Δοκιμάστε ξανά.';

  @override
  String get billing_storeUnavailable =>
      'Το Google Play δεν είναι διαθέσιμο σε αυτήν τη συσκευή.';

  @override
  String get welcome_title => 'Το VPN σου, απλά.';

  @override
  String get welcome_description =>
      'Προστάτεψε τη σύνδεσή σου. Κράτησε τον έλεγχο του απορρήτου σου.';

  @override
  String get welcome_start => 'Έναρξη';

  @override
  String get welcome_alreadyPurchased => 'Έχεις ήδη αγοράσει;';

  @override
  String get welcome_noAccountRequired =>
      'Δεν χρειάζεται να δημιουργήσεις λογαριασμό για να ξεκινήσεις.';

  @override
  String get guest_accountTitle => 'Ο λογαριασμός δεν έχει συνδεθεί';

  @override
  String get guest_accountDescription =>
      'Επαναφέρετε τις αγορές με τον ίδιο λογαριασμό Google Play για να χρησιμοποιήσετε τη συνδρομή σε άλλη συσκευή.';

  @override
  String get guest_existingSubscriberSignIn => 'Έχεις ήδη συνδρομή; Σύνδεση';

  @override
  String get guest_claimTitle => 'Πάρε το FuzeVPN μαζί σου';

  @override
  String get guest_claimDescription =>
      'Δημιούργησε λογαριασμό για πρόσβαση στη συνδρομή από τις άλλες συσκευές σου. Αυτό το βήμα είναι προαιρετικό.';

  @override
  String get guest_skip => 'Αργότερα';

  @override
  String get guest_activationTitle => 'Το Fuze Premium είναι ενεργό';

  @override
  String get guest_activationDescription =>
      'Η συνδρομή σου είναι έτοιμη. Χρησιμοποίησε το VPN και δημιούργησε λογαριασμό όποτε θέλεις.';

  @override
  String get guest_useVpn => 'Χρήση του VPN μου';

  @override
  String get guest_loginRequired =>
      'Αυτή η αγορά είναι ήδη συνδεδεμένη με λογαριασμό FuzeVPN. Συνδέσου σε αυτόν για να αποκτήσεις πρόσβαση στη συνδρομή σου.';

  @override
  String get guest_signOutWarning =>
      'Μπορείς να ανακτήσεις τη συνδρομή επαναφέροντας τις αγορές με τον ίδιο λογαριασμό Google Play.';

  @override
  String get guest_profileUnavailable =>
      'Ο λογαριασμός σου είναι ήδη συνδεδεμένος. Συνδέσου για να δεις και να διαχειριστείς τα στοιχεία σου.';

  @override
  String get billing_acceptance =>
      'Συνεχίζοντας, αποδέχεσαι τους Όρους χρήσης και την Πολιτική απορρήτου.';

  @override
  String get guest_verifyEmailReminder =>
      'Επιβεβαίωσε τη διεύθυνση email για να ασφαλίσεις τον λογαριασμό σου. Μπορείς να συνεχίσεις να χρησιμοποιείς το VPN.';

  @override
  String get guest_serviceUnavailable =>
      'Η υπηρεσία δεν είναι διαθέσιμη προσωρινά. Δοκίμασε ξανά σε λίγο.';

  @override
  String get guest_restoreError =>
      'Δεν ήταν δυνατή η επαναφορά των αγορών σου. Δοκίμασε ξανά με τον λογαριασμό Google Play που χρησιμοποίησες για την αγορά.';

  @override
  String get guest_claimSuccess =>
      'Ο λογαριασμός σου δημιουργήθηκε. Η συνδρομή και η πρόσβαση στο VPN διατηρούνται.';

  @override
  String get guest_emailExists =>
      'Αυτή η διεύθυνση email χρησιμοποιείται ήδη. Επίλεξε άλλη διεύθυνση ή συνδέσου στον υπάρχοντα λογαριασμό σου. Η αγορά σου παραμένει διαθέσιμη μέσω του Google Play.';

  @override
  String get guest_claimError =>
      'Δεν ήταν δυνατή η δημιουργία του λογαριασμού σου. Μπορείς να συνεχίσεις να χρησιμοποιείς το VPN και να δοκιμάσεις ξανά αργότερα.';

  @override
  String get guest_secureStorageError =>
      'Δεν ήταν δυνατή η ασφαλής αποθήκευση της συνεδρίας σου σε αυτή τη συσκευή. Δοκίμασε ξανά.';

  @override
  String get guest_premiumRequired =>
      'Επίλεξε μια συνδρομή για να ενεργοποιήσεις το VPN σου.';

  @override
  String get welcome_viewPlans => 'Δες τα προγράμματα';

  @override
  String get google_continue => 'Συνέχεια με Google';

  @override
  String get google_or => 'ή';

  @override
  String get google_title => 'Ο λογαριασμός σας FuzeVPN';

  @override
  String get google_settingUp => 'Ολοκληρώστε τον λογαριασμό σας';

  @override
  String get google_country => 'Χώρα κατοικίας';

  @override
  String get google_profileDescription =>
      'Επιλέξτε τη χώρα σας και διαβάστε τα δύο έγγραφα για να δημιουργήσετε λογαριασμό FuzeVPN.';

  @override
  String get google_claimDescription =>
      'Συνδέστε τον λογαριασμό επισκέπτη με το Google. Η συνδρομή και η συσκευή παραμένουν σε αυτόν τον λογαριασμό.';

  @override
  String get google_linkTitle => 'Σύνδεση Google με FuzeVPN';

  @override
  String get google_linkDescription =>
      'Επιβεβαιώστε την πρόσβαση στον υπάρχοντα λογαριασμό FuzeVPN. Δεν ζητείται ο κωδικός Google.';

  @override
  String get google_password => 'Κωδικός FuzeVPN';

  @override
  String get google_linkAccount => 'Επιβεβαίωση σύνδεσης';

  @override
  String get google_requestEmail => 'Λήψη email επιβεβαίωσης';

  @override
  String get google_emailInstructions =>
      'Ανοίξτε το email του FuzeVPN και εισαγάγετε τον κωδικό επιβεβαίωσης.';

  @override
  String get google_emailCode => 'Κωδικός επιβεβαίωσης email';

  @override
  String get google_confirmEmail => 'Επιβεβαίωση κωδικού';

  @override
  String get google_restart => 'Επιλογή άλλου λογαριασμού Google';

  @override
  String get google_resume => 'Έλεγχος αυτής της προσπάθειας';

  @override
  String get google_unavailable =>
      'Η σύνδεση Google δεν είναι διαθέσιμη. Μπορείτε να χρησιμοποιήσετε email και κωδικό.';

  @override
  String get google_expired =>
      'Αυτή η προσπάθεια έληξε. Ακυρώστε την και ξεκινήστε ξανά.';

  @override
  String get google_conflict =>
      'Αυτός ο λογαριασμός Google συνδέεται ήδη αλλού. Ο τρέχων λογαριασμός και η συνδρομή διατηρούνται.';

  @override
  String get google_error =>
      'Η σύνδεση Google απέτυχε. Δοκιμάστε ξανά· η τρέχουσα πρόσβαση διατηρείται.';

  @override
  String get google_uncertain =>
      'Το αποτέλεσμα δεν επιβεβαιώθηκε. Ελέγξτε την προσπάθεια ή ακυρώστε την πριν ξεκινήσετε ξανά.';

  @override
  String get google_cancelFailed =>
      'Η ακύρωση δεν επιβεβαιώθηκε. Δοκιμάστε να ακυρώσετε ξανά πριν φύγετε από αυτή την οθόνη.';

  @override
  String get google_cancelled => 'Η σύνδεση Google ακυρώθηκε.';

  @override
  String get google_selecting => 'Επιλέξτε τον λογαριασμό σας Google…';

  @override
  String get google_verifying => 'Έλεγχος λογαριασμού…';

  @override
  String get google_emailUnavailable =>
      'Το email επιβεβαίωσης δεν στάλθηκε. Δοκιμάστε αργότερα.';

  @override
  String get google_emailSent =>
      'Στάλθηκε email επιβεβαίωσης. Ελέγξτε τα εισερχόμενα.';

  @override
  String get google_rateLimited => 'Περιμένετε πριν δοκιμάσετε ξανά.';

  @override
  String get google_invalidPassword =>
      'Ο κωδικός FuzeVPN είναι λανθασμένος. Ο τρέχων λογαριασμός διατηρείται.';

  @override
  String get google_invalidCode =>
      'Ο κωδικός επιβεβαίωσης δεν είναι έγκυρος ή έχει λήξει.';

  @override
  String get google_accountChanged =>
      'Η συνεδρία άλλαξε. Ακυρώστε αυτή την προσπάθεια πριν ξεκινήσετε ξανά.';

  @override
  String get google_invalidResponse =>
      'Η απάντηση δεν επικυρώθηκε. Η τρέχουσα πρόσβαση διατηρείται.';

  @override
  String get google_invalidRegistration =>
      'Ελέγξτε τη χώρα και τις δύο συγκαταθέσεις.';

  @override
  String get google_consentRequired =>
      'Επιλέξτε χώρα και αποδεχτείτε τα δύο έγγραφα για να συνεχίσετε.';

  @override
  String get google_challengeRequired =>
      'Απαιτείται επιπλέον έλεγχος ασφαλείας. Η τρέχουσα πρόσβαση διατηρείται.';

  @override
  String get google_challengeUnavailable =>
      'Ο έλεγχος ασφαλείας δεν είναι διαθέσιμος. Δοκιμάστε αργότερα.';
}
