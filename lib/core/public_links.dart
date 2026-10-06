import 'package:flutter/widgets.dart';

/// Public FuzeVPN pages and the independent Google Play subscription manager.
abstract final class PublicLinks {
  static final Uri playSubscriptions = Uri.https(
    'play.google.com',
    '/store/account/subscriptions',
    <String, String>{'sku': 'premium', 'package': 'com.fuzevpn'},
  );

  static const Set<String> _supportedLanguages = <String>{
    'fr',
    'en',
    'es',
    'de',
  };

  static Uri privacy(Locale locale) => _page(locale, 'privacy.html');

  static Uri deleteAccount(Locale locale) =>
      privacy(locale).replace(fragment: 'rights-deletion');

  static Uri terms(Locale locale) => _page(locale, 'terms.html');

  static Uri security(Locale locale) => _page(locale, 'security.html');

  static Uri _page(Locale locale, String page) {
    final String requested = locale.languageCode.toLowerCase();
    final String language = _supportedLanguages.contains(requested)
        ? requested
        : 'fr';
    return Uri.https('fuzevpn.com', '/$language/$page');
  }
}
