// Intégration de localisation du 29/10/2026 (Helper1, par délégation de la
// racine), sur les 70 langues livrées :
//  * device_clock_ahead (C4-04) dans notice_controller_title et _message ;
//  * google.busy (R2), billing.playOnHold et billing.playReceiptUnlinked (R5) ;
//  * notice.retryAfter lisible au-delà de 120 s, en minutes puis en heures
//    (R1, suite de C5-04 et A16-ui-l10n-04) ;
//  * vérification du placeholder target de location_migration_slow
//    (A16-ui-l10n-02).
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fuzevpn_android/l10n/app_copy.dart';
import 'package:fuzevpn_android/l10n/app_languages.dart';
import 'package:fuzevpn_android/l10n/generated/app_localizations.dart';

String _retry(AppLocalizations l, Object? seconds) =>
    AppCopy.resolve(l, 'notice.retryAfter', arguments: {'seconds': seconds});

String _controller(
  AppLocalizations l,
  String part,
  String code, [
  String target = '',
]) => AppCopy.resolve(
  l,
  'notice.controller.$part',
  arguments: {'code': code, 'target': target},
);

void main() {
  group('nouvelles clés (70 langues)', () {
    test('google.busy et les deux messages Play sont traduits', () {
      for (final language in AppLanguages.all) {
        final l = lookupAppLocalizations(language.locale);
        for (final key in [
          'google.busy',
          'billing.playOnHold',
          'billing.playReceiptUnlinked',
        ]) {
          final text = AppCopy.resolve(l, key);
          expect(text, isNot(key), reason: '${language.tag} $key');
          expect(text.trim(), isNotEmpty, reason: '${language.tag} $key');
          expect(text, isNot(contains('{')), reason: '${language.tag} $key');
        }
        // Both Play messages name the action shown next to them.
        final manage = AppCopy.resolve(l, 'billing.manage');
        for (final key in [
          'billing.playOnHold',
          'billing.playReceiptUnlinked',
        ]) {
          expect(
            AppCopy.resolve(l, key),
            contains(manage),
            reason: '${language.tag} $key',
          );
        }
      }
    });

    test('device_clock_ahead a son propre titre et son propre message', () {
      for (final language in AppLanguages.all) {
        final l = lookupAppLocalizations(language.locale);
        final title = _controller(l, 'title', 'device_clock_ahead');
        final message = _controller(l, 'message', 'device_clock_ahead');
        expect(
          title,
          isNot(_controller(l, 'title', '__unknown__')),
          reason: language.tag,
        );
        expect(
          message,
          isNot(_controller(l, 'message', '__unknown__')),
          reason: language.tag,
        );
        expect(title.trim(), isNotEmpty, reason: language.tag);
        expect(message.trim(), isNotEmpty, reason: language.tag);
      }
    });

    test('textes FR et EN demandés', () {
      final fr = lookupAppLocalizations(const Locale('fr'));
      final en = lookupAppLocalizations(const Locale('en'));
      expect(
        _controller(fr, 'title', 'device_clock_ahead'),
        'Heure de l’appareil en avance',
      );
      expect(
        _controller(fr, 'message', 'device_clock_ahead'),
        'L’heure de cet appareil semble en avance. Activez la date et '
        'l’heure automatiques pour rester connecté.',
      );
      expect(
        _controller(en, 'title', 'device_clock_ahead'),
        'Device clock ahead',
      );
      expect(
        _controller(en, 'message', 'device_clock_ahead'),
        'This device’s clock seems to be ahead. Turn on automatic date and '
        'time to stay signed in.',
      );
      expect(
        AppCopy.resolve(fr, 'google.busy'),
        'Google n’est pas disponible pendant l’opération en cours (connexion '
        'VPN, compte ou invité). Réessayez lorsqu’elle sera terminée ; votre '
        'accès actuel est conservé.',
      );
      expect(
        AppCopy.resolve(en, 'google.busy'),
        'Google is unavailable while another operation is in progress (VPN '
        'connection, account or guest). Try again once it has finished; your '
        'current access is kept.',
      );
      expect(
        AppCopy.resolve(fr, 'billing.playOnHold'),
        'Votre abonnement Google Play est suspendu ou en attente de paiement. '
        'Ouvrez « Gérer l’abonnement » pour le régulariser dans Google Play.',
      );
      expect(
        AppCopy.resolve(en, 'billing.playOnHold'),
        'Your Google Play subscription is on hold or awaiting payment. Open '
        '“Manage subscription” to fix it in Google Play.',
      );
      expect(
        AppCopy.resolve(fr, 'billing.playReceiptUnlinked'),
        'Ce compte Google Play détient déjà un abonnement Fuze Premium qui '
        'n’est pas actif pour ce compte FuzeVPN. Ouvrez « Gérer l’abonnement » '
        'pour le consulter dans Google Play.',
      );
      expect(
        AppCopy.resolve(en, 'billing.playReceiptUnlinked'),
        'This Google Play account already holds a Fuze Premium subscription '
        'that is not active for this FuzeVPN account. Open “Manage '
        'subscription” to review it in Google Play.',
      );
    });
  });

  group('notice.retryAfter au-delà de 120 s', () {
    test('minutes puis heures, arrondies au-dessus (70 langues)', () {
      // (secondes reçues, nombre affiché)
      const cases = <(int, int)>[
        (121, 3),
        (3600, 60),
        (3601, 61),
        (7200, 120),
        (7201, 3),
        (86400, 24),
      ];
      for (final language in AppLanguages.all) {
        final l = lookupAppLocalizations(language.locale);
        // Up to 120 seconds the message is unchanged (A16-ui-l10n-04).
        expect(_retry(l, 120), l.notice_retryAfter(120), reason: language.tag);
        for (final (seconds, shown) in cases) {
          final text = _retry(l, seconds);
          final reason = '${language.tag} $seconds';
          expect(text, contains('$shown'), reason: reason);
          expect(text, isNot(contains('$seconds')), reason: reason);
          expect(text, isNot(contains('{')), reason: reason);
          expect(text, isNot(l.notice_retryAfter(shown)), reason: reason);
        }
        // Three minutes and three hours are told apart.
        expect(_retry(l, 180), isNot(_retry(l, 10800)), reason: language.tag);
      }
    });

    test('formes grammaticales des minutes et des heures', () {
      const expected = <String, Map<int, String>>{
        'en': {
          121: 'Try again in 3 minutes.',
          3601: 'Try again in 61 minutes.',
          7201: 'Try again in 3 hours.',
          86400: 'Try again in 24 hours.',
        },
        'fr': {
          121: 'Réessayez dans 3 minutes.',
          86400: 'Réessayez dans 24 heures.',
        },
        'de': {180: 'in 3 Minuten erneut', 10800: 'in 3 Stunden erneut'},
        'es': {180: '3 minutos.', 10800: '3 horas.'},
        'it': {180: '3 minuti.', 10800: '3 ore.'},
        'nl': {180: '3 minuten opnieuw', 10800: '3 uur opnieuw'},
        'sv': {180: '3 minuter.', 10800: '3 timmar.'},
        'el': {180: '3 λεπτά.', 10800: '3 ώρες.'},
        'ru': {
          1260: 'через 21 минуту.',
          1320: 'через 22 минуты.',
          1500: 'через 25 минут.',
          75600: 'через 21 час.',
          79200: 'через 22 часа.',
          18000: 'через 5 часов.',
        },
        'uk': {
          1260: 'через 21 хвилину.',
          1320: 'через 22 хвилини.',
          1500: 'через 25 хвилин.',
          75600: 'через 21 годину.',
          79200: 'через 22 години.',
          18000: 'через 5 годин.',
        },
        'pl': {
          1260: 'za 21 minut.',
          1320: 'za 22 minuty.',
          1500: 'za 25 minut.',
          79200: 'za 22 godziny.',
          18000: 'za 5 godzin.',
        },
        'cs': {
          180: 'za 3 minuty.',
          300: 'za 5 minut.',
          10800: 'za 3 hodiny.',
          18000: 'za 5 hodin.',
        },
        'ro': {
          180: 'peste 3 minute.',
          1200: 'peste 20 de minute.',
          10800: 'peste 3 ore.',
          72000: 'peste 20 de ore.',
        },
        'ar': {
          180: '3 دقائق',
          660: '11 دقيقة',
          10800: '3 ساعات',
          39600: '11 ساعة',
        },
      };
      expected.forEach((tag, cases) {
        final l = lookupAppLocalizations(Locale(tag));
        cases.forEach((seconds, fragment) {
          expect(
            _retry(l, seconds),
            contains(fragment),
            reason: '$tag $seconds',
          );
        });
      });
    });

    test('un argument non entier reste lisible', () {
      final en = lookupAppLocalizations(const Locale('en'));
      expect(_retry(en, '3600'), 'Try again in 60 minutes.');
      expect(_retry(en, 7201.0), 'Try again in 3 hours.');
    });
  });

  test('location_migration_slow cite la destination (70 langues)', () {
    for (final language in AppLanguages.all) {
      final l = lookupAppLocalizations(language.locale);
      for (final code in [
        'location_migration_slow',
        'location_migration_pending',
      ]) {
        expect(
          _controller(l, 'message', code, 'Zürich 7'),
          contains('Zürich 7'),
          reason: '${language.tag} $code',
        );
      }
    }
  });
}
