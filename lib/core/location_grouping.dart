import 'country_data.dart';
import 'location_presentation.dart';
import 'models.dart';

/// A view of the current catalogue. Groups never invent or retain servers.
class LocationCountryGroup {
  LocationCountryGroup({
    required this.countryCode,
    required this.name,
    required Iterable<LocationCityGroup> cities,
  }) : cities = List<LocationCityGroup>.unmodifiable(cities);

  final String countryCode;
  final String name;
  final List<LocationCityGroup> cities;

  List<Location> get servers =>
      List<Location>.unmodifiable(cities.expand((city) => city.servers));
}

class LocationCityGroup {
  LocationCityGroup({
    required this.key,
    required this.countryCode,
    required this.name,
    required Iterable<Location> servers,
  }) : servers = List<Location>.unmodifiable(servers);

  /// Stable within its country, across UI languages and catalogue response order.
  final String key;
  final String countryCode;
  final String name;
  final List<Location> servers;
}

/// Countries use bundled names in the UI language; city names come from the API.
/// Case, accents and repeated spaces do not create duplicate city groups within
/// a country. The same city name in different countries always stays separate.
List<LocationCountryGroup> groupLocations(
  Iterable<Location> locations, {
  required String languageCode,
}) {
  final countries = <String, Map<String, List<Location>>>{};
  for (final location in locations) {
    final countryCode = normalizeLocationCountryCode(location.countryCode);
    final cityKey = normalizeLocationSearch(location.city);
    final cities = countries.putIfAbsent(countryCode, () => {});
    cities.putIfAbsent(cityKey, () => []).add(location);
  }
  final result = <LocationCountryGroup>[];
  for (final country in countries.entries) {
    final cities = <LocationCityGroup>[];
    for (final city in country.value.entries) {
      final servers = city.value.toList()..sort(_compareServers);
      // Pick an actual API spelling deterministically, preserving accents when
      // another row spells the same city without them.
      final names =
          servers.map((server) => _cleanLabel(server.city)).toSet().toList()
            ..sort(_compareCitySpellings);
      cities.add(
        LocationCityGroup(
          key: city.key,
          countryCode: country.key,
          name: names.first,
          servers: servers,
        ),
      );
    }
    cities.sort((a, b) {
      final byName = _compareLabels(a.name, b.name);
      return byName != 0 ? byName : a.key.compareTo(b.key);
    });
    result.add(
      LocationCountryGroup(
        countryCode: country.key,
        name: countryName(country.key, languageCode),
        cities: cities,
      ),
    );
  }
  return List<LocationCountryGroup>.unmodifiable(
    sortedByLocalizedLabel<LocationCountryGroup>(
      result,
      (country) => country.name,
      languageCode: languageCode,
      tieBreak: (a, b) => a.countryCode.compareTo(b.countryCode),
    ),
  );
}

/// Orders [items] by their translated [label] in the alphabet of
/// [languageCode], without depending on a platform collator: identical
/// offline and on every Android version. Case, accents and punctuation are
/// secondary, numbers are natural, and letters which a language sorts
/// separately keep their place (sv `Ö` after `Z`, cs `Ch` after `H`, uk `І`
/// after `И`, fa `گ` after `ک`, ur `آ` after the `ا` block, Thai pre-vowels
/// by their consonant), and Latin follows a non-Latin script. Equal labels use
/// [tieBreak], so the result never depends on the input order.
List<T> sortedByLocalizedLabel<T>(
  Iterable<T> items,
  String Function(T item) label, {
  required String languageCode,
  int Function(T a, T b)? tieBreak,
}) {
  final language = languageCode.split(RegExp('[-_]')).first.toLowerCase();
  final keyed = [
    for (final item in items)
      (item: item, label: label(item), key: _sortKey(label(item), language)),
  ];
  keyed.sort((a, b) {
    var order = _compareKeys(a.key, b.key);
    if (order == 0) {
      order = a.label.toLowerCase().compareTo(b.label.toLowerCase());
    }
    if (order == 0) order = a.label.compareTo(b.label);
    if (order == 0 && tieBreak != null) order = tieBreak(a.item, b.item);
    return order;
  });
  return [for (final entry in keyed) entry.item];
}

// A letter sorted after [base] as a separate letter becomes base + marker.
// Markers are above every code unit a key can otherwise contain.
const _after1 = '￱', _after2 = '￲', _after3 = '￳', _after4 = '￴';

/// Script-wide primary equivalences (CLDR root order).
const _scriptOrder = <String, String>{
  // Greek tonos, dialytika and final sigma are secondary.
  'ά': 'α', 'έ': 'ε', 'ή': 'η', 'ί': 'ι', 'ό': 'ο', 'ύ': 'υ', 'ώ': 'ω',
  'ϊ': 'ι', 'ϋ': 'υ', 'ΐ': 'ι', 'ΰ': 'υ', 'ς': 'σ',
  // Cyrillic: ё is е; ґ, є, і, ї follow г, е, и.
  'ё': 'е', 'ґ': 'г$_after1', 'є': 'е$_after1', 'і': 'и$_after1',
  'ї': 'и$_after2',
  // Serbian, Macedonian and Kazakh letters follow their base letter; ѓ, ќ
  // and ў are accents.
  'ә': 'а$_after1', 'ѓ': 'г', 'ғ': 'г$_after2', 'ђ': 'д$_after1',
  'ѕ': 'з$_after1', 'ј': 'й$_after1', 'ќ': 'к', 'қ': 'к$_after1',
  'љ': 'л$_after1', 'ң': 'н$_after1', 'њ': 'н$_after2', 'ө': 'о$_after1',
  'ћ': 'т$_after1', 'ў': 'у', 'ү': 'у$_after1', 'ұ': 'у$_after2',
  'һ': 'х$_after1', 'џ': 'ч$_after1',
  // Persian and Urdu letters follow their Arabic base letters.
  'پ': 'ب$_after1', 'ٹ': 'ت$_after1', 'چ': 'ج$_after1', 'ڈ': 'د$_after1',
  'ڑ': 'ر$_after1', 'ژ': 'ز$_after1', 'ک': 'ك', 'گ': 'ك$_after1',
  'ں': 'ن$_after1', 'ہ': 'ه', 'ۀ': 'ه', 'ھ': 'ه$_after1', 'ی': 'ي',
  'ے': 'ي$_after1',
  // Lao: ສ follows ຈ, ໜ and ໝ are ຫນ and ຫມ; tone marks and niggahita are
  // secondary.
  'ສ': 'ຈ$_after1', 'ໜ': 'ຫນ', 'ໝ': 'ຫມ', '\u0EC8': '', '\u0EC9': '',
  '\u0ECA': '', '\u0ECB': '', '\u0ECC': '', '\u0ECD': '',
  // Zero-width spaces and joiners are ignored, not word breaks.
  '\u200B': '', '\u200C': '', '\u200D': '',
};

const _nordic = <String, String>{
  'æ': 'z$_after1',
  'ä': 'z$_after1',
  'ø': 'z$_after2',
  'ö': 'z$_after2',
  'å': 'z$_after3',
};
const _swedish = <String, String>{
  // Also CLDR fi.
  'å': 'z$_after1',
  'ä': 'z$_after2',
  'æ': 'z$_after2',
  'ö': 'z$_after3',
  'ø': 'z$_after3',
};
const _southSlavic = <String, String>{
  // CLDR hr and sl.
  'č': 'c$_after1',
  'ć': 'c$_after2',
  'đ': 'd$_after2',
  'š': 's$_after1',
  'ž': 'z$_after1',
};
const _persoArabic = <String, String>{
  // و precedes ه in the Persian and Urdu alphabets.
  'ه': 'و$_after1', 'ہ': 'و$_after1', 'ۀ': 'و$_after1', 'ھ': 'و$_after2',
};
const _urdu = <String, String>{
  // CLDR ur, unlike fa: آ is a letter after the whole ا block.
  'آ': 'ا$_after1',
  // ؤ, ئ and ۓ are و, ی and ے plus a secondary mark.
  'ؤ': 'و', 'ئ': 'ي', 'ۓ': 'ي$_after1',
  // و precedes ہ, as in Persian.
  'ه': 'و$_after1', 'ہ': 'و$_after1', 'ۀ': 'و$_after1',
  // An aspirate (consonant + ھ) follows every other word of its consonant:
  // ھ sorts after the last letter (ی, ے) and before the next consonant.
  'ھ': 'ي$_after3',
  // Kasra (U+0650) is a secondary mark.
  '\u0650': '',
};

/// Letters that the language sorts as separate letters (CLDR tailorings).
const _languageOrder = <String, Map<String, String>>{
  'sv': _swedish,
  'fi': _swedish,
  'da': _nordic,
  'nb': _nordic,
  'tr': {
    'ç': 'c$_after1',
    'ğ': 'g$_after1',
    'ı': 'h$_after1',
    'ö': 'o$_after1',
    'ş': 's$_after1',
    'ü': 'u$_after1',
  },
  'cs': {
    'č': 'c$_after1',
    'ř': 'r$_after1',
    'š': 's$_after1',
    'ž': 'z$_after1',
  },
  'pl': {
    'ą': 'a$_after1',
    'ć': 'c$_after1',
    'ę': 'e$_after1',
    'ł': 'l$_after1',
    'ń': 'n$_after1',
    'ó': 'o$_after1',
    'ś': 's$_after1',
    'ź': 'z$_after1',
    'ż': 'z$_after2',
  },
  'ro': {
    'ă': 'a$_after1',
    'â': 'a$_after2',
    'î': 'i$_after1',
    'ș': 's$_after1',
    'ş': 's$_after1',
    'ț': 't$_after1',
    'ţ': 't$_after1',
  },
  'es': {'ñ': 'n$_after1'},
  'vi': {
    'ă': 'a$_after1',
    'ằ': 'a$_after1',
    'ắ': 'a$_after1',
    'ẳ': 'a$_after1',
    'ẵ': 'a$_after1',
    'ặ': 'a$_after1',
    'â': 'a$_after2',
    'ầ': 'a$_after2',
    'ấ': 'a$_after2',
    'ẩ': 'a$_after2',
    'ẫ': 'a$_after2',
    'ậ': 'a$_after2',
    'đ': 'd$_after1',
    'ê': 'e$_after1',
    'ề': 'e$_after1',
    'ế': 'e$_after1',
    'ể': 'e$_after1',
    'ễ': 'e$_after1',
    'ệ': 'e$_after1',
    'ô': 'o$_after1',
    'ồ': 'o$_after1',
    'ố': 'o$_after1',
    'ổ': 'o$_after1',
    'ỗ': 'o$_after1',
    'ộ': 'o$_after1',
    'ơ': 'o$_after2',
    'ờ': 'o$_after2',
    'ớ': 'o$_after2',
    'ở': 'o$_after2',
    'ỡ': 'o$_after2',
    'ợ': 'o$_after2',
    'ư': 'u$_after1',
    'ừ': 'u$_after1',
    'ứ': 'u$_after1',
    'ử': 'u$_after1',
    'ữ': 'u$_after1',
    'ự': 'u$_after1',
  },
  // Alef with hamza is alef plus a secondary mark in Arabic (CLDR). Alef with
  // madda, ؤ and ئ keep their code unit order, which matches CLDR for every
  // bundled name: آ sorts ahead of the alef words, as in Persian.
  'ar': {'أ': 'ا', 'إ': 'ا'},
  'fa': _persoArabic,
  'ur': _urdu,
  // CLDR ps: Pashto letters follow their Arabic base; ې, ۍ and ئ are ی.
  'ps': {
    'ټ': 'ت$_after1',
    'ځ': 'ج$_after1',
    'چ': 'ج$_after2',
    'څ': 'ج$_after3',
    'ډ': 'د$_after1',
    'ړ': 'ر$_after1',
    'ږ': 'ز$_after2',
    'ښ': 'ش$_after1',
    'ګ': 'ك$_after1',
    'ڼ': 'ن$_after1',
    'ؤ': 'و',
    'ې': 'ي',
    'ۍ': 'ي',
    'ئ': 'ي',
  },
  // CLDR kk: ұ precedes ү, ё follows е and і follows ы.
  'kk': {
    'ё': 'е$_after1',
    'ұ': 'у$_after1',
    'ү': 'у$_after2',
    'і': 'ы$_after1',
  },
  // CLDR hy: և sorts as եվ.
  'hy': {'և': 'եվ'},
  // Azerbaijani: x follows h, q follows k and w follows z.
  'az': {
    'ç': 'c$_after1',
    'ə': 'e$_after1',
    'ğ': 'g$_after1',
    'x': 'h$_after1',
    'ı': 'h$_after2',
    'q': 'k$_after1',
    'ö': 'o$_after1',
    'ş': 's$_after1',
    'ü': 'u$_after1',
    'w': 'z$_after1',
  },
  // Estonian: š z ž come before t, õ ä ö ü between w and x.
  'et': {
    'š': 's$_after1',
    'z': 's$_after2',
    'ž': 's$_after3',
    'õ': 'w$_after1',
    'ä': 'w$_after2',
    'ö': 'w$_after3',
    'ü': 'w$_after4',
  },
  'hu': {
    'ö': 'o$_after1',
    'ő': 'o$_after1',
    'ü': 'u$_after1',
    'ű': 'u$_after1',
  },
  'sk': {
    'ä': 'a$_after1',
    'č': 'c$_after1',
    'ô': 'o$_after1',
    'ř': 'r$_after1',
    'š': 's$_after1',
    'ž': 'z$_after1',
  },
  'hr': _southSlavic,
  'sl': _southSlavic,
  // Lithuanian y is i plus a secondary difference.
  'lt': {'č': 'c$_after1', 'y': 'i', 'š': 's$_after1', 'ž': 'z$_after1'},
  // Latvian: long vowels and cedilla letters are letters; y follows i.
  'lv': {
    'ā': 'a$_after1',
    'č': 'c$_after1',
    'ē': 'e$_after1',
    'ģ': 'g$_after1',
    'y': 'i$_after1',
    'ī': 'i$_after2',
    'ķ': 'k$_after1',
    'ļ': 'l$_after1',
    'ņ': 'n$_after1',
    'ō': 'o$_after1',
    'ŗ': 'r$_after1',
    'š': 's$_after1',
    'ū': 'u$_after1',
    'ž': 'z$_after1',
  },
  'sq': {'ç': 'c$_after1', 'ë': 'e$_after1'},
  'ha': {
    'ɓ': 'b$_after1',
    'ɗ': 'd$_after1',
    'ƙ': 'k$_after1',
    'ƴ': 'y$_after1',
  },
  'yo': {'ẹ': 'e$_after1', 'ọ': 'o$_after1', 'ṣ': 's$_after1'},
  'ig': {
    'ị': 'i$_after1',
    'ṅ': 'n$_after1',
    'ọ': 'o$_after1',
    'ụ': 'u$_after1',
  },
  // Indic scripts: letters that CLDR moves, and signs that it ignores.
  'mr': {'\u0901': '\u0902', 'ळ': 'ह$_after1'},
  'ne': {'\u0901': '', '\u0902': ''},
  'gu': {'ળ': 'હ$_after1'},
  'kn': {'ಳ': 'ಹ$_after1'},
  'or': {'ୟ': 'ଯ', 'ୱ': 'ଵ$_after1'},
  // Gurmukhi vowels sort by bearer (ੳ: ਉ ਊ ਓ, then ਅ ਆ ਐ ਔ, then ੲ: ਇ ਈ ਏ)
  // and ਸ ਹ precede ਕ; the virama precedes the vowel signs.
  'pa': {
    'ਉ': 'ਅ',
    'ਊ': 'ਅ$_after1',
    'ਓ': 'ਅ$_after2',
    'ਅ': 'ਆ',
    'ਆ': 'ਆ$_after1',
    'ਐ': 'ਆ$_after2',
    'ਔ': 'ਆ$_after3',
    'ਸ': 'ਏ$_after1',
    'ਹ': 'ਏ$_after2',
    'ੜ': 'ਵ$_after1',
    '\u0A4D': 'ਵ$_after2',
    '\u0A02': '',
    '\u0A3C': '',
    '\u0A70': '',
    '\u0A71': '',
  },
  // Tamil: ஃ follows the vowels; ழ ள ற ன and then the Grantha letters follow வ.
  'ta': {
    'ஃ': 'ஔ$_after1',
    'ழ': 'வ$_after1',
    'ள': 'வ$_after2',
    'ற': 'வ$_after3',
    'ன': 'வ$_after4',
    'ஜ': 'வ$_after4$_after1',
  },
  // Malayalam: ള ഴ റ follow ഹ; chillus and anusvara are consonant + virama.
  'ml': {
    'ള': 'ഹ$_after1',
    'ഴ': 'ഹ$_after2',
    'റ': 'ഹ$_after3',
    '\u0D4D': _malayalamVirama,
    'ൺ': 'ണ$_malayalamVirama',
    'ൻ': 'ന$_malayalamVirama',
    'ർ': 'ര$_malayalamVirama',
    'ൽ': 'ല$_malayalamVirama',
    'ൾ': 'ഹ$_after1$_malayalamVirama',
    '\u0D02': 'മ$_malayalamVirama',
  },
  // Sinhala: ෲ ෟ ෳ follow ෘ; al-lakuna follows every vowel sign.
  'si': {
    '\u0DF2': '\u0DD8$_after1',
    '\u0DDF': '\u0DD8$_after2',
    '\u0DF3': '\u0DD8$_after3',
    '\u0DCA': '\u0DDE$_after1',
  },
  // Myanmar ါ is ာ; independent vowels are အ + vowel (ဩ and ဪ as ော, ော်).
  'my': {
    '\u102B': '\u102C',
    'ဣ': 'အ\u102D',
    'ဤ': 'အ\u102E',
    'ဥ': 'အ\u102F',
    'ဦ': 'အ\u1030',
    'ဧ': 'အ\u1031',
    'ဩ': 'အ\u1032$_after1',
    'ဪ': 'အ\u1032$_after2',
  },
  // Khmer independent vowels are អ + vowel; register and diacritic signs are
  // secondary.
  'km': {
    'ឥ': 'អ\u17B7',
    'ឦ': 'អ\u17B8',
    'ឧ': 'អ\u17BB',
    'ឱ': 'អ\u17C4',
    '\u17C9': '',
    '\u17CA': '',
    '\u17CB': '',
    '\u17CD': '',
    '\u17D0': '',
  },
};

// Malayalam virama: after the last vowel sign, the au length mark.
const _malayalamVirama = '\u0D57$_after1';

/// Letter sequences that the language sorts as one letter (CLDR
/// contractions). They are replaced before [_languageOrder] applies.
const _contractions = <String, Map<String, String>>{
  'cs': {'ch': 'h$_after1'},
  'sk': {'ch': 'h$_after1', 'dz': 'd$_after1', 'dž': 'd$_after2'},
  'hr': {'dž': 'd$_after1', 'lj': 'l$_after1', 'nj': 'n$_after1'},
  'hu': {
    'cs': 'c$_after1',
    'dz': 'd$_after1',
    'dzs': 'd$_after2',
    'gy': 'g$_after1',
    'ly': 'l$_after1',
    'ny': 'n$_after1',
    'sz': 's$_after1',
    'ty': 't$_after1',
    'zs': 'z$_after1',
  },
  'sq': {
    'dh': 'd$_after1',
    'gj': 'g$_after1',
    'll': 'l$_after1',
    'nj': 'n$_after1',
    'rr': 'r$_after1',
    'sh': 's$_after1',
    'th': 't$_after1',
    'xh': 'x$_after1',
    'zh': 'z$_after1',
  },
  // Uzbek oʻ gʻ sh ch follow z.
  'uz': {
    'oʻ': 'z$_after1',
    'gʻ': 'z$_after2',
    'sh': 'z$_after3',
    'ch': 'z$_after4',
  },
  'ha': {'sh': 's$_after1', 'ts': 't$_after1'},
  'yo': {'gb': 'g$_after1'},
  // Igbo ch precedes c.
  'ig': {
    'ch': 'b$_after1',
    'gb': 'g$_after1',
    'gh': 'g$_after2',
    'gw': 'g$_after3',
    'kp': 'k$_after1',
    'kw': 'k$_after2',
    'nw': 'n$_after2',
    'ny': 'n$_after3',
    'sh': 's$_after1',
  },
  // Conjuncts sorted after the last consonant.
  'mr': {'क\u094Dष': 'ह$_after2', 'ज\u094Dञ': 'ह$_after3'},
  'or': {'କ\u0B4Dଷ': 'ହ$_after1'},
  // Myanmar vowels: o and aw follow ai, ui follows the anusvara.
  'my': {
    '\u1031\u102C': '\u1032$_after1',
    '\u1031\u102B': '\u1032$_after1',
    '\u1031\u102C\u103A': '\u1032$_after2',
    '\u1031\u102B\u103A': '\u1032$_after2',
    '\u102D\u102F': '\u1036$_after1',
  },
  // Khmer vowels with nikahit or reahmuk follow the plain vowels.
  'km': {
    '\u17BB\u17C6': '\u17C5$_after1',
    '\u17B6\u17C6': '\u17C6$_after1',
    '\u17B7\u17C7': '\u17C7$_after1',
    '\u17BB\u17C7': '\u17C7$_after2',
    '\u17C1\u17C7': '\u17C7$_after3',
    '\u17C4\u17C7': '\u17C7$_after4',
  },
};

// Longest sequence first, as CLDR matches contractions.
final _contractionPatterns = {
  for (final entry in _contractions.entries)
    entry.key: RegExp(
      (entry.value.keys.toList()..sort((a, b) => b.length.compareTo(a.length)))
          .join('|'),
    ),
};
// Myanmar rhymes sort by final consonant, then vowel: a final consonant (with
// asat, or stacked with a virama) moves ahead of its vowel as virama + letter,
// after every vowel sign and tone and before the medials. Only ေ ာ ိ ု and
// their compounds form rhymes, and not with a dot below before the asat.
final _myanmarRhyme = RegExp(
  '(\u1031?[\u102B\u102C]?|\u102D?\u102F?)([က-အ])(\u1037?)'
  '(?:\u103A\u1039?|\u1039)',
);
// Tamil sorts a pure consonant (with virama) before the same consonant with a
// vowel: the virama is dropped and the inherent vowel is spelled out, after
// every consonant and before the vowel signs.
final _tamilSyllable = RegExp('([க-ஹ])([\u0BBE-\u0BCD]?)');
const _tamilInherentVowel = 'ஹ$_after4';
// Thai and Lao pre-vowels are written first but sorted after their consonant.
final _preVowels = {
  'th': RegExp('([เ-ไ])([ก-ฮ])'),
  'lo': RegExp('([ເ-ໄ])([ກ-ຮໜ-ໟ])'),
};
final _combiningMarks = RegExp(r'[̀-ͯ]');
final _separators = RegExp(r'[^\p{L}\p{M}\p{N}￱-￴]+', unicode: true);

/// Languages whose own script sorts ahead of Latin (CLDR reorder): every UI
/// language written in another script but Japanese. Their Latin letters become
/// fullwidth, above every other letter of a key and below the markers.
const _latinLast = {
  // Cyrillic, Greek, Armenian, Georgian, Hebrew, Arabic and Ethiopic.
  'am', 'ar', 'bg', 'el', 'fa', 'he', 'hy', 'ka', 'kk', 'ps', 'ru', 'sr',
  'uk', 'ur',
  // Indic and Southeast Asian scripts, Hangul and Han.
  'bn', 'gu', 'hi', 'km', 'kn', 'ko', 'lo', 'ml', 'mr', 'my', 'ne', 'or',
  'pa', 'si', 'ta', 'te', 'th', 'zh',
};
final _latinLetter = RegExp('[a-z]');

String _sortKey(String value, String language) {
  var text = value;
  // Turkish and Azerbaijani keep dotless and dotted I distinct.
  if (language == 'tr' || language == 'az') {
    text = text.replaceAll('I', 'ı').replaceAll('İ', 'i');
  }
  text = text.toLowerCase();
  if (language == 'my') {
    text = text.replaceAllMapped(
      _myanmarRhyme,
      (m) => m[3]!.isEmpty
          ? '\u1039${m[2]}${m[1]}'
          : '${m[1]}\u1039${m[2]}${m[3]}',
    );
  }
  final contractions = _contractions[language];
  if (contractions != null) {
    text = text.replaceAllMapped(
      _contractionPatterns[language]!,
      (m) => contractions[m[0]]!,
    );
  }
  if (language == 'ta') {
    text = text.replaceAllMapped(
      _tamilSyllable,
      (m) => switch (m[2]) {
        '' => '${m[1]}$_tamilInherentVowel',
        '\u0BCD' => m[1]!,
        _ => m[0]!,
      },
    );
  }
  final preVowel = _preVowels[language];
  if (preVowel != null) {
    text = text.replaceAllMapped(preVowel, (m) => '${m[2]}${m[1]}');
  }
  final tailoring = _languageOrder[language] ?? const <String, String>{};
  final buffer = StringBuffer();
  for (final rune in text.runes) {
    final char = String.fromCharCode(rune);
    buffer.write(
      tailoring[char] ??
          _scriptOrder[char] ??
          latinSearchReplacements[char] ??
          char,
    );
  }
  final key = buffer
      .toString()
      .replaceAll(_combiningMarks, '')
      .replaceAll(_separators, ' ')
      .trim();
  if (!_latinLast.contains(language)) return key;
  return key.replaceAllMapped(
    _latinLetter,
    (m) => String.fromCharCode(m[0]!.codeUnitAt(0) + 0xFEE0),
  );
}

/// Selects only from the supplied current group. This is a deterministic choice,
/// not a latency/load ranking, and makes no network requests.
///
/// Supply [activeProtocol] only while a tunnel is active, so country/city choices
/// retain the running tunnel's actual protocol. A compatible active server wins,
/// followed by a compatible saved selection, then the first readable label.
Location? chooseLocationServer(
  Iterable<Location> servers, {
  required VpnProtocol selectedProtocol,
  VpnProtocol? activeProtocol,
  String? activeLocationId,
  String? selectedLocationId,
}) {
  final protocol = activeProtocol ?? selectedProtocol;
  final candidates =
      servers.where((server) => server.supports(protocol)).toList()
        ..sort(_compareServers);
  for (final preferred in [activeLocationId, selectedLocationId]) {
    if (preferred == null) continue;
    for (final candidate in candidates) {
      if (candidate.id == preferred) return candidate;
    }
  }
  return candidates.firstOrNull;
}

String _cleanLabel(String value) =>
    value.trim().replaceAll(RegExp(r'\s+'), ' ');

int _compareServers(Location a, Location b) {
  final byName = _compareLabels(a.displayName, b.displayName);
  return byName != 0 ? byName : a.id.compareTo(b.id);
}

int _compareCitySpellings(String a, String b) {
  bool accented(String value) => value.toLowerCase().runes.any(
    (rune) =>
        normalizeLocationSearch(String.fromCharCode(rune)) !=
        String.fromCharCode(rune).trim(),
  );
  final byAccents = (accented(a) ? 0 : 1).compareTo(accented(b) ? 0 : 1);
  if (byAccents != 0) return byAccents;
  bool mixedCase(String value) =>
      value != value.toLowerCase() && value != value.toUpperCase();
  final byCase = (mixedCase(a) ? 0 : 1).compareTo(mixedCase(b) ? 0 : 1);
  return byCase != 0 ? byCase : a.compareTo(b);
}

int _compareLabels(String a, String b) =>
    _compareKeys(normalizeLocationSearch(a), normalizeLocationSearch(b));

int _compareKeys(String left, String right) {
  // Natural numeric order keeps Server 2 ahead of Server 10 without making any
  // claim about capacity or quality. Lengths avoid parsing unbounded integers.
  final parts = RegExp(r'\d+|\D+');
  final leftParts = parts
      .allMatches(left)
      .map((match) => match.group(0)!)
      .toList();
  final rightParts = parts
      .allMatches(right)
      .map((match) => match.group(0)!)
      .toList();
  for (var i = 0; i < leftParts.length && i < rightParts.length; i++) {
    final l = leftParts[i];
    final r = rightParts[i];
    var comparison = 0;
    if (RegExp(r'^\d').hasMatch(l) && RegExp(r'^\d').hasMatch(r)) {
      final ln = l.replaceFirst(RegExp(r'^0+'), '');
      final rn = r.replaceFirst(RegExp(r'^0+'), '');
      comparison = ln.length.compareTo(rn.length);
      if (comparison == 0) comparison = ln.compareTo(rn);
    } else {
      comparison = l.compareTo(r);
    }
    if (comparison != 0) return comparison;
  }
  return leftParts.length.compareTo(rightParts.length);
}
