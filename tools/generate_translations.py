"""Validate and integrate locally authored translation packs (no network)."""
from pathlib import Path
import argparse
import json
import re
import xml.etree.ElementTree as ET

ROOT = Path(__file__).resolve().parents[1]
PACKS = ROOT / 'lib/l10n/translations'
LANGUAGES = ('en es pt de fr ar tr ja id ru it ko pl nl hi vi uk th zh-Hans zh-Hant fa ur fil ms ro cs sv da nb el '
             'bn sw my km uz ne si ta te mr gu ha am hu bg fi sk hr sr he pa kn ml or ps lt lv et sl sq kk az hy ka lo mg so yo ig rw').split()
# Android resource folders keep Java's legacy codes for Indonesian and Hebrew.
# Preferences, Flutter and translation packs use the canonical BCP-47 codes.
LEGACY_QUALIFIERS = {'id': 'in', 'he': 'iw'}
# These catalogues include localized descriptions for translator metadata.
LOCALIZED_METADATA = {'en', 'es', 'de', 'fr'}
# Each select case of the message needs its own title case (A16-ui-l10n-03).
PAIRED_SELECTS = (('notice_native_title', 'notice_native_message'),)


class TranslationError(ValueError):
    """A pack violates the translation contract (kept under python -O)."""


def require(condition, message):
    # Never use assert for validation: python -O and PYTHONOPTIMIZE remove it.
    if not condition:
        raise TranslationError(message)


def read(path):
    def unique(pairs):
        result = {}
        for key, value in pairs:
            if key in result:
                raise ValueError(f'{path}: duplicate key {key}')
            result[key] = value
        return result
    return json.loads(path.read_text(encoding='utf-8-sig'), object_pairs_hook=unique)


def icu_contract(message):
    """Extract argument names and enum cases without mistaking prose for keys."""
    variables, selects = set(), {}

    def closing(text, start):
        depth = 1
        for i in range(start + 1, len(text)):
            if text[i] == '{':
                depth += 1
            elif text[i] == '}':
                depth -= 1
                if depth == 0:
                    return i
        raise ValueError('Unbalanced ICU braces')

    def scan(text):
        pos = 0
        while (start := text.find('{', pos)) >= 0:
            end = closing(text, start)
            body = text[start + 1:end]
            parts = body.split(',', 2)
            name = parts[0].strip()
            require(re.fullmatch(r'[A-Za-z_]\w*', name), f'Invalid ICU name {name}')
            variables.add(name)
            if len(parts) == 3 and parts[1].strip() in ('select', 'plural', 'selectordinal'):
                choices = parts[2].strip()
                choices = re.sub(r'^offset:\s*\d+\s*', '', choices)
                index, keys = 0, set()
                while index < len(choices):
                    match = re.match(r'\s*([\w=]+)\s*\{', choices[index:])
                    require(match, f'Invalid ICU choices: {choices[index:]}')
                    key = match.group(1)
                    require(key not in keys, f'Duplicate ICU case {key}')
                    keys.add(key)
                    child_start = index + match.end() - 1
                    child_end = closing(choices, child_start)
                    scan(choices[child_start + 1:child_end])
                    index = child_end + 1
                    while index < len(choices) and choices[index].isspace():
                        index += 1
                require('other' in keys, 'ICU other case missing')
                if parts[1].strip() == 'select':
                    selects[name] = keys
            pos = end + 1
    scan(message)
    return variables, selects


def validate_source(source):
    # Every language must repeat the source select cases, so checking the source suffices.
    for title_key, message_key in PAIRED_SELECTS:
        if title_key in source['arb'] and message_key in source['arb']:
            titles = icu_contract(source['arb'][title_key])[1]
            for variable, cases in icu_contract(source['arb'][message_key])[1].items():
                missing = sorted(cases - titles.get(variable, set()))
                require(not missing, f'en.{title_key}: no title case for {message_key} cases {missing}')


def validate(pack, source, language):
    require(set(pack) == set(source), f'{language}: unexpected pack structure')
    require(pack['locale'].replace('_', '-') == language, f'{language}: locale')
    require(pack['arb']['@@locale'].replace('_', '-') == language, f'{language}: ARB locale')
    for section in ('arb', 'android', 'countries'):
        target_keys, source_keys = set(pack[section]), set(source[section])
        if section == 'arb' and language in LOCALIZED_METADATA:
            target_keys = {key for key in target_keys if not key.startswith('@')}
            source_keys = {key for key in source_keys if not key.startswith('@')}
        require(target_keys == source_keys, f'{language}: missing/extra {section} keys: {target_keys ^ source_keys}')
        for key, text in pack[section].items():
            if key.startswith('@'):
                if key != '@@locale' and language not in LOCALIZED_METADATA:
                    require(text == source[section][key], f'{language}.{key}: metadata changed')
                continue
            require(isinstance(text, str) and text.strip(), f'{language}.{key}: empty text')
            require('\ufffd' not in text, f'{language}.{key}: invalid Unicode')
            original = source[section][key]
            if section == 'android':
                require(sorted(re.findall(r'%\d+\$[sd]', text)) == sorted(re.findall(r'%\d+\$[sd]', original)), f'{language}.{key}: Android arguments')
            if section == 'arb':
                require(icu_contract(text) == icu_contract(original), f'{language}.{key}: ICU arguments/select cases')
    names = {}
    for code, name in pack['countries'].items():
        normalized = ' '.join(name.casefold().split())
        require(normalized not in names, f'{language}: countries {names.get(normalized)} and {code} share the name {name!r}')
        names[normalized] = code


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument('--require-all', action='store_true', help=f'Compatibility option; all {len(LANGUAGES)} packs are always required.')
    parser.add_argument('--check', action='store_true', help='Validate all packs and check generated files without writing.')
    args = parser.parse_args()
    try:
        generate(args, parser)
    except (TranslationError, ValueError, KeyError, TypeError, AttributeError) as error:
        parser.exit(1, f'Translation validation failed: {type(error).__name__}: {error}\n')


def generate(args, parser):
    source = read(PACKS / 'en.json')
    validate_source(source)
    countries = {}
    outputs = {}
    for language in LANGUAGES:
        path = PACKS / f'{language}.json'
        require(path.exists(), f'Missing translation: {language}')
        pack = read(path)
        validate(pack, source, language)
        countries[language] = pack['countries']
        arb = dict(pack['arb'])
        arb['@@locale'] = language.replace('-', '_')
        outputs[ROOT / f'lib/l10n/app_{language.replace("-", "_")}.arb'] = json.dumps(arb, ensure_ascii=False, indent=2) + '\n'
        if language == 'zh-Hans':
            # Flutter requires a base catalogue for script-specific locales.
            # The public registry still exposes only Hans and Hant.
            fallback = dict(arb)
            fallback['@@locale'] = 'zh'
            outputs[ROOT / 'lib/l10n/app_zh.arb'] = json.dumps(fallback, ensure_ascii=False, indent=2) + '\n'
        qualifier = 'b+' + language.replace('-', '+') if '-' in language else LEGACY_QUALIFIERS.get(language, language)
        resource_dir = 'values' if language == 'fr' else f'values-{qualifier}'
        output = ROOT / f'android/app/src/main/res/{resource_dir}/strings.xml'
        resources = ET.Element('resources')
        for key, value in pack['android'].items():
            node = ET.SubElement(resources, 'string', name=key)
            node.text = value.replace('\\', '\\\\').replace("'", "\\'").replace('"', '\\"')
        ET.indent(resources, space='    ')
        outputs[output] = ET.tostring(resources, encoding='unicode') + '\n'
    outputs[ROOT / 'lib/l10n/translated_countries.dart'] = (
        '// Generated from lib/l10n/translations/*.json. Do not edit directly.\n'
        '// Run tools/generate_translations.py after editing the packs.\n'
        'const Map<String, Map<String, String>> translatedCountryNames = '
        + json.dumps(countries, ensure_ascii=False, indent=2) + ';\n'
    )
    # Validate every pack before changing any generated file.
    if args.check:
        stale = [str(path.relative_to(ROOT)) for path, content in outputs.items()
                 if not path.exists() or path.read_text(encoding='utf-8') != content]
        if stale:
            parser.exit(1, 'Generated files differ; run tools/generate_translations.py:\n' + '\n'.join(stale) + '\n')
    else:
        for path, content in outputs.items():
            path.parent.mkdir(parents=True, exist_ok=True)
            path.write_text(content, encoding='utf-8')
    print(f'Validated {len(LANGUAGES)}/{len(LANGUAGES)} complete packs and {len(outputs)} generated files.')


if __name__ == '__main__':
    main()
