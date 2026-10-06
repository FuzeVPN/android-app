import 'package:flutter_test/flutter_test.dart';
import 'package:fuzevpn_android/core/location_grouping.dart';
import 'package:fuzevpn_android/core/models.dart';

Location server(
  String id, {
  String country = 'FR',
  String city = 'Paris',
  String? name,
  Set<VpnProtocol> protocols = const {
    VpnProtocol.wireGuard,
    VpnProtocol.openVpn,
  },
}) => Location(
  id: id,
  city: city,
  countryCode: country,
  displayName: name ?? id,
  supportedProtocols: protocols,
);

void main() {
  group('country city server catalogue hierarchy', () {
    test('empty catalogue has no synthetic countries, cities or choice', () {
      expect(groupLocations([], languageCode: 'fr'), isEmpty);
      expect(
        chooseLocationServer([], selectedProtocol: VpnProtocol.wireGuard),
        isNull,
      );
    });

    test('single city retains each server without inventing any node', () {
      final first = server('paris-01', name: 'Paris 01');
      final second = server('paris-02', name: 'Paris 02');
      final groups = groupLocations([second, first], languageCode: 'fr');
      expect(groups, hasLength(1));
      final country = groups.single;
      expect(country.countryCode, 'FR');
      expect(country.name, 'France');
      expect(country.cities, hasLength(1));
      expect(country.cities.single.key, 'paris');
      expect(country.cities.single.name, 'Paris');
      expect(country.cities.single.servers, [first, second]);
      expect(country.servers, [first, second]);
    });

    test(
      'multiple cities remain separate and sort by readable city labels',
      () {
        final paris = server('paris');
        final lyon = server('lyon', city: 'Lyon');
        final groups = groupLocations([paris, lyon], languageCode: 'en');
        expect(groups.single.cities.map((city) => city.name), [
          'Lyon',
          'Paris',
        ]);
        expect(groups.single.servers, [lyon, paris]);
      },
    );

    test(
      'UK and GB share normalized country while cities ignore spacing case and accents',
      () {
        final variants = [
          server('gb-1', country: ' uk ', city: '  Cardiff  '),
          server('gb-2', country: 'GB', city: 'CARDIFF'),
          server('br-1', country: ' br ', city: '  São    Paulo '),
          server('br-2', country: 'BR', city: 'sao paulo'),
        ];
        final groups = groupLocations(variants, languageCode: 'fr');
        expect(groups.map((country) => country.countryCode), ['BR', 'GB']);
        expect(groups.first.cities.single.key, 'sao paulo');
        expect(groups.first.cities.single.name, 'São Paulo');
        expect(groups.first.cities.single.servers, hasLength(2));
        expect(groups.last.name, 'Royaume-Uni');
        expect(groups.last.cities.single.name, 'Cardiff');
        expect(groups.last.cities.single.servers, hasLength(2));
      },
    );

    test('composed and decomposed accents share the same city key', () {
      final groups = groupLocations([
        server('de-1', country: 'DE', city: 'München'),
        server('de-2', country: 'DE', city: 'Mu\u0308nchen'),
      ], languageCode: 'de');
      expect(groups.single.cities, hasLength(1));
      expect(groups.single.cities.single.key, 'munchen');
    });

    test('identically named cities in different countries never merge', () {
      final groups = groupLocations([
        server('paris-fr'),
        server('paris-us', country: 'US'),
      ], languageCode: 'fr');
      expect(groups, hasLength(2));
      expect(
        groups
            .expand((country) => country.cities)
            .map((city) => '${city.countryCode}:${city.key}')
            .toSet(),
        {'FR:paris', 'US:paris'},
      );
    });

    test('country order follows the current translated names', () {
      final locations = [server('de', country: 'DE'), server('fr')];
      expect(
        groupLocations(
          locations,
          languageCode: 'fr',
        ).map((country) => country.countryCode),
        ['DE', 'FR'],
      ); // Allemagne, France.
      expect(
        groupLocations(
          locations,
          languageCode: 'en',
        ).map((country) => country.countryCode),
        ['FR', 'DE'],
      ); // France, Germany.
    });

    test(
      'unknown country remains an honest code and unsupported UI language uses English',
      () {
        expect(
          groupLocations([
            server('xy', country: ' xy '),
          ], languageCode: 'fr').single.name,
          'XY',
        );
        expect(
          groupLocations([
            server('de', country: 'DE'),
          ], languageCode: 'unsupported').single.name,
          'Germany',
        );
      },
    );

    test('server ordering is natural and uses id to break equal labels', () {
      final input = [
        server('z', name: 'Server 2'),
        server('ten', name: 'Server 10'),
        server('a', name: 'SERVER 02'),
        server('one', name: 'Server 1'),
      ];
      expect(
        groupLocations(
          input,
          languageCode: 'en',
        ).single.servers.map((item) => item.id),
        ['one', 'a', 'z', 'ten'],
      );
    });

    test(
      'output is stable across response order and does not mutate source',
      () {
        final locations = [
          server('z', city: 'Zürich', country: 'CH'),
          server('b', city: 'Lyon'),
          server('a'),
          server('z2', city: 'zurich', country: 'CH'),
        ];
        List<String> signature(List<Location> source) =>
            groupLocations(source, languageCode: 'fr')
                .expand(
                  (country) => [
                    country.countryCode,
                    country.name,
                    for (final city in country.cities) ...[
                      city.key,
                      city.name,
                      ...city.servers.map((server) => server.id),
                    ],
                  ],
                )
                .toList();
        expect(signature(locations.reversed.toList()), signature(locations));
        expect(locations.map((location) => location.id), ['z', 'b', 'a', 'z2']);
        final grouped = groupLocations(locations, languageCode: 'fr');
        expect(() => grouped.clear(), throwsUnsupportedError);
        expect(() => grouped.first.cities.clear(), throwsUnsupportedError);
        expect(() => grouped.first.servers.clear(), throwsUnsupportedError);
        expect(
          () => grouped.first.cities.first.servers.clear(),
          throwsUnsupportedError,
        );
      },
    );

    test(
      'removing a server from the current catalogue removes it from every group',
      () {
        final first = server('one');
        final second = server('two');
        final before = groupLocations([first, second], languageCode: 'fr');
        final after = groupLocations([second], languageCode: 'fr');
        expect(before.single.servers, [first, second]);
        expect(after.single.servers, [second]);
        expect(
          chooseLocationServer(
            after.single.servers,
            selectedProtocol: VpnProtocol.wireGuard,
            activeLocationId: first.id,
          ),
          same(second),
        );
      },
    );
  });

  group('automatic group choice', () {
    test('preserves a compatible active member before selected member', () {
      final first = server('a');
      final selected = server('b');
      final active = server('c');
      expect(
        chooseLocationServer(
          [first, selected, active],
          selectedProtocol: VpnProtocol.wireGuard,
          activeLocationId: active.id,
          selectedLocationId: selected.id,
        ),
        same(active),
      );
    });

    test('preserves selected member when active is absent or incompatible', () {
      final first = server('a');
      final selected = server('b');
      final active = server('c', protocols: {VpnProtocol.openVpn});
      for (final activeId in [null, 'absent', active.id]) {
        expect(
          chooseLocationServer(
            [first, selected, active],
            selectedProtocol: VpnProtocol.wireGuard,
            activeLocationId: activeId,
            selectedLocationId: selected.id,
          ),
          same(selected),
        );
      }
    });

    test('actual active protocol overrides a different UI protocol', () {
      final wireguard = server('a', protocols: {VpnProtocol.wireGuard});
      final openvpn = server('b', protocols: {VpnProtocol.openVpn});
      expect(
        chooseLocationServer(
          [wireguard, openvpn],
          selectedProtocol: VpnProtocol.wireGuard,
          activeProtocol: VpnProtocol.openVpn,
          selectedLocationId: wireguard.id,
        ),
        same(openvpn),
      );
    });

    test(
      'first compatible server is stable rather than a performance claim',
      () {
        final unavailable = server('a', protocols: {});
        final first = server('b');
        final second = server('c');
        for (final input in [
          [unavailable, first, second],
          [second, first, unavailable],
        ]) {
          expect(
            chooseLocationServer(
              input,
              selectedProtocol: VpnProtocol.wireGuard,
              selectedLocationId: 'absent',
            ),
            same(first),
          );
        }
      },
    );

    test('no compatible member means no automatic destination', () {
      final onlyOpenVpn = server('a', protocols: {VpnProtocol.openVpn});
      final unspecified = server('b', protocols: {});
      expect(
        chooseLocationServer(
          [onlyOpenVpn, unspecified],
          selectedProtocol: VpnProtocol.wireGuard,
          activeLocationId: onlyOpenVpn.id,
          selectedLocationId: unspecified.id,
        ),
        isNull,
      );
    });

    test('choosing a country or city never escapes its current members', () {
      final paris = server('a-paris');
      final lyon = server('b-lyon', city: 'Lyon');
      final london = server('c-london', city: 'London', country: 'GB');
      final groups = groupLocations([paris, lyon, london], languageCode: 'fr');
      final france = groups.firstWhere(
        (country) => country.countryCode == 'FR',
      );
      expect(
        chooseLocationServer(
          france.servers,
          selectedProtocol: VpnProtocol.wireGuard,
          activeLocationId: london.id,
        ),
        same(paris),
      );
      final lyonGroup = france.cities.firstWhere((city) => city.name == 'Lyon');
      expect(
        chooseLocationServer(
          lyonGroup.servers,
          selectedProtocol: VpnProtocol.wireGuard,
          activeLocationId: paris.id,
        ),
        same(lyon),
      );
    });
  });
}
