import 'package:flutter/material.dart';

/// FuzeVPN's official ivory, ink and golden signal identity, adapted to Android.
abstract final class FuzeVpnTheme {
  static const Color paper = Color(0xFFF3EFE6);
  static const Color ink = Color(0xFF101820);
  static const Color surfaceLight = Color(0xFFFAF8F3);
  static const Color signal = Color(0xFFF4C95D);
  static const Color signalDeep = Color(0xFF8F6107);
  static const Color wash = Color(0xFFEAE4D9);
  static const Color muted = Color(0xFF625D54);
  static const Color border = Color(0xFFD1C9BD);
  static const Color canvasDark = Color(0xFF101820);
  static const Color surfaceDark = Color(0xFF17242C);
  static const Color successLight = Color(0xFF2F7058);
  static const Color errorLight = Color(0xFFAA3F38);
  static const Color successDark = Color(0xFF9AC7A8);
  static const Color errorDark = Color(0xFFFFB4A7);

  static const String displayFont = 'Archivo';
  static const String monoFont = 'IBM Plex Mono';
  static const List<String> fontFallback = <String>['Noto Sans Arabic'];
  static const double cornerRadius = 8;

  static ThemeData light() => _theme(Brightness.light);

  static ThemeData dark() => _theme(Brightness.dark);

  static TextStyle mono({
    double? fontSize,
    FontWeight fontWeight = FontWeight.w600,
    Color? color,
    double? letterSpacing,
  }) => TextStyle(
    fontFamily: monoFont,
    fontFamilyFallback: fontFallback,
    fontSize: fontSize,
    fontWeight: fontWeight,
    color: color,
    letterSpacing: letterSpacing,
  );

  static ThemeData _theme(Brightness brightness) {
    final bool isLight = brightness == Brightness.light;
    final Color foreground = isLight ? ink : paper;
    final Color background = isLight ? paper : canvasDark;
    final Color surface = isLight ? surfaceLight : surfaceDark;
    final Color success = isLight ? successLight : successDark;
    final Color error = isLight ? errorLight : errorDark;
    final Color subdued = isLight ? muted : const Color(0xFFC6BEB2);
    final Color outline = isLight ? border : const Color(0xFF3C4951);
    final Color controlOutline = isLight
        ? const Color(0xFF938878)
        : const Color(0xFF79858B);

    final ColorScheme scheme =
        ColorScheme.fromSeed(
          seedColor: signal,
          brightness: brightness,
        ).copyWith(
          primary: signal,
          onPrimary: ink,
          primaryContainer: isLight ? ink : surfaceDark,
          onPrimaryContainer: paper,
          secondary: isLight ? ink : signal,
          onSecondary: isLight ? paper : ink,
          secondaryContainer: isLight
              ? const Color(0xFFF8E9BB)
              : const Color(0xFF3A3224),
          onSecondaryContainer: isLight ? ink : const Color(0xFFF8E9BB),
          tertiary: success,
          onTertiary: isLight ? paper : ink,
          error: error,
          onError: isLight ? paper : ink,
          errorContainer: isLight
              ? const Color(0xFFF8E4DD)
              : const Color(0xFF402B2A),
          onErrorContainer: isLight
              ? const Color(0xFF7C302B)
              : const Color(0xFFFFDAD2),
          surface: surface,
          onSurface: foreground,
          onSurfaceVariant: subdued,
          outline: outline,
          outlineVariant: outline,
          surfaceContainerLowest: surface,
          surfaceContainerLow: surface,
          surfaceContainer: isLight ? wash : const Color(0xFF1C2A32),
          surfaceContainerHigh: isLight
              ? const Color(0xFFE2DACC)
              : const Color(0xFF26343C),
          surfaceContainerHighest: isLight
              ? const Color(0xFFD9D0C1)
              : const Color(0xFF35434B),
          shadow: ink.withValues(alpha: 0.08),
          scrim: ink.withValues(alpha: 0.56),
        );

    final TextTheme baseTextTheme =
        Typography.material2021(
          platform: TargetPlatform.android,
          colorScheme: scheme,
        ).black.apply(
          fontFamily: displayFont,
          fontFamilyFallback: fontFallback,
          bodyColor: foreground,
          displayColor: foreground,
        );
    final TextTheme textTheme = baseTextTheme.copyWith(
      displayLarge: baseTextTheme.displayLarge?.copyWith(
        fontWeight: FontWeight.w800,
        letterSpacing: -2.2,
      ),
      displayMedium: baseTextTheme.displayMedium?.copyWith(
        fontWeight: FontWeight.w800,
        letterSpacing: -1.6,
      ),
      headlineLarge: baseTextTheme.headlineLarge?.copyWith(
        fontWeight: FontWeight.w800,
        letterSpacing: -1.2,
        height: 1.15,
      ),
      headlineMedium: baseTextTheme.headlineMedium?.copyWith(
        fontWeight: FontWeight.w800,
        letterSpacing: -0.8,
        height: 1.18,
      ),
      headlineSmall: baseTextTheme.headlineSmall?.copyWith(
        fontWeight: FontWeight.w700,
        letterSpacing: -0.5,
      ),
      titleLarge: baseTextTheme.titleLarge?.copyWith(
        fontWeight: FontWeight.w700,
      ),
      titleMedium: baseTextTheme.titleMedium?.copyWith(
        fontWeight: FontWeight.w600,
      ),
      bodyLarge: baseTextTheme.bodyLarge?.copyWith(fontSize: 16, height: 1.5),
      bodyMedium: baseTextTheme.bodyMedium?.copyWith(fontSize: 14, height: 1.5),
      bodySmall: baseTextTheme.bodySmall?.copyWith(fontSize: 12, height: 1.45),
      labelLarge: baseTextTheme.labelLarge?.copyWith(
        fontWeight: FontWeight.w700,
      ),
    );

    final RoundedRectangleBorder controlShape = RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(cornerRadius),
    );
    final RoundedRectangleBorder cardShape = RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
      side: BorderSide(color: outline),
    );

    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      colorScheme: scheme,
      fontFamily: displayFont,
      fontFamilyFallback: fontFallback,
      textTheme: textTheme,
      scaffoldBackgroundColor: background,
      canvasColor: background,
      splashFactory: InkSparkle.splashFactory,
      visualDensity: VisualDensity.standard,
      materialTapTargetSize: MaterialTapTargetSize.padded,
      textSelectionTheme: TextSelectionThemeData(
        cursorColor: scheme.secondary,
        selectionHandleColor: scheme.secondary,
        selectionColor: scheme.secondary.withValues(alpha: 0.18),
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: background,
        foregroundColor: foreground,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
        titleTextStyle: textTheme.titleLarge?.copyWith(color: foreground),
        toolbarHeight: 68,
      ),
      cardTheme: CardThemeData(
        elevation: 0,
        color: surface,
        surfaceTintColor: Colors.transparent,
        shape: cardShape,
        margin: EdgeInsets.zero,
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          minimumSize: const Size(48, 56),
          padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 16),
          backgroundColor: signal,
          foregroundColor: scheme.onPrimary,
          disabledBackgroundColor: scheme.surfaceContainerHighest,
          disabledForegroundColor: subdued,
          elevation: 0,
          shape: controlShape,
          textStyle: textTheme.labelLarge,
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          minimumSize: const Size(48, 52),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
          foregroundColor: foreground,
          side: BorderSide(color: outline),
          shape: controlShape,
          textStyle: textTheme.labelLarge,
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          minimumSize: const Size(48, 48),
          foregroundColor: scheme.secondary,
          shape: controlShape,
          textStyle: textTheme.labelLarge,
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: surface,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
        floatingLabelStyle: TextStyle(color: scheme.secondary),
        hintStyle: TextStyle(color: subdued),
        prefixIconColor: subdued,
        suffixIconColor: subdued,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(cornerRadius),
          borderSide: BorderSide(color: outline),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(cornerRadius),
          borderSide: BorderSide(color: controlOutline),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(cornerRadius),
          borderSide: BorderSide(color: scheme.secondary, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(cornerRadius),
          borderSide: BorderSide(color: error),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(cornerRadius),
          borderSide: BorderSide(color: error, width: 2),
        ),
      ),
      dividerTheme: DividerThemeData(color: outline, thickness: 1, space: 1),
      tabBarTheme: TabBarThemeData(
        dividerColor: outline,
        indicatorColor: scheme.secondary,
        indicatorSize: TabBarIndicatorSize.tab,
        labelColor: foreground,
        unselectedLabelColor: subdued,
        labelStyle: textTheme.labelLarge,
        unselectedLabelStyle: textTheme.labelLarge,
      ),
      navigationBarTheme: NavigationBarThemeData(
        height: 78,
        backgroundColor: background,
        surfaceTintColor: Colors.transparent,
        indicatorColor: signal,
        indicatorShape: controlShape,
        elevation: 0,
        iconTheme: WidgetStateProperty.resolveWith(
          (states) => IconThemeData(
            color: states.contains(WidgetState.selected) ? ink : subdued,
          ),
        ),
        labelTextStyle: WidgetStateProperty.resolveWith(
          (states) => textTheme.labelMedium?.copyWith(
            color: states.contains(WidgetState.selected) ? foreground : subdued,
            fontWeight: states.contains(WidgetState.selected)
                ? FontWeight.w700
                : FontWeight.w500,
          ),
        ),
      ),
      navigationRailTheme: NavigationRailThemeData(
        backgroundColor: background,
        indicatorColor: signal,
        indicatorShape: controlShape,
        elevation: 0,
        selectedIconTheme: const IconThemeData(color: ink),
        unselectedIconTheme: IconThemeData(color: subdued),
        selectedLabelTextStyle: textTheme.labelMedium?.copyWith(
          color: foreground,
          fontWeight: FontWeight.w700,
        ),
        unselectedLabelTextStyle: textTheme.labelMedium?.copyWith(
          color: subdued,
        ),
      ),
      chipTheme: ChipThemeData(
        backgroundColor: surface,
        selectedColor: scheme.secondaryContainer,
        side: BorderSide(color: outline),
        shape: controlShape,
        labelStyle: textTheme.labelMedium,
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      ),
      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        backgroundColor: foreground,
        contentTextStyle: textTheme.bodyMedium?.copyWith(color: background),
        shape: controlShape,
        elevation: 0,
      ),
      dialogTheme: DialogThemeData(
        backgroundColor: surface,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        shape: cardShape,
      ),
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: surface,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        modalElevation: 0,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
      ),
      progressIndicatorTheme: ProgressIndicatorThemeData(
        color: isLight ? signalDeep : signal,
        linearTrackColor: outline,
        circularTrackColor: outline,
      ),
      checkboxTheme: CheckboxThemeData(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        side: BorderSide(color: controlOutline, width: 1.5),
        fillColor: WidgetStateProperty.resolveWith<Color?>((states) {
          if (states.contains(WidgetState.selected)) return signal;
          return Colors.transparent;
        }),
        checkColor: WidgetStatePropertyAll<Color>(scheme.onPrimary),
      ),
      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.disabled)) return subdued;
          return states.contains(WidgetState.selected) ? ink : subdued;
        }),
        trackColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.disabled)) return outline;
          return states.contains(WidgetState.selected)
              ? signal
              : scheme.surfaceContainerHigh;
        }),
        trackOutlineColor: WidgetStateProperty.resolveWith(
          (states) =>
              states.contains(WidgetState.selected) ? null : controlOutline,
        ),
      ),
      radioTheme: RadioThemeData(
        fillColor: WidgetStateProperty.resolveWith(
          (states) => states.contains(WidgetState.disabled)
              ? subdued
              : scheme.secondary,
        ),
      ),
      expansionTileTheme: ExpansionTileThemeData(
        iconColor: scheme.secondary,
        textColor: foreground,
        collapsedIconColor: subdued,
        collapsedTextColor: foreground,
        shape: const Border(),
        collapsedShape: const Border(),
        tilePadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
      ),
      listTileTheme: ListTileThemeData(
        iconColor: subdued,
        selectedColor: scheme.secondary,
        selectedTileColor: scheme.secondaryContainer,
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
      ),
    );
  }
}
