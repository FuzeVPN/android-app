import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

import 'app_languages.dart';

abstract final class AppFormats {
  static Locale localeOf(BuildContext context) => AppLanguages.formattingLocale(
    Localizations.localeOf(context),
    WidgetsBinding.instance.platformDispatcher.locales,
  );

  /// API instants are UTC; they are shown on the device's local calendar day.
  static String date(BuildContext context, DateTime value) =>
      DateFormat.yMd(localeOf(context).toString()).format(value.toLocal());

  /// Financial dates spell out the month to avoid day/month ambiguity.
  static String longDate(BuildContext context, DateTime value) =>
      DateFormat.yMMMMd(localeOf(context).toString()).format(value.toLocal());
}
