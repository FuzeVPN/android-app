import 'package:flutter/material.dart';

import '../core/country_data.dart';

/// Bundled artwork: reliable on Android, including offline and custom fonts.
/// The adjacent localized country/language name provides the accessible label.
class CountryFlag extends StatelessWidget {
  const CountryFlag({
    super.key,
    required this.countryCode,
    this.width = 32,
    this.height = 24,
  });

  final String countryCode;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    final code = countryCode.trim().toUpperCase();
    final normalized = code == 'UK' ? 'GB' : code;
    final fallback = Icon(
      Icons.public,
      size: height,
      color: Theme.of(context).colorScheme.onSurfaceVariant,
    );
    return ExcludeSemantics(
      child: SizedBox(
        width: width,
        height: height,
        child: bundledCountryFlags.contains(normalized)
            ? Image.asset(
                'assets/flags/${normalized.toLowerCase()}.png',
                fit: BoxFit.contain,
                filterQuality: FilterQuality.medium,
                errorBuilder: (_, _, _) => fallback,
              )
            : fallback,
      ),
    );
  }
}
