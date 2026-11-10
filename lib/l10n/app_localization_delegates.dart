import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'generated/app_localizations.dart';

/// App texts plus Material, Cupertino and Widgets texts for every language.
/// Flutter ships no framework texts for Hausa, Malagasy, Somali, Yoruba, Igbo
/// and Kinyarwanda (nor Cupertino texts for Pashto): those fall back to the
/// English framework texts, so the app copy stays translated and no framework
/// lookup fails. The six languages without Widgets texts are left-to-right.
abstract final class AppLocalizationDelegates {
  static const frameworkFallback = Locale('en');

  static const all = <LocalizationsDelegate<dynamic>>[
    AppLocalizations.delegate,
    _FrameworkFallback<MaterialLocalizations>(
      GlobalMaterialLocalizations.delegate,
    ),
    _FrameworkFallback<CupertinoLocalizations>(
      GlobalCupertinoLocalizations.delegate,
    ),
    _FrameworkFallback<WidgetsLocalizations>(
      GlobalWidgetsLocalizations.delegate,
    ),
  ];
}

class _FrameworkFallback<T> extends LocalizationsDelegate<T> {
  const _FrameworkFallback(this._delegate);

  final LocalizationsDelegate<T> _delegate;

  @override
  bool isSupported(Locale locale) => true;

  @override
  Future<T> load(Locale locale) => _delegate.load(
    _delegate.isSupported(locale)
        ? locale
        : AppLocalizationDelegates.frameworkFallback,
  );

  @override
  bool shouldReload(_FrameworkFallback<T> old) => false;
}
