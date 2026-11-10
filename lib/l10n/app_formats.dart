import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

import 'app_languages.dart';

abstract final class AppFormats {
  static Locale localeOf(BuildContext context) => AppLanguages.formattingLocale(
    Localizations.localeOf(context),
    WidgetsBinding.instance.platformDispatcher.locales,
  );

  /// Flutter ships date patterns for most app languages; the others (Hausa,
  /// Malagasy, Somali, Yoruba, Igbo, Kinyarwanda) use day-first British
  /// English patterns instead of throwing.
  static String _dateLocale(BuildContext context) => Intl.verifiedLocale(
    localeOf(context).toString(),
    DateFormat.localeExists,
    onFailure: (_) => 'en_GB',
  )!;

  /// API instants are UTC; they are shown on the device's local calendar day.
  static String date(BuildContext context, DateTime value) =>
      DateFormat.yMd(_dateLocale(context)).format(value.toLocal());

  /// Financial dates spell out the month to avoid day/month ambiguity.
  static String longDate(BuildContext context, DateTime value) =>
      DateFormat.yMMMMd(_dateLocale(context)).format(value.toLocal());
}
