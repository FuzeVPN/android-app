// Renouvellement automatique du certificat OpenVPN : textes des 70 langues.
// Les deux avis natifs ne demandent plus un « renouvellement du profil » que
// l'interface ne proposait pas, et la durée de validité a ses libellés.
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fuzevpn_android/l10n/app_copy.dart';
import 'package:fuzevpn_android/l10n/app_languages.dart';
import 'package:fuzevpn_android/l10n/generated/app_localizations.dart';

String _native(AppLocalizations l, String code) => AppCopy.resolve(
  l,
  'notice.native.message',
  arguments: {'code': code, 'protocol': 'OpenVPN'},
);

void main() {
  test('les avis disent quoi faire quand le renouvellement automatique '
      'échoue', () {
    final fr = lookupAppLocalizations(const Locale('fr'));
    expect(
      _native(fr, 'openvpn_renewal_required'),
      'Le certificat OpenVPN n’a pas pu être renouvelé automatiquement. '
      'Relancez la connexion dans l’application.',
    );
    expect(
      _native(fr, 'openvpn_certificate_expired'),
      'Le certificat OpenVPN a expiré. Relancez la connexion dans '
      'l’application pour le renouveler.',
    );
    final en = lookupAppLocalizations(const Locale('en'));
    expect(
      _native(en, 'openvpn_renewal_required'),
      'The OpenVPN certificate could not be renewed automatically. '
      'Start a new connection in the app.',
    );
    expect(
      _native(en, 'openvpn_certificate_expired'),
      'The OpenVPN certificate has expired. Start a new connection in the '
      'app to renew it.',
    );
  });

  test('les deux avis nomment le certificat OpenVPN (70 langues)', () {
    for (final language in AppLanguages.all) {
      final l = lookupAppLocalizations(language.locale);
      final generic = _native(l, '__unknown__');
      final required = _native(l, 'openvpn_renewal_required');
      final expired = _native(l, 'openvpn_certificate_expired');
      for (final message in [required, expired]) {
        expect(message, contains('OpenVPN'), reason: language.tag);
        expect(message, isNot(generic), reason: language.tag);
        expect(message, isNot(contains('{')), reason: language.tag);
      }
      expect(required, isNot(expired), reason: language.tag);
    }
  });

  test('la validité du certificat a ses libellés (70 langues)', () {
    const date = '9 FEB 2027';
    for (final language in AppLanguages.all) {
      final l = lookupAppLocalizations(language.locale);
      final label = AppCopy.resolve(l, 'connection.certificate');
      expect(label, contains('OpenVPN'), reason: language.tag);
      final valid = AppCopy.resolve(
        l,
        'connection.certificateValidUntil',
        arguments: {'date': date},
      );
      final expired = AppCopy.resolve(
        l,
        'connection.certificateExpired',
        arguments: {'date': date},
      );
      for (final line in [valid, expired]) {
        expect(line, contains(date), reason: language.tag);
        expect(line, isNot(contains('{')), reason: language.tag);
        expect(
          line.replaceAll(date, '').trim(),
          isNotEmpty,
          reason: language.tag,
        );
      }
      expect(valid, isNot(expired), reason: language.tag);
      final hint = AppCopy.resolve(l, 'connection.certificateAutoRenewal');
      final renew = AppCopy.resolve(l, 'action.renew');
      for (final (key, text) in [
        ('connection.certificateAutoRenewal', hint),
        ('action.renew', renew),
      ]) {
        expect(text.trim(), isNotEmpty, reason: language.tag);
        // An unknown key resolves to itself.
        expect(text, isNot(key), reason: language.tag);
      }
      expect(renew.length, lessThanOrEqualTo(28), reason: language.tag);
    }
  });

  test('les libellés français et anglais', () {
    final fr = lookupAppLocalizations(const Locale('fr'));
    expect(fr.connection_certificate, 'Certificat OpenVPN');
    expect(fr.connection_certificateValidUntil('X'), 'Valable jusqu’au X');
    expect(fr.connection_certificateExpired('X'), 'Expiré le X');
    expect(
      fr.connection_certificateAutoRenewal,
      'Renouvelé automatiquement à la prochaine connexion.',
    );
    expect(fr.action_renew, 'Renouveler');
    final en = lookupAppLocalizations(const Locale('en'));
    expect(en.connection_certificate, 'OpenVPN certificate');
    expect(en.connection_certificateValidUntil('X'), 'Valid until X');
    expect(en.connection_certificateExpired('X'), 'Expired on X');
    expect(
      en.connection_certificateAutoRenewal,
      'Renewed automatically at the next connection.',
    );
    expect(en.action_renew, 'Renew');
  });
}
