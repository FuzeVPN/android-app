import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fuzevpn_android/core/public_links.dart';

void main() {
  test('builds localized public links for every supported language', () {
    for (final String language in <String>['fr', 'en', 'es', 'de']) {
      final Locale locale = Locale(language);

      expect(
        PublicLinks.privacy(locale).toString(),
        'https://fuzevpn.com/$language/privacy.html',
      );
      expect(
        PublicLinks.terms(locale).toString(),
        'https://fuzevpn.com/$language/terms.html',
      );
      expect(
        PublicLinks.security(locale).toString(),
        'https://fuzevpn.com/$language/security.html',
      );
      expect(
        PublicLinks.deleteAccount(locale).toString(),
        'https://fuzevpn.com/$language/privacy.html#rights-deletion',
      );
    }
  });

  test('falls back to French for an unsupported language', () {
    expect(
      PublicLinks.privacy(const Locale('it')).toString(),
      'https://fuzevpn.com/fr/privacy.html',
    );
    expect(
      PublicLinks.deleteAccount(const Locale('ar')).toString(),
      'https://fuzevpn.com/fr/privacy.html#rights-deletion',
    );
  });
}
