import 'package:flutter/painting.dart';

/// Android 14's 200% lookup table, linearly interpolated between entries.
/// Source: AOSP FontScaleConverterFactory (android14-release, Apache-2.0).
/// https://android.googlesource.com/platform/frameworks/base/+/refs/heads/android14-release/core/java/android/content/res/FontScaleConverterFactory.java
class Android14TextScaler extends TextScaler {
  const Android14TextScaler();

  static const _from = [8.0, 10.0, 12.0, 14.0, 18.0, 20.0, 24.0, 30.0, 100.0];
  static const _to = [16.0, 20.0, 24.0, 26.0, 30.0, 34.0, 36.0, 38.0, 100.0];

  @override
  double get textScaleFactor => 2;

  @override
  double scale(double fontSize) {
    if (fontSize <= _from.first) return fontSize * 2;
    for (var i = 1; i < _from.length; i++) {
      if (fontSize <= _from[i]) {
        final fraction = (fontSize - _from[i - 1]) / (_from[i] - _from[i - 1]);
        return _to[i - 1] + fraction * (_to[i] - _to[i - 1]);
      }
    }
    return fontSize;
  }
}
