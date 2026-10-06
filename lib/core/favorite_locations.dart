/// Small, device-local selection of catalogue IDs; no account or VPN data.
abstract final class FavoriteLocations {
  static const int maximumCount = 500;
  static final RegExp _identifier = RegExp(r'^[A-Za-z0-9._-]{1,160}$');

  static Set<String> checked(Object? value) {
    if (value is! Iterable || value.length > maximumCount) {
      throw const FormatException('invalid_favorite_locations');
    }
    final result = <String>{};
    for (final item in value) {
      if (item is! String || !_identifier.hasMatch(item)) {
        throw const FormatException('invalid_favorite_locations');
      }
      result.add(item);
    }
    return Set<String>.unmodifiable(result);
  }
}
