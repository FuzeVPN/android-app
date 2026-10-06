import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fuzevpn_android/app_controller.dart';
import 'package:fuzevpn_android/app_theme.dart';
import 'package:fuzevpn_android/core/api_exception.dart';
import 'package:fuzevpn_android/core/models.dart';
import 'package:fuzevpn_android/core/repositories.dart';
import 'package:fuzevpn_android/features/home/home_shell.dart';
import 'package:fuzevpn_android/l10n/app_languages.dart';
import 'package:fuzevpn_android/l10n/generated/app_localizations.dart';
import 'package:fuzevpn_android/native_vpn_bridge.dart';
import 'package:fuzevpn_android/widgets/country_flag.dart';
import 'package:fuzevpn_android/widgets/notice_card.dart';

const _paris = Location(
  id: 'paris-01',
  city: 'Paris',
  countryCode: 'FR',
  displayName: 'Paris',
  supportedProtocols: {VpnProtocol.wireGuard, VpnProtocol.openVpn},
);
const _saoPaulo = Location(
  id: 'sao-paulo-01',
  city: 'São Paulo',
  countryCode: 'BR',
  displayName: 'São Paulo',
  supportedProtocols: {VpnProtocol.wireGuard},
);
const _frankfurt = Location(
  id: 'frankfurt-01',
  city: 'Frankfurt',
  countryCode: 'DE',
  displayName: 'Frankfurt 01',
  supportedProtocols: {VpnProtocol.wireGuard, VpnProtocol.openVpn},
);
const _frankfurtTwo = Location(
  id: 'frankfurt-02',
  city: 'Frankfurt',
  countryCode: 'DE',
  displayName: 'Frankfurt 02',
  supportedProtocols: {VpnProtocol.openVpn},
);
const _catalog = [_paris, _saoPaulo, _frankfurt, _frankfurtTwo];
const _profile = UserProfile(
  userId: 'fixture-user',
  email: 'fixture@example.test',
  firstName: '',
  lastName: '',
  phone: '',
  addressLine1: '',
  addressLine2: '',
  postalCode: '',
  city: '',
  countryCode: 'FR',
);

void main() {
  _locationsTest(
    'hierarchy starts with one card per country and two separate actions',
    (tester, h) async {
      await h.mount(tester, searchAll: false);
      expect(find.byType(CountryFlag), findsNWidgets(3));
      expect(find.byType(LocationRow), findsNothing);
      expect(find.text('3 pays'), findsOneWidget);
      expect(find.text('Allemagne'), findsOneWidget);
      expect(find.text('Frankfurt 01'), findsNothing);
      expect(find.byKey(const ValueKey('select-country-DE')), findsOneWidget);
      expect(find.byKey(const ValueKey('browse-country-DE')), findsOneWidget);
      expect(
        tester
            .widget<InkWell>(find.byKey(const ValueKey('select-country-FR')))
            .onTap,
        isNull,
      );
      expect(
        tester
            .widget<InkWell>(find.byKey(const ValueKey('browse-country-FR')))
            .onTap,
        isNotNull,
      );
      expect(h.api.reads, 1);
      expect(h.tunnel.actions, isEmpty);
    },
  );

  _locationsTest(
    'browsing country city and server never connects and supports visible and Android back',
    (tester, h) async {
      await h.mount(tester, searchAll: false);
      await _tap(tester, 'browse-country-DE');
      await tester.pumpAndSettle();
      expect(
        tester
            .widget<Text>(find.byKey(const ValueKey('locations-results-count')))
            .data,
        '1 ville',
      );
      expect(
        find.byKey(const ValueKey('browse-city-DE-frankfurt')),
        findsOneWidget,
      );
      expect(find.text('Tous les pays › Allemagne'), findsOneWidget);
      await _tap(tester, 'browse-city-DE-frankfurt');
      await tester.pumpAndSettle();
      expect(find.byType(LocationRow), findsNWidgets(2));
      expect(
        tester
            .widget<Text>(find.byKey(const ValueKey('locations-results-count')))
            .data,
        '2 serveurs',
      );
      expect(find.text('Frankfurt 01'), findsOneWidget);
      expect(find.text('Frankfurt 02'), findsOneWidget);
      expect(
        find.text('Tous les pays › Allemagne › Frankfurt'),
        findsOneWidget,
      );
      await tester.binding.handlePopRoute();
      await tester.pumpAndSettle();
      expect(
        find.byKey(const ValueKey('browse-city-DE-frankfurt')),
        findsOneWidget,
      );
      await _tap(tester, 'locations-back');
      await tester.pumpAndSettle();
      expect(find.byKey(const ValueKey('browse-country-DE')), findsOneWidget);
      expect(find.byKey(const ValueKey('locations-back')), findsNothing);
      expect(h.api.reads, 1);
      expect(h.tunnel.actions, isEmpty);
      expect(h.selectedCalls, 0);
    },
  );

  for (final level in ['country', 'city']) {
    _locationsTest(
      '$level shortcut confirms the exact compatible server before connecting',
      (tester, h) async {
        await h.mount(tester, searchAll: false);
        if (level == 'city') {
          await _tap(tester, 'browse-country-DE');
          await tester.pumpAndSettle();
        }
        await _tap(
          tester,
          level == 'country' ? 'select-country-DE' : 'select-city-DE-frankfurt',
        );
        await tester.pumpAndSettle();
        expect(
          find.byKey(const ValueKey('location-change-dialog')),
          findsOneWidget,
        );
        expect(find.textContaining('Frankfurt 01'), findsOneWidget);
        expect(h.tunnel.actions, isEmpty);
        expect(h.preferences.selectedWrites, isEmpty);
        await _tap(tester, 'location-change-confirm');
        await tester.pumpAndSettle();
        expect(h.api.registeredLocations, ['frankfurt-01']);
        expect(h.tunnel.actions, ['permission', 'connect:frankfurt-01']);
        expect(h.selectedCalls, 1);
      },
    );

    _locationsTest(
      '$level shortcut cancellation leaves the connection untouched',
      (tester, h) async {
        await h.mount(tester, searchAll: false);
        if (level == 'city') {
          await _tap(tester, 'browse-country-DE');
          await tester.pumpAndSettle();
        }
        await _tap(
          tester,
          level == 'country' ? 'select-country-DE' : 'select-city-DE-frankfurt',
        );
        await tester.pumpAndSettle();
        await _tap(tester, 'location-change-cancel');
        await tester.pumpAndSettle();
        expect(h.controller.selectedLocation, _paris);
        expect(h.tunnel.actions, isEmpty);
        expect(h.selectedCalls, 0);
      },
    );
  }

  _locationsTest(
    'incompatible groups stay browsable without offering a connection',
    (tester, h) async {
      h.controller.selectedProtocol = VpnProtocol.openVpn;
      await h.mount(tester, searchAll: false);
      expect(
        tester
            .widget<InkWell>(find.byKey(const ValueKey('select-country-BR')))
            .onTap,
        isNull,
      );
      expect(find.text('Aucun serveur compatible disponible.'), findsOneWidget);
      await _tap(tester, 'browse-country-BR');
      await tester.pumpAndSettle();
      expect(
        tester
            .widget<InkWell>(
              find.byKey(const ValueKey('select-city-BR-sao paulo')),
            )
            .onTap,
        isNull,
      );
      await _tap(tester, 'browse-city-BR-sao paulo');
      await tester.pumpAndSettle();
      expect(
        find.byKey(const ValueKey('favorite-location-sao-paulo-01')),
        findsOneWidget,
      );
      expect(
        tester
            .widget<InkWell>(
              find.byKey(const ValueKey('select-location-sao-paulo-01')),
            )
            .onTap,
        isNull,
      );
      expect(find.text('Aucun serveur compatible disponible.'), findsOneWidget);
      expect(h.tunnel.actions, isEmpty);
      expect(h.api.reads, 1);
    },
  );

  _locationsTest(
    'busy connection locks group selection but not browsing or favorites',
    (tester, h) async {
      h.controller.isConnecting = true;
      await h.mount(tester, searchAll: false);
      expect(
        tester
            .widget<InkWell>(find.byKey(const ValueKey('select-country-BR')))
            .onTap,
        isNull,
      );
      await _tap(tester, 'browse-country-BR');
      await tester.pumpAndSettle();
      await _tap(tester, 'browse-city-BR-sao paulo');
      await tester.pumpAndSettle();
      await _tap(tester, 'favorite-location-sao-paulo-01');
      await tester.pumpAndSettle();
      expect(h.controller.isFavoriteLocation(_saoPaulo.id), isTrue);
      expect(h.tunnel.actions, isEmpty);
      expect(h.api.reads, 1);
    },
  );

  for (final nativeProtocol in VpnProtocol.values) {
    _locationsTest(
      'group and server compatibility follow the native protocol (${nativeProtocol.name})',
      (tester, h) async {
        h.controller.selectedProtocol = nativeProtocol == VpnProtocol.wireGuard
            ? VpnProtocol.openVpn
            : VpnProtocol.wireGuard;
        h.controller.tunnelState = VpnRuntimeState(
          phase: VpnRuntimePhase.connected,
          protocol: nativeProtocol,
          locationId: _paris.id,
        );
        await h.mount(tester, searchAll: false);
        final compatible = nativeProtocol == VpnProtocol.wireGuard;
        expect(
          tester
                  .widget<InkWell>(
                    find.byKey(const ValueKey('select-country-BR')),
                  )
                  .onTap !=
              null,
          compatible,
        );
        await _tap(tester, 'browse-country-BR');
        await tester.pumpAndSettle();
        expect(
          tester
                  .widget<InkWell>(
                    find.byKey(const ValueKey('select-city-BR-sao paulo')),
                  )
                  .onTap !=
              null,
          compatible,
        );
        await _tap(tester, 'browse-city-BR-sao paulo');
        await tester.pumpAndSettle();
        expect(
          tester
                  .widget<InkWell>(
                    find.byKey(const ValueKey('select-location-sao-paulo-01')),
                  )
                  .onTap !=
              null,
          compatible,
        );
        expect(h.tunnel.actions, isEmpty);
        expect(h.api.reads, 1);
      },
    );
  }

  _locationsTest(
    'global search and favorites restore the previously browsed server list',
    (tester, h) async {
      await h.controller.toggleFavoriteLocation(_saoPaulo);
      await h.mount(tester, searchAll: false);
      await _tap(tester, 'browse-country-DE');
      await tester.pumpAndSettle();
      await _tap(tester, 'browse-city-DE-frankfurt');
      await tester.pumpAndSettle();
      await tester.enterText(
        find.byKey(const ValueKey('locations-search')),
        'sao',
      );
      await tester.pumpAndSettle();
      expect(
        find.byKey(const ValueKey('location-sao-paulo-01')),
        findsOneWidget,
      );
      expect(find.byKey(const ValueKey('location-frankfurt-01')), findsNothing);
      await _tap(tester, 'locations-clear-search');
      await tester.pumpAndSettle();
      expect(
        find.byKey(const ValueKey('location-frankfurt-01')),
        findsOneWidget,
      );
      expect(find.byKey(const ValueKey('location-sao-paulo-01')), findsNothing);
      await _tap(tester, 'locations-filter-favorites');
      await tester.pumpAndSettle();
      expect(
        find.byKey(const ValueKey('location-sao-paulo-01')),
        findsOneWidget,
      );
      await _tap(tester, 'locations-filter-all');
      await tester.pumpAndSettle();
      expect(
        find.text('Tous les pays › Allemagne › Frankfurt'),
        findsOneWidget,
      );
      expect(find.byType(LocationRow), findsNWidgets(2));
      expect(h.api.reads, 1);
    },
  );

  _locationsTest(
    'catalogue removal returns from an obsolete country to countries',
    (tester, h) async {
      await h.mount(tester, searchAll: false);
      await _tap(tester, 'browse-country-DE');
      await tester.pumpAndSettle();
      await _tap(tester, 'browse-city-DE-frankfurt');
      await tester.pumpAndSettle();
      h.api.catalog = [_paris, _saoPaulo];
      await h.controller.refreshLocations();
      await tester.pumpAndSettle();
      expect(find.byKey(const ValueKey('browse-country-FR')), findsOneWidget);
      expect(find.byKey(const ValueKey('browse-country-DE')), findsNothing);
      expect(find.byKey(const ValueKey('locations-back')), findsNothing);
      expect(h.tunnel.actions, isEmpty);
    },
  );

  _locationsTest(
    'catalogue removal returns from an obsolete city to its surviving country',
    (tester, h) async {
      await h.mount(tester, searchAll: false);
      await _tap(tester, 'browse-country-DE');
      await tester.pumpAndSettle();
      await _tap(tester, 'browse-city-DE-frankfurt');
      await tester.pumpAndSettle();
      h.api.catalog = [
        _paris,
        const Location(
          id: 'berlin-01',
          city: 'Berlin',
          countryCode: 'DE',
          displayName: 'Berlin 01',
          supportedProtocols: {VpnProtocol.wireGuard},
        ),
      ];
      await h.controller.refreshLocations();
      await tester.pumpAndSettle();
      expect(
        find.byKey(const ValueKey('browse-city-DE-berlin')),
        findsOneWidget,
      );
      expect(find.text('Tous les pays › Allemagne'), findsOneWidget);
      expect(find.byType(LocationRow), findsNothing);
      expect(h.tunnel.actions, isEmpty);
    },
  );

  _locationsTest(
    'a group confirmation cannot connect a server removed while the dialog is open',
    (tester, h) async {
      await h.mount(tester, searchAll: false);
      await _tap(tester, 'select-country-DE');
      await tester.pumpAndSettle();
      h.api.catalog = [_paris, _saoPaulo];
      await h.controller.refreshLocations();
      await tester.pumpAndSettle();
      await _tap(tester, 'location-change-confirm');
      await tester.pumpAndSettle();
      expect(h.api.registeredLocations, isEmpty);
      expect(h.tunnel.actions, isEmpty);
      expect(h.selectedCalls, 0);
      expect(tester.takeException(), isNull);
    },
  );

  for (final language in ['fr', 'en', 'es', 'de']) {
    _locationsTest(
      'hierarchy actions remain accessible at 320dp and 200% text ($language)',
      (tester, h) async {
        tester.view.physicalSize = const Size(320, 640);
        tester.platformDispatcher.textScaleFactorTestValue = 2;
        addTearDown(tester.platformDispatcher.clearTextScaleFactorTestValue);
        await h.mount(tester, searchAll: false, locale: Locale(language));
        await _tap(tester, 'browse-country-DE');
        await tester.pumpAndSettle();
        expect(tester.takeException(), isNull);
        await _tap(tester, 'browse-city-DE-frankfurt');
        await tester.pumpAndSettle();
        expect(tester.takeException(), isNull);
        await _tap(tester, 'favorite-location-frankfurt-01');
        await tester.pumpAndSettle();
        expect(h.controller.isFavoriteLocation('frankfurt-01'), isTrue);
        await _tap(tester, 'locations-back');
        await tester.pumpAndSettle();
        await _tap(tester, 'select-city-DE-frankfurt');
        await tester.pumpAndSettle();
        expect(
          find.byKey(const ValueKey('location-change-dialog')),
          findsOneWidget,
        );
        await _tap(tester, 'location-change-cancel');
        await tester.pumpAndSettle();
        expect(tester.takeException(), isNull);
        expect(h.tunnel.actions, isEmpty);
      },
    );
  }

  for (final size in [
    const Size(800, 1280),
    const Size(1280, 800),
    const Size(1920, 1080),
  ]) {
    _locationsTest(
      'country and city counts stay on one line at ${size.width}dp and 200% text',
      (tester, h) async {
        tester.view.physicalSize = size;
        tester.platformDispatcher.textScaleFactorTestValue = 2;
        addTearDown(tester.platformDispatcher.clearTextScaleFactorTestValue);
        await h.mount(tester, searchAll: false);
        final countryBrowse = find.byKey(const ValueKey('browse-country-DE'));
        await _ensureVisible(tester, countryBrowse);
        _expectSingleLineCount(tester, countryBrowse, '1 ville');
        expect(tester.takeException(), isNull);

        await _tap(tester, 'browse-country-DE');
        await tester.pumpAndSettle();
        final cityBrowse = find.byKey(
          const ValueKey('browse-city-DE-frankfurt'),
        );
        await _ensureVisible(tester, cityBrowse);
        _expectSingleLineCount(tester, cityBrowse, '2 serveurs');
        expect(tester.takeException(), isNull);

        await _tap(tester, 'browse-city-DE-frankfurt');
        await tester.pumpAndSettle();
        expect(
          find.byKey(const ValueKey('location-frankfurt-01')),
          findsOneWidget,
        );
        expect(h.tunnel.actions, isEmpty);
        expect(h.selectedCalls, 0);
        expect(tester.takeException(), isNull);
      },
    );
  }
  _locationsTest(
    'server search shows flags and localized countries without repeating the city',
    (tester, h) async {
      await h.mount(tester);
      expect(find.byType(CountryFlag), findsNWidgets(4));
      expect(find.text('Paris'), findsOneWidget);
      expect(find.text('France'), findsOneWidget);
      expect(find.text('Brésil'), findsOneWidget);
      expect(find.text('Frankfurt 01'), findsOneWidget);
      expect(find.text('Frankfurt 02'), findsOneWidget);
      final selectedLocation = find.descendant(
        of: find.byKey(const ValueKey('location-paris-01')),
        matching: find.byWidgetPredicate(
          (widget) => widget is Semantics && widget.properties.selected == true,
        ),
      );
      expect(selectedLocation, findsOneWidget);
      expect(
        tester.widget<Semantics>(selectedLocation).properties.enabled,
        isFalse,
      );
      expect(find.text('Emplacement sélectionné'), findsOneWidget);
      expect(find.textContaining('WireGuard'), findsNothing);
      expect(find.textContaining('OpenVPN'), findsNothing);
      expect(tester.takeException(), isNull);
    },
  );

  _locationsTest('search matches city country code and accents locally', (
    tester,
    h,
  ) async {
    await h.mount(tester);
    for (final query in ['  sao  ', 'BRESIL', 'SÃO BRÉSIL', 'BR']) {
      await tester.enterText(
        find.byKey(const ValueKey('locations-search')),
        query,
      );
      await tester.pumpAndSettle();
      expect(
        find.byKey(const ValueKey('location-sao-paulo-01')),
        findsOneWidget,
      );
      expect(find.byKey(const ValueKey('location-paris-01')), findsNothing);
    }
    expect(h.api.reads, 1);
    expect(h.preferences.selectedWrites, isEmpty);
    expect(h.selectedCalls, 0);
  });

  for (final entry in {
    'fr': 'Allemagne',
    'en': 'Germany',
    'es': 'Alemania',
    'de': 'Deutschland',
  }.entries) {
    _locationsTest(
      'country search uses the displayed language (${entry.key})',
      (tester, h) async {
        await h.mount(tester, locale: Locale(entry.key));
        await tester.enterText(
          find.byKey(const ValueKey('locations-search')),
          entry.value,
        );
        await tester.pumpAndSettle();
        expect(
          find.byKey(const ValueKey('location-frankfurt-01')),
          findsOneWidget,
        );
        expect(
          find.byKey(const ValueKey('location-frankfurt-02')),
          findsOneWidget,
        );
        expect(find.byKey(const ValueKey('location-paris-01')), findsNothing);
        expect(
          find.descendant(
            of: find.byType(LocationRow),
            matching: find.textContaining(entry.value),
          ),
          findsNWidgets(2),
        );
        expect(h.api.reads, 1);
      },
    );
  }

  _locationsTest('empty search has a clear action and restores the catalogue', (
    tester,
    h,
  ) async {
    await h.mount(tester);
    await tester.enterText(
      find.byKey(const ValueKey('locations-search')),
      'nowhere-fixture',
    );
    await tester.pumpAndSettle();
    expect(find.text('Aucune destination trouvée'), findsOneWidget);
    await _tap(tester, 'locations-empty-action');
    await tester.pumpAndSettle();
    expect(find.byKey(const ValueKey('locations-empty')), findsNothing);
    expect(
      tester
          .widget<TextField>(find.byKey(const ValueKey('locations-search')))
          .controller!
          .text,
      isEmpty,
    );
    await tester.enterText(
      find.byKey(const ValueKey('locations-search')),
      'Paris',
    );
    await tester.pumpAndSettle();
    await _tap(tester, 'locations-clear-search');
    await tester.pumpAndSettle();
    expect(find.byType(CountryFlag), findsNWidgets(3));
  });

  _locationsTest(
    'favorites filter adds removes and explains the empty state without selecting',
    (tester, h) async {
      await h.mount(tester);
      await _tap(tester, 'favorite-location-sao-paulo-01');
      await tester.pumpAndSettle();
      expect(h.controller.favoriteLocationIds, {'sao-paulo-01'});
      expect(h.preferences.favorites, {'sao-paulo-01'});
      expect(h.controller.selectedLocation, same(_paris));
      expect(h.selectedCalls, 0);
      await _tap(tester, 'locations-clear-search');
      await _tap(tester, 'locations-filter-favorites');
      await tester.pumpAndSettle();
      expect(
        find.byKey(const ValueKey('location-sao-paulo-01')),
        findsOneWidget,
      );
      expect(find.byKey(const ValueKey('location-paris-01')), findsNothing);
      await _tap(tester, 'favorite-location-sao-paulo-01');
      await tester.pumpAndSettle();
      expect(find.text('Vos favoris, à portée de main'), findsOneWidget);
      await _tap(tester, 'locations-empty-action');
      await tester.pumpAndSettle();
      expect(find.byType(CountryFlag), findsNWidgets(3));
      expect(h.preferences.selectedWrites, isEmpty);
      expect(h.tunnel.unexpectedCalls, 0);
    },
  );

  _locationsTest(
    'saved favorites are restored and search combines with the favorites filter',
    (tester, h) async {
      await h.mount(tester);
      await _tap(tester, 'locations-filter-favorites');
      await tester.pumpAndSettle();
      expect(
        find.byKey(const ValueKey('location-sao-paulo-01')),
        findsOneWidget,
      );
      expect(find.byKey(const ValueKey('location-paris-01')), findsOneWidget);
      expect(find.byKey(const ValueKey('location-frankfurt-01')), findsNothing);
      await tester.enterText(
        find.byKey(const ValueKey('locations-search')),
        'France',
      );
      await tester.pumpAndSettle();
      expect(find.byKey(const ValueKey('location-sao-paulo-01')), findsNothing);
      expect(find.byKey(const ValueKey('location-paris-01')), findsOneWidget);
    },
    setup: (h) => h.preferences.favorites = {'paris-01', 'sao-paulo-01'},
  );

  for (final phase in [
    VpnRuntimePhase.authorizing,
    VpnRuntimePhase.preparing,
    VpnRuntimePhase.connecting,
    VpnRuntimePhase.disconnecting,
  ]) {
    _locationsTest(
      'favorites stay available while selection is locked (${phase.name})',
      (tester, h) async {
        h.controller.tunnelState = VpnRuntimeState(phase: phase);
        await h.mount(tester);
        final selection = find.byKey(
          const ValueKey('select-location-sao-paulo-01'),
        );
        expect(tester.widget<InkWell>(selection).onTap, isNull);
        final favorite = find.byKey(
          const ValueKey('favorite-location-sao-paulo-01'),
        );
        expect(tester.widget<IconButton>(favorite).onPressed, isNotNull);
        await _tap(tester, 'favorite-location-sao-paulo-01');
        await tester.pumpAndSettle();
        expect(h.preferences.favorites, {'sao-paulo-01'});
        expect(h.controller.selectedLocation, same(_paris));
        expect(h.controller.tunnelState.phase, phase);
        expect(h.selectedCalls, 0);
        expect(h.tunnel.unexpectedCalls, 0);
      },
    );
  }

  _locationsTest(
    'another idle location connects only after confirmation and returns immediately',
    (tester, h) async {
      await h.mount(tester);
      await _tap(tester, 'select-location-sao-paulo-01');
      await tester.pumpAndSettle();
      expect(
        find.byKey(const ValueKey('location-change-dialog')),
        findsOneWidget,
      );
      expect(h.controller.selectedLocation, same(_paris));
      expect(h.selectedCalls, 0);
      expect(h.tunnel.actions, isEmpty);
      final permission = Completer<bool>();
      h.tunnel.permissionGate = permission.future;
      await _tap(tester, 'location-change-confirm');
      await tester.pump();
      expect(h.selectedCalls, 1);
      expect(h.controller.isChangingLocation, isTrue);
      expect(h.tunnel.actions, ['permission']);
      permission.complete(true);
      await tester.pumpAndSettle();
      expect(h.controller.selectedLocation, same(_saoPaulo));
      expect(h.preferences.selectedWrites, ['sao-paulo-01']);
      expect(h.selectedCalls, 1);
      expect(h.tunnel.actions, ['permission', 'connect:sao-paulo-01']);
      expect(h.tunnel.unexpectedCalls, 0);
    },
  );

  _locationsTest(
    'a failed selection write keeps the choice and navigates with an explanatory notice',
    (tester, h) async {
      await h.mount(tester);
      h.preferences.failSelectedWrite = true;
      await _tap(tester, 'select-location-sao-paulo-01');
      await tester.pumpAndSettle();
      await _tap(tester, 'location-change-confirm');
      await tester.pumpAndSettle();
      expect(tester.takeException(), isNull);
      expect(h.controller.selectedLocation, same(_saoPaulo));
      expect(h.preferences.selectedWrites, ['sao-paulo-01']);
      expect(h.selectedCalls, 1);
      expect(h.controller.notice?.messageKey, 'notice.preferenceSave.message');
      expect(
        tester.widget<NoticeCard>(find.byType(NoticeCard)).notice,
        same(h.controller.notice),
      );
      expect(h.tunnel.unexpectedCalls, 0);
    },
  );

  for (final (code, status, title) in [
    ('server_full', 409, 'Serveur complet'),
    ('capacity_unavailable', 503, 'Emplacement temporairement indisponible'),
  ]) {
    _locationsTest(
      '$code during a confirmed change hides the target and keeps its favorite for a later refresh',
      (tester, h) async {
        const connected = VpnRuntimeState(
          phase: VpnRuntimePhase.connected,
          protocol: VpnProtocol.wireGuard,
          locationId: 'paris-01',
        );
        h.controller.tunnelState = connected;
        h.tunnel.observed = connected;
        await h.mount(tester);
        expect(h.api.reads, 1);
        await _tap(tester, 'select-location-sao-paulo-01');
        await tester.pumpAndSettle();
        expect(
          find.byKey(const ValueKey('location-change-dialog')),
          findsOneWidget,
        );
        expect(h.api.registeredLocations, isEmpty);
        expect(h.tunnel.actions, isEmpty);

        // Capacity changes after the pre-connection catalogue was read.
        h.api.catalogAfterRegistration = [_paris, _frankfurt, _frankfurtTwo];
        h.api.registrationFailure = ApiException(
          statusCode: status,
          errorCode: code,
        );
        await _tap(tester, 'location-change-confirm');
        await tester.pumpAndSettle();

        expect(h.selectedCalls, 1);
        expect(h.api.registeredLocations, ['sao-paulo-01']);
        expect(h.tunnel.actions, ['disconnect', 'permission']);
        expect(h.controller.isConnected, isFalse);
        // Initialization, pre-connection capabilities, then one recovery read.
        expect(h.api.reads, 3);
        expect(h.controller.notice?.arguments['code'], code);
        expect(find.text(title), findsOneWidget);
        expect(
          find.byKey(const ValueKey('location-sao-paulo-01')),
          findsNothing,
        );
        expect(find.byType(LocationRow), findsNWidgets(3));
        expect(h.preferences.favorites, {'sao-paulo-01'});

        await _tap(tester, 'locations-filter-favorites');
        await tester.pumpAndSettle();
        expect(find.byType(LocationRow), findsNothing);
        expect(
          find.byKey(const ValueKey('location-sao-paulo-01')),
          findsNothing,
        );
        expect(h.controller.isFavoriteLocation('sao-paulo-01'), isTrue);

        // A later user refresh can make the saved favorite available again.
        h.api.catalog = _catalog;
        await tester.drag(find.byType(ListView), const Offset(0, 450));
        await tester.pumpAndSettle();
        expect(h.api.reads, 4);
        expect(
          tester
              .widget<ChoiceChip>(
                find.byKey(const ValueKey('locations-filter-favorites')),
              )
              .selected,
          isTrue,
        );
        expect(
          find.byKey(const ValueKey('location-sao-paulo-01')),
          findsOneWidget,
        );
        expect(find.byType(LocationRow), findsOneWidget);
        expect(h.preferences.favorites, {'sao-paulo-01'});
        expect(h.api.registeredLocations, ['sao-paulo-01']);
        expect(h.tunnel.actions, ['disconnect', 'permission']);
        expect(h.tunnel.unexpectedCalls, 0);
        expect(tester.takeException(), isNull);
      },
      setup: (h) => h.preferences.favorites = {'sao-paulo-01'},
    );
  }

  _locationsTest(
    'cancelling a connected change leaves the tunnel location and account untouched',
    (tester, h) async {
      h.controller.tunnelState = const VpnRuntimeState(
        phase: VpnRuntimePhase.connected,
        protocol: VpnProtocol.wireGuard,
      );
      await h.mount(tester);
      await _tap(tester, 'select-location-sao-paulo-01');
      await tester.pumpAndSettle();
      expect(
        find.byKey(const ValueKey('location-change-dialog')),
        findsOneWidget,
      );
      expect(find.textContaining('se déconnecter'), findsOneWidget);
      expect(h.tunnel.actions, isEmpty);
      await _tap(tester, 'location-change-cancel');
      await tester.pumpAndSettle();
      expect(
        find.byKey(const ValueKey('location-change-dialog')),
        findsNothing,
      );
      expect(h.controller.selectedLocation, same(_paris));
      expect(h.controller.isConnected, isTrue);
      expect(h.controller.profile?.userId, _profile.userId);
      expect(h.preferences.selectedWrites, isEmpty);
      expect(h.tunnel.actions, isEmpty);
      expect(h.selectedCalls, 0);
    },
  );

  _locationsTest(
    'confirming a connected change stops first and opens progress before reconnecting',
    (tester, h) async {
      h.controller.tunnelState = const VpnRuntimeState(
        phase: VpnRuntimePhase.connected,
        protocol: VpnProtocol.wireGuard,
      );
      await h.mount(tester);
      final stopped = Completer<void>();
      h.tunnel.disconnectGate = stopped.future;
      await _tap(tester, 'select-location-sao-paulo-01');
      await tester.pumpAndSettle();
      await _tap(tester, 'location-change-confirm');
      await tester.pump();
      expect(h.selectedCalls, 1);
      expect(h.tunnel.actions, ['disconnect']);
      expect(h.controller.isChangingLocation, isTrue);
      expect(h.controller.tunnelState.phase, VpnRuntimePhase.disconnecting);
      await tester.pump(const Duration(milliseconds: 400));
      expect(
        tester
            .widget<InkWell>(
              find.byKey(const ValueKey('select-location-frankfurt-01')),
            )
            .onTap,
        isNull,
      );
      stopped.complete();
      await tester.pumpAndSettle();
      expect(h.tunnel.actions, [
        'disconnect',
        'permission',
        'connect:sao-paulo-01',
      ]);
      expect(h.controller.selectedLocation, same(_saoPaulo));
      expect(h.controller.isConnected, isTrue);
      expect(h.selectedCalls, 1);
    },
  );

  _locationsTest(
    'restored local choice different from the native location still asks before switching',
    (tester, h) async {
      h.controller.tunnelState = const VpnRuntimeState(
        phase: VpnRuntimePhase.connected,
        protocol: VpnProtocol.wireGuard,
        locationId: 'frankfurt-01',
      );
      await h.mount(tester);
      expect(
        tester
            .widget<InkWell>(
              find.byKey(const ValueKey('select-location-frankfurt-01')),
            )
            .onTap,
        isNull,
      );
      await _tap(tester, 'select-location-paris-01');
      await tester.pumpAndSettle();
      expect(
        find.byKey(const ValueKey('location-change-dialog')),
        findsOneWidget,
      );
      expect(h.tunnel.actions, isEmpty);
      await _tap(tester, 'location-change-confirm');
      await tester.pumpAndSettle();
      expect(h.tunnel.actions, [
        'disconnect',
        'permission',
        'connect:paris-01',
      ]);
      expect(h.selectedCalls, 1);
    },
  );

  _locationsTest(
    'same location and favorites do not open a confirmation or connect',
    (tester, h) async {
      h.controller.tunnelState = const VpnRuntimeState(
        phase: VpnRuntimePhase.connected,
      );
      await h.mount(tester);
      expect(
        tester
            .widget<InkWell>(
              find.byKey(const ValueKey('select-location-paris-01')),
            )
            .onTap,
        isNull,
      );
      await _tap(tester, 'favorite-location-sao-paulo-01');
      await tester.pumpAndSettle();
      expect(h.controller.isFavoriteLocation('sao-paulo-01'), isTrue);
      expect(
        find.byKey(const ValueKey('location-change-dialog')),
        findsNothing,
      );
      expect(h.tunnel.actions, isEmpty);
      expect(h.selectedCalls, 0);
    },
  );

  _locationsTest('double row and confirm callbacks start only one change', (
    tester,
    h,
  ) async {
    await h.mount(tester);
    final tap = tester
        .widget<InkWell>(
          find.byKey(const ValueKey('select-location-sao-paulo-01')),
        )
        .onTap!;
    tap();
    tap();
    await tester.pumpAndSettle();
    expect(
      find.byKey(const ValueKey('location-change-dialog')),
      findsOneWidget,
    );
    final confirm = tester
        .widget<FilledButton>(
          find.byKey(const ValueKey('location-change-confirm')),
        )
        .onPressed!;
    confirm();
    confirm();
    await tester.pumpAndSettle();
    expect(h.selectedCalls, 1);
    expect(h.tunnel.actions, ['permission', 'connect:sao-paulo-01']);
    expect(tester.takeException(), isNull);
  });

  for (final changed in [
    'account',
    'selection',
    'device',
    'protocol',
    'native-location',
    'busy',
  ]) {
    _locationsTest('confirmation is ignored when $changed changes while open', (
      tester,
      h,
    ) async {
      await h.mount(tester);
      await _tap(tester, 'select-location-sao-paulo-01');
      await tester.pumpAndSettle();
      switch (changed) {
        case 'account':
          h.controller.profile = const UserProfile(
            userId: 'other-fixture',
            email: 'other@example.test',
            firstName: '',
            lastName: '',
            phone: '',
            addressLine1: '',
            addressLine2: '',
            postalCode: '',
            city: '',
            countryCode: 'FR',
          );
        case 'selection':
          h.controller.selectedLocation = _frankfurt;
        case 'device':
          h.controller.currentDeviceId = 'other-device';
        case 'protocol':
          h.controller.selectedProtocol = VpnProtocol.openVpn;
        case 'native-location':
          h.controller.tunnelState = const VpnRuntimeState(
            phase: VpnRuntimePhase.connected,
            protocol: VpnProtocol.wireGuard,
            locationId: 'frankfurt-01',
          );
        case 'busy':
          h.controller.isConnecting = true;
      }
      await _tap(tester, 'location-change-confirm');
      await tester.pumpAndSettle();
      expect(h.selectedCalls, 0);
      expect(h.tunnel.actions, isEmpty);
      expect(h.preferences.selectedWrites, isEmpty);
      expect(tester.takeException(), isNull);
    });
  }

  _locationsTest(
    'old dialog cannot use a replacement session even for the same account and token',
    (tester, h) async {
      await h.mount(tester);
      await _tap(tester, 'select-location-sao-paulo-01');
      await tester.pumpAndSettle();
      final previousSession = h.controller.locationChangeSessionIdentity;
      await h.controller.signOut();
      await h.controller.signIn(
        email: 'fixture@example.test',
        password: 'fixture-password',
      );
      expect(
        h.controller.locationChangeSessionIdentity,
        isNot(same(previousSession)),
      );
      expect(h.controller.profile?.userId, _profile.userId);
      expect(h.controller.token, 'fixture-token');
      h.tunnel.actions.clear();
      await _tap(tester, 'location-change-confirm');
      await tester.pumpAndSettle();
      expect(h.selectedCalls, 0);
      expect(h.tunnel.actions, isEmpty);
      expect(h.controller.selectedLocation, same(_paris));
    },
  );

  for (final nativeConnected in [false, true]) {
    _locationsTest(
      nativeConnected
          ? 'native-connected stop cancels location preparation without restarting'
          : 'location preparation can be cancelled before its preference write completes',
      (tester, h) async {
        await h.mount(tester, primaryOnly: true);
        final saved = Completer<void>();
        h.preferences.selectedGate = saved.future;
        final change = h.controller.changeLocationAndConnect(_saoPaulo);
        await tester.pump();
        expect(h.controller.isChangingLocation, isTrue);
        expect(h.controller.isConnecting, isFalse);
        expect(h.controller.tunnelState.phase, VpnRuntimePhase.idle);
        expect(find.text('Annuler'), findsOneWidget);
        expect(
          tester.widget<FilledButton>(find.byType(FilledButton)).onPressed,
          isNotNull,
        );
        if (nativeConnected) {
          h.controller.tunnelState = const VpnRuntimeState(
            phase: VpnRuntimePhase.connected,
          );
          h.controller.notifyListeners();
          await tester.pump();
        }
        final action = find.widgetWithText(
          FilledButton,
          nativeConnected ? 'Se déconnecter' : 'Annuler',
        );
        expect(tester.widget<FilledButton>(action).onPressed, isNotNull);
        final stopped = Completer<void>();
        h.tunnel.disconnectGate = stopped.future;
        await tester.tap(action);
        await tester.pump();
        expect(h.controller.isDisconnecting, isTrue);
        expect(h.controller.isConnecting, isFalse);
        expect(h.tunnel.actions, ['disconnect']);
        expect(
          tester.widget<FilledButton>(find.byType(FilledButton)).onPressed,
          isNull,
        );
        await h.controller.connect();
        expect(h.tunnel.actions, ['disconnect']);
        expect(h.api.registeredLocations, isEmpty);
        stopped.complete();
        await tester.pump();
        saved.complete();
        await change;
        await tester.pumpAndSettle();
        expect(h.controller.isChangingLocation, isFalse);
        expect(h.controller.isDisconnecting, isFalse);
        expect(h.controller.tunnelState.phase, VpnRuntimePhase.idle);
        expect(h.tunnel.actions, ['disconnect']);
        expect(h.api.registeredLocations, isEmpty);
        expect(h.tunnel.unexpectedCalls, 0);
        expect(tester.takeException(), isNull);
      },
    );
  }

  _locationsTest(
    'closing the page during confirmation cannot start a connection',
    (tester, h) async {
      await h.mount(tester);
      await _tap(tester, 'select-location-sao-paulo-01');
      await tester.pumpAndSettle();
      await tester.pumpWidget(const SizedBox.shrink());
      await tester.pumpAndSettle();
      expect(h.tunnel.actions, isEmpty);
      expect(h.selectedCalls, 0);
      expect(tester.takeException(), isNull);
    },
  );

  _locationsTest(
    'pending favorite writes cannot double tap and failed writes explain the rollback',
    (tester, h) async {
      await h.mount(tester);
      final gate = Completer<void>();
      h.preferences.writeGate = gate.future;
      await _tap(tester, 'favorite-location-sao-paulo-01');
      await tester.pump();
      expect(h.controller.favoritesSaving, isTrue);
      expect(
        tester
            .widget<IconButton>(
              find.byKey(const ValueKey('favorite-location-sao-paulo-01')),
            )
            .onPressed,
        isNull,
      );
      h.preferences.failWrite = true;
      gate.complete();
      await tester.pumpAndSettle();
      expect(h.controller.isFavoriteLocation('sao-paulo-01'), isFalse);
      expect(
        find.byKey(const ValueKey('locations-favorite-error')),
        findsOneWidget,
      );
      expect(
        tester
            .widget<IconButton>(
              find.byKey(const ValueKey('favorite-location-sao-paulo-01')),
            )
            .onPressed,
        isNotNull,
      );
      h.preferences.failWrite = false;
      await _tap(tester, 'favorite-location-sao-paulo-01');
      await tester.pumpAndSettle();
      expect(h.controller.isFavoriteLocation('sao-paulo-01'), isTrue);
      expect(
        find.byKey(const ValueKey('locations-favorite-error')),
        findsNothing,
      );
    },
  );

  _locationsTest(
    'search and filter survive controller updates and the page rebuild',
    (tester, h) async {
      await h.controller.toggleFavoriteLocation(_saoPaulo);
      await h.mount(tester);
      await _tap(tester, 'locations-filter-favorites');
      await tester.enterText(
        find.byKey(const ValueKey('locations-search')),
        'sao',
      );
      await h.controller.refreshLocations();
      await h.mount(tester);
      expect(
        tester
            .widget<TextField>(find.byKey(const ValueKey('locations-search')))
            .controller!
            .text,
        'sao',
      );
      expect(
        tester
            .widget<ChoiceChip>(
              find.byKey(const ValueKey('locations-filter-favorites')),
            )
            .selected,
        isTrue,
      );
      expect(
        find.byKey(const ValueKey('location-sao-paulo-01')),
        findsOneWidget,
      );
      expect(find.byKey(const ValueKey('location-paris-01')), findsNothing);
    },
  );

  _locationsTest(
    'an empty catalogue can retry and loading never displays a false empty state',
    (tester, h) async {
      await h.mount(tester);
      expect(find.byKey(const ValueKey('locations-empty')), findsOneWidget);
      final response = Completer<List<Location>>();
      h.api.next = response.future;
      await _tap(tester, 'locations-empty-action');
      await tester.pump();
      expect(find.byKey(const ValueKey('locations-loading')), findsOneWidget);
      expect(find.byKey(const ValueKey('locations-empty')), findsNothing);
      response.complete(_catalog);
      await tester.pumpAndSettle();
      expect(find.byType(CountryFlag), findsNWidgets(3));
      expect(find.byKey(const ValueKey('locations-loading')), findsNothing);
    },
    setup: (h) => h.api.catalog = [],
  );

  for (final locale in AppLanguages.supportedLocales) {
    final language = locale.toLanguageTag();
    for (final theme in [ThemeMode.light, ThemeMode.dark]) {
      _locationsTest(
        'locations remain usable at 320dp and 200% text ($language, ${theme.name})',
        (tester, h) async {
          tester.view.physicalSize = const Size(320, 640);
          tester.platformDispatcher.textScaleFactorTestValue = 2;
          addTearDown(tester.platformDispatcher.clearTextScaleFactorTestValue);
          await h.mount(tester, locale: locale, theme: theme);
          await tester.enterText(
            find.byKey(const ValueKey('locations-search')),
            'Paris',
          );
          await tester.pumpAndSettle();
          await _tap(tester, 'favorite-location-paris-01');
          await tester.pumpAndSettle();
          expect(h.controller.isFavoriteLocation('paris-01'), isTrue);
          for (final key in [
            'locations-filter-favorites',
            'locations-clear-search',
            'favorite-location-paris-01',
          ]) {
            await _ensureVisible(tester, find.byKey(ValueKey(key)));
            expect(find.byKey(ValueKey(key)).hitTestable(), findsOneWidget);
          }
          await _tap(tester, 'locations-filter-favorites');
          await tester.pumpAndSettle();
          await _tap(tester, 'favorite-location-paris-01');
          await tester.pumpAndSettle();
          await _ensureVisible(
            tester,
            find.byKey(const ValueKey('locations-empty-action')),
          );
          expect(
            find.byKey(const ValueKey('locations-empty-action')).hitTestable(),
            findsOneWidget,
          );
          await _tap(tester, 'locations-empty-action');
          await tester.pumpAndSettle();
          await _tap(tester, 'locations-filter-all');
          await tester.pumpAndSettle();
          await _tap(tester, 'select-country-BR');
          await tester.pumpAndSettle();
          expect(
            find.byKey(const ValueKey('location-change-dialog')),
            findsOneWidget,
          );
          await _ensureVisible(
            tester,
            find.byKey(const ValueKey('location-change-confirm')),
          );
          expect(
            find.byKey(const ValueKey('location-change-confirm')).hitTestable(),
            findsOneWidget,
          );
          await _tap(tester, 'location-change-cancel');
          await tester.pumpAndSettle();
          expect(h.tunnel.actions, isEmpty);
          expect(tester.takeException(), isNull);
        },
      );
    }
  }
}

void _locationsTest(
  String name,
  Future<void> Function(WidgetTester, _LocationsHarness) body, {
  void Function(_LocationsHarness)? setup,
}) {
  testWidgets(name, (tester) async {
    tester.view.physicalSize = const Size(900, 1400);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    final h = _LocationsHarness();
    try {
      setup?.call(h);
      await h.controller.initialize();
      await body(tester, h);
    } finally {
      await tester.pumpWidget(const SizedBox.shrink());
      h.controller.dispose();
      await h.tunnel.dispose();
    }
  });
}

Future<void> _tap(WidgetTester tester, String key) async {
  final finder = find.byKey(ValueKey(key));
  await _ensureVisible(tester, finder);
  await tester.tap(finder);
}

void _expectSingleLineCount(WidgetTester tester, Finder browse, String label) {
  final text = find.descendant(of: browse, matching: find.text(label));
  expect(text, findsOneWidget);
  final paragraph = tester.renderObject<RenderParagraph>(text);
  final painter = TextPainter(
    text: paragraph.text,
    textDirection: paragraph.textDirection,
    textScaler: paragraph.textScaler,
    locale: paragraph.locale,
  )..layout(maxWidth: paragraph.size.width);
  try {
    expect(paragraph.textScaler.scale(11), 22);
    expect(
      painter.computeLineMetrics(),
      hasLength(1),
      reason: '$label must remain readable without wrapping at 200% text',
    );
  } finally {
    painter.dispose();
  }
}

Future<void> _ensureVisible(WidgetTester tester, Finder finder) async {
  if (finder.evaluate().isEmpty) {
    final scrollable = find.byType(Scrollable).first;
    tester.state<ScrollableState>(scrollable).position.jumpTo(0);
    await tester.pump();
    await tester.scrollUntilVisible(
      finder,
      220,
      scrollable: scrollable,
      maxScrolls: 80,
    );
  }
  await tester.ensureVisible(finder);
  await tester.pump();
}

class _LocationsHarness {
  _LocationsHarness() {
    controller = VpnAppController(
      api: api,
      sessionStore: session,
      preferences: preferences,
      tunnel: tunnel,
    );
  }
  final api = _LocationsApi();
  final preferences = _LocationsPreferences();
  final tunnel = _LocationsTunnel();
  final session = _LocationsSession();
  late final VpnAppController controller;
  int selectedCalls = 0;
  bool _initialSearchOpened = false;

  Future<void> mount(
    WidgetTester tester, {
    Locale locale = const Locale('fr'),
    ThemeMode theme = ThemeMode.light,
    bool primaryOnly = false,
    bool searchAll = true,
    bool isActive = true,
  }) async {
    await tester.pumpWidget(
      MaterialApp(
        locale: locale,
        theme: FuzeVpnTheme.light(),
        darkTheme: FuzeVpnTheme.dark(),
        themeMode: theme,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: Scaffold(
          body: primaryOnly
              ? AnimatedBuilder(
                  animation: controller,
                  builder: (context, _) =>
                      PrimaryVpnAction(controller: controller),
                )
              : LocationsPage(
                  controller: controller,
                  isActive: isActive,
                  onLocationSelected: () => selectedCalls++,
                ),
        ),
      ),
    );
    await tester.pumpAndSettle();
    if (!primaryOnly && !_initialSearchOpened) {
      _initialSearchOpened = true;
      if (searchAll && controller.locations.isNotEmpty) {
        // All fixture server names contain 'a'; exercise leaf behavior through
        // the actual global search, while hierarchy tests start at countries.
        await tester.enterText(
          find.byKey(const ValueKey('locations-search')),
          'a',
        );
        await tester.pumpAndSettle();
      }
    }
  }
}

class _LocationsApi implements VpnApiRepository {
  List<Location> catalog = _catalog;
  Future<List<Location>>? next;
  ApiException? registrationFailure;
  List<Location>? catalogAfterRegistration;
  final registeredLocations = <String>[];
  int reads = 0;
  @override
  Future<List<Location>> locations() async {
    reads++;
    return next == null ? catalog : await next!;
  }

  @override
  Future<UserProfile> me(String token) async => _profile;
  @override
  Future<DeviceList> listDevices(String token) async =>
      const DeviceList(limit: 2, devices: []);
  @override
  Future<AuthSession> login({
    required String email,
    required String password,
  }) async =>
      AuthSession(accessToken: 'fixture-token', expiresAt: DateTime.utc(2099));
  @override
  Future<void> logout(String token) async {}
  @override
  Future<DeviceConfiguration> registerDevice({
    required String token,
    required String name,
    required String publicKey,
    required String locationId,
    bool requestIpv6 = false,
  }) async {
    registeredLocations.add(locationId);
    if (catalogAfterRegistration != null) catalog = catalogAfterRegistration!;
    final failure = registrationFailure;
    if (failure != null) throw failure;
    return const DeviceConfiguration(
      deviceId: 'fixture-device',
      address: '10.0.0.2/32',
      dns: ['1.1.1.1'],
      serverPublicKey: 'fixture-public-key',
      endpoint: 'fixture.invalid:51820',
      allowedIps: ['0.0.0.0/0'],
    );
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class _LocationsSession implements SecureSessionStore {
  AuthSession? value = AuthSession(
    accessToken: 'fixture-token',
    expiresAt: DateTime.utc(2099),
  );
  @override
  Future<AuthSession?> readSession() async => value;
  @override
  Future<void> writeSession(AuthSession session, {String? userId}) async =>
      value = session;
  @override
  Future<String?> readCurrentDeviceId({required String userId}) async => null;
  @override
  Future<void> writeCurrentDeviceId({
    required String userId,
    required String deviceId,
  }) async {}
  @override
  Future<SessionTerminationResult> clearSession({bool expired = false}) async {
    value = null;
    return const SessionTerminationResult.complete();
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class _LocationsPreferences
    implements AppPreferenceStore, FavoriteLocationStore {
  Set<String> favorites = {};
  final selectedWrites = <String>[];
  Future<void>? writeGate;
  Future<void>? selectedGate;
  bool failWrite = false;
  bool failSelectedWrite = false;
  @override
  Future<Set<String>> readFavoriteLocations() async => Set.of(favorites);
  @override
  Future<void> writeFavoriteLocations(Set<String> locationIds) async {
    if (writeGate != null) await writeGate;
    if (failWrite) throw const NativeVpnException('fixture_write_failed');
    favorites = Set.of(locationIds);
  }

  @override
  Future<String?> readThemeMode() async => null;
  @override
  Future<String?> readLocale() async => 'fr';
  @override
  Future<String?> readSelectedProtocol() async => null;
  @override
  Future<String?> readSelectedLocation() async => null;
  @override
  Future<bool?> readVerificationNeeded({required String userId}) async => false;
  @override
  Future<void> writeVerificationNeeded({
    required String userId,
    required bool value,
  }) async {}
  @override
  Future<void> writeSelectedLocation(String value) async {
    selectedWrites.add(value);
    await selectedGate;
    if (failSelectedWrite) {
      throw const NativeVpnException('secure_storage_write_failed');
    }
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class _LocationsTunnel implements VpnTunnelGateway {
  final events = StreamController<VpnRuntimeState>.broadcast();
  Future<void> dispose() => events.close();
  int unexpectedCalls = 0;
  final actions = <String>[];
  Future<bool>? permissionGate;
  Future<void>? disconnectGate;
  VpnRuntimeState observed = const VpnRuntimeState(phase: VpnRuntimePhase.idle);
  @override
  Stream<VpnRuntimeState> get states => events.stream;
  @override
  Future<VpnRuntimeState> getState() async => observed;
  @override
  Future<bool> requestVpnPermission() async {
    actions.add('permission');
    return permissionGate == null ? true : await permissionGate!;
  }

  @override
  Future<String> getOrCreateWireGuardPublicKey({
    required String accountId,
  }) async => 'fixture-public-key';
  @override
  Future<void> connectWireGuard({
    required String accountId,
    required DeviceConfiguration configuration,
    required Location location,
  }) async {
    actions.add('connect:${location.id}');
    observed = const VpnRuntimeState(
      phase: VpnRuntimePhase.connected,
      protocol: VpnProtocol.wireGuard,
    );
    events.add(observed);
  }

  @override
  Future<void> disconnect() async {
    actions.add('disconnect');
    await disconnectGate;
    observed = const VpnRuntimeState(phase: VpnRuntimePhase.idle);
    events.add(observed);
  }

  @override
  dynamic noSuchMethod(Invocation invocation) {
    unexpectedCalls++;
    return super.noSuchMethod(invocation);
  }
}
