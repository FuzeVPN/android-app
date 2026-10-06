import 'package:flutter/material.dart';

const String _emblemAsset = 'assets/images/fuzevpn-emblem.png';

/// The official FuzeVPN shield-and-rocket emblem, automatically recoloured
/// for the active theme while preserving its transparent background.
class FuzeEmblem extends StatelessWidget {
  const FuzeEmblem({super.key, this.size = 40, this.color, this.semanticLabel});

  final double size;
  final Color? color;
  final String? semanticLabel;

  @override
  Widget build(BuildContext context) {
    final Color resolvedColor =
        color ?? Theme.of(context).colorScheme.onSurface;
    final Widget image = ColorFiltered(
      colorFilter: ColorFilter.mode(resolvedColor, BlendMode.srcIn),
      child: Image.asset(
        _emblemAsset,
        width: size,
        height: size,
        fit: BoxFit.contain,
        excludeFromSemantics: true,
        filterQuality: FilterQuality.high,
      ),
    );
    if (semanticLabel == null) return image;
    return Semantics(image: true, label: semanticLabel, child: image);
  }
}

/// Horizontal brand lockup shared by authentication and application chrome.
class FuzeBrand extends StatelessWidget {
  const FuzeBrand({
    super.key,
    this.emblemSize = 32,
    this.alignment = MainAxisAlignment.start,
    this.wordmark = true,
    this.color,
  });

  final double emblemSize;
  final MainAxisAlignment alignment;
  final bool wordmark;
  final Color? color;

  @override
  Widget build(BuildContext context) => Semantics(
    image: true,
    label: 'FuzeVPN',
    container: true,
    child: ExcludeSemantics(
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: alignment,
          children: <Widget>[
            FuzeEmblem(size: emblemSize, color: color),
            if (wordmark) ...<Widget>[
              SizedBox(width: emblemSize * 0.25),
              Text(
                'FuzeVPN',
                // A wordmark is a visual logo rather than body copy. Keeping it
                // geometrically stable prevents the lockup from clipping at
                // large accessibility scales; the enclosing Semantics remains
                // available to assistive technologies.
                textScaler: TextScaler.noScaling,
                maxLines: 1,
                overflow: TextOverflow.fade,
                softWrap: false,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: color,
                  fontSize: emblemSize * 0.78,
                  height: 1,
                  fontWeight: FontWeight.w700,
                  letterSpacing: -0.6,
                ),
              ),
            ],
          ],
        ),
      ),
    ),
  );
}
