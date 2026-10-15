#!/usr/bin/env python3
# SPDX-License-Identifier: Apache-2.0
"""Verify the public qualification registry without SDKs or private evidence."""
from __future__ import annotations

import argparse
from collections import Counter
import hashlib
import json
from pathlib import Path, PurePosixPath
import re

VERDICTS = {'validated', 'failed', 'blocked', 'not_applicable'}
LABELS = {'validated': 'Validé', 'failed': 'Échec reproduit', 'blocked': 'Bloqué', 'not_applicable': 'Non applicable'}
COUNT_LABELS = {'validated': 'validés', 'failed': 'échecs reproduits', 'blocked': 'bloqués', 'not_applicable': 'non applicable'}

def read(path):
    return json.loads(path.read_text(encoding='utf-8-sig'))

def safe_file(root, name):
    relative = PurePosixPath(name)
    if relative.is_absolute() or '..' in relative.parts or '\\' in name or ':' in name:
        raise ValueError(f'Unsafe repository path: {name}')
    path = root.joinpath(*relative.parts)
    if not path.is_file() or path.is_symlink() or not path.resolve().is_relative_to(root.resolve()):
        raise ValueError(f'Missing or unsafe file: {name}')
    return path

def sha(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()

def validate(root, registry):
    errors = []
    def require(condition, message):
        if not condition:
            errors.append(message)
    require(registry.get('schema') == 1, 'Unsupported registry schema')
    artifacts = registry.get('artifacts', {})
    require('apk-74016' in artifacts, 'Missing reference APK')
    for key, artifact in artifacts.items():
        require(bool(artifact.get('version')), f'{key}: missing version')
        if 'sha256' in artifact:
            require(bool(re.fullmatch('[0-9a-f]{64}', artifact['sha256'])), f'{key}: invalid artifact hash')
    evidence = {}
    for entry in registry.get('evidence', []):
        key = entry.get('id')
        require(key not in evidence, f'Duplicate evidence: {key}')
        try:
            path = safe_file(root, entry['path'])
            require(sha(path) == entry.get('sha256'), f'{key}: evidence hash mismatch')
            payload = read(path)
            require(payload.get('id') == key, f'{key}: evidence ID mismatch')
            require(payload.get('artifacts') == entry.get('artifacts'), f'{key}: evidence artifact mismatch')
            require(payload.get('kind') == entry.get('kind'), f'{key}: evidence kind mismatch')
            for artifact_id in entry.get('artifacts', []):
                require(artifact_id in artifacts, f'{key}: unknown artifact {artifact_id}')
            for artifact_id, digest in payload.get('artifact_sha256', {}).items():
                require(digest == artifacts.get(artifact_id, {}).get('sha256'), f'{key}: wrong APK or artifact hash')
            counts = payload.get('test_counts')
            if counts:
                fields = ['total', 'passed', 'failures', 'errors', 'skipped']
                require(all(isinstance(counts.get(f), int) and counts[f] >= 0 for f in fields), f'{key}: invalid test counts')
                if all(isinstance(counts.get(f), int) for f in fields):
                    require(counts['total'] == sum(counts[f] for f in fields[1:]), f'{key}: ignored/failed tests counted as passed')
            text = path.read_text(encoding='utf-8')
            mac_prefix = '/' + 'Users' + '/'
            linux_prefix = '/' + 'home' + '/'
            host_path_pattern = r'(?i)[a-z]:[\\/]+(?:users|windows)|' + re.escape(mac_prefix) + '|' + re.escape(linux_prefix) + r'[^/]+/'
            require(not re.search(host_path_pattern, text), f'{key}: private host path')
            require(not re.search(r'-----BEGIN (?:RSA |EC |OPENSSH )?PRIVATE KEY-----|eyJ[A-Za-z0-9_-]{20,}\.[A-Za-z0-9_-]{20,}\.', text), f'{key}: private key or token')
            evidence[key] = entry
        except (ValueError, KeyError, OSError, json.JSONDecodeError) as error:
            errors.append(f'{key}: {error}')
    items = {}
    for item in registry.get('items', []):
        key = item.get('id')
        require(bool(re.fullmatch(r'Q\d{3}', str(key))), f'Invalid item ID: {key}')
        require(key not in items, f'Duplicate item: {key}')
        items[key] = item
        require(item.get('verdict') in VERDICTS, f'{key}: invalid verdict')
        for field in ['claim', 'date', 'environment', 'method', 'result', 'scope']:
            require(bool(item.get(field)), f'{key}: missing {field}')
        refs = item.get('evidence', [])
        require(bool(refs), f'{key}: verdict without evidence')
        for ref in refs:
            require(ref in evidence, f'{key}: missing evidence {ref}')
        for artifact_id in item.get('artifacts', []):
            require(artifact_id in artifacts, f'{key}: unknown artifact {artifact_id}')
            if item.get('verdict') == 'validated':
                require(any(artifact_id in evidence.get(ref, {}).get('artifacts', []) for ref in refs), f'{key}: evidence linked to wrong APK/version')
        if item.get('verdict') in ['blocked', 'failed']:
            require(bool(item.get('prerequisites')), f'{key}: missing next prerequisite')
        for doc in item.get('documents', []):
            try:
                safe_file(root, doc)
            except ValueError as error:
                errors.append(f'{key}: {error}')
    inventory = registry.get('inventory', [])
    require(bool(inventory), 'Empty reservation inventory')
    seen = set()
    for occurrence in inventory:
        key = (occurrence.get('path'), occurrence.get('line'))
        require(key not in seen, f'Duplicate reservation {key}')
        seen.add(key)
        require(bool(occurrence.get('original_text')), f'{key}: missing original wording')
        refs = occurrence.get('items', [])
        require(bool(refs) or bool(occurrence.get('excluded_reason')), f'{key}: reservation without verdict')
        for ref in refs:
            require(ref in items, f'{key}: unknown qualification {ref}')
            if ref in items:
                require(occurrence['path'] in items[ref].get('documents', []), f'{key}: missing document coverage in {ref}')
    sbom = read(root/'docs/SBOM.spdx.json')
    licenses = read(root/'docs/validation-evidence/licenses.json')['packages']
    indexed = {p['id']: p for p in licenses}
    require(len(indexed) == len(licenses), 'Duplicate license audit item')
    require(set(indexed) == {p['SPDXID'] for p in sbom['packages']}, 'Incomplete SBOM audit coverage')
    for package in sbom['packages']:
        item = indexed.get(package['SPDXID'], {})
        for field in ['licenseDeclared', 'licenseConcluded']:
            require(package.get(field) == item.get(field), f"{package['SPDXID']}: {field} diverges from audit")
        for field, value in package.items():
            if value == 'NOASSERTION':
                require(bool(item.get('remaining_unknown_fields', {}).get(field)), f"{package['SPDXID']}: unexplained NOASSERTION {field}")
        require(bool(item.get('reason')), f"{package['SPDXID']}: missing license verdict reason")
    for license_info in sbom.get('hasExtractedLicensingInfos', []):
        if license_info.get('extractedText') == 'NOASSERTION':
            require(bool(license_info.get('comment')) and bool(license_info.get('seeAlsos')), f"{license_info['licenseId']}: unexplained custom license text")
    covered={(u['id'],u['field']) for u in registry.get('original_sbom_unknown_fields', [])}
    for id,field in covered:
        require(id in indexed, f'{id}: original unknown is not audited')
        if id in indexed:
            require(bool(indexed[id].get('reason')), f'{id}: unknown field {field} has no audit reason')
    return errors

def render(registry):
    counts = Counter(i['verdict'] for i in registry['items'])
    lines = ['# Qualification documentée — 0.2.10+74016', '',
             'État daté du 14 octobre 2026. Chaque résultat s’applique uniquement aux versions, environnements et méthodes indiqués. Les preuves publiques sont des extraits expurgés ; leurs originaux restent conservés hors du dépôt.', '',
             f"Bilan : **{len(registry['items'])} points** — " + ', '.join(f"{counts[v]} {COUNT_LABELS[v]}" for v in ['validated','failed','blocked','not_applicable']) + '.', '',
             'Référence APK ARM32/ARM64 : `'+registry['artifacts']['apk-74016']['sha256']+'`.', '',
             'Sources 74016 conservées par le commit `'+registry['source_snapshot_commit']+'`, après la base publique `'+registry['base_commit']+'`. Les mises à jour documentaires et outils d’audit ultérieurs ne constituent pas une nouvelle livraison Android.', '',
             '[Registre machine](validation.json) · [Audit des 106 composants SPDX](validation-evidence/licenses.json)', '',
             '| Point | Verdict | Résultat et périmètre |', '| --- | --- | --- |']
    for item in registry['items']:
        lines.append(f"| [{item['id']}](#{item['id'].lower()}) — {item['claim'].replace('|','/')} | {LABELS[item['verdict']]} | {item['result'].replace('|','/')} |")
    for item in registry['items']:
        lines += ['', f"<a id=\"{item['id'].lower()}\"></a>", f"## {item['id']} — {item['claim']}", '',
                  '**'+LABELS[item['verdict']]+'** — '+item['result'], '',
                  '**Périmètre :** '+item['scope'], '', '**Environnement :** '+item['environment'], '',
                  '**Méthode :** '+item['method'], '', '**Date :** '+item['date'], '',
                  '**Preuves :** '+', '.join(f"[{ref}]({next(e['path'] for e in registry['evidence'] if e['id']==ref).removeprefix('docs/')})" for ref in item['evidence'])+'.']
        if item.get('prerequisites'):
            lines += ['', '**Pour compléter :** '+item['prerequisites']]
    lines += ['', '## Vérification', '', '```powershell', 'python tools/check_validation.py', "python -m unittest discover -s tools/tests -p 'test_check_validation.py'", '```', '',
              'Le contrôle vérifie les liens locaux, les empreintes publiques, les versions associées, les comptes de tests, les verdicts, chaque occurrence inventoriée et chaque champ NOASSERTION du SBOM. Il ne réexécute pas les parcours historiques ni les services distants.', '']
    return '\n'.join(lines)

def check_markdown_links(root):
    errors = []
    documents = [*root.glob('*.md'), *root.glob('docs/*.md'), root/'android/native-provenance/README.md', root/'android/source-distribution/README.md', root/'assets/fonts/GoogleSans-TRADEMARKS.md']
    for document in documents:
        if not document.is_file():
            continue
        text = document.read_text(encoding='utf-8-sig')
        for match in re.finditer(r'\[[^\]]*\]\((?:<([^>]+)>|([^\s)]+))\)', text):
            target = match.group(1) or match.group(2)
            if re.match(r'[a-zA-Z][a-zA-Z0-9+.-]*:', target) or target.startswith('#'):
                continue
            path = (document.parent/target.split('#', 1)[0]).resolve()
            if not path.exists() or not path.is_relative_to(root.resolve()):
                errors.append(f'{document.relative_to(root)}: broken local link {target}')
    return errors

def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--render', action='store_true', help='Regenerate the human-readable report')
    args = parser.parse_args()
    root = Path(__file__).resolve().parents[1]
    registry = read(root/'docs/validation.json')
    errors = validate(root, registry)
    expected = render(registry)
    report = root/'docs/VALIDATION.md'
    if args.render and not errors:
        report.write_text(expected, encoding='utf-8')
    elif not report.is_file() or report.read_text(encoding='utf-8') != expected:
        errors.append('Human-readable report diverges; run --render after updating the registry')
    errors.extend(check_markdown_links(root))
    if errors:
        print('\n'.join('FAIL: '+error for error in errors))
        return 1
    print(f"PASS: {len(registry['items'])} qualification items, {len(registry['inventory'])} reservation occurrences, {len(registry['evidence'])} evidence files, complete SPDX coverage")
    return 0

if __name__ == '__main__':
    raise SystemExit(main())
