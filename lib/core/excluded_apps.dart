/// Split tunneling: the apps the user keeps out of the VPN, as Android package
/// names. Native code saves the list and applies it to each new tunnel;
/// FuzeVPN itself is never in it.
abstract final class ExcludedApps {
  static const int maxApps = 256;

  // Android's own rule: two segments or more, each starting with a letter.
  static final RegExp _packageName = RegExp(
    r'^[A-Za-z][A-Za-z0-9_]*(\.[A-Za-z][A-Za-z0-9_]*)+$',
  );

  static bool isPackageName(Object? value) =>
      value is String && value.length <= 255 && _packageName.hasMatch(value);

  /// A list read from or sent to native code: package names only, at most
  /// [maxApps]. Anything else is a [FormatException].
  static Set<String> checked(Iterable<Object?> values) {
    final List<Object?> list = values.toList(growable: false);
    if (list.length > maxApps || !list.every(isPackageName)) {
      throw const FormatException('excluded_apps');
    }
    return Set<String>.unmodifiable(list.cast<String>());
  }
}

/// An app the split tunneling screen offers: one with an icon in the launcher.
class InstalledApp {
  const InstalledApp({required this.packageName, required this.label});

  final String packageName;
  final String label;

  /// Null for an entry that is not a launchable app as native code describes
  /// one.
  static InstalledApp? fromWire(Object? value) {
    if (value is! Map) return null;
    final Object? name = value['package'];
    final Object? label = value['label'];
    if (!ExcludedApps.isPackageName(name)) return null;
    final String text = label is String
        ? label.replaceAll(RegExp(r'[\u0000-\u001f\u007f]'), ' ').trim()
        : '';
    return InstalledApp(
      packageName: name as String,
      label: text.isEmpty
          ? name
          : text.length > 120
          ? text.substring(0, 120)
          : text,
    );
  }
}
