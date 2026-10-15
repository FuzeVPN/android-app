part of '../app_controller_test.dart';

void favoriteControllerTests() {
  group('device-local favorites', () {
    late _FavoritesPreferences preferences;
    late _FakeTunnel tunnel;
    late VpnAppController controller;
    bool disposed = false;
    setUp(() {
      disposed = false;
      preferences = _FavoritesPreferences();
      tunnel = _FakeTunnel();
      controller = _controller(
        api: _FakeApi(),
        store: _FakeSessionStore(),
        preferences: preferences,
        tunnel: tunnel,
      );
    });
    tearDown(() async {
      if (!disposed) controller.dispose();
      await tunnel.close();
    });
    test('restores favorites and keeps unavailable catalogue IDs', () async {
      preferences.saved = {'frankfurt-01', 'temporarily-unavailable'};
      await controller.initialize();
      expect(controller.isFavoriteLocation('frankfurt-01'), isTrue);
      expect(
        controller.favoriteLocationIds,
        contains('temporarily-unavailable'),
      );
      await controller.refreshLocations();
      expect(preferences.saved, contains('temporarily-unavailable'));
      expect(
        () => controller.favoriteLocationIds.add('new'),
        throwsUnsupportedError,
      );
    });
    test(
      'favorite changes persist without selecting or altering the tunnel',
      () async {
        await controller.initialize();
        final selected = controller.selectedLocation;
        controller.tunnelState = const VpnRuntimeState(
          phase: VpnRuntimePhase.connected,
        );
        await controller.toggleFavoriteLocation(_frankfurt02);
        expect(preferences.saved, {'frankfurt-02'});
        expect(controller.selectedLocation, same(selected));
        expect(controller.tunnelState.phase, VpnRuntimePhase.connected);
        expect(tunnel.wireGuardConnections, isEmpty);
        expect(tunnel.openVpnConnections, isEmpty);
        await controller.toggleFavoriteLocation(_frankfurt02);
        expect(preferences.saved, isEmpty);
      },
    );
    test('rapid changes are written in order and newest choice wins', () async {
      await controller.initialize();
      preferences.writeGate = Completer<void>();
      final first = controller.toggleFavoriteLocation(_frankfurt);
      await Future<void>.delayed(Duration.zero);
      final second = controller.toggleFavoriteLocation(_frankfurt);
      final third = controller.toggleFavoriteLocation(_frankfurt02);
      expect(controller.favoriteLocationIds, {'frankfurt-02'});
      expect(controller.favoritesSaving, isTrue);
      expect(preferences.writes, hasLength(1));
      preferences.writeGate!.complete();
      await Future.wait([first, second, third]);
      expect(preferences.writes, [
        {'frankfurt-01'},
        <String>{},
        {'frankfurt-02'},
      ]);
      expect(preferences.saved, {'frankfurt-02'});
      expect(controller.favoritesSaving, isFalse);
    });
    test(
      'failed write restores last durable state and allows another try',
      () async {
        preferences.saved = {'frankfurt-01'};
        await controller.initialize();
        preferences.failWrite = true;
        await controller.toggleFavoriteLocation(_frankfurt02);
        expect(controller.favoriteLocationIds, {'frankfurt-01'});
        expect(controller.favoritesSaveFailed, isTrue);
        preferences.failWrite = false;
        await controller.toggleFavoriteLocation(_frankfurt02);
        expect(controller.favoriteLocationIds, {
          'frankfurt-01',
          'frankfurt-02',
        });
        expect(controller.favoritesSaveFailed, isFalse);
      },
    );
    test(
      'favorites cannot overwrite stored IDs before their read completes',
      () async {
        preferences.readGate = Completer<Set<String>>();
        final init = controller.initialize();
        await controller.toggleFavoriteLocation(_frankfurt);
        expect(preferences.writes, isEmpty);
        preferences.readGate!.complete({'old-location'});
        await init;
        expect(controller.favoriteLocationIds, {'old-location'});
        await controller.toggleFavoriteLocation(_frankfurt);
        expect(preferences.saved, {'old-location', 'frankfurt-01'});
      },
    );
    test('corrupt favorites do not block app initialization', () async {
      preferences.saved = {'../invalid'};
      await controller.initialize();
      expect(controller.favoriteLocationIds, isEmpty);
      expect(controller.favoritesLoadFailed, isTrue);
      expect(controller.favoritesSaveFailed, isFalse);
      expect(controller.canChangeFavorites, isFalse);
      expect(controller.isInitializing, isFalse);
    });
    test(
      'a timed-out read accepts its late result and retries share it',
      () async {
        preferences.readGate = Completer<Set<String>>();
        await controller.initialize();
        expect(controller.favoritesLoadFailed, isTrue);
        expect(controller.favoritesSaveFailed, isFalse);
        expect(controller.favoritesLoading, isTrue);
        final retry = controller.reloadFavoriteLocations();
        expect(preferences.reads, 1);
        await controller.toggleFavoriteLocation(_frankfurt);
        expect(preferences.writes, isEmpty);
        preferences.readGate!.complete({'old-location'});
        await retry;
        expect(controller.favoriteLocationIds, {'old-location'});
        expect(controller.canChangeFavorites, isTrue);
        expect(controller.favoritesLoadFailed, isFalse);
      },
    );
    test('failed reads can be retried without a save error', () async {
      preferences.failRead = true;
      await controller.initialize();
      expect(controller.favoritesLoadFailed, isTrue);
      expect(controller.favoritesSaveFailed, isFalse);
      preferences.failRead = false;
      preferences.saved = {'old-location'};
      await controller.reloadFavoriteLocations();
      expect(preferences.reads, 2);
      expect(controller.favoriteLocationIds, {'old-location'});
      expect(controller.canChangeFavorites, isTrue);
    });
    test(
      'settings remain usable with an explicit notice if storage fails',
      () async {
        await controller.initialize();
        preferences.failedChoices.addAll([
          'location',
          'theme',
          'protocol',
          'locale',
        ]);
        await controller.selectLocation(_frankfurt02);
        expect(controller.selectedLocation, same(_frankfurt02));
        expect(controller.notice?.messageKey, 'notice.preferenceSave.message');
        await controller.setThemeMode(ThemeMode.dark);
        expect(controller.themeMode, ThemeMode.dark);
        await controller.selectProtocol(VpnProtocol.openVpn);
        expect(controller.selectedProtocol, VpnProtocol.openVpn);
        await controller.setLocale(const Locale('de'));
        expect(controller.locale, const Locale('de'));
        expect(controller.notice?.arguments['preference'], 'locale');
        preferences.failedChoices.clear();
        await controller.setLocale(const Locale('de'));
        expect(preferences.locale, 'de');
        expect(controller.notice, isNull);
      },
    );
    test(
      'rapid location choices save in order without stale selection',
      () async {
        await controller.initialize();
        preferences.choiceGate = Completer<void>();
        final first = controller.selectLocation(_frankfurt);
        final last = controller.selectLocation(_frankfurt02);
        expect(controller.selectedLocation, same(_frankfurt02));
        await Future<void>.delayed(Duration.zero);
        expect(preferences.choiceWrites, ['location']);
        preferences.choiceGate!.complete();
        await Future.wait([first, last]);
        expect(preferences.selectedLocation, _frankfurt02.id);
        expect(controller.selectedLocation, same(_frankfurt02));
        expect(controller.notice, isNull);
      },
    );
    test(
      'a different successful setting does not hide a failed location write',
      () async {
        await controller.initialize();
        preferences.choiceGate = Completer<void>();
        preferences.failedChoices.add('location');
        final first = controller.selectLocation(_frankfurt02);
        final second = controller.setThemeMode(ThemeMode.dark);
        preferences.choiceGate!.complete();
        await Future.wait([first, second]);
        expect(controller.notice?.arguments['preference'], 'location');
        expect(preferences.themeMode, 'dark');
      },
    );
    test(
      'completing a write after disposal does not notify disposed UI',
      () async {
        await controller.initialize();
        preferences.writeGate = Completer<void>();
        final write = controller.toggleFavoriteLocation(_frankfurt);
        await Future<void>.delayed(Duration.zero);
        controller.dispose();
        disposed = true;
        preferences.writeGate!.complete();
        await write;
        expect(preferences.saved, {'frankfurt-01'});
      },
    );
  });
}

class _FavoritesPreferences extends _FakePreferences
    implements FavoriteLocationStore {
  Set<String> saved = {};
  final List<Set<String>> writes = [];
  Completer<void>? writeGate;
  Completer<Set<String>>? readGate;
  bool failWrite = false;
  bool failRead = false;
  int reads = 0;
  final Set<String> failedChoices = {};
  final List<String> choiceWrites = [];
  Completer<void>? choiceGate;

  Future<void> _choice(String key) async {
    choiceWrites.add(key);
    await choiceGate?.future;
    if (failedChoices.contains(key)) throw StateError('storage_unavailable');
  }

  @override
  Future<void> writeSelectedLocation(String value) async {
    await _choice('location');
    await super.writeSelectedLocation(value);
  }

  @override
  Future<void> writeSelectedProtocol(String value) async {
    await _choice('protocol');
    await super.writeSelectedProtocol(value);
  }

  @override
  Future<void> writeThemeMode(String value) async {
    await _choice('theme');
    await super.writeThemeMode(value);
  }

  @override
  Future<void> writeLocale(String? value) async {
    await _choice('locale');
    await super.writeLocale(value);
  }

  @override
  Future<Set<String>> readFavoriteLocations() async {
    reads++;
    if (failRead) throw StateError('read_failed');
    return readGate == null ? saved : readGate!.future;
  }

  @override
  Future<void> writeFavoriteLocations(Set<String> locationIds) async {
    writes.add(Set.of(locationIds));
    await writeGate?.future;
    if (failWrite) throw StateError('storage_unavailable');
    saved = Set.of(locationIds);
  }
}
