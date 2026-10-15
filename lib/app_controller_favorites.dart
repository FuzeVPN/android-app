part of 'app_controller.dart';

extension VpnFavorites on VpnAppController {
  Set<String> get favoriteLocationIds => _favoriteLocationIds;
  bool get favoritesSaving => _favoriteWritesPending > 0;
  bool get favoritesLoading => _favoriteRead != null && !_favoritesLoaded;
  bool get canChangeFavorites => !_disposed && _favoritesLoaded;
  bool isFavoriteLocation(String id) => _favoriteLocationIds.contains(id);

  Future<void> _initializeFavorites() => reloadFavoriteLocations();

  Future<void> reloadFavoriteLocations() async {
    if (_disposed || _favoritesLoaded) return;
    final store = _preferences;
    if (store is! FavoriteLocationStore) return;
    final read = _favoriteRead ??= Future<void>.microtask(
      () => _readFavorites(store as FavoriteLocationStore),
    );
    favoritesLoadFailed = false;
    notifyListeners();
    // Bound startup without abandoning the original read. A slow Keystore can
    // still restore the saved set, and retry never starts a concurrent read.
    await read.timeout(
      const Duration(seconds: 4),
      onTimeout: () {
        if (!_disposed && !_favoritesLoaded) {
          favoritesLoadFailed = true;
          notifyListeners();
        }
      },
    );
  }

  Future<void> _readFavorites(FavoriteLocationStore store) async {
    final epoch = _favoriteEpoch;
    try {
      final saved = FavoriteLocations.checked(
        await store.readFavoriteLocations(),
      );
      if (_disposed || epoch != _favoriteEpoch) return;
      _favoriteLocationIds = saved;
      _savedFavoriteLocationIds = saved;
      _favoritesLoaded = true;
      favoritesLoadFailed = false;
    } catch (_) {
      if (!_disposed && epoch == _favoriteEpoch) favoritesLoadFailed = true;
    } finally {
      _favoriteRead = null;
      if (!_disposed) notifyListeners();
    }
  }

  /// Optimistic selection with ordered durable writes. Failure restores the
  /// last saved state, and a late result never overwrites a newer user action.
  Future<void> toggleFavoriteLocation(Location location) async {
    if (_disposed || !_favoritesLoaded) return;
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
