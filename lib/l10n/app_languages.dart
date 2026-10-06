import 'package:flutter/widgets.dart';

/// Canonical language tags are shared with Android's NativeLocalePolicy.
/// Names are autonyms, so the picker remains usable in an unfamiliar language.
class AppLanguage {
  const AppLanguage(this.locale, this.name, this.flag);
  final Locale locale;
  final String name;
  final String flag;
  String get tag => locale.toLanguageTag();
}

abstract final class AppLanguages {
  static const fallback = Locale('fr');
  static const all = <AppLanguage>[
    AppLanguage(Locale('en'), 'English', 'GB'),
    AppLanguage(Locale('es'), 'Español', 'ES'),
    AppLanguage(Locale('pt'), 'Português', 'PT'),
    AppLanguage(Locale('de'), 'Deutsch', 'DE'),
    AppLanguage(Locale('fr'), 'Français', 'FR'),
    AppLanguage(Locale('ar'), 'العربية', 'SA'),
    AppLanguage(Locale('tr'), 'Türkçe', 'TR'),
    AppLanguage(Locale('ja'), '日本語', 'JP'),
    AppLanguage(Locale('id'), 'Bahasa Indonesia', 'ID'),
    AppLanguage(Locale('ru'), 'Русский', 'RU'),
    AppLanguage(Locale('it'), 'Italiano', 'IT'),
    AppLanguage(Locale('ko'), '한국어', 'KR'),
    AppLanguage(Locale('pl'), 'Polski', 'PL'),
    AppLanguage(Locale('nl'), 'Nederlands', 'NL'),
    AppLanguage(Locale('hi'), 'हिन्दी', 'IN'),
    AppLanguage(Locale('vi'), 'Tiếng Việt', 'VN'),
    AppLanguage(Locale('uk'), 'Українська', 'UA'),
    AppLanguage(Locale('th'), 'ไทย', 'TH'),
    AppLanguage(
      Locale.fromSubtags(languageCode: 'zh', scriptCode: 'Hans'),
      '简体中文',
      'CN',
    ),
    AppLanguage(
      Locale.fromSubtags(languageCode: 'zh', scriptCode: 'Hant'),
      '繁體中文',
      'TW',
    ),
    AppLanguage(Locale('fa'), 'فارسی', 'IR'),
    AppLanguage(Locale('ur'), 'اردو', 'PK'),
    AppLanguage(Locale('fil'), 'Filipino', 'PH'),
    AppLanguage(Locale('ms'), 'Bahasa Melayu', 'MY'),
    AppLanguage(Locale('ro'), 'Română', 'RO'),
    AppLanguage(Locale('cs'), 'Čeština', 'CZ'),
    AppLanguage(Locale('sv'), 'Svenska', 'SE'),
    AppLanguage(Locale('da'), 'Dansk', 'DK'),
    AppLanguage(Locale('nb'), 'Norsk bokmål', 'NO'),
    AppLanguage(Locale('el'), 'Ελληνικά', 'GR'),
  ];

  // Keep the historical fallback, independently of the alphabetical picker.
  static final supportedLocales = <Locale>[
    fallback,
    ...all.where((item) => item.locale != fallback).map((item) => item.locale),
  ];

  /// Latin names ignore accents for ordering. Other scripts are grouped in
  /// Unicode order, consistently on every Android version and while offline.
  static final sorted = List<AppLanguage>.unmodifiable(
    <AppLanguage>[...all]
      ..sort((a, b) => _sortKey(a.name).compareTo(_sortKey(b.name))),
  );

  static String _sortKey(String value) {
    const replacements = {
      'á': 'a',
      'ă': 'a',
      'â': 'a',
      'å': 'a',
      'č': 'c',
      'ç': 'c',
      'é': 'e',
      'ê': 'e',
      'ě': 'e',
      'í': 'i',
      'ñ': 'n',
      'ó': 'o',
      'ô': 'o',
      'ö': 'o',
      'š': 's',
      'ú': 'u',
      'ü': 'u',
      'ž': 'z',
      'ế': 'e',
      'ệ': 'e',
    };
    return value
        .toLowerCase()
        .split('')
        .map((c) => replacements[c] ?? c)
        .join();
  }

  static Locale? parse(String? tag) {
    if (tag == null || tag.trim().isEmpty) return null;
    if (tag.length > 63) return null;
    final normalized = tag.trim().replaceAll('_', '-');
    if (!RegExp(
      r'^[A-Za-z]{2,3}(?:-[A-Za-z0-9]{1,8})*$',
    ).hasMatch(normalized)) {
      return null;
    }
    final parts = normalized.toLowerCase().split('-');
    final code = switch (parts.first) {
      'in' => 'id',
      'tl' => 'fil',
      'no' => 'nb',
      final value => value,
    };
    if (code == 'zh') {
      final traditional =
          parts.contains('hant') ||
          (!parts.contains('hans') && parts.any({'tw', 'hk', 'mo'}.contains));
      return Locale.fromSubtags(
        languageCode: 'zh',
        scriptCode: traditional ? 'Hant' : 'Hans',
      );
    }
    for (final item in all) {
      if (item.locale.languageCode == code) return item.locale;
    }
    return null;
  }

  static Locale resolve(List<Locale>? requested, Iterable<Locale> _) {
    for (final locale in requested ?? const <Locale>[]) {
      final match = parse(locale.toLanguageTag());
      if (match != null) return match;
    }
    return fallback;
  }

  static AppLanguage? find(Locale? locale) {
    final canonical = parse(locale?.toLanguageTag());
    for (final item in all) {
      if (item.locale == canonical) return item;
    }
    return null;
  }
}
