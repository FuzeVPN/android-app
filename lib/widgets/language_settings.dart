import 'package:flutter/material.dart';

import '../l10n/app_copy.dart';
import '../l10n/app_languages.dart';
import 'country_flag.dart';
import 'fuze_design.dart';

/// The same language choices are available before and after authentication.
class LanguageSettings extends StatelessWidget {
  const LanguageSettings({
    super.key,
    required this.locale,
    required this.onChanged,
    this.compact = false,
  });

  final Locale? locale;
  final ValueChanged<Locale?> onChanged;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    if (compact) {
      return TextButton.icon(
        style: TextButton.styleFrom(
          side: BorderSide(color: Theme.of(context).colorScheme.outlineVariant),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        ),
        onPressed: () => _showPicker(context),
        icon: const Icon(Icons.language),
        label: Text(
          _languageLabel(context, locale ?? Localizations.localeOf(context)),
        ),
      );
    }
    return ListTile(
      minVerticalPadding: 16,
      leading: _LanguageFlag(locale: locale),
      title: Text(context.copy('settings.language')),
      subtitle: Text(_languageLabel(context, locale)),
      trailing: Icon(
        Directionality.of(context) == TextDirection.rtl
            ? Icons.chevron_left
            : Icons.chevron_right,
      ),
      onTap: () => _showPicker(context),
    );
  }

  Future<void> _showPicker(BuildContext context) => showModalBottomSheet<void>(
    context: context,
    showDragHandle: true,
    isScrollControlled: true,
    useSafeArea: true,
    builder: (sheetContext) => SafeArea(
      top: false,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.sizeOf(sheetContext).height * .8,
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(12, 0, 12, 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: FuzePageHeader(
                  title: sheetContext.copy('settings.language'),
                  compact: true,
                ),
              ),
              for (final choice in <Locale?>[
                null,
                ...AppLanguages.sorted.map((language) => language.locale),
              ])
                ListTile(
                  key: ValueKey(
                    'language-${choice?.toLanguageTag() ?? 'system'}',
                  ),
                  minVerticalPadding: 14,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  leading: _LanguageFlag(locale: choice),
                  title: Text(_languageLabel(sheetContext, choice)),
                  trailing: locale == choice
                      ? const Icon(Icons.check_circle)
                      : null,
                  selected: locale == choice,
                  onTap: () {
                    Navigator.of(sheetContext).pop();
                    onChanged(choice);
                  },
                ),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                child: Text(
                  sheetContext.copy('settings.languageDescription'),
                  style: Theme.of(sheetContext).textTheme.bodySmall?.copyWith(
                    color: Theme.of(sheetContext).colorScheme.onSurfaceVariant,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

String _languageLabel(BuildContext context, Locale? locale) =>
    AppLanguages.find(locale)?.name ?? context.copy('language.system');

class _LanguageFlag extends StatelessWidget {
  const _LanguageFlag({required this.locale});
  final Locale? locale;

  @override
  Widget build(BuildContext context) {
    final country = AppLanguages.find(locale)?.flag;
    return SizedBox(
      width: 28,
      child: country == null
          ? const Icon(Icons.language)
          : CountryFlag(countryCode: country, width: 28, height: 21),
    );
  }
}
