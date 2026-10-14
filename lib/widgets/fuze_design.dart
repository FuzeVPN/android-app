import 'package:flutter/material.dart';

import '../app_theme.dart';

enum FuzePanelTone { surface, wash, dark, signal }

/// A restrained, bordered surface shared by forms and product information.
class FuzePanel extends StatelessWidget {
  const FuzePanel({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(20),
    this.tone = FuzePanelTone.surface,
    this.border = true,
  });

  final Widget child;
  final EdgeInsetsGeometry padding;
  final FuzePanelTone tone;
  final bool border;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final background = switch (tone) {
      FuzePanelTone.surface => scheme.surface,
      FuzePanelTone.wash => scheme.surfaceContainer,
      FuzePanelTone.dark => FuzeVpnTheme.surfaceDark,
      FuzePanelTone.signal => scheme.secondaryContainer,
    };
    final foreground = tone == FuzePanelTone.dark
        ? FuzeVpnTheme.paper
        : scheme.onSurface;
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(12),
        border: border
            ? Border.all(
                color: tone == FuzePanelTone.dark
                    ? const Color(0xFF465158)
                    : scheme.outlineVariant,
              )
            : null,
      ),
      child: IconTheme.merge(
        data: IconThemeData(color: foreground),
        child: DefaultTextStyle.merge(
          style: TextStyle(color: foreground),
          child: child,
        ),
      ),
    );
  }
}

class FuzeEyebrow extends StatelessWidget {
  const FuzeEyebrow(this.text, {super.key, this.color, this.leading});

  final String text;
  final Color? color;
  final Widget? leading;

  @override
  Widget build(BuildContext context) => Row(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: <Widget>[
      if (leading != null) ...<Widget>[
        leading!,
        const SizedBox(width: 10),
      ] else ...<Widget>[
        Container(width: 22, height: 2, color: FuzeVpnTheme.signalDeep),
        const SizedBox(width: 10),
      ],
      Flexible(
        child: Text(
          text.toUpperCase(),
          style: FuzeVpnTheme.mono(
            fontSize: 11,
            letterSpacing: 0.7,
            color: color ?? Theme.of(context).colorScheme.onSurfaceVariant,
          ),
        ),
      ),
    ],
  );
}

class FuzePageHeader extends StatelessWidget {
  const FuzePageHeader({
    super.key,
    required this.title,
    this.description,
    this.eyebrow,
    this.trailing,
    this.compact = false,
  });

  final String title;
  final String? description;
  final String? eyebrow;
  final Widget? trailing;
  final bool compact;

  @override
  Widget build(BuildContext context) => Padding(
    padding: EdgeInsets.only(top: compact ? 4 : 8, bottom: compact ? 20 : 28),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        if (eyebrow != null) ...<Widget>[
          FuzeEyebrow(eyebrow!),
          const SizedBox(height: 12),
        ],
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: Semantics(
                header: true,
                child: FuzeAdaptiveText(
                  title,
                  style: compact
                      ? Theme.of(context).textTheme.headlineSmall
                      : Theme.of(context).textTheme.headlineLarge,
                ),
              ),
            ),
            if (trailing != null) ...<Widget>[
              const SizedBox(width: 12),
              trailing!,
            ],
          ],
        ),
        if (description != null) ...<Widget>[
          const SizedBox(height: 10),
          Text(
            description!,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ],
    ),
  );
}

/// Fit whole words using the actual font and accessibility scale. The user's
/// TextScaler is never clamped; only the base style can become compact.
class FuzeAdaptiveText extends StatelessWidget {
  const FuzeAdaptiveText(
    this.text, {
    super.key,
    required this.style,
    this.minimumFontSize = 20,
    this.textAlign,
  }) : assert(minimumFontSize > 0);

  final String text;
  final TextStyle? style;
  final double minimumFontSize;
  final TextAlign? textAlign;

  @override
  Widget build(BuildContext context) => LayoutBuilder(
    builder: (context, constraints) {
      final resolved = DefaultTextStyle.of(context).style.merge(style);
      final scaler = MediaQuery.textScalerOf(context);
      final direction = Directionality.of(context);
      final locale = Localizations.maybeLocaleOf(context);
      final original = resolved.fontSize ?? 32;
      final words = <String>[];
      final boundaries = TextPainter(
        text: TextSpan(text: text, style: resolved),
        textDirection: direction,
        locale: locale,
        textScaler: scaler,
      )..layout();
      final punctuation = RegExp(r'\p{P}', unicode: true);
      for (var offset = 0; offset < text.length;) {
        final range = boundaries.getWordBoundary(TextPosition(offset: offset));
        var end = range.end > offset ? range.end : offset + 1;
        // Keep attached punctuation (notably reconnecting's ellipsis) in the
        // width measurement so it cannot force the preceding word to split.
        if (text.substring(offset, end).trim().isNotEmpty) {
          while (end < text.length &&
              punctuation.hasMatch(text.substring(end, end + 1))) {
            end++;
          }
        }
        final word = text.substring(offset, end).trim();
        if (word.isNotEmpty) words.add(word);
        offset = end;
      }
      boundaries.dispose();
      bool fits(double size) {
        for (final word in words) {
          final painter = TextPainter(
            text: TextSpan(
              text: word,
              style: resolved.copyWith(fontSize: size),
            ),
            textDirection: direction,
            locale: locale,
            textScaler: scaler,
          )..layout();
          final width = painter.width;
          painter.dispose();
          if (width > constraints.maxWidth) return false;
        }
        return true;
      }

      var size = original;
      if (!fits(original) && original > minimumFontSize) {
        var lower = minimumFontSize;
        var upper = original;
        for (var step = 0; step < 12; step++) {
          final middle = (lower + upper) / 2;
          if (fits(middle)) {
            lower = middle;
          } else {
            upper = middle;
          }
        }
        size = lower;
      }
      return Text(
        text,
        style: resolved.copyWith(fontSize: size),
        textScaler: scaler,
        locale: locale,
        textAlign: textAlign,
        softWrap: true,
      );
    },
  );
}

class FuzeEmptyState extends StatelessWidget {
  const FuzeEmptyState({
    super.key,
    required this.icon,
    required this.title,
    this.description,
    this.action,
  });

  final IconData icon;
  final String title;
  final String? description;
  final Widget? action;

  @override
  Widget build(BuildContext context) => FuzePanel(
    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
    child: Column(
      children: <Widget>[
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.secondaryContainer,
            shape: BoxShape.circle,
          ),
          child: Icon(icon, size: 28),
        ),
        const SizedBox(height: 18),
        Text(
          title,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        if (description != null) ...<Widget>[
          const SizedBox(height: 8),
          Text(
            description!,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
        ],
        if (action != null) ...<Widget>[const SizedBox(height: 20), action!],
      ],
    ),
  );
}

/// Decorative geometry derived from the site's tunnel diagram, without data.
class FuzeNetworkGrid extends StatelessWidget {
  const FuzeNetworkGrid({super.key, this.child});
  final Widget? child;

  @override
  Widget build(BuildContext context) =>
      CustomPaint(painter: const _NetworkGridPainter(), child: child);
}

class _NetworkGridPainter extends CustomPainter {
  const _NetworkGridPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final line = Paint()
      ..color = FuzeVpnTheme.paper.withValues(alpha: 0.035)
      ..strokeWidth = 1;
    for (double x = 0; x < size.width; x += 32) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), line);
    }
    for (double y = 0; y < size.height; y += 32) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), line);
    }
  }

  @override
  bool shouldRepaint(_NetworkGridPainter oldDelegate) => false;
}
