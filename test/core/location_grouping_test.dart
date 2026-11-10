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

  // A03-google-04 / A16-ui-l10n-06 (29/10/2026): country names follow the
  // alphabet of the displayed language, not UTF-16 code units.
  group('localized country order', () {
    List<String> order(String language, List<String> codes) => groupLocations([
      for (final code in codes.reversed) server(code, country: code),
    ], languageCode: language).map((country) => country.countryCode).toList();

    const expected = <String, List<String>>{
      // Égypte, Espagne, Estonie, États-Unis, Éthiopie, Zambie, Zimbabwe.
      'fr': ['EG', 'ES', 'EE', 'US', 'ET', 'ZM', 'ZW'],
      // Afghanistan, Åland Islands, Albania, Zimbabwe.
      'en': ['AF', 'AX', 'AL', 'ZW'],
      // Afghanistan, Ägypten, Oman, Österreich, Simbabwe, Zypern.
      'de': ['AF', 'EG', 'OM', 'AT', 'ZW', 'CY'],
      // Vatikanstaten, Vietnam, Västsahara, Zimbabwe, Åland, Österrike, Östtimor.
      'sv': ['VA', 'VN', 'EH', 'ZW', 'AX', 'AT', 'TL'],
      // Zimbabwe, Ækvatorialguinea, Østrig, Ålandsøerne.
      'da': ['ZW', 'GQ', 'AT', 'AX'],
      // Ekvatorial-Guinea, Zimbabwe, Øst-Timor, Østerrike, Åland.
      'nb': ['GQ', 'ZW', 'TL', 'AT', 'AX'],
      // Çekya, Çin, Irak, İran, İsveç, İsviçre, Şili, Türkiye, Zimbabve.
      'tr': ['CZ', 'CN', 'IQ', 'IR', 'SE', 'CH', 'CL', 'TR', 'ZW'],
      // Čad, Česko, Čína, Honduras, Chile, Chorvatsko, Indie.
      'cs': ['TD', 'CZ', 'CN', 'HN', 'CL', 'HR', 'IN'],
      // Liban, Litwa, Luksemburg, Łotwa.
      'pl': ['LB', 'LT', 'LU', 'LV'],
      // Tanzania, Turcia, Tuvalu, Țările de Jos.
      'ro': ['TZ', 'TR', 'TV', 'NL'],
      // Angola, Áo, Azerbaijan, Ấn Độ.
      'vi': ['AO', 'AT', 'AZ', 'IN'],
      // Естонія, Ємен, Ізраїль, Індія, Ірак, Італія, Йорданія, Японія.
      'uk': ['EE', 'YE', 'IL', 'IN', 'IQ', 'IT', 'JO', 'JP'],
      // Άγιος Μαρίνος, Ανγκόλα, Τόγκο, Τσεχία, Τυνησία.
      'el': ['SM', 'AO', 'TG', 'CZ', 'TN'],
      // برزیل پاکستان چاد چین کانادا گرجستان گواتمالا گینه لبنان نروژ هائیتی یمن
      'fa': [
        'BR',
        'PK',
        'TD',
        'CN',
        'CA',
        'GE',
        'GT',
        'GN',
        'LB',
        'NO',
        'HT',
        'YE',
      ],
      // بھارت پاکستان جارجیا کینیڈا لبنان ہیٹی یمن یوکرین
      'ur': ['IN', 'PK', 'GE', 'CA', 'LB', 'HT', 'YE', 'UA'],
      // แคนาดา ชาด ไต้หวัน ไทย ไนจีเรีย เยอรมนี: pre-vowels follow their consonant.
      'th': ['CA', 'TD', 'TW', 'TH', 'NG', 'DE'],
      // Newer UI languages (ICU 78.3 / CLDR 48).
      // Гвајана, Гватемала, Јамајка, Мађарска, Маурицијус, Пољска, Португалија,
      // Шри Ланка: ђ ј љ follow д и л.
      'sr': ['GY', 'GT', 'JM', 'HU', 'MU', 'PL', 'PT', 'LK'],
      // Ауғанстан, Аустрия, Әзірбайжан, Болгария, Біріккен Араб Әмірліктері,
      // Қазақстан, Ұлыбритания, Үндістан, Ямайка: ғ ә қ ұ ү і are letters.
      'kk': ['AF', 'AT', 'AZ', 'BG', 'AE', 'KZ', 'GB', 'IN', 'JM'],
      // انټيګوا او باربودا اندونیزیا پورتګال پورتو ریکو تاجکستان تائيوان
      // ټرينيډاډ او ټوباګو سوډان سویډن سویلي کوریا: ټ ډ ګ follow ت د ک.
      'ps': ['AG', 'ID', 'PT', 'PR', 'TJ', 'TW', 'TT', 'SD', 'SE', 'KR'],
      // ເກົາຫຼີໃຕ້, ເກົາຫຼີເໜືອ, ຈໍເຈຍ, ຈີນ, ສະເປນ, ສະວາບາ ແລະ ແຢນ ມາເຢນ,
      // ສະຫະລາຊະອານາຈັກ, ວາລລິສ ແລະ ຟູຕູນາ, ໝູ່ເກາະ ເຄແມນ, ອາເຈນທິນາ, ໄຮຕິ:
      // pre-vowels follow their consonant.
      'lo': ['KR', 'KP', 'GE', 'CN', 'ES', 'SJ', 'GB', 'WF', 'KY', 'AR', 'HT'],
      // Cersi, Çad, Əfqanıstan, Fransa Qvianası, Fransa Polineziyası,
      // Xorvatiya, İraq, İran, Lixtenşteyn, Liviya: q follows k, x follows h.
      'az': ['JE', 'TD', 'AF', 'GF', 'PF', 'HR', 'IQ', 'IR', 'LI', 'LY'],
      // Gruusia, Gröönimaa, Kosovo, Kõrgõzstan, Küpros, Leedu, Läti,
      // Svaasimaa, Süüria, Šveits, Zimbabwe, Turks ja Caicos, Türkmenistan,
      // Wallis ja Futuna, Ühendkuningriik: š and z follow s; õ ä ö ü are
      // separate letters (ü after w).
      'et': [
        'GE',
        'GL',
        'XK',
        'KG',
        'CY',
        'LT',
        'LV',
        'SZ',
        'SY',
        'CH',
        'ZW',
        'TC',
        'TM',
        'WF',
        'GB',
      ],
      // Curaçao, Csehország, Oroszország, Örményország,
      // Turks- és Caicos-szigetek, Türkmenisztán: cs, ö and ü are letters.
      'hu': ['CW', 'CZ', 'RU', 'AM', 'TC', 'TM'],
      // Fidži, Färsaaret, Italia, Itä-Timor, Laos, Länsi-Sahara, Pakistan,
      // Päiväntasaajan Guinea, Venezuela, Venäjä: ä follows z.
      'fi': ['FJ', 'FO', 'IT', 'TL', 'LA', 'EH', 'PK', 'GQ', 'VE', 'RU'],
      // Cookove ostrovy, Čína, Honduras, Chorvátsko, Salvádor,
      // Spojené arabské emiráty, Šalamúnove ostrovy, Španielsko: č follows c,
      // ch follows h.
      'sk': ['CK', 'CN', 'HN', 'HR', 'SV', 'AE', 'SB', 'ES'],
      // Cipar, Čile, Norveška, Njemačka, Srbija, Sudan, Sveta Helena,
      // Španjolska, Šri Lanka, Švedska: č follows c, nj follows n.
      'hr': ['CY', 'CL', 'NO', 'DE', 'RS', 'SD', 'SH', 'ES', 'LK', 'SE'],
      // Centrinės Afrikos Respublika, Čekija, Nyderlandai, Norvegija,
      // Rytų Timoras, Rusija, Siera Leonė, Šiaurės Makedonija, Zambija,
      // Žaliasis Kyšulys: y is i.
      'lt': ['CF', 'CZ', 'NL', 'NO', 'TL', 'RU', 'SL', 'MK', 'ZM', 'CV'],
      // Beliza, Beļģija, Centrālāfrikas Republika, Čehija, Ekvadora, Ēģipte,
      // Islande, Īrija, Lietuva, Lībija: ļ č ē ī are letters.
      'lv': ['BZ', 'BE', 'CF', 'CZ', 'EC', 'EG', 'IS', 'IE', 'LT', 'LY'],
      // Côte d’Ivoire, Çeki, Granadë, Greqi, Grënlandë, Gjibraltar, Islandë,
      // Ishulli Norfolk, Sierra-Leone, Shqipëri: ë, gj and sh are letters.
      'sq': ['CI', 'CZ', 'GD', 'GR', 'GL', 'GI', 'IS', 'NF', 'SL', 'AL'],
      // ကနေဒါ, ကင်မရွန်း, စိန့်ကစ်နှင့်နီဗီစ်, စင့်မာတင်, ဘူလ်ဂေးရီးယား,
      // ဘယ်လ်ဂျီယမ်, မောင့်စဲရက်, မက်ကဆီကို, ဥဇဘက်ကစ္စတန်, ဩစတြေးလျ,
      // အယ်လ်ဘေးနီးယား: rhymes by final consonant.
      'my': ['CA', 'CM', 'KN', 'SX', 'BG', 'BE', 'MS', 'MX', 'UZ', 'AU', 'AL'],
      // அர்மேனியா, அர்ஜென்டினா, அரூபா, உக்ரைன், உகாண்டா, ஓமன், ஃபிஜி,
      // கம்போடியா, கனடா, டர்க்ஸ் & கைகோஸ் தீவுகள், ஜோர்டான்: pure consonants
      // first.
      'ta': ['AM', 'AR', 'AW', 'UA', 'UG', 'OM', 'FJ', 'KH', 'CA', 'TC', 'JO'],
      // അൻഡോറ, അന്റാർട്ടിക്ക, അംഗോള, അസർബൈജാൻ, ഇസ്രായേൽ, ഇറ്റലി, എൽ സാൽവദോർ,
      // എസ്റ്റോണിയ, ജർമ്മനി, ജോർദ്ദാൻ: chillus are consonant + virama.
      'ml': ['AD', 'AQ', 'AO', 'AZ', 'IL', 'IT', 'SV', 'EE', 'DE', 'JO'],
      // ਉਜ਼ਬੇਕਿਸਤਾਨ, ਓਮਾਨ, ਅੰਗੁਇਲਾ, ਅਲੈਂਡ ਟਾਪੂ, ਐਂਟੀਗੁਆ ਅਤੇ ਬਾਰਬੁਡਾ, ਈਰਾਨ,
      // ਸਪੇਨ, ਹੰਗਰੀ, ਹੋਂਡੁਰਸ, ਕੁੱਕ ਟਾਪੂ, ਕੁਵੈਤ: vowels by bearer.
      'pa': ['UZ', 'OM', 'AI', 'AX', 'AG', 'IR', 'ES', 'HU', 'HN', 'CK', 'KW'],
      // అంగోలా, జింబాబ్వే, U.S. బయట ఉన్న దీవులు: Latin last.
      'te': ['AO', 'ZW', 'UM'],
    };
    for (final entry in expected.entries) {
      test('${entry.key} sorts by its own alphabet', () {
        final codes = entry.value;
        expect(order(entry.key, codes), codes);
        expect(order(entry.key, [...codes]..shuffle()), codes);
      });
    }

    test('an unknown code follows a non-Latin script, except in Japanese', () {
      // Австрия, Япония, XY; XY, オーストリア, 日本 (ICU 78.3 / CLDR 48).
      expect(order('ru', ['AT', 'JP', 'XY']), ['AT', 'JP', 'XY']);
      expect(order('ja', ['XY', 'AT', 'JP']), ['XY', 'AT', 'JP']);
    });

    test(
      'ar sorts hamza alef with alef, madda alef first; fa keeps آ apart',
      () {
        // آيسلندا إثيوبيا إسبانيا إستونيا أفغانستان الأرجنتين الإكوادور
        // الإمارات… ألبانيا الجزائر أوغندا باكستان (ICU 78.3 / CLDR 48, ar)
        const arabic = [
          'IS',
          'ET',
          'ES',
          'EE',
          'AF',
          'AR',
          'EC',
          'AE',
          'AL',
          'DZ',
          'UG',
          'PK',
        ];
        expect(order('ar', arabic), arabic);
        expect(order('ar', [...arabic]..shuffle()), arabic);
        // آرژانتین آلمان اتیوپی اسپانیا استرالیا
        const persian = ['AR', 'DE', 'ET', 'ES', 'AU'];
        expect(order('fa', [...persian]..shuffle()), persian);
      },
    );

    // Réaudit final du 30/10/2026, B22 (A03-google-04) : en ourdou, les noms
    // en آ suivaient l'ordre des unités de code et passaient devant tout le
    // bloc ا (checks/review-R2-google/review2_icu_compare.txt, ligne ur).
    test('ur sorts alef madda after the alef block, before ب; fa keeps آ '
        'ahead of ا', () {
      // انڈونیشیا اینٹیگوا اور باربوڈا آذربائیجان آرمینیا آسٹریا آئرلینڈ
      // بارباڈوس (ICU 78.3 / CLDR 48, ur)
      const urdu = ['ID', 'AG', 'AZ', 'AM', 'AT', 'IE', 'BB'];
      expect(order('ur', urdu), urdu);
      expect(order('ur', [...urdu]..shuffle()), urdu);
      // آرژانتین آلمان اتیوپی استرالیا (fa): unchanged, آ first.
      const persian = ['AR', 'DE', 'ET', 'AU'];
      expect(order('fa', [...persian]..shuffle()), persian);
    });

    test('ur also follows CLDR for ئ (as ی), ؤ (as و), aspirates with ھ '
        '(after their consonant) and kasra (secondary)', () {
      // اینٹیگوا… آذربائیجان آرمینیا آسٹریا آسٹریلیا آلینڈ جزائر آئرلینڈ
      // آئس لینڈ آئل آف مین آئیوری کوسٹ بارباڈوس بینن بھارت بھوٹان پاکستان
      // تاجکستان تائیوان ترکیہ تھائی لینڈ ٹرینیڈاڈ… سان مارینو ساؤ تومے…
      // سربیا سورینام سوئٹزرلینڈ سویڈن گوام گوئٹے مالا گیمبیا گھانا لاؤس
      // لبنان لتھوانیا لٹویا لِختن اشٹائن لکسمبرگ مالی مائکرونیشیا مایوٹ
      // ملاوی ملائیشیا منگولیا ناروے ناؤرو نائجر نکاراگوا
      // (ICU 78.3 / CLDR 48, ur; every bundled ur name matches ICU order)
      const urdu = [
        'AG',
        'AZ',
        'AM',
        'AT',
        'AU',
        'AX',
        'IE',
        'IS',
        'IM',
        'CI',
        'BB',
        'BJ',
        'IN',
        'BT',
        'PK',
        'TJ',
        'TW',
        'TR',
        'TH',
        'TT',
        'SM',
        'ST',
        'RS',
        'SR',
        'CH',
        'SE',
        'GU',
        'GT',
        'GM',
        'GH',
        'LA',
        'LB',
        'LT',
        'LV',
        'LI',
        'LU',
        'ML',
        'FM',
        'YT',
        'MW',
        'MY',
        'MN',
        'NO',
        'NR',
        'NE',
        'NI',
      ];
      expect(order('ur', urdu), urdu);
      expect(order('ur', [...urdu]..shuffle()), urdu);
    });

    test('ur sorts ہ right after و', () {
      // لبنان والس اور فتونہ ویتنام ہانگ کانگ SAR چین ہیٹی یمن
      // (ICU 78.3 / CLDR 48, ur)
      const urdu = ['LB', 'WF', 'VN', 'HK', 'HT', 'YE'];
      expect(order('ur', urdu), urdu);
      expect(order('ur', urdu.reversed.toList()), urdu);
    });

    test('tr and cs letters with a cedilla, caron or no dot follow their '
        'base letter', () {
      // Cezayir Çad Dominika Honduras Irak İran Kıbrıs Kırgızistan Kiribati
      // Suudi Arabistan Şili Tanzanya (ICU 78.3 / CLDR 48, tr)
      const turkish = [
        'DZ',
        'TD',
        'DM',
        'HN',
        'IQ',
        'IR',
        'CY',
        'KG',
        'KI',
        'SA',
        'CL',
        'TZ',
      ];
      // Alžírsko Cookovy ostrovy Čad Dánsko Rwanda Řecko Sýrie
      // Šalamounovy ostrovy Španělsko (ICU 78.3 / CLDR 48, cs)
      const czech = ['DZ', 'CK', 'TD', 'DK', 'RW', 'GR', 'SY', 'SB', 'ES'];
      for (final (language, codes) in [('tr', turkish), ('cs', czech)]) {
        expect(order(language, codes), codes, reason: language);
        expect(order(language, [...codes]..shuffle()), codes, reason: language);
      }
    });

    test('unknown or regional tags fall back to the base language', () {
      expect(order('sv-SE', ['ZW', 'AT']), ['ZW', 'AT']);
      expect(order('zh-Hans', ['CN', 'JP']), hasLength(2));
      expect(order('unsupported', ['AX', 'AL']), ['AX', 'AL']);
    });
  });
}
