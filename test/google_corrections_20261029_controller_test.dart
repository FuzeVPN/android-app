// Corrections du 29/10/2026, sous-lot R2-google : A03-google-01, A03-google-02,
// H-RA-A08-01-04 et C5-Analyseurs-stricts-face-au-con-03. Les contre-exemples
// exécutés par l'audit complet du 28/10 (repros/A03-google, repros/H-RA-A08-01,
// repros/C5-Analyseurs-stricts-face-au-con) sont portés ici avec les
// assertions du comportement corrigé, plus des variantes et des témoins.
// Contrôleur Google de production ; API, stockage chiffré, sélecteur
// Credential Manager et défi de sécurité simulés, sans réseau.
import 'dart:async';
import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fuzevpn_android/core/api_exception.dart';
import 'package:fuzevpn_android/core/google_auth.dart';
import 'package:fuzevpn_android/core/google_credentials.dart';
import 'package:fuzevpn_android/core/models.dart';
import 'package:fuzevpn_android/core/security_challenge.dart';
import 'package:fuzevpn_android/google_auth_controller.dart';

final _expiry = DateTime.utc(2099);
final _browser = GoogleBrowserContext(
  browserContextToken: 'browser-fixture',
  authGeneration: 3,
  expiresAt: _expiry,
);
final _challenge = GoogleAuthChallenge(
  challengeId: 'challenge-fixture',
  nonce: 'exact-server-nonce',
  contextToken: 'initial-ticket-fixture',
  expiresAt: _expiry,
);
final _authenticated = GoogleAuthenticatedResult(
  session: AuthSession(accessToken: 'final-fuze-fixture', expiresAt: _expiry),
);
const _limited = ApiException(
  statusCode: 429,
  errorCode: 'rate_limited',
  retryAfterSeconds: 120,
);
const _offline = ApiNetworkException(code: 'network_timeout');

/// A ticket left by an earlier process, as the native store returns it.
String _storedIntent({
  String stage = 'continuation',
  String purpose = 'authenticate',
  String? userId,
}) => jsonEncode(<String, Object?>{
  'version': 1,
  'request_id': 'request-fixture-0001',
  'purpose': purpose,
  'stage': stage,
  'ticket': 'stored-$stage-ticket',
  'context': 'browser-fixture',
  'expires_at': '2099-01-01T00:00:00.000Z',
  'generation': 3,
  if (stage == 'challenge') 'challenge_id': 'stored-challenge-id',
  if (userId != null) 'user_id': userId,
});

void main() {
  _retryAfterDuringBackTests();
  _claimTurnstileTests();
  _rateLimitedFormTests();
  _persistedTicketCancellationTests();
  _reviewFollowUpTests();
  _reviewRound2Tests();
  _afterCrashTests();
  _finalMinorTests();
  _confirmedCancellationMemoryTests();
}

void _retryAfterDuringBackTests() {
  group('A03-google-01 a Retry-After received during Back is kept', () {
    for (final kind in ['claim', 'register', 'link', 'email']) {
      test(
        '$kind 429 during Back with a failed cancellation blocks until expiry',
        () async {
          var now = DateTime.utc(2026, 10, 29, 12);
          final h = _H(guest: kind == 'claim', now: () => now);
          addTearDown(h.close);
          if (kind == 'link' || kind == 'email') {
            h.api.continuationStatus = 'link_required';
          }
          await h.c.begin(
            kind == 'claim'
                ? GoogleAuthPurpose.claim
                : GoogleAuthPurpose.authenticate,
          );
          if (kind == 'email') {
            await h.c.requestEmailLink();
            expect(h.c.state.emailRequested, isTrue);
          }
          Future<void> finalize() => switch (kind) {
            'claim' || 'register' => h.submit(),
            'link' => h.c.linkWithPassword('fixture-password'),
            _ => h.c.confirmEmailLink('FIXTURE-CODE'),
          };
          int calls() => switch (kind) {
            'claim' => h.api.claims,
            'register' => h.api.registrations,
            _ => h.api.linkCalls,
          };
          final entered = Completer<void>();
          final reply = Completer<void>();
          h.api.finalizeGate = () {
            entered.complete();
            return reply.future;
          };
          final finalizing = finalize();
          await entered.future;
          h.api.cancelFailure = _offline;
          final cancelling = h.c.cancel();
          reply.completeError(_limited);
          await finalizing;
          final cancelled = await cancelling;
          final deadline = now.add(const Duration(seconds: 120));
          expect(cancelled, isFalse);
          expect(h.c.state.messageKey, 'google.cancelFailed');
          expect(h.c.state.retryAfter, deadline);
          expect(h.c.hasPendingIntent, isTrue);

          h.api.finalizeGate = null;
          h.api.cancelFailure = null;
          await h.c.resume();
          expect(h.c.state.step, switch (kind) {
            'claim' => GoogleAuthStep.guestClaimRequired,
            'register' => GoogleAuthStep.registrationRequired,
            _ => GoogleAuthStep.linkRequired,
          });
          expect(h.c.state.retryAfter, deadline);
          expect(h.c.state.messageKey, 'google.rateLimited');
          await finalize();
          expect(calls(), 1);
          now = deadline.subtract(const Duration(microseconds: 1));
          await finalize();
          expect(calls(), 1);
          now = deadline;
          h.claimed = true;
          await finalize();
          expect(calls(), 2);
          expect(h.c.state.step, GoogleAuthStep.authenticated);
          expect(h.c.state.retryAfter, isNull);
        },
      );
    }

    test(
      'email request 429 during Back with a failed cancellation is kept',
      () async {
        var now = DateTime.utc(2026, 10, 29, 12);
        final h = _H(now: () => now);
        addTearDown(h.close);
        h.api.continuationStatus = 'link_required';
        await h.c.begin(GoogleAuthPurpose.authenticate);
        final entered = Completer<void>();
        final reply = Completer<void>();
        h.api.emailGate = () {
          entered.complete();
          return reply.future;
        };
        final requesting = h.c.requestEmailLink();
        await entered.future;
        h.api.cancelFailure = _offline;
        final cancelling = h.c.cancel();
        reply.completeError(_limited);
        await requesting;
        expect(await cancelling, isFalse);
        final deadline = now.add(const Duration(seconds: 120));
        expect(h.c.state.retryAfter, deadline);
        h.api.emailGate = null;
        h.api.cancelFailure = null;
        await h.c.resume();
        await h.c.requestEmailLink();
        await h.c.linkWithPassword('fixture-password');
        expect(h.api.emailRequests, 1);
        expect(h.api.linkCalls, 0);
        now = deadline;
        await h.c.requestEmailLink();
        expect(h.api.emailRequests, 2);
      },
    );

    test(
      'a confirmed cancellation still forgets the cancelled intent deadline',
      () async {
        final now = DateTime.utc(2026, 10, 29, 12);
        final h = _H(now: () => now);
        addTearDown(h.close);
        await h.c.begin(GoogleAuthPurpose.authenticate);
        final entered = Completer<void>();
        final reply = Completer<void>();
        h.api.finalizeGate = () {
          entered.complete();
          return reply.future;
        };
        final finalizing = h.submit();
        await entered.future;
        final cancelling = h.c.cancel();
        reply.completeError(_limited);
        await finalizing;
        expect(await cancelling, isTrue);
        expect(h.c.state.retryAfter, isNull);
        expect(h.store.payload, isNull);
        expect(h.api.cancelledTickets, ['rotated-ticket-fixture']);
        h.api.finalizeGate = null;
        await h.c.begin(GoogleAuthPurpose.authenticate);
        expect(h.c.state.step, GoogleAuthStep.registrationRequired);
        expect(h.c.state.retryAfter, isNull);
        expect(h.c.state.messageKey, isNull);
        await h.submit();
        expect(h.api.registrations, 2);
        expect(h.c.state.step, GoogleAuthStep.authenticated);
      },
    );

    test(
      'a Turnstile refusal received during Back survives a failed cancellation',
      () async {
        final h = _H();
        addTearDown(h.close);
        await h.c.begin(GoogleAuthPurpose.authenticate);
        final entered = Completer<void>();
        final reply = Completer<void>();
        h.api.finalizeGate = () {
          entered.complete();
          return reply.future;
        };
        final finalizing = h.submit();
        await entered.future;
        h.api.cancelFailure = _offline;
        final cancelling = h.c.cancel();
        reply.completeError(
          const ApiException(statusCode: 403, errorCode: 'turnstile_required'),
        );
        await finalizing;
        expect(await cancelling, isFalse);
        expect(h.c.state.block, GoogleAuthBlock.securityChallenge);
        h.api.finalizeGate = null;
        h.api.cancelFailure = null;
        await h.c.resume();
        // The form context is reloaded, so the challenge stays solvable.
        expect(h.c.state.block, GoogleAuthBlock.securityChallenge);
        expect(h.c.state.securityChallengeRequired, isTrue);
        expect(h.c.state.context?.status, 'registration_required');
        expect(h.c.state.messageKey, 'google.challengeRequired');
        await h.submit();
        expect(h.api.registrations, 1);
        await h.c.solveSecurityChallenge(title: 'title', cancelLabel: 'cancel');
        expect(h.security.solves, 1);
        expect(h.c.state.step, GoogleAuthStep.registrationRequired);
        await h.submit();
        expect(h.api.registrations, 2);
        expect(h.api.turnstileTokens, [null, 'proof-fixture']);
        expect(h.c.state.step, GoogleAuthStep.authenticated);
      },
    );
  });
}

void _claimTurnstileTests() {
  group('A03-google-02 a claim Turnstile refusal survives a failing /me', () {
    for (final code in [
      'turnstile_required',
      'turnstile_invalid',
      'turnstile_unavailable',
    ]) {
      for (final readFailure in <Object>[
        _offline,
        const ApiException(statusCode: 401, errorCode: 'unauthorized'),
        const ApiProtocolException(),
      ]) {
        test('$code then /me ${readFailure.runtimeType} keeps the challenge '
            'block and never sends a second claim without proof', () async {
          final h = _H(guest: true);
          addTearDown(h.close);
          await h.c.begin(GoogleAuthPurpose.claim);
          h.api.claimFailure = ApiException(statusCode: 403, errorCode: code);
          h.claimReadFailure = readFailure;
          await h.submit();
          expect(h.c.state.block, GoogleAuthBlock.securityChallenge);
          expect(h.c.state.securityChallengeRequired, isTrue);
          expect(h.c.state.step, GoogleAuthStep.uncertain);
          expect(h.c.state.context?.status, 'guest_claim_required');
          expect(h.api.claims, 1);

          h.claimReadFailure = null;
          await h.c.resume();
          expect(h.c.state.block, GoogleAuthBlock.securityChallenge);
          await h.submit();
          expect(h.api.claims, 1);

          h.api.claimFailure = null;
          await h.c.solveSecurityChallenge(
            title: 'title',
            cancelLabel: 'cancel',
          );
          expect(h.c.state.step, GoogleAuthStep.guestClaimRequired);
          h.claimed = true;
          await h.submit();
          expect(h.api.claims, 2);
          expect(h.api.turnstileTokens, [null, 'proof-fixture']);
          expect(h.c.state.step, GoogleAuthStep.authenticated);
        });
      }
    }

    test(
      'control: an unconverted /me still blocks with the challenge message',
      () async {
        final h = _H(guest: true);
        addTearDown(h.close);
        await h.c.begin(GoogleAuthPurpose.claim);
        h.api.claimFailure = const ApiException(
          statusCode: 403,
          errorCode: 'turnstile_required',
        );
        await h.submit();
        expect(h.c.state.block, GoogleAuthBlock.securityChallenge);
        expect(h.c.state.messageKey, 'google.challengeRequired');
        await h.c.resume();
        await h.submit();
        expect(h.api.claims, 1);
      },
    );

    test('a Turnstile refusal with Retry-After keeps both blocks', () async {
      var now = DateTime.utc(2026, 10, 29, 12);
      final h = _H(guest: true, now: () => now);
      addTearDown(h.close);
      await h.c.begin(GoogleAuthPurpose.claim);
      h.api.claimFailure = const ApiException(
        statusCode: 403,
        errorCode: 'turnstile_unavailable',
        retryAfterSeconds: 30,
      );
      h.claimReadFailure = _offline;
      await h.submit();
      final deadline = now.add(const Duration(seconds: 30));
      expect(h.c.state.block, GoogleAuthBlock.securityChallenge);
      expect(h.c.state.retryAfter, deadline);
      h.claimReadFailure = null;
      await h.c.solveSecurityChallenge(title: 'title', cancelLabel: 'cancel');
      expect(h.security.solves, 0);
      now = deadline;
      await h.c.solveSecurityChallenge(title: 'title', cancelLabel: 'cancel');
      expect(h.security.solves, 1);
    });

    test(
      'a successful /me after a Turnstile refusal still completes',
      () async {
        final h = _H(guest: true);
        addTearDown(h.close);
        await h.c.begin(GoogleAuthPurpose.claim);
        h.api.claimFailure = const ApiException(
          statusCode: 403,
          errorCode: 'turnstile_required',
        );
        h.claimed = true;
        await h.submit();
        expect(h.c.state.step, GoogleAuthStep.authenticated);
        expect(h.c.state.block, isNull);
        expect(h.c.state.securityChallengeRequired, isFalse);
        expect(h.store.payload, isNull);
      },
    );
  });
}

void _rateLimitedFormTests() {
  group('H-RA-A08-01-04 a rate-limited form explains why it is disabled', () {
    test('claim429, failing /me, then resume shows the limit', () async {
      final now = DateTime.utc(2026, 10, 29, 12);
      final h = _H(guest: true, now: () => now);
      addTearDown(h.close);
      await h.c.begin(GoogleAuthPurpose.claim);
      h.api.claimFailure = _limited;
      h.claimReadFailure = _offline;
      await h.submit();
      expect(h.c.state.messageKey, 'google.uncertain');
      h.claimReadFailure = null;
      await h.c.resume();
      expect(h.c.state.step, GoogleAuthStep.guestClaimRequired);
      expect(h.c.state.retryAfter, now.add(const Duration(seconds: 120)));
      expect(h.c.state.messageKey, 'google.rateLimited');
    });

    test('reopening the screen on a blocked intent shows the limit', () async {
      final now = DateTime.utc(2026, 10, 29, 12);
      final h = _H(now: () => now);
      addTearDown(h.close);
      await h.c.begin(GoogleAuthPurpose.authenticate);
      h.api.registrationFailure = _limited;
      await h.submit();
      expect(h.c.state.messageKey, 'google.rateLimited');
      await h.c.begin(GoogleAuthPurpose.authenticate);
      expect(h.c.state.step, GoogleAuthStep.uncertain);
      await h.c.resume();
      expect(h.c.state.step, GoogleAuthStep.registrationRequired);
      expect(h.c.state.messageKey, 'google.rateLimited');
    });

    test('control: an expired or absent deadline adds no message', () async {
      var now = DateTime.utc(2026, 10, 29, 12);
      final h = _H(now: () => now);
      addTearDown(h.close);
      await h.c.begin(GoogleAuthPurpose.authenticate);
      expect(h.c.state.messageKey, isNull);
      h.api.registrationFailure = _limited;
      await h.submit();
      now = now.add(const Duration(seconds: 120));
      await h.c.resume();
      expect(h.c.state.step, GoogleAuthStep.registrationRequired);
      expect(h.c.state.messageKey, isNull);
    });
  });
}

void _persistedTicketCancellationTests() {
  group('C5-03 a persisted ticket is cancelled server-side before erasure', () {
    test(
      'a refused begin explains itself without reading or replacing the ticket',
      () async {
        final h = _H(canBegin: false);
        addTearDown(h.close);
        h.store.payload = _storedIntent();
        await h.c.begin(GoogleAuthPurpose.authenticate);
        expect(h.c.state.step, GoogleAuthStep.idle);
        expect(h.c.state.messageKey, isNotNull);
        expect(h.store.reads, 0);
        expect(h.store.payload, _storedIntent());
        expect(h.gateway.selections, 0);
        expect(h.api.cancelledTickets, isEmpty);
      },
    );

    for (final stage in ['continuation', 'challenge']) {
      test(
        'cancel after a refused begin cancels the exact $stage intent first',
        () async {
          final h = _H(canBegin: false);
          addTearDown(h.close);
          h.store.payload = _storedIntent(stage: stage);
          await h.c.begin(GoogleAuthPurpose.authenticate);
          expect(await h.c.cancel(), isTrue);
          expect(h.api.cancelledTickets, ['stored-$stage-ticket']);
          expect(h.api.cancelledChallengeIds, [
            stage == 'challenge' ? 'stored-challenge-id' : null,
          ]);
          expect(h.api.cancelledBrowsers, ['browser-fixture']);
          expect(h.store.payload, isNull);
          expect(h.c.hasPendingIntent, isFalse);
          expect(h.c.state.step, GoogleAuthStep.idle);
        },
      );
    }

    test(
      'an unconfirmed cancellation keeps the ticket and never starts a new choice',
      () async {
        final h = _H(canBegin: false);
        addTearDown(h.close);
        h.store.payload = _storedIntent();
        await h.c.begin(GoogleAuthPurpose.authenticate);
        h.api.cancelFailure = _offline;
        expect(await h.c.cancel(), isFalse);
        expect(h.c.state.messageKey, 'google.cancelFailed');
        expect(h.c.state.step, GoogleAuthStep.uncertain);
        expect(h.store.payload, _storedIntent());
        expect(h.c.hasPendingIntent, isTrue);

        h.canBegin = true;
        await h.c.begin(GoogleAuthPurpose.authenticate);
        expect(h.c.state.step, GoogleAuthStep.uncertain);
        expect(h.gateway.selections, 0);
        expect(h.api.created, 0);
        await h.c.resume();
        expect(h.c.state.step, GoogleAuthStep.registrationRequired);
        expect(h.api.inspectedTickets, ['stored-continuation-ticket']);

        h.api.cancelFailure = null;
        expect(await h.c.cancel(), isTrue);
        expect(h.api.cancelledTickets, [
          'stored-continuation-ticket',
          'stored-continuation-ticket',
        ]);
        expect(h.store.payload, isNull);
        expect(h.c.hasPendingIntent, isFalse);
      },
    );

    test('an unreadable store never erases an unconfirmed ticket', () async {
      final h = _H();
      addTearDown(h.close);
      h.store.payload = _storedIntent();
      h.store.readFailure = GoogleCredentialException('secure_storage_failed');
      await h.c.begin(GoogleAuthPurpose.authenticate);
      expect(h.c.state.step, GoogleAuthStep.failure);
      // Nothing is loaded, so leaving is allowed (review P1); the unread
      // ticket stays on disk for a later read and server cancellation.
      expect(await h.c.cancel(), isTrue);
      expect(h.c.hasPendingIntent, isFalse);
      expect(h.store.payload, _storedIntent());
      expect(h.store.clears, 0);
      expect(h.api.cancelledTickets, isEmpty);

      h.store.readFailure = null;
      expect(await h.c.cancel(), isTrue);
      expect(h.api.cancelledTickets, ['stored-continuation-ticket']);
      expect(h.store.payload, isNull);
    });

    for (final corrupt in ['payload', 'native']) {
      test('an unusable $corrupt ticket, which no server call can cancel, '
          'is removed', () async {
        final h = _H(canBegin: false);
        addTearDown(h.close);
        h.store.payload = corrupt == 'payload'
            ? '{"version":1}'
            : _storedIntent();
        if (corrupt == 'native') {
          h.store.readFailure = GoogleCredentialException(
            'secure_storage_corrupt',
          );
        }
        await h.c.begin(GoogleAuthPurpose.authenticate);
        expect(await h.c.cancel(), isTrue);
        expect(h.api.cancelledTickets, isEmpty);
        expect(h.store.clears, 1);
        expect(h.c.hasPendingIntent, isFalse);
      });
    }

    test('an already expired server intent counts as cancelled', () async {
      final h = _H(canBegin: false);
      addTearDown(h.close);
      h.store.payload = _storedIntent();
      await h.c.begin(GoogleAuthPurpose.authenticate);
      h.api.cancelFailure = const ApiException(
        statusCode: 410,
        errorCode: 'google_context_expired',
      );
      expect(await h.c.cancel(), isTrue);
      expect(h.api.cancelledTickets, ['stored-continuation-ticket']);
      expect(h.store.payload, isNull);
    });

    test('without any persisted ticket cancel needs no server call', () async {
      final h = _H(canBegin: false);
      addTearDown(h.close);
      await h.c.begin(GoogleAuthPurpose.authenticate);
      expect(await h.c.cancel(), isTrue);
      expect(h.api.cancelledTickets, isEmpty);
      expect(h.store.payload, isNull);
    });

    test(
      'restart after a refused begin replaces the old intent only once cancelled',
      () async {
        final h = _H(canBegin: false);
        addTearDown(h.close);
        h.store.payload = _storedIntent();
        await h.c.begin(GoogleAuthPurpose.authenticate);
        // GoogleAuthenticationPage._restart: cancel() then begin().
        expect(await h.c.cancel(), isTrue);
        await h.c.begin(GoogleAuthPurpose.authenticate);
        expect(h.gateway.selections, 0);
        h.canBegin = true;
        expect(await h.c.cancel(), isTrue);
        await h.c.begin(GoogleAuthPurpose.authenticate);
        expect(h.api.cancelledTickets, ['stored-continuation-ticket']);
        expect(h.gateway.selections, 1);
        expect(h.c.state.step, GoogleAuthStep.registrationRequired);
      },
    );

    test(
      'control: an admitted begin resumes the ticket and Back cancels it once',
      () async {
        final h = _H();
        addTearDown(h.close);
        h.store.payload = _storedIntent();
        await h.c.begin(GoogleAuthPurpose.authenticate);
        expect(h.c.state.step, GoogleAuthStep.registrationRequired);
        expect(h.gateway.selections, 0);
        expect(await h.c.cancel(), isTrue);
        expect(h.api.cancelledTickets, ['stored-continuation-ticket']);
        expect(h.store.payload, isNull);
      },
    );
  });
}

/// Reprise après la revue adversariale du 29/10 (checks/review-R2-google) :
/// P1/V1, P2/V2, P3/V3, P4/V4 et V7, assertions du comportement corrigé.
void _reviewFollowUpTests() {
  group('Review P1 an unreadable ticket never traps Back', () {
    for (final failure in <Object>[
      GoogleCredentialException('secure_storage_failed'),
      StateError('keystore unavailable'),
    ]) {
      test('${failure.runtimeType}: cancel leaves, keeps the unread ticket '
          'and never starts a new Google choice', () async {
        final h = _H();
        addTearDown(h.close);
        h.store.payload = _storedIntent();
        h.store.readFailure = failure;
        await h.c.begin(GoogleAuthPurpose.authenticate);
        expect(h.c.state.step, GoogleAuthStep.failure);
        expect(h.c.state.messageKey, 'google.unavailable');
        for (var attempt = 0; attempt < 3; attempt++) {
          expect(await h.c.cancel(), isTrue);
          expect(h.c.state.step, GoogleAuthStep.idle);
          expect(h.c.hasPendingIntent, isFalse);
        }
        expect(h.store.payload, _storedIntent());
        expect(h.store.clears, 0);
        expect(h.api.cancelledTickets, isEmpty);

        // Continue with Google: the unread ticket is never replaced.
        await h.c.begin(GoogleAuthPurpose.authenticate);
        expect(h.c.state.messageKey, 'google.unavailable');
        expect(h.gateway.selections, 0);
        expect(h.api.created, 0);
        expect(h.store.payload, _storedIntent());

        // Readable again: that same intent is resumed, then cancelled.
        h.store.readFailure = null;
        await h.c.begin(GoogleAuthPurpose.authenticate);
        expect(h.c.state.step, GoogleAuthStep.registrationRequired);
        expect(h.gateway.selections, 0);
        expect(await h.c.cancel(), isTrue);
        expect(h.api.cancelledTickets, ['stored-continuation-ticket']);
        expect(h.store.payload, isNull);
      });
    }

    test(
      'a refused begin over an unreadable ticket still lets Back leave',
      () async {
        final h = _H(canBegin: false);
        addTearDown(h.close);
        h.store.payload = _storedIntent(stage: 'challenge');
        await h.c.begin(GoogleAuthPurpose.authenticate);
        h.store.readFailure = GoogleCredentialException(
          'secure_storage_failed',
        );
        expect(await h.c.cancel(), isTrue);
        expect(h.store.payload, _storedIntent(stage: 'challenge'));
        expect(h.api.cancelledTickets, isEmpty);
        expect(h.c.hasPendingIntent, isFalse);
      },
    );

    test(
      'control: a loaded intent whose cancellation fails still stays',
      () async {
        final h = _H(canBegin: false);
        addTearDown(h.close);
        h.store.payload = _storedIntent();
        await h.c.begin(GoogleAuthPurpose.authenticate);
        h.api.cancelFailure = _offline;
        expect(await h.c.cancel(), isFalse);
        expect(h.c.state.messageKey, 'google.cancelFailed');
        expect(h.c.hasPendingIntent, isTrue);
        expect(h.store.payload, _storedIntent());
      },
    );
  });

  group('Review P2/P3 only a deadline in force is published', () {
    test(
      'a 429 with Retry-After 0 explains itself and blocks nothing',
      () async {
        final now = DateTime.utc(2026, 10, 29, 12);
        final h = _H(now: () => now);
        addTearDown(h.close);
        await h.c.begin(GoogleAuthPurpose.authenticate);
        h.api.registrationFailure = const ApiException(
          statusCode: 429,
          errorCode: 'rate_limited',
          retryAfterSeconds: 0,
        );
        await h.submit();
        expect(h.c.state.step, GoogleAuthStep.registrationRequired);
        expect(h.c.state.messageKey, 'google.rateLimited');
        expect(h.c.state.retryAfter, isNull);
        h.api.registrationFailure = null;
        await h.submit();
        expect(h.api.registrations, 2);
        expect(h.c.state.step, GoogleAuthStep.authenticated);
      },
    );

    test('a 429 without Retry-After after an expired deadline publishes no '
        'stale deadline', () async {
      var now = DateTime.utc(2026, 10, 29, 12);
      final h = _H(now: () => now);
      addTearDown(h.close);
      await h.c.begin(GoogleAuthPurpose.authenticate);
      h.api.registrationFailure = const ApiException(
        statusCode: 429,
        errorCode: 'rate_limited',
        retryAfterSeconds: 10,
      );
      await h.submit();
      expect(h.c.state.retryAfter, now.add(const Duration(seconds: 10)));
      now = now.add(const Duration(seconds: 11));
      h.api.registrationFailure = const ApiException(
        statusCode: 429,
        errorCode: 'rate_limited',
      );
      await h.submit();
      expect(h.api.registrations, 2);
      expect(h.c.state.messageKey, 'google.rateLimited');
      expect(h.c.state.retryAfter, isNull);
      await h.submit();
      expect(h.api.registrations, 3);
    });

    test(
      'a deadline in force stays published, then disappears at expiry',
      () async {
        var now = DateTime.utc(2026, 10, 29, 12);
        final h = _H(now: () => now);
        addTearDown(h.close);
        await h.c.begin(GoogleAuthPurpose.authenticate);
        h.api.registrationFailure = _limited;
        await h.submit();
        final deadline = now.add(const Duration(seconds: 120));
        now = now.add(const Duration(seconds: 60));
        await h.c.resume();
        expect(h.c.state.retryAfter, deadline);
        expect(h.c.state.messageKey, 'google.rateLimited');
        now = deadline;
        await h.c.resume();
        expect(h.c.state.retryAfter, isNull);
        expect(h.c.state.messageKey, isNull);
      },
    );
  });

  group('Review P4 the visible challenge action reloads a lost context', () {
    for (final kind in ['claim', 'register', 'claim after failing /me']) {
      test('$kind Turnstile refusal, then Back with a failed cancellation: '
          'solving the challenge leads to a proven finalization', () async {
        final claim = kind.startsWith('claim');
        final h = _H(guest: claim);
        addTearDown(h.close);
        await h.c.begin(
          claim ? GoogleAuthPurpose.claim : GoogleAuthPurpose.authenticate,
        );
        const refusal = ApiException(
          statusCode: 403,
          errorCode: 'turnstile_required',
        );
        if (kind == 'claim after failing /me') {
          // A03-google-02 first, then Back.
          h.api.claimFailure = refusal;
          h.claimReadFailure = _offline;
          await h.submit();
          expect(h.c.state.block, GoogleAuthBlock.securityChallenge);
          h.api.cancelFailure = _offline;
          expect(await h.c.cancel(), isFalse);
          h.api.claimFailure = null;
          h.claimReadFailure = null;
        } else {
          final entered = Completer<void>();
          final reply = Completer<void>();
          h.api.finalizeGate = () {
            entered.complete();
            return reply.future;
          };
          final finalizing = h.submit();
          await entered.future;
          h.api.cancelFailure = _offline;
          final cancelling = h.c.cancel();
          reply.completeError(refusal);
          await finalizing;
          expect(await cancelling, isFalse);
          h.api.finalizeGate = null;
        }
        h.api.cancelFailure = null;
        // The state published by the failed cancellation has no context.
        expect(h.c.state.messageKey, 'google.cancelFailed');
        expect(h.c.state.block, GoogleAuthBlock.securityChallenge);
        expect(h.c.state.securityChallengeRequired, isTrue);
        expect(h.c.state.context, isNull);
        final inspected = h.api.inspectedTickets.length;

        await h.c.solveSecurityChallenge(title: 'title', cancelLabel: 'cancel');
        expect(h.api.inspectedTickets, hasLength(inspected + 1));
        expect(h.security.solves, 1);
        expect(
          h.c.state.step,
          claim
              ? GoogleAuthStep.guestClaimRequired
              : GoogleAuthStep.registrationRequired,
        );
        expect(h.c.state.messageKey, 'google.challengeReady');
        expect(h.c.state.block, isNull);

        h.claimed = true;
        await h.submit();
        expect(h.api.turnstileTokens.last, 'proof-fixture');
        expect(h.api.turnstileTokens.where((token) => token == null), [null]);
        expect(h.c.state.step, GoogleAuthStep.authenticated);
      });
    }

    test(
      'control: an expired lost context is reported, never solved',
      () async {
        var now = DateTime.utc(2026, 10, 29, 12);
        final h = _H(now: () => now);
        addTearDown(h.close);
        await h.c.begin(GoogleAuthPurpose.authenticate);
        final entered = Completer<void>();
        final reply = Completer<void>();
        h.api.finalizeGate = () {
          entered.complete();
          return reply.future;
        };
        final finalizing = h.submit();
        await entered.future;
        h.api.cancelFailure = _offline;
        final cancelling = h.c.cancel();
        reply.completeError(
          const ApiException(statusCode: 403, errorCode: 'turnstile_required'),
        );
        await finalizing;
        expect(await cancelling, isFalse);
        final inspected = h.api.inspectedTickets.length;
        now = _expiry.add(const Duration(seconds: 1));
        await h.c.solveSecurityChallenge(title: 'title', cancelLabel: 'cancel');
        expect(h.security.solves, 0);
        expect(h.api.inspectedTickets, hasLength(inspected));
        expect(h.c.state.messageKey, 'google.expired');
        expect(h.api.registrations, 1);
      },
    );
  });

  group('Review V7 a persisted claim ticket is reconciled before cancel', () {
    test('a committed conversion is recognised by /me, without server '
        'cancellation', () async {
      final h = _H(guest: true, canBegin: false);
      addTearDown(h.close);
      h.store.payload = _storedIntent(
        purpose: 'claim',
        userId: 'guest-fixture',
      );
      await h.c.begin(GoogleAuthPurpose.claim);
      expect(h.store.reads, 0);
      h.claimed = true;
      expect(await h.c.cancel(), isTrue);
      expect(h.claimReads, 1);
      expect(h.api.cancelledTickets, isEmpty);
      expect(h.c.state.step, GoogleAuthStep.authenticated);
      expect(h.store.payload, isNull);
      expect(h.c.hasPendingIntent, isFalse);
    });

    for (final readFailure in <Object?>[null, _offline]) {
      test('an unconverted claim (/me ${readFailure ?? 'guest'}) is cancelled '
          'server-side', () async {
        final h = _H(guest: true, canBegin: false);
        addTearDown(h.close);
        h.store.payload = _storedIntent(
          purpose: 'claim',
          userId: 'guest-fixture',
        );
        await h.c.begin(GoogleAuthPurpose.claim);
        h.claimReadFailure = readFailure;
        expect(await h.c.cancel(), isTrue);
        expect(h.claimReads, 1);
        expect(h.api.cancelledTickets, ['stored-continuation-ticket']);
        expect(h.c.state.step, GoogleAuthStep.idle);
        expect(h.store.payload, isNull);
      });
    }

    test(
      'control: another user\'s claim ticket is never admitted by /me',
      () async {
        final h = _H(guest: true, canBegin: false);
        addTearDown(h.close);
        h.store.payload = _storedIntent(
          purpose: 'claim',
          userId: 'other-guest',
        );
        await h.c.begin(GoogleAuthPurpose.claim);
        h.claimed = true;
        expect(await h.c.cancel(), isTrue);
        expect(h.claimReads, 0);
        expect(h.api.cancelledTickets, ['stored-continuation-ticket']);
        expect(h.c.state.step, GoogleAuthStep.idle);
      },
    );
  });
}

/// Second review round: V1 (durably undecryptable native entry), V2
/// (google_context_consumed), R30 (expiry guard of a blocked resume) and the
/// message of a refused begin.
void _reviewRound2Tests() {
  group('Review 2 V1 a durably undecryptable native ticket', () {
    test('stays while the native store calls it unavailable, is dropped once '
        'reported corrupt (AEADBadTag, lost Keystore key), then a new Google '
        'choice proceeds', () async {
      TestWidgetsFlutterBinding.ensureInitialized();
      // The real Dart channel client, over a slot that behaves like the
      // native one: an undecryptable entry reads null once it is removed.
      const channel = MethodChannel('fuzevpn.test/google_auth_review2');
      const undecryptable = '<undecryptable-fixture>';
      String? slot = undecryptable;
      var verdict = 'secure_storage_failed';
      var clears = 0;
      final messenger =
          TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger;
      messenger.setMockMethodCallHandler(channel, (call) async {
        switch (call.method) {
          case 'readPendingAuthentication':
            if (slot == undecryptable) throw PlatformException(code: verdict);
            return slot;
          case 'writePendingAuthentication':
            slot =
                (call.arguments as Map<Object?, Object?>)['payload'] as String?;
            return null;
          case 'clearPendingAuthentication':
            clears++;
            slot = null;
            return null;
        }
        throw MissingPluginException();
      });
      addTearDown(() => messenger.setMockMethodCallHandler(channel, null));
      final h = _H(
        pendingStore: NativeGoogleCredentialGateway(channel: channel),
      );
      addTearDown(h.close);
      // Back or Cancel, then « Continuer avec Google » (page _restart).
      Future<List<bool>> cycles() async => [
        for (var i = 0; i < 3; i++)
          await h.c.cancel().then((left) async {
            await h.c.begin(GoogleAuthPurpose.authenticate);
            return left;
          }),
      ];

      await h.c.begin(GoogleAuthPurpose.authenticate);
      expect(h.c.state.messageKey, 'google.unavailable');
      // Temporarily unavailable: never erased, never replaced (review P1).
      expect(await cycles(), [true, true, true]);
      expect(h.gateway.selections, 0);
      expect(clears, 0);
      expect(slot, undecryptable);
      expect(h.c.state.messageKey, 'google.unavailable');

      // Lot N: an entry that can never be decrypted again is now reported
      // secure_storage_corrupt; no API call can target it, so Back drops it.
      verdict = 'secure_storage_corrupt';
      expect(await cycles(), [true, true, true]);
      expect(h.gateway.selections, 3);
      expect(clears, 3);
      expect(h.api.cancelledTickets, [
        'rotated-ticket-fixture',
        'rotated-ticket-fixture',
      ]);
      expect(h.c.state.step, GoogleAuthStep.registrationRequired);
      expect(slot, isNot(undecryptable));
    });
  });

  group('Review 2 V2 a consumed context leaves nothing to cancel', () {
    const consumed = ApiException(
      statusCode: 409,
      errorCode: 'google_context_consumed',
    );

    test('a refused begin, then Back, never traps the screen', () async {
      final h = _H(canBegin: false);
      addTearDown(h.close);
      h.store.payload = _storedIntent();
      await h.c.begin(GoogleAuthPurpose.authenticate);
      h.api.cancelFailure = consumed;
      final results = [for (var i = 0; i < 3; i++) await h.c.cancel()];
      expect(results, [true, true, true]);
      // The exact intent was still presented to the API exactly once.
      expect(h.api.cancelledTickets, ['stored-continuation-ticket']);
      expect(h.store.payload, isNull);
      expect(h.c.hasPendingIntent, isFalse);
      expect(h.c.state.step, GoogleAuthStep.idle);
      h.canBegin = true;
      h.api.cancelFailure = null;
      await h.c.begin(GoogleAuthPurpose.authenticate);
      expect(h.gateway.selections, 1);
      expect(h.c.state.step, GoogleAuthStep.registrationRequired);
    });

    test(
      'a loaded intent whose finalization reply was lost can be left',
      () async {
        final h = _H();
        addTearDown(h.close);
        await h.c.begin(GoogleAuthPurpose.authenticate);
        h.api.registrationFailure = _offline;
        await h.submit();
        expect(h.c.state.step, GoogleAuthStep.uncertain);
        h.api.cancelFailure = consumed;
        expect(await h.c.cancel(), isTrue);
        expect(h.api.cancelledTickets, ['rotated-ticket-fixture']);
        expect(h.store.payload, isNull);
        expect(h.c.hasPendingIntent, isFalse);
        expect(h.c.isBusy, isFalse);
      },
    );

    test('a persisted claim is reconciled through /me first', () async {
      final h = _H(guest: true, canBegin: false);
      addTearDown(h.close);
      h.store.payload = _storedIntent(
        purpose: 'claim',
        userId: 'guest-fixture',
      );
      await h.c.begin(GoogleAuthPurpose.claim);
      h.api.cancelFailure = consumed;
      expect(await h.c.cancel(), isTrue);
      expect(h.claimReads, 1);
      expect(h.api.cancelledTickets, ['stored-continuation-ticket']);
      expect(h.store.payload, isNull);
      expect(h.c.state.step, GoogleAuthStep.idle);
    });

    for (final failure in <Object>[
      _offline,
      _limited,
      const ApiException(statusCode: 503, errorCode: 'google_unavailable'),
    ]) {
      test('control: ${failure is ApiFailure ? failure.code : failure} '
          'still keeps the unconfirmed intent', () async {
        final h = _H(canBegin: false);
        addTearDown(h.close);
        h.store.payload = _storedIntent();
        await h.c.begin(GoogleAuthPurpose.authenticate);
        h.api.cancelFailure = failure;
        expect(await h.c.cancel(), isFalse);
        expect(h.c.state.messageKey, 'google.cancelFailed');
        expect(h.c.hasPendingIntent, isTrue);
        expect(h.store.payload, _storedIntent());
      });
    }
  });

  group('Review 2 R30 a blocked challenge resumed after expiry', () {
    Future<_H> blockedAfterFailedCancel(DateTime Function() now) async {
      final h = _H(now: now);
      addTearDown(h.close);
      await h.c.begin(GoogleAuthPurpose.authenticate);
      final entered = Completer<void>();
      final reply = Completer<void>();
      h.api.finalizeGate = () {
        entered.complete();
        return reply.future;
      };
      final finalizing = h.submit();
      await entered.future;
      h.api.cancelFailure = _offline;
      final cancelling = h.c.cancel();
      reply.completeError(
        const ApiException(statusCode: 403, errorCode: 'turnstile_required'),
      );
      await finalizing;
      expect(await cancelling, isFalse);
      h.api.finalizeGate = null;
      h.api.cancelFailure = null;
      expect(h.c.state.messageKey, 'google.cancelFailed');
      expect(h.c.state.context, isNull);
      return h;
    }

    test('reports the expiry without reloading the context', () async {
      var now = DateTime.utc(2026, 10, 29, 12);
      final h = await blockedAfterFailedCancel(() => now);
      final inspected = h.api.inspectedTickets.length;
      now = _expiry.add(const Duration(seconds: 1));
      await h.c.resume();
      expect(h.api.inspectedTickets, hasLength(inspected));
      expect(h.c.state.messageKey, 'google.expired');
      expect(h.c.state.step, GoogleAuthStep.uncertain);
      expect(h.c.state.securityChallengeRequired, isTrue);
      expect(h.security.solves, 0);
      expect(h.api.registrations, 1);
      // Leaving still cancels that exact intent.
      expect(await h.c.cancel(), isTrue);
      expect(h.store.payload, isNull);
    });

    test('control: before expiry the context is reloaded', () async {
      final h = await blockedAfterFailedCancel(
        () => DateTime.utc(2026, 10, 29, 12),
      );
      final inspected = h.api.inspectedTickets.length;
      await h.c.resume();
      expect(h.api.inspectedTickets, hasLength(inspected + 1));
      expect(h.c.state.messageKey, 'google.challengeRequired');
      expect(h.c.state.context?.status, 'registration_required');
    });
  });

  group('Review 2 a refused begin explains itself', () {
    test('with google.busy, without reading or replacing a ticket', () async {
      final h = _H(canBegin: false);
      addTearDown(h.close);
      h.store.payload = _storedIntent();
      await h.c.begin(GoogleAuthPurpose.authenticate);
      expect(h.c.state.step, GoogleAuthStep.idle);
      expect(h.c.state.messageKey, 'google.busy');
      expect(h.store.reads, 0);
      expect(h.gateway.selections, 0);
      expect(h.store.payload, _storedIntent());
    });
  });
}

/// End of the second review round, after the crash: a persisted ticket that
/// can never be read again (lot N reports AEADBadTag and a lost Keystore key as
/// secure_storage_corrupt) must not keep opening the Google screen, or
/// checking an attempt, on « unavailable »; a temporarily unreadable one is
/// still kept and retried.
void _afterCrashTests() {
  group('After crash V1 an unrecoverable persisted ticket frees begin and '
      'resume', () {
    for (final cause in ['AEADBadTag', 'lost Keystore key']) {
      for (final purpose in [
        GoogleAuthPurpose.authenticate,
        GoogleAuthPurpose.claim,
      ]) {
        test(
          '$cause, ${purpose.name}: opening Google drops it without any '
          'server call, explains it, and Continue with Google proceeds',
          () async {
            final slot = _NativeSlot();
            final h = _H(
              guest: purpose == GoogleAuthPurpose.claim,
              pendingStore: slot.store,
            );
            addTearDown(h.close);
            await h.c.begin(purpose);
            expect(slot.clears, 1);
            expect(slot.value, isNull);
            expect(h.api.cancelledTickets, isEmpty);
            expect(h.api.inspectedTickets, isEmpty);
            expect(h.api.created, 0);
            expect(h.gateway.selections, 0);
            expect(h.c.state.step, GoogleAuthStep.failure);
            expect(h.c.state.messageKey, 'google.error');
            expect(h.c.hasPendingIntent, isFalse);

            // Cancel leaves at once: nothing is left to cancel or to remove.
            expect(await h.c.cancel(), isTrue);
            expect(h.c.state.step, GoogleAuthStep.idle);
            expect(slot.clears, 1);

            // Continue with Google (page _restart: cancel, then begin).
            expect(await h.c.cancel(), isTrue);
            await h.c.begin(purpose);
            expect(h.gateway.selections, 1);
            expect(
              h.c.state.step,
              purpose == GoogleAuthPurpose.claim
                  ? GoogleAuthStep.guestClaimRequired
                  : GoogleAuthStep.registrationRequired,
            );
            expect(h.api.cancelledTickets, isEmpty);
            expect(slot.clears, 1);
          },
        );
      }
    }

    test('resume with nothing loaded drops it the same way', () async {
      final slot = _NativeSlot();
      final h = _H(pendingStore: slot.store);
      addTearDown(h.close);
      await h.c.resume();
      expect(slot.clears, 1);
      expect(slot.value, isNull);
      expect(h.c.state.step, GoogleAuthStep.failure);
      expect(h.c.state.messageKey, 'google.error');
      expect(h.c.hasPendingIntent, isFalse);
      expect(h.api.cancelledTickets, isEmpty);
      expect(h.api.inspectedTickets, isEmpty);
      await h.c.begin(GoogleAuthPurpose.authenticate);
      expect(h.gateway.selections, 1);
      expect(h.c.state.step, GoogleAuthStep.registrationRequired);
    });

    test(
      'a native entry the channel client rejects is dropped on opening',
      () async {
        final slot = _NativeSlot()..value = '{"version":2}';
        final h = _H(pendingStore: slot.store);
        addTearDown(h.close);
        await h.c.begin(GoogleAuthPurpose.authenticate);
        expect(slot.clears, 1);
        expect(slot.value, isNull);
        expect(h.c.state.messageKey, 'google.error');
        expect(h.gateway.selections, 0);
        expect(h.api.cancelledTickets, isEmpty);
      },
    );

    test(
      'a payload the controller cannot decode is dropped on opening',
      () async {
        final h = _H();
        addTearDown(h.close);
        h.store.payload = '{"version":1}';
        await h.c.begin(GoogleAuthPurpose.authenticate);
        expect(h.store.clears, 1);
        expect(h.store.payload, isNull);
        expect(h.c.state.step, GoogleAuthStep.failure);
        expect(h.c.state.messageKey, 'google.error');
        expect(h.gateway.selections, 0);
        expect(h.api.cancelledTickets, isEmpty);
      },
    );

    test('a failed removal is explained too, then retried by Cancel', () async {
      final slot = _NativeSlot()..clearFailure = 'secure_storage_failed';
      final h = _H(pendingStore: slot.store);
      addTearDown(h.close);
      await h.c.begin(GoogleAuthPurpose.authenticate);
      expect(h.c.state.step, GoogleAuthStep.failure);
      expect(h.c.state.messageKey, 'google.error');
      expect(h.c.isBusy, isFalse);
      expect(slot.clears, 1);
      expect(slot.value, _NativeSlot.undecryptable);
      // Continue with Google: Cancel removes it, then a new choice proceeds.
      expect(await h.c.cancel(), isTrue);
      expect(slot.clears, 2);
      expect(slot.value, isNull);
      await h.c.begin(GoogleAuthPurpose.authenticate);
      expect(h.gateway.selections, 1);
      expect(h.api.cancelledTickets, isEmpty);
    });

    test('control: a temporarily unreadable ticket is kept and retried, then '
        'the same intent is resumed once readable', () async {
      final slot = _NativeSlot()..verdict = 'secure_storage_failed';
      final h = _H(pendingStore: slot.store);
      addTearDown(h.close);
      await h.c.begin(GoogleAuthPurpose.authenticate);
      expect(h.c.state.step, GoogleAuthStep.failure);
      expect(h.c.state.messageKey, 'google.unavailable');
      // Retry while still unavailable: never erased, never replaced.
      expect(await h.c.cancel(), isTrue);
      await h.c.begin(GoogleAuthPurpose.authenticate);
      await h.c.resume();
      expect(h.c.state.messageKey, 'google.unavailable');
      expect(h.c.isBusy, isFalse);
      expect(slot.clears, 0);
      expect(slot.value, _NativeSlot.undecryptable);
      expect(h.gateway.selections, 0);

      // The Keystore answers again: that same intent is resumed.
      slot.value = _storedIntent();
      await h.c.begin(GoogleAuthPurpose.authenticate);
      expect(h.c.state.step, GoogleAuthStep.registrationRequired);
      expect(h.api.inspectedTickets, ['stored-continuation-ticket']);
      expect(h.gateway.selections, 0);
      expect(slot.clears, 0);
      expect(await h.c.cancel(), isTrue);
      expect(h.api.cancelledTickets, ['stored-continuation-ticket']);
      expect(slot.value, isNull);
    });
  });
}

/// Final minors of 30/10 (checks/review-R2-final, PR1/PR1b): once the API has
/// confirmed the cancellation, or reports the context expired or consumed, a
/// failing removal of the local ticket must not trap Back. A failing API call
/// still keeps the intent and the screen.
void _finalMinorTests() {
  group('Final R2-cancel a confirmed cancellation whose local removal fails '
      'still leaves', () {
    const expired = ApiException(
      statusCode: 410,
      errorCode: 'google_context_expired',
    );
    const consumed = ApiException(
      statusCode: 409,
      errorCode: 'google_context_consumed',
    );
    final storageFailed = GoogleCredentialException('secure_storage_failed');

    for (final purpose in [
      GoogleAuthPurpose.authenticate,
      GoogleAuthPurpose.claim,
    ]) {
      test('${purpose.name}: one API cancellation, then Back leaves and the '
          'intent is no longer pending', () async {
        final h = _H(guest: purpose == GoogleAuthPurpose.claim);
        addTearDown(h.close);
        await h.c.begin(purpose);
        expect(h.c.hasPendingIntent, isTrue);
        h.store.clearFailure = storageFailed;
        expect(await h.c.cancel(), isTrue);
        expect(h.api.cancelledTickets, ['rotated-ticket-fixture']);
        expect(h.store.clears, 1);
        expect(h.c.hasPendingIntent, isFalse);
        expect(h.c.isBusy, isFalse);
        expect(h.c.state.step, GoogleAuthStep.idle);
        expect(h.c.state.messageKey, isNull);
        // Only the encrypted ticket the server no longer holds may remain.
        expect(h.store.payload, contains('rotated-ticket-fixture'));
      });
    }

    for (final answer in [expired, consumed]) {
      test('${answer.code} also releases the intent although its removal '
          'fails', () async {
        final h = _H();
        addTearDown(h.close);
        await h.c.begin(GoogleAuthPurpose.authenticate);
        h.api.cancelFailure = answer;
        h.store.clearFailure = storageFailed;
        expect(await h.c.cancel(), isTrue);
        expect(h.api.cancelledTickets, ['rotated-ticket-fixture']);
        expect(h.c.hasPendingIntent, isFalse);
        expect(h.c.state.step, GoogleAuthStep.idle);
      });

      test('a ticket of an earlier process, then its stale copy read after a '
          'restart and cancelled again (${answer.code}), never traps the '
          'screen', () async {
        final h = _H(canBegin: false);
        addTearDown(h.close);
        h.store.payload = _storedIntent();
        await h.c.begin(GoogleAuthPurpose.authenticate);
        h.store.clearFailure = storageFailed;
        expect(await h.c.cancel(), isTrue);
        expect(h.api.cancelledTickets, ['stored-continuation-ticket']);
        expect(h.c.hasPendingIntent, isFalse);
        expect(h.store.payload, _storedIntent());

        // A new process no longer knows that this cancellation was confirmed
        // (the same process is covered by Final C9-1). The server no longer
        // holds that intent; the removal still fails.
        h.restart();
        h.api.cancelFailure = answer;
        h.api.contextFailure = answer;
        h.canBegin = true;
        // Reopening the screen reads the stale copy and explains it.
        await h.c.begin(GoogleAuthPurpose.authenticate);
        expect(h.c.state.step, GoogleAuthStep.uncertain);
        expect(h.gateway.selections, 0);
        // Back cancels it again, retries the removal and leaves.
        expect(await h.c.cancel(), isTrue);
        expect(h.api.cancelledTickets, hasLength(2));
        expect(h.store.clears, 2);
        expect(h.c.hasPendingIntent, isFalse);
        expect(h.c.state.step, GoogleAuthStep.idle);

        // Cancel, then reopen, once the removal succeeds: this process now
        // knows that confirmed cancellation, so the stale copy is removed
        // without a third API call, and a new choice proceeds.
        h.store.clearFailure = null;
        expect(await h.c.cancel(), isTrue);
        expect(h.api.cancelledTickets, hasLength(2));
        expect(h.store.payload, isNull);
        h.api.cancelFailure = null;
        h.api.contextFailure = null;
        await h.c.begin(GoogleAuthPurpose.authenticate);
        expect(h.gateway.selections, 1);
        expect(h.c.state.step, GoogleAuthStep.registrationRequired);
      });
    }

    test('a selection cancelled in the Google picker releases its intent '
        'although the removal fails', () async {
      final h = _H();
      addTearDown(h.close);
      h.gateway.signInFailure = GoogleCredentialException('cancelled');
      h.store.clearFailure = storageFailed;
      await h.c.begin(GoogleAuthPurpose.authenticate);
      expect(h.api.cancelledTickets, ['initial-ticket-fixture']);
      expect(h.api.cancelledChallengeIds, ['challenge-fixture']);
      expect(h.store.clears, 1);
      expect(h.c.state.step, GoogleAuthStep.idle);
      expect(h.c.state.messageKey, isNull);
      expect(h.c.hasPendingIntent, isFalse);
    });

    for (final failure in <Object>[
      _offline,
      const ApiException(statusCode: 503, errorCode: 'google_unavailable'),
    ]) {
      test(
        'control: ${failure is ApiFailure ? failure.code : failure} on '
        'the API cancellation still keeps the intent and the screen',
        () async {
          final h = _H();
          addTearDown(h.close);
          await h.c.begin(GoogleAuthPurpose.authenticate);
          h.store.clearFailure = storageFailed;
          h.api.cancelFailure = failure;
          for (var attempt = 0; attempt < 2; attempt++) {
            expect(await h.c.cancel(), isFalse);
            expect(h.c.state.step, GoogleAuthStep.uncertain);
            expect(h.c.state.messageKey, 'google.cancelFailed');
            expect(h.c.hasPendingIntent, isTrue);
          }
          expect(h.api.cancelledTickets, hasLength(2));
          expect(h.store.clears, 0);
          expect(h.store.payload, contains('rotated-ticket-fixture'));
          // Reopening resumes that same intent, never a new Google choice.
          await h.c.begin(GoogleAuthPurpose.authenticate);
          expect(h.c.state.step, GoogleAuthStep.uncertain);
          await h.c.resume();
          expect(h.c.state.step, GoogleAuthStep.registrationRequired);
          expect(h.gateway.selections, 1);
        },
      );
    }
  });
}

/// Final pass of 30/10 (reaudit C9-1): a cancellation that the API confirmed
/// in this process is remembered while its local removal fails. Reading that
/// stale copy again never asks the API a second time, since the reply to a
/// second cancellation is unspecified (401 or 404 here): only the removal is
/// retried and Back still leaves. Another ticket, or a new process (see
/// Final R2-cancel), still goes through the API.
void _confirmedCancellationMemoryTests() {
  group('Final C9-1 a cancellation confirmed in this process is not sent '
      'again', () {
    final storageFailed = GoogleCredentialException('secure_storage_failed');
    const unspecified = <ApiException>[
      ApiException(statusCode: 401, errorCode: 'unauthorized'),
      ApiException(statusCode: 404, errorCode: 'api_error'),
    ];
    const earlier = 'earlier process';

    _H harness(String origin) {
      final h = _H(guest: origin == 'claim', canBegin: origin != earlier);
      addTearDown(h.close);
      return h;
    }

    /// One API cancellation confirmed while the local removal fails; returns
    /// the ticket whose stale copy stays on disk.
    Future<String> cancelledOnce(_H h, String origin) async {
      if (origin == earlier) {
        h.store.payload = _storedIntent();
        // Refused begin: the ticket stays unread until Cancel loads it.
        await h.c.begin(GoogleAuthPurpose.authenticate);
      } else {
        await h.c.begin(GoogleAuthPurpose.values.byName(origin));
      }
      final ticket = origin == earlier
          ? 'stored-continuation-ticket'
          : 'rotated-ticket-fixture';
      h.store.clearFailure = storageFailed;
      expect(await h.c.cancel(), isTrue);
      expect(h.api.cancelledTickets, [ticket]);
      expect(h.store.clears, 1);
      expect(h.store.payload, contains(ticket));
      return ticket;
    }

    for (final answer in unspecified) {
      for (final origin in [earlier, 'authenticate', 'claim']) {
        test('$origin: a second cancellation that would answer '
            '${answer.statusCode} makes no API call and leaves', () async {
          final h = harness(origin);
          final ticket = await cancelledOnce(h, origin);
          final inspected = h.api.inspectedTickets.length;
          final claimReads = h.claimReads;
          h.api.cancelFailure = answer;
          h.api.contextFailure = answer;
          for (var clears = 2; clears <= 3; clears++) {
            expect(await h.c.cancel(), isTrue);
            expect(h.store.clears, clears);
            expect(h.c.state.step, GoogleAuthStep.idle);
            expect(h.c.state.messageKey, isNull);
            expect(h.c.hasPendingIntent, isFalse);
            expect(h.c.isBusy, isFalse);
          }
          // Checking the attempt asks the server nothing either.
          await h.c.resume();
          expect(h.store.clears, 4);
          expect(h.c.state.step, GoogleAuthStep.idle);
          expect(h.api.cancelledTickets, [ticket]);
          expect(h.api.inspectedTickets, hasLength(inspected));
          expect(h.claimReads, claimReads);
          expect(h.store.payload, contains(ticket));
          // Once the removal works, the stale copy is gone, still without
          // any API call.
          h.store.clearFailure = null;
          expect(await h.c.cancel(), isTrue);
          expect(h.store.clears, 5);
          expect(h.store.payload, isNull);
          expect(h.api.cancelledTickets, [ticket]);
          expect(h.c.state.step, GoogleAuthStep.idle);
        });
      }
    }

    test('reopening in this process retries only the removal; the new choice '
        'replaces the stale copy and is cancelled through the API', () async {
      final h = harness(earlier);
      await cancelledOnce(h, earlier);
      h.canBegin = true;
      h.api.cancelFailure = unspecified.first;
      await h.c.begin(GoogleAuthPurpose.authenticate);
      expect(h.store.clears, 2);
      expect(h.api.inspectedTickets, ['rotated-ticket-fixture']);
      expect(h.api.cancelledTickets, ['stored-continuation-ticket']);
      expect(h.gateway.selections, 1);
      expect(h.c.state.step, GoogleAuthStep.registrationRequired);
      expect(h.store.payload, contains('rotated-ticket-fixture'));
      // A live intent again: its cancellation is still asked of the API, and
      // an unconfirmed one keeps the screen.
      expect(await h.c.cancel(), isFalse);
      expect(h.api.cancelledTickets, [
        'stored-continuation-ticket',
        'rotated-ticket-fixture',
      ]);
      expect(h.c.state.messageKey, 'google.cancelFailed');
      expect(h.c.hasPendingIntent, isTrue);
    });

    test('control: a different ticket read afterwards is still cancelled '
        'through the API', () async {
      final h = harness('authenticate');
      await cancelledOnce(h, 'authenticate');
      // Another intent's ticket occupies the slot instead of that stale copy.
      h.store.payload = _storedIntent(stage: 'challenge');
      h.api.cancelFailure = unspecified.first;
      expect(await h.c.cancel(), isFalse);
      expect(h.api.cancelledTickets, [
        'rotated-ticket-fixture',
        'stored-challenge-ticket',
      ]);
      expect(h.api.cancelledChallengeIds.last, 'stored-challenge-id');
      expect(h.c.state.messageKey, 'google.cancelFailed');
      expect(h.c.hasPendingIntent, isTrue);
      expect(h.store.clears, 1);
      h.api.cancelFailure = null;
      expect(await h.c.cancel(), isTrue);
      expect(h.api.cancelledTickets, hasLength(3));
      expect(h.store.clears, 2);
      expect(h.c.state.step, GoogleAuthStep.idle);
    });
  });
}

/// The native pending slot behind the real Dart channel client. An entry the
/// Keystore can no longer decrypt fails with [verdict] until it is removed.
class _NativeSlot {
  _NativeSlot() {
    TestWidgetsFlutterBinding.ensureInitialized();
    final messenger =
        TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger;
    messenger.setMockMethodCallHandler(_channel, (call) async {
      switch (call.method) {
        case 'readPendingAuthentication':
          if (value == undecryptable) throw PlatformException(code: verdict);
          return value;
        case 'writePendingAuthentication':
          value =
              (call.arguments as Map<Object?, Object?>)['payload'] as String?;
          return null;
        case 'clearPendingAuthentication':
          clears++;
          final failure = clearFailure;
          clearFailure = null;
          if (failure != null) throw PlatformException(code: failure);
          value = null;
          return null;
      }
      throw MissingPluginException();
    });
    addTearDown(() => messenger.setMockMethodCallHandler(_channel, null));
  }

  static const undecryptable = '<undecryptable-fixture>';
  static const _channel = MethodChannel('fuzevpn.test/google_after_crash');
  String? value = undecryptable;
  String verdict = 'secure_storage_corrupt';
  String? clearFailure;
  int clears = 0;
  final store = NativeGoogleCredentialGateway(channel: _channel);
}

class _H {
  _H({
    bool guest = false,
    DateTime Function()? now,
    this.canBegin = true,
    GooglePendingAuthStore? pendingStore,
  }) {
    final identity = GoogleIdentitySnapshot(
      userId: guest ? 'guest-fixture' : null,
      accessToken: guest ? 'guest-bearer-fixture' : null,
      isGuest: guest,
    );
    api.purpose = guest ? 'claim' : 'authenticate';
    _build = () => GoogleAuthController(
      api: api,
      gateway: gateway,
      pendingStore: pendingStore ?? store,
      challengeGateway: security,
      now: now,
      identity: () => identity,
      identityMatches: (_) => true,
      canBegin: (_) => canBegin,
      admitSession: (result, before, isCurrent) async => isCurrent(),
      admitClaim: (before, isCurrent) async {
        claimReads++;
        final failure = claimReadFailure;
        if (failure != null) throw failure;
        return isCurrent() && claimed;
      },
    );
    c = _build();
  }
  final api = _Api();
  final gateway = _Gateway();
  final store = _Store();
  final security = _Security();
  late final GoogleAuthController Function() _build;
  late GoogleAuthController c;

  /// A new process: a new controller over the same store, API and picker.
  void restart() {
    c.dispose();
    c = _build();
  }

  bool canBegin;
  bool claimed = false;
  int claimReads = 0;
  Object? claimReadFailure;
  Future<void> submit() => c.completeProfile(
    countryCode: 'FR',
    termsAccepted: true,
    privacyAccepted: true,
  );
  void close() => c.dispose();
}

class _Store implements GooglePendingAuthStore {
  String? payload;
  Object? readFailure, clearFailure;
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
    final failure = clearFailure;
    if (failure != null) throw failure;
    payload = null;
  }
}

class _Gateway implements GoogleCredentialGateway {
  int selections = 0;
  Object? signInFailure;
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
    final failure = signInFailure;
    if (failure != null) throw failure;
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
    return SecurityChallengeResult(
      requestId: requestId,
      token: 'proof-fixture',
    );
  }

  @override
  Future<void> cancel({required String requestId}) async {}
}

class _Api implements GoogleAuthApiRepository {
  String purpose = 'authenticate';
  String? continuationStatus;
  int created = 0, registrations = 0, claims = 0, linkCalls = 0;
  int emailRequests = 0;
  Object? registrationFailure, claimFailure, cancelFailure, contextFailure;
  Future<void> Function()? finalizeGate;
  Future<void> Function()? emailGate;
  final turnstileTokens = <String?>[];
  final cancelledTickets = <String>[];
  final cancelledChallengeIds = <String?>[];
  final cancelledBrowsers = <String>[];
  final inspectedTickets = <String>[];

  String get _status =>
      continuationStatus ??
      (purpose == 'claim' ? 'guest_claim_required' : 'registration_required');

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
  }) async {
    created++;
    return _challenge;
  }

  @override
  Future<GoogleAuthResult> verifyGoogleCredential({
    required GoogleBrowserContext browserContext,
    required String contextToken,
    required String challengeId,
    required String credential,
  }) async => GoogleContinuationResult(
    status: _status,
    contextToken: 'rotated-ticket-fixture',
    expiresAt: _expiry,
  );

  @override
  Future<GoogleAuthContext> getGoogleContext({
    required GoogleBrowserContext browserContext,
    required String contextToken,
  }) async {
    inspectedTickets.add(contextToken);
    final failure = contextFailure;
    if (failure != null) throw failure;
    return GoogleAuthContext(
      status: _status,
      purpose: purpose,
      expiresAt: _expiry,
      email: 'identity@example.test',
    );
  }

  @override
  Future<GoogleAuthenticatedResult> registerGoogleAccount({
    required GoogleBrowserContext browserContext,
    required String contextToken,
    required String countryCode,
    required bool termsAccepted,
    required bool privacyAccepted,
    String? turnstileToken,
  }) async {
    registrations++;
    turnstileTokens.add(turnstileToken);
    if (finalizeGate != null) await finalizeGate!();
    final failure = registrationFailure;
    if (failure != null) throw failure;
    return _authenticated;
  }

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
    turnstileTokens.add(turnstileToken);
    if (finalizeGate != null) await finalizeGate!();
    final failure = claimFailure;
    if (failure != null) throw failure;
    return const GoogleGuestClaimResult(
      userId: 'guest-fixture',
      emailVerified: true,
    );
  }

  @override
  Future<GoogleAuthenticatedResult> linkGoogleWithPassword({
    required GoogleBrowserContext browserContext,
    required String contextToken,
    required String currentPassword,
  }) async {
    linkCalls++;
    if (finalizeGate != null) await finalizeGate!();
    return _authenticated;
  }

  @override
  Future<void> requestGoogleLinkEmail({
    required GoogleBrowserContext browserContext,
    required String contextToken,
  }) async {
    emailRequests++;
    if (emailGate != null) await emailGate!();
  }

  @override
  Future<GoogleAuthenticatedResult> confirmGoogleLinkEmail({
    required GoogleBrowserContext browserContext,
    required String contextToken,
    required String code,
  }) async {
    linkCalls++;
    if (finalizeGate != null) await finalizeGate!();
    return _authenticated;
  }

  @override
  Future<void> cancelGoogleAuth({
    required GoogleBrowserContext browserContext,
    required String contextToken,
    String? challengeId,
  }) async {
    cancelledTickets.add(contextToken);
    cancelledChallengeIds.add(challengeId);
    cancelledBrowsers.add(browserContext.browserContextToken);
    final failure = cancelFailure;
    if (failure != null) throw failure;
  }

  @override
  Future<AuthSession> loginWithAuthContext({
    required GoogleBrowserContext browserContext,
    required String email,
    required String password,
  }) => throw UnimplementedError();
}
