"""Vendor pinned country artwork and localized names. No runtime network use."""
import concurrent.futures
import hashlib
import json
import re
import unicodedata
import urllib.request
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
TWEMOJI = 'v14.0.2'
CLDR = '47.0.0'

def fetch(url):
    request = urllib.request.Request(url, headers={'User-Agent': 'FuzeVPN-Android-asset-build'})
    with urllib.request.urlopen(request, timeout=45) as response:
        return response.read()

def save(path, data):
    target = ROOT / path
    target.parent.mkdir(parents=True, exist_ok=True)
    target.write_bytes(data)
    return hashlib.sha256(data).hexdigest()

tree = json.loads(fetch(f'https://api.github.com/repos/twitter/twemoji/git/trees/{TWEMOJI}?recursive=1'))
flags = {}
for item in tree['tree']:
    match = re.fullmatch(r'assets/72x72/(1f1[e-f][0-9a-f])-(1f1[e-f][0-9a-f])\.png', item['path'])
    if not match:
        continue
    code = ''.join(chr(int(part, 16) - 0x1F1E6 + 65) for part in match.groups())
    if re.fullmatch('[A-Z]{2}', code):
        flags[code] = item['path']

def download_flag(pair):
    code, path = pair
    data = fetch(f'https://raw.githubusercontent.com/twitter/twemoji/{TWEMOJI}/{path}')
    if not data.startswith(b'\x89PNG\r\n\x1a\n'):
        raise ValueError(path)
    return code, save(f'assets/flags/{code.lower()}.png', data)

with concurrent.futures.ThreadPoolExecutor(max_workers=10) as pool:
    hashes = dict(pool.map(download_flag, sorted(flags.items())))

names = {}
for language in ['fr', 'en', 'de', 'es']:
    url = f'https://raw.githubusercontent.com/unicode-org/cldr-json/{CLDR}/cldr-json/cldr-localenames-full/main/{language}/territories.json'
    source = json.loads(fetch(url))['main'][language]['localeDisplayNames']['territories']
    names[language] = {key: value for key, value in source.items() if re.fullmatch('[A-Z]{2}', key)}

dart = '// Generated from Unicode CLDR 47.0.0. See assets/licenses/UNICODE.txt.\n'
dart += 'const Map<String, Map<String, String>> countryNames = ' + json.dumps(names, ensure_ascii=False, indent=2) + ';\n'
dart += '\nconst Set<String> bundledCountryFlags = {\n' + ''.join(f"  '{code}',\n" for code in sorted(flags)) + '};\n'
folds = {}
for number in list(range(0xA0, 0x0250)) + list(range(0x1E00, 0x1F00)):
    char = chr(number)
    if char.lower() != char or 'LATIN' not in unicodedata.name(char, ''):
        continue
    folded = ''.join(c for c in unicodedata.normalize('NFKD', char) if not unicodedata.combining(c))
    if folded != char:
        folds[char] = folded
folds.update({'ß': 'ss', 'æ': 'ae', 'œ': 'oe', 'ø': 'o', 'ł': 'l', 'đ': 'd', 'ð': 'd', 'þ': 'th', 'ı': 'i'})
dart += '\nconst Map<String, String> latinSearchReplacements = ' + json.dumps(folds, ensure_ascii=False, indent=2) + ';\n'
save('lib/core/country_data.dart', dart.encode())
save('assets/licenses/TWEMOJI.txt', fetch(f'https://raw.githubusercontent.com/twitter/twemoji/{TWEMOJI}/LICENSE-GRAPHICS'))
save('assets/licenses/UNICODE.txt', fetch(f'https://raw.githubusercontent.com/unicode-org/cldr-json/{CLDR}/LICENSE'))
provenance = {'twemoji_tag': TWEMOJI, 'cldr_tag': CLDR, 'twemoji_tree_sha': tree['sha'], 'flags_sha256': hashes}
save('assets/licenses/country-assets.json', json.dumps(provenance, indent=2).encode())
print(f'Bundled {len(flags)} flags and {len(names)} country-name languages.')
