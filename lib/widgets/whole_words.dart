import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

/// Keeps every word of a [Text] whole. The text still wraps between words;
/// only when a single word is wider than the space (very large accessibility
/// fonts on a narrow screen) is the text drawn smaller, just enough for that
/// word, instead of being cut in the middle ("Déconnect / er").
class WholeWords extends SingleChildRenderObjectWidget {
  const WholeWords({super.key, required Text super.child});

  @override
  RenderObject createRenderObject(BuildContext context) => RenderWholeWords();
}

class RenderWholeWords extends RenderProxyBox {
  double _scale = 1;

  /// The factor applied when the text was last laid out; 1 when it fits.
  double get scale => _scale;

  /// A paragraph's minimum intrinsic width is its widest word.
  double _scaleFor(double maxWidth) {
    final RenderBox? child = this.child;
    if (child == null || !maxWidth.isFinite) return 1;
    final double widest = child.getMinIntrinsicWidth(double.infinity);
    return widest > maxWidth && maxWidth > 0 ? maxWidth / widest : 1;
  }

  static BoxConstraints _unscaled(BoxConstraints constraints, double scale) =>
      scale == 1
      ? constraints
      : BoxConstraints(
          minWidth: constraints.minWidth / scale,
          maxWidth: constraints.maxWidth / scale,
          minHeight: constraints.minHeight / scale,
          maxHeight: constraints.maxHeight / scale,
        );

  Matrix4 get _transform => Matrix4.diagonal3Values(_scale, _scale, 1);

  @override
  void performLayout() {
    final RenderBox? child = this.child;
    if (child == null) {
      _scale = 1;
      size = constraints.smallest;
      return;
    }
    _scale = _scaleFor(constraints.maxWidth);
    child.layout(_unscaled(constraints, _scale), parentUsesSize: true);
    size = constraints.constrain(child.size * _scale);
  }

  @override
  Size computeDryLayout(BoxConstraints constraints) {
    final RenderBox? child = this.child;
    if (child == null) return constraints.smallest;
    final double scale = _scaleFor(constraints.maxWidth);
    return constraints.constrain(
      child.getDryLayout(_unscaled(constraints, scale)) * scale,
    );
  }

  @override
  double computeMinIntrinsicHeight(double width) {
    final double scale = _scaleFor(width);
    return super.computeMinIntrinsicHeight(width / scale) * scale;
  }

  @override
  double computeMaxIntrinsicHeight(double width) {
    final double scale = _scaleFor(width);
    return super.computeMaxIntrinsicHeight(width / scale) * scale;
  }

  @override
  double? computeDistanceToActualBaseline(TextBaseline baseline) {
    final double? distance = super.computeDistanceToActualBaseline(baseline);
    return distance == null ? null : distance * _scale;
  }

  @override
  double? computeDryBaseline(
    BoxConstraints constraints,
    TextBaseline baseline,
  ) {
    final RenderBox? child = this.child;
    if (child == null) return null;
    final double scale = _scaleFor(constraints.maxWidth);
    final double? distance = child.getDryBaseline(
      _unscaled(constraints, scale),
      baseline,
    );
    return distance == null ? null : distance * scale;
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    final RenderBox? child = this.child;
    if (child == null) return;
    if (_scale == 1) {
      layer = null;
      context.paintChild(child, offset);
      return;
    }
    layer = context.pushTransform(
      needsCompositing,
      offset,
      _transform,
      (PaintingContext context, Offset offset) =>
          context.paintChild(child, offset),
      oldLayer: layer is TransformLayer ? layer! as TransformLayer : null,
    );
  }

  @override
  bool hitTestChildren(BoxHitTestResult result, {required Offset position}) {
    final RenderBox? child = this.child;
    if (child == null) return false;
    return result.addWithPaintTransform(
      transform: _transform,
      position: position,
      hitTest: (BoxHitTestResult result, Offset position) =>
          child.hitTest(result, position: position),
    );
  }

  @override
  void applyPaintTransform(RenderBox child, Matrix4 transform) {
    transform.multiply(_transform);
  }
}
