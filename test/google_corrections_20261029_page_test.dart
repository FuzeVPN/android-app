// Corrections du 29/10/2026, sous-lot R2-google, côté page Google réelle :
// A03-google-01, A03-google-03, A03-google-04 (+ A16-ui-l10n-06),
// H-RA-A08-01-04 et C5-Analyseurs-stricts-face-au-con-03. Contre-exemples de
// repros/A03-google/a03_google_page_test.dart, repros/H-RA-A08-01 (V9, V10) et
// repros/C5-Analyseurs-stricts-face-au-con/c5_google_test.dart, assertions
// inversées. Vrai GoogleAuthController ; API, stockage et sélecteur simulés.
import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fuzevpn_android/core/api_exception.dart';
import 'package:fuzevpn_android/core/google_auth.dart';
import 'package:fuzevpn_android/core/google_credentials.dart';
import 'package:fuzevpn_android/core/models.dart';
import 'package:fuzevpn_android/core/security_challenge.dart';
import 'package:fuzevpn_android/features/auth/google_auth_page.dart';
import 'package:fuzevpn_android/google_auth_controller.dart';
import 'package:fuzevpn_android/l10n/generated/app_localizations.dart';
import 'package:fuzevpn_android/widgets/fuze_design.dart';

import 'support/welcome_ui_fixture.dart';

final _expiry = DateTime.utc(2099);
final _fr = lookupAppLocalizations(const Locale('fr'));
const _limited = ApiException(
  statusCode: 429,
  errorCode: 'rate_limited',
  retryAfterSeconds: 120,
);
const _offline = ApiNetworkException(code: 'network_timeout');

void main() {
  _retryAfterTests();
  _staleExitMessageTests();
  _countryOrderTests();
  _persistedTicketTests();
  _reviewFollowUpTests();
  _afterCrashTests();
}

void _retryAfterTests() {
  testWidgets('A03-google-01 Back during a link 429 then failed cancellation '
      'keeps the form disabled with an explanation', (tester) async {
    var now = DateTime.utc(2026, 10, 29, 12);
    final f = _Fixture(status: 'link_required', now: () => now);
    addTearDown(f.app.dispose);
    await f.open(tester, GoogleAuthPurpose.authenticate);
    expect(f.auth.state.step, GoogleAuthStep.linkRequired);
    await tester.enterText(
      find.byKey(const ValueKey('google-fuze-password')),
      'fixture-password',
    );
    final entered = Completer<void>();
    final reply = Completer<void>();
    f.api.finalizeGate = () {
      entered.complete();
      return reply.future;
    };
    await tester.tap(find.byKey(const ValueKey('google-password-confirm')));
    await tester.pump();
    expect(entered.isCompleted, isTrue);
    f.api.cancelFailure = _offline;
    await tester.tap(find.byType(BackButton));
    await tester.pump();
    reply.completeError(_limited);
    await tester.pumpAndSettle();
    expect(find.byType(GoogleAuthenticationPage), findsOneWidget);
    expect(f.auth.state.messageKey, 'google.cancelFailed');
    expect(f.auth.state.retryAfter, now.add(const Duration(seconds: 120)));

    f.api.finalizeGate = null;
    f.api.cancelFailure = null;
    await tester.ensureVisible(find.byKey(const ValueKey('google-resume')));
    await tester.tap(find.byKey(const ValueKey('google-resume')));
    await tester.pumpAndSettle();
    expect(f.auth.state.step, GoogleAuthStep.linkRequired);
    final confirm = find.byKey(const ValueKey('google-password-confirm'));
    expect(tester.widget<ButtonStyleButton>(confirm).onPressed, isNull);
    expect(find.text(_fr.google_rateLimited), findsOneWidget);
    expect(find.text(_fr.notice_retryAfter(120)), findsOneWidget);
    expect(find.text(_fr.google_cancelFailed), findsNothing);
    await tester.ensureVisible(confirm);
    await tester.tap(confirm, warnIfMissed: false);
    await tester.pumpAndSettle();
    expect(f.api.linkCalls, 1);

    now = now.add(const Duration(seconds: 120));
    await tester.pump(const Duration(seconds: 1));
    await tester.pump();
    expect(tester.widget<ButtonStyleButton>(confirm).onPressed, isNotNull);
    expect(find.text(_fr.google_rateLimited), findsNothing);
    await tester.ensureVisible(confirm);
    await tester.tap(confirm);
    await tester.pumpAndSettle();
    expect(f.api.linkCalls, 2);
  });

  testWidgets('H-RA-A08-01-04 claim429 then failing /me: the reopened form '
      'explains the limit and counts down to the deadline', (tester) async {
    var now = DateTime.utc(2026, 10, 29, 12);
    final f = _Fixture(
      status: 'guest_claim_required',
      guest: true,
      now: () => now,
    );
    addTearDown(f.app.dispose);
    await f.open(tester, GoogleAuthPurpose.claim);
    expect(f.auth.state.step, GoogleAuthStep.guestClaimRequired);
    f.api.claimFailure = _limited;
    f.claimReadFailure = _offline;
    await f.auth.completeProfile(
      countryCode: 'FR',
      termsAccepted: true,
      privacyAccepted: true,
    );
    await tester.pumpAndSettle();
    expect(f.auth.state.messageKey, 'google.uncertain');
    f.claimReadFailure = null;
    await tester.ensureVisible(find.byKey(const ValueKey('google-resume')));
    await tester.tap(find.byKey(const ValueKey('google-resume')));
    await tester.pumpAndSettle();
    expect(f.auth.state.step, GoogleAuthStep.guestClaimRequired);
    final submit = find.byKey(const ValueKey('google-profile-submit'));
    expect(tester.widget<ButtonStyleButton>(submit).onPressed, isNull);
    expect(find.text(_fr.google_rateLimited), findsOneWidget);
    expect(find.text(_fr.notice_retryAfter(120)), findsOneWidget);

    now = now.add(const Duration(seconds: 90));
    await tester.pump(const Duration(seconds: 1));
    expect(find.text(_fr.notice_retryAfter(30)), findsOneWidget);
    expect(tester.widget<ButtonStyleButton>(submit).onPressed, isNull);

    now = now.add(const Duration(seconds: 30));
    await tester.pump(const Duration(seconds: 1));
    await tester.pump();
    expect(tester.widget<ButtonStyleButton>(submit).onPressed, isNotNull);
    expect(find.text(_fr.google_rateLimited), findsNothing);
    expect(find.textContaining('30'), findsNothing);
    expect(f.api.claims, 1);
  });

  testWidgets('control: a form without deadline shows no countdown', (
    tester,
  ) async {
    final f = _Fixture(status: 'registration_required');
    addTearDown(f.app.dispose);
    await f.open(tester, GoogleAuthPurpose.authenticate);
    expect(f.auth.state.step, GoogleAuthStep.registrationRequired);
    expect(f.auth.state.retryAfter, isNull);
    expect(find.text(_fr.google_rateLimited), findsNothing);
    expect(
      find.textContaining(_fr.notice_retryAfter(0).split('0').first),
      findsNothing,
    );
    final submit = find.byKey(const ValueKey('google-profile-submit'));
    expect(tester.widget<ButtonStyleButton>(submit).onPressed, isNotNull);
  });
}

void _staleExitMessageTests() {
  testWidgets('A03-google-03 cancelFailed disappears once the attempt resumes '
      'and a later error is visible', (tester) async {
    final f = _Fixture(status: 'link_required');
    addTearDown(f.app.dispose);
    await f.open(tester, GoogleAuthPurpose.authenticate);
    f.api.cancelFailure = _offline;
    await tester.tap(find.byType(BackButton));
    await tester.pumpAndSettle();
    expect(find.text(_fr.google_cancelFailed), findsOneWidget);
    f.api.cancelFailure = null;
    await tester.ensureVisible(find.byKey(const ValueKey('google-resume')));
    await tester.tap(find.byKey(const ValueKey('google-resume')));
    await tester.pumpAndSettle();
    expect(f.auth.state.step, GoogleAuthStep.linkRequired);
    expect(find.text(_fr.google_cancelFailed), findsNothing);
    await tester.enterText(
      find.byKey(const ValueKey('google-fuze-password')),
      'wrong-password',
    );
    f.api.linkFailure = const ApiException(
      statusCode: 400,
      errorCode: 'invalid_current_password',
    );
    await tester.tap(find.byKey(const ValueKey('google-password-confirm')));
    await tester.pumpAndSettle();
    expect(f.auth.state.messageKey, 'google.invalidPassword');
    expect(find.text(_fr.google_invalidPassword), findsOneWidget);
    expect(find.text(_fr.google_cancelFailed), findsNothing);
  });

  testWidgets('A03-google-03 a failed restart cancellation is replaced by the '
      'next state message', (tester) async {
    final f = _Fixture(status: 'registration_required', canBegin: false);
    addTearDown(f.app.dispose);
    f.store.payload = _storedIntent();
    await f.open(tester, GoogleAuthPurpose.authenticate);
    f.api.cancelFailure = _offline;
    await tester.tap(find.byKey(const ValueKey('google-restart')));
    await tester.pumpAndSettle();
    expect(find.text(_fr.google_cancelFailed), findsOneWidget);
    f.api.cancelFailure = null;
    f.canBegin = true;
    await tester.ensureVisible(find.byKey(const ValueKey('google-resume')));
    await tester.tap(find.byKey(const ValueKey('google-resume')));
    await tester.pumpAndSettle();
    expect(f.auth.state.step, GoogleAuthStep.registrationRequired);
    expect(find.text(_fr.google_cancelFailed), findsNothing);
  });
}

void _countryOrderTests() {
  const cases = <String, List<String>>{
    'fr': ['Égypte', 'Espagne', 'Estonie', 'États-Unis', 'Éthiopie'],
    'en': ['Afghanistan', 'Åland Islands', 'Albania'],
    'de': ['Ägypten', 'Oman', 'Österreich', 'Pakistan'],
    'tr': ['Çin', 'Irak', 'İran', 'İsveç', 'Şili', 'Türkiye'],
    'uk': ['Естонія', 'Ємен', 'Ізраїль', 'Італія', 'Йорданія', 'Японія'],
    'th': ['แคนาดา', 'ชาด', 'ไต้หวัน', 'ไทย', 'เยอรมนี'],
    // Témoin: Swedish already places Å, Ä and Ö after Z.
    'sv': ['Vietnam', 'Västsahara', 'Zimbabwe', 'Åland', 'Österrike'],
  };
  const last = <String, String>{
    'fr': 'Zimbabwe',
    'en': 'Zimbabwe',
    'de': 'Zypern',
    'tr': 'Zimbabve',
    'uk': 'Японія',
  };
  for (final MapEntry(key: language, value: expected) in cases.entries) {
    testWidgets('A03-google-04 Google country picker follows the $language '
        'alphabet', (tester) async {
      final f = _Fixture(status: 'registration_required');
      f.app.locale = Locale(language);
      addTearDown(f.app.dispose);
      await f.open(tester, GoogleAuthPurpose.authenticate);
      expect(f.auth.state.step, GoogleAuthStep.registrationRequired);
      final labels = tester
          .widget<DropdownButton<String>>(find.byType(DropdownButton<String>))
          .items!
          .map((item) => (item.child as Text).data!)
          .toList();
      final positions = [for (final name in expected) labels.indexOf(name)];
      expect(positions, isNot(contains(-1)), reason: '$labels');
      expect(positions, [...positions]..sort(), reason: expected.join(' < '));
      if (last[language] case final String name) {
        expect(labels.last, name);
      }
      expect(labels.toSet(), hasLength(labels.length));
    });
  }
}

void _persistedTicketTests() {
  testWidgets('C5-03 a refused begin explains itself and Cancel cancels the '
      'persisted intent on the server before leaving', (tester) async {
    final f = _Fixture(status: 'registration_required', canBegin: false);
    addTearDown(f.app.dispose);
    f.store.payload = _storedIntent();
    await f.open(tester, GoogleAuthPurpose.authenticate);
    expect(f.auth.state.step, GoogleAuthStep.idle);
    expect(f.auth.state.messageKey, isNotNull);
    expect(
      find.descendant(of: find.byType(FuzePanel), matching: find.byType(Text)),
      findsOneWidget,
    );
    expect(f.store.reads, 0);
    await tester.tap(find.byKey(const ValueKey('google-cancel')));
    await tester.pumpAndSettle();
    expect(f.api.cancelledTickets, ['stored-continuation-ticket']);
    expect(f.store.payload, isNull);
    expect(find.byType(GoogleAuthenticationPage), findsNothing);
  });

  testWidgets('C5-03 Continue with Google never orphans the persisted intent', (
    tester,
  ) async {
    final f = _Fixture(status: 'registration_required', canBegin: false);
    addTearDown(f.app.dispose);
    f.store.payload = _storedIntent();
    await f.open(tester, GoogleAuthPurpose.authenticate);
    await tester.tap(find.byKey(const ValueKey('google-restart')));
    await tester.pumpAndSettle();
    expect(f.api.cancelledTickets, ['stored-continuation-ticket']);
    expect(f.store.payload, isNull);
    expect(f.gateway.selections, 0);
    expect(find.byType(GoogleAuthenticationPage), findsOneWidget);
    f.canBegin = true;
    await tester.tap(find.byKey(const ValueKey('google-restart')));
    await tester.pumpAndSettle();
    expect(f.gateway.selections, 1);
    expect(f.auth.state.step, GoogleAuthStep.registrationRequired);
    expect(f.api.cancelledTickets, hasLength(1));
  });

  testWidgets('C5-03 an unconfirmed cancellation keeps the persisted intent '
      'and the screen', (tester) async {
    final f = _Fixture(status: 'registration_required', canBegin: false);
    addTearDown(f.app.dispose);
    f.store.payload = _storedIntent();
    await f.open(tester, GoogleAuthPurpose.authenticate);
    f.api.cancelFailure = _offline;
    await tester.tap(find.byKey(const ValueKey('google-cancel')));
    await tester.pumpAndSettle();
    expect(find.byType(GoogleAuthenticationPage), findsOneWidget);
    expect(find.text(_fr.google_cancelFailed), findsOneWidget);
    expect(find.byKey(const ValueKey('google-resume')), findsOneWidget);
    expect(f.store.payload, _storedIntent());
    expect(f.auth.hasPendingIntent, isTrue);
  });
}

/// Reprise après la revue adversariale du 29/10 (checks/review-R2-google,
/// variantes P1 à P5 de la page réelle), assertions du comportement corrigé.
void _reviewFollowUpTests() {
  testWidgets('Review P1 a persistently unreadable ticket never traps Cancel, '
      'Back or Continue with Google', (tester) async {
    final f = _Fixture(status: 'registration_required');
    addTearDown(f.app.dispose);
    f.store.payload = _storedIntent();
    f.store.readFailure = GoogleCredentialException('secure_storage_failed');
    await f.open(tester, GoogleAuthPurpose.authenticate);
    expect(find.text(_fr.google_unavailable), findsOneWidget);
    await tester.ensureVisible(find.byKey(const ValueKey('google-cancel')));
    await tester.tap(find.byKey(const ValueKey('google-cancel')));
    await tester.pumpAndSettle();
    expect(find.byType(GoogleAuthenticationPage), findsNothing);

    await tester.tap(find.byKey(const ValueKey('open')));
    await tester.pumpAndSettle();
    await tester.tap(find.byType(BackButton));
    await tester.pumpAndSettle();
    expect(find.byType(GoogleAuthenticationPage), findsNothing);

    await tester.tap(find.byKey(const ValueKey('open')));
    await tester.pumpAndSettle();
    await tester.ensureVisible(find.byKey(const ValueKey('google-restart')));
    await tester.tap(find.byKey(const ValueKey('google-restart')));
    await tester.pumpAndSettle();
    expect(find.byType(GoogleAuthenticationPage), findsOneWidget);
    expect(find.text(_fr.google_unavailable), findsOneWidget);
    expect(find.text(_fr.google_cancelFailed), findsNothing);
    expect(f.gateway.selections, 0);

    // Never erased without a server confirmation, never replaced.
    expect(f.store.payload, _storedIntent());
    expect(f.api.cancelledTickets, isEmpty);
    f.store.readFailure = null;
    await tester.tap(find.byType(BackButton));
    await tester.pumpAndSettle();
    expect(find.byType(GoogleAuthenticationPage), findsNothing);
    expect(f.api.cancelledTickets, ['stored-continuation-ticket']);
    expect(f.store.payload, isNull);
  });

  testWidgets('Review P2 a 429 with Retry-After 0 is explained on an enabled '
      'form', (tester) async {
    final now = DateTime.utc(2026, 10, 29, 12);
    final f = _Fixture(status: 'link_required', now: () => now);
    addTearDown(f.app.dispose);
    await f.open(tester, GoogleAuthPurpose.authenticate);
    await tester.enterText(
      find.byKey(const ValueKey('google-fuze-password')),
      'fixture-password',
    );
    f.api.linkFailure = const ApiException(
      statusCode: 429,
      errorCode: 'rate_limited',
      retryAfterSeconds: 0,
    );
    final confirm = find.byKey(const ValueKey('google-password-confirm'));
    await tester.tap(confirm);
    await tester.pumpAndSettle();
    expect(find.text(_fr.google_rateLimited), findsOneWidget);
    expect(find.byKey(const ValueKey('google-retry-countdown')), findsNothing);
    expect(tester.widget<ButtonStyleButton>(confirm).onPressed, isNotNull);
  });

  testWidgets('Review P3 a later 429 without Retry-After is explained after '
      'an expired countdown', (tester) async {
    var now = DateTime.utc(2026, 10, 29, 12);
    final f = _Fixture(status: 'link_required', now: () => now);
    addTearDown(f.app.dispose);
    await f.open(tester, GoogleAuthPurpose.authenticate);
    await tester.enterText(
      find.byKey(const ValueKey('google-fuze-password')),
      'fixture-password',
    );
    f.api.linkFailure = const ApiException(
      statusCode: 429,
      errorCode: 'rate_limited',
      retryAfterSeconds: 10,
    );
    final confirm = find.byKey(const ValueKey('google-password-confirm'));
    await tester.tap(confirm);
    await tester.pumpAndSettle();
    expect(find.text(_fr.google_rateLimited), findsOneWidget);
    expect(find.text(_fr.notice_retryAfter(10)), findsOneWidget);
    expect(tester.widget<ButtonStyleButton>(confirm).onPressed, isNull);

    now = now.add(const Duration(seconds: 10));
    await tester.pump(const Duration(seconds: 1));
    await tester.pump();
    // The limit message of that expired deadline is no longer shown.
    expect(find.text(_fr.google_rateLimited), findsNothing);
    expect(tester.widget<ButtonStyleButton>(confirm).onPressed, isNotNull);

    now = now.add(const Duration(seconds: 1));
    f.api.linkFailure = const ApiException(
      statusCode: 429,
      errorCode: 'rate_limited',
    );
    await tester.ensureVisible(confirm);
    await tester.tap(confirm);
    await tester.pumpAndSettle();
    expect(f.api.linkCalls, 2);
    expect(find.text(_fr.google_rateLimited), findsOneWidget);
    expect(find.byKey(const ValueKey('google-retry-countdown')), findsNothing);
  });

  testWidgets('Review P4 claim Turnstile refusal during Back + failed '
      'cancellation: the visible challenge action leads to a proven claim', (
    tester,
  ) async {
    final f = _Fixture(status: 'guest_claim_required', guest: true);
    addTearDown(f.app.dispose);
    await f.open(tester, GoogleAuthPurpose.claim);
    expect(f.auth.state.step, GoogleAuthStep.guestClaimRequired);
    final entered = Completer<void>();
    final reply = Completer<void>();
    f.api.finalizeGate = () {
      entered.complete();
      return reply.future;
    };
    f.api.claimFailure = const ApiException(
      statusCode: 403,
      errorCode: 'turnstile_required',
    );
    final claiming = f.auth.completeProfile(
      countryCode: 'FR',
      termsAccepted: true,
      privacyAccepted: true,
    );
    await tester.pump();
    expect(entered.isCompleted, isTrue);
    f.api.cancelFailure = _offline;
    await tester.tap(find.byType(BackButton));
    await tester.pump();
    reply.complete();
    await claiming;
    await tester.pumpAndSettle();
    f.api.finalizeGate = null;
    f.api.cancelFailure = null;
    f.api.claimFailure = null;
    expect(find.byType(GoogleAuthenticationPage), findsOneWidget);
    expect(find.text(_fr.google_cancelFailed), findsOneWidget);

    final challenge = find.byKey(const ValueKey('google-solve-challenge'));
    await tester.ensureVisible(challenge);
    await tester.tap(challenge);
    await tester.pumpAndSettle();
    expect(f.security.solves, 1);
    expect(f.auth.state.step, GoogleAuthStep.guestClaimRequired);
    expect(find.text(_fr.google_challengeReady), findsOneWidget);

    f.claimed = true;
    await _submitProfile(tester);
    expect(f.api.claims, 2);
    expect(f.api.claimTokens, [null, 'proof']);
    expect(f.auth.state.step, GoogleAuthStep.authenticated);
  });

  testWidgets('Review P5 at the deadline a stale limit message beside the '
      'challenge action gives way to the challenge message', (tester) async {
    var now = DateTime.utc(2026, 10, 29, 12);
    final f = _Fixture(
      status: 'guest_claim_required',
      guest: true,
      now: () => now,
    );
    addTearDown(f.app.dispose);
    await f.open(tester, GoogleAuthPurpose.claim);
    final entered = Completer<void>();
    final reply = Completer<void>();
    f.api.finalizeGate = () {
      entered.complete();
      return reply.future;
    };
    f.api.claimFailure = const ApiException(
      statusCode: 403,
      errorCode: 'turnstile_unavailable',
      retryAfterSeconds: 30,
    );
    final claiming = f.auth.completeProfile(
      countryCode: 'FR',
      termsAccepted: true,
      privacyAccepted: true,
    );
    await tester.pump();
    f.api.cancelFailure = _offline;
    await tester.tap(find.byType(BackButton));
    await tester.pump();
    reply.complete();
    await claiming;
    await tester.pumpAndSettle();
    f.api.finalizeGate = null;
    f.api.cancelFailure = null;
    f.api.claimFailure = null;
    final challenge = find.byKey(const ValueKey('google-solve-challenge'));
    expect(tester.widget<ButtonStyleButton>(challenge).onPressed, isNull);
    expect(find.text(_fr.notice_retryAfter(30)), findsOneWidget);

    await f.auth.resume();
    await tester.pumpAndSettle();
    expect(find.text(_fr.google_rateLimited), findsOneWidget);
    expect(tester.widget<ButtonStyleButton>(challenge).onPressed, isNull);

    now = now.add(const Duration(seconds: 30));
    await tester.pump(const Duration(seconds: 1));
    await tester.pump();
    expect(tester.widget<ButtonStyleButton>(challenge).onPressed, isNotNull);
    expect(find.text(_fr.google_rateLimited), findsNothing);
    expect(find.text(_fr.google_challengeRequired), findsOneWidget);
    expect(find.byKey(const ValueKey('google-retry-countdown')), findsNothing);
    await tester.ensureVisible(challenge);
    await tester.tap(challenge);
    await tester.pumpAndSettle();
    expect(f.security.solves, 1);
    // Leaving discards the proof and its expiry timer.
    await tester.tap(find.byType(BackButton));
    await tester.pumpAndSettle();
    expect(find.byType(GoogleAuthenticationPage), findsNothing);
  });
}

/// Fills the reopened claim/registration form through the page and submits.
Future<void> _submitProfile(WidgetTester tester) async {
  final country = find.byKey(const ValueKey('google-country'));
  await tester.ensureVisible(country);
  await tester.tap(country);
  await tester.pumpAndSettle();
  await tester.scrollUntilVisible(
    find.text('France'),
    200,
    scrollable: find.byType(Scrollable).last,
  );
  await tester.pumpAndSettle();
  await tester.tap(find.text('France').last);
  await tester.pumpAndSettle();
  for (final key in ['google-terms-consent', 'google-privacy-consent']) {
    await tester.ensureVisible(find.byKey(ValueKey(key)));
    await tester.tap(find.byKey(ValueKey(key)));
    await tester.pumpAndSettle();
  }
  final submit = find.byKey(const ValueKey('google-profile-submit'));
  await tester.ensureVisible(submit);
  await tester.tap(submit);
  await tester.pumpAndSettle();
}

/// End of the second review round, after the crash: a persisted ticket that
/// can never be decrypted again (secure_storage_corrupt: AEADBadTag, lost
/// Keystore key) no longer opens the Google screen on « unavailable ».
void _afterCrashTests() {
  testWidgets('After crash V1 an unrecoverable ticket is dropped when the '
      'screen opens: the failure is explained and Continue with Google '
      'proceeds', (tester) async {
    final f = _Fixture(status: 'registration_required');
    addTearDown(f.app.dispose);
    f.store.payload = _storedIntent();
    f.store.readFailure = GoogleCredentialException('secure_storage_corrupt');
    await f.open(tester, GoogleAuthPurpose.authenticate);
    expect(find.byType(GoogleAuthenticationPage), findsOneWidget);
    expect(find.text(_fr.google_error), findsOneWidget);
    expect(find.text(_fr.google_unavailable), findsNothing);
    expect(f.store.clears, 1);
    expect(f.store.payload, isNull);
    expect(f.api.cancelledTickets, isEmpty);
    expect(f.gateway.selections, 0);

    await tester.ensureVisible(find.byKey(const ValueKey('google-restart')));
    await tester.tap(find.byKey(const ValueKey('google-restart')));
    await tester.pumpAndSettle();
    expect(f.gateway.selections, 1);
    expect(f.auth.state.step, GoogleAuthStep.registrationRequired);
    expect(find.text(_fr.google_error), findsNothing);
    expect(f.api.cancelledTickets, isEmpty);
  });

  testWidgets('After crash V1 control: Cancel leaves at once once the '
      'unrecoverable ticket is dropped', (tester) async {
    final f = _Fixture(status: 'registration_required');
    addTearDown(f.app.dispose);
    f.store.payload = _storedIntent();
    f.store.readFailure = GoogleCredentialException('secure_storage_corrupt');
    await f.open(tester, GoogleAuthPurpose.authenticate);
    await tester.ensureVisible(find.byKey(const ValueKey('google-cancel')));
    await tester.tap(find.byKey(const ValueKey('google-cancel')));
    await tester.pumpAndSettle();
    expect(find.byType(GoogleAuthenticationPage), findsNothing);
    expect(f.store.clears, 1);
    expect(f.store.payload, isNull);
    expect(f.api.cancelledTickets, isEmpty);
    expect(f.gateway.selections, 0);
  });
}

String _storedIntent() => jsonEncode(<String, Object?>{
  'version': 1,
  'request_id': 'request-fixture-0001',
  'purpose': 'authenticate',
  'stage': 'continuation',
  'ticket': 'stored-continuation-ticket',
  'context': 'browser-fixture',
  'expires_at': '2099-01-01T00:00:00.000Z',
  'generation': 1,
});

class _Fixture {
  _Fixture({
    required String status,
    bool guest = false,
    DateTime Function()? now,
    this.canBegin = true,
  }) {
    api.status = status;
    final identity = GoogleIdentitySnapshot(
      userId: guest ? 'guest-fixture' : null,
      accessToken: guest ? 'guest-bearer-fixture' : null,
      isGuest: guest,
    );
    auth = GoogleAuthController(
      api: api,
      gateway: gateway,
      pendingStore: store,
      challengeGateway: security,
      now: now,
      identity: () => identity,
      identityMatches: (_) => true,
      canBegin: (_) => canBegin,
      admitSession: (result, before, isCurrent) async => isCurrent(),
      admitClaim: (before, isCurrent) async {
        final failure = claimReadFailure;
        if (failure != null) throw failure;
        return claimed && isCurrent();
      },
    );
    app = WelcomeUiController(googleAuth: auth);
    if (guest) app.profile = guestUiProfile(canUseVpn: true);
  }

  final api = _Api();
  final gateway = _Gateway();
  final store = _Store();
  final security = _Security();
  late final GoogleAuthController auth;
  late final WelcomeUiController app;
  bool canBegin;
  bool claimed = false;
  Object? claimReadFailure;

  Future<void> open(WidgetTester tester, GoogleAuthPurpose purpose) async {
    await tester.pumpWidget(
      welcomeUiTestApp(
        app,
        Builder(
          builder: (context) => Scaffold(
            body: FilledButton(
              key: const ValueKey('open'),
              onPressed: () =>
                  unawaited(openGoogleAuthentication(context, app, purpose)),
              child: const Text('open'),
            ),
          ),
        ),
      ),
    );
    await tester.tap(find.byKey(const ValueKey('open')));
    await tester.pumpAndSettle();
  }
}

class _Store implements GooglePendingAuthStore {
  String? payload;
  Object? readFailure;
  int reads = 0, clears = 0;
  @override
  Future<String?> readPendingAuthentication() async {
    reads++;
    final failure = readFailure;
    if (failure != null) throw failure;
    return payload;
  }

  @override
  Future<void> writePendingAuthentication(String value) async {
    payload = value;
  }

  @override
  Future<void> clearPendingAuthentication() async {
    clears++;
    // Like the native slot: removing the entry removes what made it unreadable.
    payload = null;
    readFailure = null;
  }
}

class _Gateway implements GoogleCredentialGateway {
  int selections = 0;
  @override
  Future<GoogleCredentialCapabilities> getCapabilities() async =>
      const GoogleCredentialCapabilities(supported: true);
  @override
  Future<GoogleCredentialResult> signIn({
    required String requestId,
    required String serverClientId,
    required String nonce,
  }) async {
    selections++;
    return GoogleCredentialResult(
      requestId: requestId,
      idToken: 'google-jwt-fixture',
    );
  }

  @override
  Future<void> cancelSignIn({required String requestId}) async {}
  @override
  Future<void> clearCredentialState() async {}
}

class _Security implements SecurityChallengeGateway {
  int solves = 0;
  @override
  Future<SecurityChallengeResult> solve({
    required String requestId,
    required String title,
    required String cancelLabel,
  }) async {
    solves++;
    return SecurityChallengeResult(requestId: requestId, token: 'proof');
  }

  @override
  Future<void> cancel({required String requestId}) async {}
}

class _Api implements GoogleAuthApiRepository {
  String status = 'registration_required';
  int linkCalls = 0, claims = 0;
  Object? cancelFailure, linkFailure, claimFailure;
  Future<void> Function()? finalizeGate;
  final cancelledTickets = <String>[];
  final claimTokens = <String?>[];
  final _browser = GoogleBrowserContext(
    browserContextToken: 'browser-fixture',
    authGeneration: 1,
    expiresAt: _expiry,
  );

  String get _purpose =>
      status == 'guest_claim_required' ? 'claim' : 'authenticate';

  @override
  Future<GoogleBrowserContext> createGoogleBrowserContext({
    String? token,
    String? browserContextToken,
  }) async => _browser;
  @override
  Future<GoogleAuthChallenge> createGoogleChallenge({
    required GoogleBrowserContext browserContext,
    required String purpose,
    String? token,
  }) async => GoogleAuthChallenge(
    challengeId: 'challenge-fixture',
    nonce: 'nonce-fixture',
    contextToken: 'initial-ticket-fixture',
    expiresAt: _expiry,
  );
  @override
  Future<GoogleAuthResult> verifyGoogleCredential({
    required GoogleBrowserContext browserContext,
    required String contextToken,
    required String challengeId,
    required String credential,
  }) async => GoogleContinuationResult(
    status: status,
    contextToken: 'rotated-ticket-fixture',
    expiresAt: _expiry,
  );
  @override
  Future<GoogleAuthContext> getGoogleContext({
    required GoogleBrowserContext browserContext,
    required String contextToken,
  }) async => GoogleAuthContext(
    status: status,
    purpose: _purpose,
    expiresAt: _expiry,
    email: 'identity@example.test',
  );
  @override
  Future<GoogleAuthenticatedResult> linkGoogleWithPassword({
    required GoogleBrowserContext browserContext,
    required String contextToken,
    required String currentPassword,
  }) async {
    linkCalls++;
    if (finalizeGate != null) await finalizeGate!();
    final failure = linkFailure;
    if (failure != null) throw failure;
    return GoogleAuthenticatedResult(
      session: AuthSession(
        accessToken: 'final-fuze-fixture',
        expiresAt: _expiry,
      ),
    );
  }

  @override
  Future<void> cancelGoogleAuth({
    required GoogleBrowserContext browserContext,
    required String contextToken,
    String? challengeId,
  }) async {
    cancelledTickets.add(contextToken);
    final failure = cancelFailure;
    if (failure != null) throw failure;
  }

  @override
  Future<GoogleAuthenticatedResult> registerGoogleAccount({
    required GoogleBrowserContext browserContext,
    required String contextToken,
    required String countryCode,
    required bool termsAccepted,
    required bool privacyAccepted,
    String? turnstileToken,
  }) => throw UnimplementedError();
  @override
  Future<GoogleGuestClaimResult> claimGuestWithGoogle({
    required GoogleBrowserContext browserContext,
    required String contextToken,
    required String countryCode,
    required bool termsAccepted,
    required bool privacyAccepted,
    String? turnstileToken,
  }) async {
    claims++;
    claimTokens.add(turnstileToken);
    if (finalizeGate != null) await finalizeGate!();
    final failure = claimFailure;
    if (failure != null) throw failure;
    return const GoogleGuestClaimResult(
      userId: 'guest-fixture',
      emailVerified: true,
    );
  }

  @override
  Future<void> requestGoogleLinkEmail({
    required GoogleBrowserContext browserContext,
    required String contextToken,
  }) async {}
  @override
  Future<GoogleAuthenticatedResult> confirmGoogleLinkEmail({
    required GoogleBrowserContext browserContext,
    required String contextToken,
    required String code,
  }) => throw UnimplementedError();
  @override
  Future<AuthSession> loginWithAuthContext({
    required GoogleBrowserContext browserContext,
    required String email,
    required String password,
  }) => throw UnimplementedError();
}
