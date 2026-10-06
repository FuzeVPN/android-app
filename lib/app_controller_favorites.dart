part of 'app_controller.dart';

extension VpnFavorites on VpnAppController {
  Set<String> get favoriteLocationIds => _favoriteLocationIds;
  bool get favoritesSaving => _favoriteWritesPending > 0;
  bool isFavoriteLocation(String id) => _favoriteLocationIds.contains(id);

  Future<void> _initializeFavorites() async {
    final store = _preferences;
    if (store is! FavoriteLocationStore) return;
    final epoch = _favoriteEpoch;
    try {
      final saved = FavoriteLocations.checked(
        await (store as FavoriteLocationStore).readFavoriteLocations().timeout(
          const Duration(seconds: 4),
        ),
      );
      if (_disposed || epoch != _favoriteEpoch) return;
      _favoriteLocationIds = saved;
      _savedFavoriteLocationIds = saved;
      favoritesSaveFailed = false;
    } catch (_) {
      if (!_disposed && epoch == _favoriteEpoch) favoritesSaveFailed = true;
    }
  }

  /// Optimistic selection with ordered durable writes. Failure restores the
  /// last saved state, and a late result never overwrites a newer user action.
  Future<void> toggleFavoriteLocation(Location location) async {
    if (_disposed) return;
    final Set<String> next;
    try {
      final updated = Set<String>.of(_favoriteLocationIds);
      if (!updated.remove(location.id)) updated.add(location.id);
      next = FavoriteLocations.checked(updated);
    } catch (_) {
      favoritesSaveFailed = true;
      notifyListeners();
      return;
    }
    final epoch = ++_favoriteEpoch;
    _favoriteLocationIds = next;
    _favoriteWritesPending++;
    favoritesSaveFailed = false;
    notifyListeners();
    final store = _preferences;
    final write = _favoriteWrites.then((_) async {
      try {
        if (store is! FavoriteLocationStore) {
          throw const NativeVpnException('native_bridge_unavailable');
        }
        // Await the actual write: a timeout would allow older writes to
        // complete after a newer selection and restore stale preferences.
        await (store as FavoriteLocationStore).writeFavoriteLocations(next);
        _savedFavoriteLocationIds = next;
        if (!_disposed && epoch == _favoriteEpoch) favoritesSaveFailed = false;
      } catch (_) {
        if (!_disposed && epoch == _favoriteEpoch) {
          _favoriteLocationIds = _savedFavoriteLocationIds;
          favoritesSaveFailed = true;
        }
      } finally {
        _favoriteWritesPending--;
        if (!_disposed) notifyListeners();
      }
    });
    _favoriteWrites = write;
    await write;
  }
}
