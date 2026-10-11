import 'package:flutter/widgets.dart';
import 'generated/app_localizations.dart';

extension AppCopyContext on BuildContext {
  String copy(
    String key, {
    Map<String, Object?> arguments = const <String, Object?>{},
  }) => AppCopy.resolve(AppLocalizations.of(this), key, arguments: arguments);

  String get billingDeleteAccountWarning =>
      copy('billing.deleteAccountWarning');
  String get billingDeleteAccountContinue =>
      copy('billing.deleteAccountContinue');
}

abstract final class AppCopy {
  static String resolve(
    AppLocalizations localizations,
    String key, {
    Map<String, Object?> arguments = const <String, Object?>{},
  }) {
    String value = switch (key) {
      'google.continue' => localizations.google_continue,
      'google.or' => localizations.google_or,
      'google.title' => localizations.google_title,
      'google.settingUp' => localizations.google_settingUp,
      'google.country' => localizations.google_country,
      'google.profileDescription' => localizations.google_profileDescription,
      'google.claimDescription' => localizations.google_claimDescription,
      'google.linkTitle' => localizations.google_linkTitle,
      'google.linkDescription' => localizations.google_linkDescription,
      'google.password' => localizations.google_password,
      'google.linkAccount' => localizations.google_linkAccount,
      'google.requestEmail' => localizations.google_requestEmail,
      'google.emailInstructions' => localizations.google_emailInstructions,
      'google.emailCode' => localizations.google_emailCode,
      'google.confirmEmail' => localizations.google_confirmEmail,
      'google.restart' => localizations.google_restart,
      'google.resume' => localizations.google_resume,
      'google.unavailable' => localizations.google_unavailable,
      'google.expired' => localizations.google_expired,
      'google.conflict' ||
      'google.identityConflict' => localizations.google_conflict,
      'google.error' => localizations.google_error,
      'google.uncertain' => localizations.google_uncertain,
      'google.cancelFailed' => localizations.google_cancelFailed,
      'google.cancelled' => localizations.google_cancelled,
      'google.selecting' => localizations.google_selecting,
      'google.verifying' => localizations.google_verifying,
      'google.emailUnavailable' => localizations.google_emailUnavailable,
      'google.emailSent' => localizations.google_emailSent,
      'google.rateLimited' => localizations.google_rateLimited,
      'google.invalidPassword' => localizations.google_invalidPassword,
      'google.invalidCode' => localizations.google_invalidCode,
      'google.accountChanged' => localizations.google_accountChanged,
      'google.invalidResponse' => localizations.google_invalidResponse,
      'google.invalidRegistration' => localizations.google_invalidRegistration,
      'google.consentRequired' => localizations.google_consentRequired,
      'google.challengeRequired' => localizations.google_challengeRequired,
      'google.challengeUnavailable' =>
        localizations.google_challengeUnavailable,
      'welcome.title' => localizations.welcome_title,
      'welcome.description' => localizations.welcome_description,
      'welcome.start' => localizations.welcome_start,
      'welcome.viewPlans' => localizations.welcome_viewPlans,
      'welcome.alreadyPurchased' => localizations.welcome_alreadyPurchased,
      'welcome.noAccountRequired' => localizations.welcome_noAccountRequired,
      'guest.accountTitle' => localizations.guest_accountTitle,
      'guest.accountDescription' => localizations.guest_accountDescription,
      'guest.existingSubscriberSignIn' =>
        localizations.guest_existingSubscriberSignIn,
      'guest.claimTitle' => localizations.guest_claimTitle,
      'guest.claimDescription' => localizations.guest_claimDescription,
      'guest.skip' => localizations.guest_skip,
      'guest.activationTitle' => localizations.guest_activationTitle,
      'guest.activationDescription' =>
        localizations.guest_activationDescription,
      'guest.useVpn' => localizations.guest_useVpn,
      'guest.loginRequired' => localizations.guest_loginRequired,
      'guest.signOutWarning' => localizations.guest_signOutWarning,
      'guest.profileUnavailable' => localizations.guest_profileUnavailable,
      'guest.verifyEmailReminder' => localizations.guest_verifyEmailReminder,
      'guest.serviceUnavailable' => localizations.guest_serviceUnavailable,
      'guest.restoreError' => localizations.guest_restoreError,
      'guest.claimSuccess' => localizations.guest_claimSuccess,
      'guest.emailExists' => localizations.guest_emailExists,
      'guest.claimError' => localizations.guest_claimError,
      'guest.secureStorageError' => localizations.guest_secureStorageError,
      'guest.premiumRequired' => localizations.guest_premiumRequired,
      'billing.acceptance' => localizations.billing_acceptance,
      'billing.title' => localizations.billing_title,
      'billing.subtitle' => localizations.billing_subtitle,
      'billing.subscribe' => localizations.billing_subscribe,
      'billing.choosePlan' => localizations.billing_choosePlan,
      'billing.monthly' => localizations.billing_monthly,
      'billing.yearly' => localizations.billing_yearly,
      'billing.continue' => localizations.billing_continue,
      'billing.trialTitle' => localizations.billing_trialTitle,
      'billing.trialSubtitle' => localizations.billing_trialSubtitle,
      'billing.trialWeeks' => localizations.billing_trialWeeks,
      'billing.trialDays' => localizations.billing_trialDays(
        arguments['days'] as String? ?? '',
      ),
      'billing.trialStart' => localizations.billing_trialStart,
      'billing.trialFirstCharge' => localizations.billing_trialFirstCharge(
        arguments['date'] as String? ?? '',
      ),
      'billing.trialTerms' => localizations.billing_trialTerms,
      'billing.trialThenMonthly' => localizations.billing_trialThenMonthly(
        arguments['price'] as String? ?? '',
      ),
      'billing.trialThenYearly' => localizations.billing_trialThenYearly(
        arguments['price'] as String? ?? '',
      ),
      'billing.choosePeriod' => localizations.billing_choosePeriod,
      'billing.selectionHint' => localizations.billing_selectionHint,
      'billing.benefitConnection' => localizations.billing_benefitConnection,
      'billing.benefitPrivacy' => localizations.billing_benefitPrivacy,
      'billing.benefitNoAccount' => localizations.billing_benefitNoAccount,
      'billing.cancellation' => localizations.billing_cancellation,
      'billing.premiumTitle' => localizations.billing_premiumTitle,
      'billing.premiumSubtitle' => localizations.billing_premiumSubtitle,
      'billing.priceMonthly' => localizations.billing_priceMonthly,
      'billing.priceYearly' => localizations.billing_priceYearly,
      'billing.trialToday' => localizations.billing_trialToday,
      'billing.trialConfirmation' => localizations.billing_trialConfirmation,
      'billing.offerChanged' => localizations.billing_offerChanged,
      'billing.restore' => localizations.billing_restore,
      'billing.manage' => localizations.billing_manage,
      'billing.deleteAccountWarning' =>
        localizations.billing_deleteAccountWarning,
      'billing.deleteAccountContinue' =>
        localizations.billing_deleteAccountContinue,
      'billing.refresh' => localizations.billing_refresh,
      'billing.loadingPlans' => localizations.billing_loadingPlans,
      'billing.unavailable' => localizations.billing_unavailable,
      'billing.comingSoon' => localizations.billing_comingSoon,
      'billing.priceDisclosure' => localizations.billing_priceDisclosure,
      'billing.renewalMonthly' => localizations.billing_renewalMonthly,
      'billing.renewalYearly' => localizations.billing_renewalYearly,
      'billing.active' => localizations.billing_active,
      'billing.accessUntil' => localizations.billing_accessUntil(
        arguments['date'] as String? ?? '',
      ),
      'billing.webManaged' => localizations.billing_webManaged,
      'billing.playManaged' => localizations.billing_playManaged,
      'billing.inactive' => localizations.billing_inactive,
      'billing.checkingAccess' => localizations.billing_checkingAccess,
      'billing.restoring' => localizations.billing_restoring,
      'billing.pending' => localizations.billing_pending,
      'billing.cancelled' => localizations.billing_cancelled,
      'billing.verifying' => localizations.billing_verifying,
      'billing.success' => localizations.billing_success,
      'billing.restored' => localizations.billing_restored,
      'billing.restoreEmpty' => localizations.billing_restoreEmpty,
      'billing.catalogError' => localizations.billing_catalogError,
      'billing.purchaseError' => localizations.billing_purchaseError,
      'billing.verificationError' => localizations.billing_verificationError,
      'billing.restoreError' => localizations.billing_restoreError,
      'billing.managementError' => localizations.billing_managementError,
      'billing.storeUnavailable' => localizations.billing_storeUnavailable,
      'externalLink.failed' => localizations.externalLink_failed,
      'externalLink.copy' => localizations.externalLink_copy,
      'externalLink.copied' => localizations.externalLink_copied,
      'externalLink.copyFailed' => localizations.externalLink_copyFailed,
      'settings.deleteAccount' => localizations.settings_deleteAccount,
      'settings.deleteAccountDetail' =>
        localizations.settings_deleteAccountDetail,
      'locations.automaticSelection' =>
        localizations.locations_automaticSelection,
      'locations.cities' => localizations.locations_cities,
      'locations.servers' => localizations.locations_servers,
      'locations.viewCities' => localizations.locations_viewCities(
        arguments['name'] as String? ?? '',
      ),
      'locations.viewServers' => localizations.locations_viewServers(
        arguments['name'] as String? ?? '',
      ),
      'locations.countryCount' => localizations.locations_countryCount(
        arguments['count'] as int? ?? 0,
      ),
      'locations.cityCount' => localizations.locations_cityCount(
        arguments['count'] as int? ?? 0,
      ),
      'locations.serverCount' => localizations.locations_serverCount(
        arguments['count'] as int? ?? 0,
      ),
      'locations.allCountries' => localizations.locations_allCountries,
      'locations.backToCountries' => localizations.locations_backToCountries,
      'locations.backToCities' => localizations.locations_backToCities(
        arguments['name'] as String? ?? '',
      ),
      'locations.chooseCountry' => localizations.locations_chooseCountry(
        arguments['name'] as String? ?? '',
      ),
      'locations.chooseCity' => localizations.locations_chooseCity(
        arguments['name'] as String? ?? '',
      ),
      'locations.noCompatibleServer' =>
        localizations.locations_noCompatibleServer,
      'protection.learnMore' => localizations.protection_learnMore,
      'protection.guideWhy' => localizations.protection_guideWhy,
      'protection.guideAlwaysOnTitle' =>
        localizations.protection_guideAlwaysOnTitle,
      'protection.guideAlwaysOn' => localizations.protection_guideAlwaysOn,
      'protection.guideBlockTitle' => localizations.protection_guideBlockTitle,
      'protection.guideBlock' => localizations.protection_guideBlock,
      'protection.guideWarning' => localizations.protection_guideWarning,
      'protection.guideStepsTitle' => localizations.protection_guideStepsTitle,
      'protection.guideStep1' => localizations.protection_guideStep1,
      'protection.guideStep2' => localizations.protection_guideStep2,
      'protection.guideStep3' => localizations.protection_guideStep3,
      'protection.guideManufacturers' =>
        localizations.protection_guideManufacturers,
      'protection.guideDisableTitle' =>
        localizations.protection_guideDisableTitle,
      'protection.guideDisable' => localizations.protection_guideDisable,
      'protection.guideManual' => localizations.protection_guideManual,
      'locations.changeTitle' => localizations.locations_changeTitle,
      'locations.changeActive' => localizations.locations_changeActive(
        arguments['name'] as String? ?? '',
      ),
      'locations.changeIdle' => localizations.locations_changeIdle(
        arguments['name'] as String? ?? '',
      ),
      'locations.confirmChange' => localizations.locations_confirmChange,
      'locations.changeBusy' => localizations.locations_changeBusy,
      'notice.preferenceSave.title' =>
        localizations.notice_preferenceSave_title,
      'notice.preferenceSave.message' =>
        localizations.notice_preferenceSave_message,
      'connection.androidDisconnectHint' =>
        localizations.connection_androidDisconnectHint,
      'devices.profileStatus' => localizations.devices_profileStatus(
        arguments['status'] as String? ?? '',
      ),
      'auth.welcome' => localizations.auth_welcome,
      'connection.changeLocation' => localizations.connection_changeLocation,
      'connection.details' => localizations.connection_details,
      'devices.manage' => localizations.devices_manage,
      'settings.personalization' => localizations.settings_personalization,
      'settings.safety' => localizations.settings_safety,
      'settings.help' => localizations.settings_help,
      'settings.about' => localizations.settings_about,
      'diagnostics.heading' => localizations.diagnostics_heading,
      'locations.searchLabel' => localizations.locations_searchLabel,
      'locations.clearSearch' => localizations.locations_clearSearch,
      'locations.filterAll' => localizations.locations_filterAll,
      'locations.filterFavorites' => localizations.locations_filterFavorites,
      'locations.results' => localizations.locations_results(
        arguments['count'] as int? ?? 0,
      ),
      'locations.noResults' => localizations.locations_noResults,
      'locations.noResultsHint' => localizations.locations_noResultsHint,
      'locations.noFavorites' => localizations.locations_noFavorites,
      'locations.noFavoritesHint' => localizations.locations_noFavoritesHint,
      'locations.showAll' => localizations.locations_showAll,
      'locations.addFavorite' => localizations.locations_addFavorite(
        arguments['name'] as String? ?? '',
      ),
      'locations.removeFavorite' => localizations.locations_removeFavorite(
        arguments['name'] as String? ?? '',
      ),
      'locations.favoriteSaveFailed' =>
        localizations.locations_favoriteSaveFailed,
      'locations.emptyTitle' => localizations.locations_emptyTitle,
      'locations.emptyHint' => localizations.locations_emptyHint,
      'diagnostics.title' => localizations.diagnostics_title,
      'diagnostics.settingsTitle' => localizations.diagnostics_settingsTitle,
      'diagnostics.automaticTitle' => localizations.diagnostics_automaticTitle,
      'diagnostics.automaticDescription' =>
        localizations.diagnostics_automaticDescription,
      'diagnostics.privacy' => localizations.diagnostics_privacy,
      'diagnostics.manualOpen' => localizations.diagnostics_manualOpen,
      'diagnostics.localDescription' =>
        localizations.diagnostics_localDescription,
      'diagnostics.sendReport' => localizations.diagnostics_sendReport,
      'diagnostics.sendHint' => localizations.diagnostics_sendHint,
      'diagnostics.signedOut' => localizations.diagnostics_signedOut,
      'diagnostics.localLifetime' => localizations.diagnostics_localLifetime,
      'diagnostics.run' => localizations.diagnostics_run,
      'diagnostics.rerun' => localizations.diagnostics_rerun,
      'diagnostics.running' => localizations.diagnostics_running,
      'diagnostics.sending' => localizations.diagnostics_sending,
      'diagnostics.prepared' => localizations.diagnostics_prepared,
      'diagnostics.queued' => localizations.diagnostics_queued,
      'diagnostics.sent' => localizations.diagnostics_sent,
      'diagnostics.failed' => localizations.diagnostics_failed,
      'diagnostics.preparationFailed' =>
        localizations.diagnostics_preparationFailed,
      'diagnostics.authenticationRequired' =>
        localizations.diagnostics_authenticationRequired,
      'diagnostics.retry' => localizations.diagnostics_retry,
      'diagnostics.export' => localizations.diagnostics_export,
      'diagnostics.exportFailed' => localizations.diagnostics_exportFailed,
      'diagnostics.preferenceFailed' =>
        localizations.diagnostics_preferenceFailed,
      'diagnostics.receipt' => localizations.diagnostics_receipt(
        arguments['id'] ?? '',
      ),
      'diagnostics.received' => localizations.diagnostics_received(
        arguments['date'] ?? '',
      ),
      'diagnostics.expires' => localizations.diagnostics_expires(
        arguments['date'] ?? '',
      ),
      'diagnostics.duplicate' => localizations.diagnostics_duplicate,
      'diagnostics.preview' => localizations.diagnostics_preview,
      'diagnostics.eventCount' => localizations.diagnostics_eventCount(
        arguments['count'] as int? ?? 0,
      ),
      'diagnostics.technical' => localizations.diagnostics_technical,
      'diagnostics.empty' => localizations.diagnostics_empty,
      'diagnostics.checkName' => localizations.diagnostics_checkName(
        arguments['id'] as String? ?? '',
      ),
      'diagnostics.checkResult' => localizations.diagnostics_checkResult(
        arguments['result'] as String? ?? '',
      ),
      'accountRestoration.title' => localizations.accountRestoration_title,
      'accountRestoration.message' => localizations.accountRestoration_message,
      'action.retry' => localizations.action_retry,
      'network.title' => localizations.network_title,
      'network.ipv4' => localizations.network_ipv4,
      'network.dualStack' => localizations.network_dualStack,
      'network.ipv4Fallback' => localizations.network_ipv4Fallback,
      'protection.title' => localizations.protection_title,
      'protection.subtitle' => localizations.protection_subtitle,
      'protection.active' => localizations.protection_active,
      'protection.alwaysOnOnly' => localizations.protection_alwaysOnOnly,
      'protection.inactive' => localizations.protection_inactive,
      'protection.unknown' => localizations.protection_unknown,
      'protection.openSettings' => localizations.protection_openSettings,
      'protection.dialogTitle' => localizations.protection_dialogTitle,
      'protection.dialogMessage' => localizations.protection_dialogMessage,
      'protection.dialogOpen' => localizations.protection_dialogOpen,
      'startup' => localizations.startup,
      'openvpnCleanup.title' => localizations.openvpnCleanup_title,
      'openvpnCleanup.working' => localizations.openvpnCleanup_working,
      'openvpnCleanup.stopFailed' => localizations.openvpnCleanup_stopFailed,
      'openvpnCleanup.cleanupFailed' =>
        localizations.openvpnCleanup_cleanupFailed,
      'openvpnCleanup.complete' => localizations.openvpnCleanup_complete,
      'nav.connection' => localizations.nav_connection,
      'nav.locations' => localizations.nav_locations,
      'nav.account' => localizations.nav_account,
      'nav.devices' => localizations.nav_devices,
      'nav.settings' => localizations.nav_settings,
      'action.refresh' => localizations.action_refresh,
      'auth.tab.login' => localizations.auth_tab_login,
      'auth.tab.register' => localizations.auth_tab_register,
      'auth.step.account' => localizations.auth_stepAccount,
      'auth.step.identity' => localizations.auth_stepIdentity,
      'auth.step.address' => localizations.auth_stepAddress,
      'auth.step.progress' => localizations.auth_stepProgress(
        arguments['current'] ?? '',
        arguments['total'] ?? '',
      ),
      'auth.tagline' => localizations.auth_tagline,
      'auth.keysLocal' => localizations.auth_keysLocal,
      'form.email' => localizations.form_email,
      'form.password' => localizations.form_password,
      'form.showPassword' => localizations.form_showPassword,
      'form.hidePassword' => localizations.form_hidePassword,
      'form.passwordMin' => localizations.form_passwordMin,
      'form.firstName' => localizations.form_firstName,
      'form.lastName' => localizations.form_lastName,
      'form.phone' => localizations.form_phone,
      'form.address' => localizations.form_address,
      'form.address2' => localizations.form_address2,
      'form.postalCode' => localizations.form_postalCode,
      'form.city' => localizations.form_city,
      'form.country' => localizations.form_country,
      'action.login' => localizations.action_login,
      'action.createAccount' => localizations.action_createAccount,
      'action.createMyAccount' => localizations.action_createMyAccount,
      'action.next' => localizations.action_next,
      'action.previous' => localizations.action_previous,
      'action.forgotPassword' => localizations.action_forgotPassword,
      'auth.noAccount' => localizations.auth_noAccount,
      'auth.requiredInformation' => localizations.auth_requiredInformation,
      'auth.termsPrefix' => localizations.auth_termsPrefix,
      'auth.termsLink' => localizations.auth_termsLink,
      'auth.privacyPrefix' => localizations.auth_privacyPrefix,
      'auth.privacyLink' => localizations.auth_privacyLink,
      'auth.consentRequired' => localizations.auth_consentRequired,
      'validation.required' => localizations.validation_required,
      'validation.email' => localizations.validation_email,
      'validation.password' => localizations.validation_password,
      'validation.passwordTooLong' => localizations.validation_passwordTooLong,
      'validation.phone' => localizations.validation_phone,
      'validation.country' => localizations.validation_country,
      'passwordReset.title' => localizations.passwordReset_title,
      'passwordReset.description' => localizations.passwordReset_description,
      'passwordReset.send' => localizations.passwordReset_send,
      'connection.title' => localizations.connection_title,
      'connection.subtitle' => localizations.connection_subtitle,
      'connection.prepare' => localizations.connection_prepare,
      'connection.advancedOptions' => localizations.connection_advancedOptions,
      'connection.location' => localizations.connection_location,
      'connection.chooseLocation' => localizations.connection_chooseLocation,
      'connection.protocol' => localizations.connection_protocol,
      'connection.connect' => localizations.connection_connect,
      'connection.connecting' => localizations.connection_connecting,
      'connection.disconnect' => localizations.connection_disconnect,
      'connection.disconnecting' => localizations.connection_disconnecting,
      'connection.locationChange' => localizations.connection_locationChange,
      'connection.unavailable' => localizations.connection_unavailable(
        arguments['protocol'] ?? '',
      ),
      'connection.activeLocation' => localizations.connection_activeLocation,
      'connection.duration' => localizations.connection_duration,
      'connection.received' => localizations.connection_received,
      'connection.sent' => localizations.connection_sent,
      'connection.lastHandshake' => localizations.connection_lastHandshake,
      'connection.handshakeAgo' => localizations.connection_handshakeAgo(
        arguments['duration'] ?? '',
      ),
      'verification.title' => localizations.verification_title,
      'verification.message' => localizations.verification_message,
      'verification.resend' => localizations.verification_resend,
      'migration.title' => localizations.migration_title,
      'migration.draining' => localizations.migration_draining,
      'migration.activating' => localizations.migration_activating,
      'migration.ready' => localizations.migration_ready,
      'migration.blocked' => localizations.migration_blocked,
      'migration.progress' => localizations.migration_progress,
      'migration.retryDelay' => localizations.migration_retryDelay(
        arguments['seconds'] ?? '',
      ),
      'migration.resume' => localizations.migration_resume,
      'status.authorizing' => localizations.status_authorizing,
      'status.authorizingDetail' => localizations.status_authorizingDetail,
      'status.preparing' => localizations.status_preparing,
      'status.preparingDetail' => localizations.status_preparingDetail,
      'session.endingTitle' => localizations.session_endingTitle,
      'session.ending' => localizations.session_ending,
      'session.stopFailed' => localizations.session_stopFailed,
      'session.cleanupFailed' => localizations.session_cleanupFailed,
      'session.systemProtectionNote' =>
        localizations.session_systemProtectionNote,
      'session.retryStop' => localizations.session_retryStop,
      'session.retryCleanup' => localizations.session_retryCleanup,
      'status.connecting' => localizations.status_connecting,
      'status.reconnecting' => localizations.status_reconnecting,
      'status.reconnectingDetail' => localizations.status_reconnectingDetail,
      'status.connectingDetail' => localizations.status_connectingDetail,
      'status.connected' => localizations.status_connected,
      'status.connectedDetail' => localizations.status_connectedDetail,
      'status.disconnecting' => localizations.status_disconnecting,
      'status.disconnectingDetail' => localizations.status_disconnectingDetail,
      'status.error' => localizations.status_error,
      'status.errorDetail' => localizations.status_errorDetail,
      'status.idle' => localizations.status_idle,
      'status.idleDetail' => localizations.status_idleDetail,
      'trust.note' => localizations.trust_note,
      'locations.none' => localizations.locations_none,
      'locations.available' => localizations.locations_available,
      'locations.selected' => localizations.locations_selected,
      'locations.select' => localizations.locations_select,
      'locations.lockedTunnel' => localizations.locations_lockedTunnel,
      'locations.lockedMigration' => localizations.locations_lockedMigration,
      'devices.title' => localizations.devices_title,
      'devices.used' => localizations.devices_used(
        arguments['count'] ?? '',
        arguments['limit'] ?? '',
      ),
      'devices.refresh' => localizations.devices_refresh,
      'devices.empty' => localizations.devices_empty,
      'devices.firstConnection' => localizations.devices_firstConnection,
      'devices.thisDevice' => localizations.devices_thisDevice,
      'devices.added' => localizations.devices_added(arguments['date'] ?? ''),
      'action.remove' => localizations.action_remove,
      'settings.title' => localizations.settings_title,
      'settings.subtitle' => localizations.settings_subtitle,
      'settings.appearance' => localizations.settings_appearance,
      'settings.language' => localizations.settings_language,
      'settings.languageDescription' =>
        localizations.settings_languageDescription,
      'settings.account' => localizations.settings_account,
      'settings.signOut' => localizations.settings_signOut,
      'settings.privacy' => localizations.settings_privacy,
      'settings.terms' => localizations.settings_terms,
      'settings.security' => localizations.settings_security,
      'settings.licenses' => localizations.settings_licenses,
      'settings.licensesDetail' => localizations.settings_licensesDetail,
      'settings.background' => localizations.settings_background,
      'theme.system' => localizations.theme_system,
      'theme.light' => localizations.theme_light,
      'theme.dark' => localizations.theme_dark,
      'language.system' => localizations.language_system,
      'language.fr' => localizations.language_fr,
      'language.en' => localizations.language_en,
      'language.es' => localizations.language_es,
      'language.de' => localizations.language_de,
      'dialog.removeDevice' => localizations.dialog_removeDevice,
      'dialog.removeCurrent' => localizations.dialog_removeCurrent,
      'dialog.removeOther' => localizations.dialog_removeOther(
        arguments['name'] ?? '',
      ),
      'dialog.signOut' => localizations.dialog_signOut,
      'dialog.signOutMessage' => localizations.dialog_signOutMessage,
      'action.cancel' => localizations.action_cancel,
      'action.signOut' => localizations.action_signOut,
      'notice.close' => localizations.notice_close,
      'notice.diagnosticCode' => localizations.notice_diagnosticCode(
        arguments['code'] ?? '',
      ),
      'notice.sessionExpired.title' =>
        localizations.notice_sessionExpired_title,
      'notice.sessionExpired.message' =>
        localizations.notice_sessionExpired_message,
      'notice.connectionFailed.title' =>
        localizations.notice_connectionFailed_title,
      'notice.invalidCredentials.message' =>
        localizations.notice_invalidCredentials_message,
      'notice.emailVerification.title' =>
        localizations.notice_emailVerification_title,
      'notice.emailVerification.message' =>
        localizations.notice_emailVerification_message,
      'notice.rateLimited.title' => localizations.notice_rateLimited_title,
      'notice.deviceLimit.title' => localizations.notice_deviceLimit_title,
      'notice.deviceLimit.message' => localizations.notice_deviceLimit_message,
      'notice.identityRenewal.title' =>
        localizations.notice_identityRenewal_title,
      'notice.identityRenewal.message' =>
        localizations.notice_identityRenewal_message,
      'notice.migrationPending.title' =>
        localizations.notice_migrationPending_title,
      'notice.migrationPending.message' =>
        localizations.notice_migrationPending_message,
      'notice.migrationBlocked.title' =>
        localizations.notice_migrationBlocked_title,
      'notice.migrationBlocked.message' =>
        localizations.notice_migrationBlocked_message,
      'notice.targetUnavailable.title' =>
        localizations.notice_targetUnavailable_title,
      'notice.targetUnavailable.message' =>
        localizations.notice_targetUnavailable_message,
      'notice.networkUnavailable.title' =>
        localizations.notice_networkUnavailable_title,
      'notice.networkUnavailable.message' =>
        localizations.notice_networkUnavailable_message,
      'notice.permissionDenied.title' =>
        localizations.notice_permissionDenied_title,
      'notice.permissionDenied.message' =>
        localizations.notice_permissionDenied_message,
      'notice.wireguardTimeout.title' =>
        localizations.notice_wireguardTimeout_title,
      'notice.wireguardTimeout.message' =>
        localizations.notice_wireguardTimeout_message,
      'notice.tlsFailed.title' => localizations.notice_tlsFailed_title,
      'notice.tlsFailed.message' => localizations.notice_tlsFailed_message,
      'notice.tunRejected.title' => localizations.notice_tunRejected_title,
      'notice.tunRejected.message' => localizations.notice_tunRejected_message,
      'notice.openvpnStart.title' => localizations.notice_openvpnStart_title,
      'notice.openvpnStart.message' =>
        localizations.notice_openvpnStart_message,
      'notice.controller.title' => localizations.notice_controller_title(
        (arguments['code'] ?? '').toString(),
      ),
      'notice.controller.message' => localizations.notice_controller_message(
        (arguments['code'] ?? '').toString(),
        (arguments['target'] ?? '').toString(),
      ),
      'notice.native.title' => _nativeTitle(
        localizations,
        (arguments['code'] ?? '').toString(),
        (arguments['protocol'] ?? 'VPN').toString(),
      ),
      'notice.native.message' => _nativeMessage(
        localizations,
        (arguments['code'] ?? '').toString(),
        (arguments['protocol'] ?? 'VPN').toString(),
      ),
      'notice.api.title' => localizations.notice_api_title(
        (arguments['code'] ?? '').toString(),
      ),
      'notice.api.message' => localizations.notice_api_message(
        (arguments['code'] ?? '').toString(),
      ),
      'notice.retryLater' => localizations.notice_retryLater,
      'notice.retryAfter' => localizations.notice_retryAfter(
        arguments['seconds'] ?? '',
      ),
      'notice.generic.title' => localizations.notice_generic_title,
      'notice.generic.message' => localizations.notice_generic_message,
      _ => key,
    };
    arguments.forEach((String name, Object? argument) {
      value = value.replaceAll('{}', argument?.toString() ?? '');
    });
    return value;
  }

  static String _nativeTitle(
    AppLocalizations localizations,
    String code,
    String protocol,
  ) => switch (code) {
    'permission_request_in_progress' =>
      localizations.notice_permissionRequestInProgress_title,
    'vpn_permission_request_interrupted' =>
      localizations.notice_permissionRequestInterrupted_title,
    'openvpn_connection_proof_missing' =>
      localizations.notice_openvpnProofMissing_title,
    'tun_network_mismatch' ||
    'invalid_tunnel_network' => localizations.network_rejectedTitle,
    'openvpn_network_metadata_invalid' => localizations.network_unreadableTitle,
    _ => localizations.notice_native_title(code, protocol),
  };

  static String _nativeMessage(
    AppLocalizations localizations,
    String code,
    String protocol,
  ) => switch (code) {
    'permission_request_in_progress' =>
      localizations.notice_permissionRequestInProgress_message,
    'vpn_permission_request_interrupted' =>
      localizations.notice_permissionRequestInterrupted_message,
    'openvpn_connection_proof_missing' =>
      localizations.notice_openvpnProofMissing_message,
    'tun_network_mismatch' ||
    'invalid_tunnel_network' => localizations.network_rejectedMessage,
    'openvpn_network_metadata_invalid' =>
      localizations.network_unreadableMessage,
    _ => localizations.notice_native_message(code, protocol),
  };
}
