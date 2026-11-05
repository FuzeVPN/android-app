#!/usr/bin/env python3
# SPDX-License-Identifier: Apache-2.0
"""Maintained AAB release runner. Import is side-effect free. Guards survive -O.

Use only for a separately authorized future local release; historical reports stay immutable.
See docs/RELEASE_EVIDENCE.md. No automatic publication or server action.
"""
from pathlib import Path
from datetime import datetime, timedelta, timezone
import argparse
import hashlib
import importlib.util
import json
import os
import re
import shutil
import stat
import subprocess
import sys
import tempfile
import types
import zipfile
import xml.etree.ElementTree as ET
REPORT = KIT = REPO = DELIVERY = CONFIG = ENV = FLUTTER = PWSH = None
PIN = VERSION_NAME = VERSION_CODE = TESTED_APK = None

def require(condition, message='Release precondition failed'):
    if not condition:
        raise RuntimeError(message)

def reject_links(path):
    for candidate in (path, *path.parents):
        try:
            info = candidate.lstat()
        except FileNotFoundError:
            continue
        require(not stat.S_ISLNK(info.st_mode) and not
                (getattr(info, 'st_file_attributes', 0) & getattr(stat, 'FILE_ATTRIBUTE_REPARSE_POINT', 0x400)),
                'Links and Windows reparse points are forbidden')

def output_guard():
    for path in (REPORT, DELIVERY):
        reject_links(path)
        require(path.resolve().is_relative_to(KIT), 'Output escaped the selected kit')

def child(directory, name):
    require(isinstance(name, str) and Path(name).name == name and name not in {'', '.', '..'}, 'Unsafe receipt filename')
    path = directory/name
    reject_links(path)
    return path

INSTANT = re.compile(r'([0-9]{4})-([0-9]{2})-([0-9]{2})T([0-9]{2}):([0-9]{2}):([0-9]{2})(?:\.([0-9]{1,9}))?(Z|[+-][0-9]{2}:[0-9]{2})')

def instant(value):
    # PowerShell receipts use seven fractional digits and Z; Python 3.10 fromisoformat reads neither.
    match = INSTANT.fullmatch(value) if isinstance(value, str) else None
    require(match is not None, 'Validation timestamps must be ISO-8601 instants with a timezone')
    zone = match[8]
    require(zone == 'Z' or (int(zone[1:3]) <= 23 and int(zone[4:6]) <= 59), 'Validation timestamp offset is invalid')
    offset = timezone.utc if zone == 'Z' else timezone((-1 if zone[0] == '-' else 1)*timedelta(hours=int(zone[1:3]), minutes=int(zone[4:6])))
    try:
        parsed = datetime(*map(int, match.groups()[:6]), tzinfo=offset)
    except ValueError as error:
        raise RuntimeError('Validation timestamp is not a calendar instant') from error
    return parsed.timestamp() + (int(match[7].ljust(9, '0'))/1e9 if match[7] else 0.0)

def configure(args):
    global REPORT, KIT, REPO, DELIVERY, CONFIG, ENV, FLUTTER, PWSH
    global PIN, VERSION_NAME, VERSION_CODE, TESTED_APK
    require(re.fullmatch('[a-zA-Z0-9][a-zA-Z0-9._-]{0,79}', args.run_name) is not None, 'Invalid run name')
    require(re.fullmatch('[0-9a-f]{40}', args.expected_commit) is not None, 'A full expected commit is required')
    KIT, REPO = Path(args.kit).absolute(), Path(args.source).absolute()
    reject_links(KIT)
    reject_links(REPO)
    KIT, REPO = KIT.resolve(strict=True), REPO.resolve(strict=True)
    require(REPO == Path(__file__).resolve().parents[1], 'Source must be this maintained tool checkout')
    CONFIG = json.loads((KIT / 'config-build.json').read_text(encoding='utf-8-sig'))
    PIN = args.expected_commit
    require(CONFIG['source_commit'] == PIN, 'Kit configuration does not select the expected commit')
    REPORT = KIT / 'rapports' / args.run_name
    DELIVERY = KIT / 'livraisons' / args.run_name
    output_guard()
    match = re.search('^version:\\s*([^+\\s]+)\\+(\\d+)\\s*$', (REPO / 'pubspec.yaml').read_text(encoding='utf-8'), re.M)
    require(match is not None, 'Source application version is missing')
    VERSION_NAME, code = match.groups()
    VERSION_CODE = int(code)
    TESTED_APK = Path(args.tested_apk).resolve(strict=True) if args.tested_apk else None
    require(TESTED_APK is None or (TESTED_APK.is_file() and TESTED_APK.suffix.lower() == '.apk'), 'Reference must be an APK file')
    ENV = os.environ.copy()
    ENV.update(JAVA_HOME=CONFIG['java_home'], ANDROID_HOME=CONFIG['android_sdk'], ANDROID_SDK_ROOT=CONFIG['android_sdk'], GRADLE_USER_HOME=str(REPO / '.gradle'), PUB_CACHE=str(REPO / '.dart_tool/isolated-pub-cache'), PYTHONUTF8='1', GIT_TERMINAL_PROMPT='0', GCM_INTERACTIVE='Never')
    ENV['PATH'] = str(Path(CONFIG['java_home']) / 'bin') + os.pathsep + str(Path(CONFIG['flutter_root']) / 'bin') + os.pathsep + ENV['PATH']
    ENV['PSModulePath'] = str(Path(os.environ.get('SystemRoot', 'C:/Windows')) / 'System32/WindowsPowerShell/v1.0/Modules') + ';' + os.environ.get('PSModulePath', '')
    FLUTTER = Path(CONFIG['flutter_root']) / 'bin/flutter.bat'
    PWSH = Path(args.powershell) if args.powershell else Path(shutil.which('pwsh') or '')
    require(PWSH.is_file(), 'PowerShell 7 is required; pass --powershell')

def sha(path):
    with Path(path).open('rb') as stream:
        digest = hashlib.sha256()
        for block in iter(lambda: stream.read(1024*1024), b''):
            digest.update(block)
        return digest.hexdigest()

def delivery_names():
    prefix = f'FuzeVPN-Android-v{VERSION_CODE}-'
    return {prefix + suffix for suffix in ('aab-mapping.txt', 'aab-embedded-mapping.txt',
        'release-unsigned.aab', 'release-upload-signed.aab', 'sources.tar.gz', 'universal.apk', 'universal.apks')}

def delivery_inventory():
    output_guard()
    expected = delivery_names()
    require({p.name for p in DELIVERY.iterdir()} == expected | {'SHA256SUMS'}, 'Delivery files are missing or unexpected')
    for name in expected | {'SHA256SUMS'}:
        require(child(DELIVERY, name).is_file(), 'Delivery contains a non-file entry')
    records = {}
    for line in child(DELIVERY, 'SHA256SUMS').read_text(encoding='ascii').splitlines():
        parts = line.split('  ', 1)
        require(len(parts) == 2 and re.fullmatch('[0-9a-f]{64}', parts[0]) is not None,
                'Malformed delivery inventory')
        digest, name = parts
        require(name in expected and name not in records, 'Unexpected or duplicate inventory entry')
        records[name] = digest
    require(set(records) == expected, 'Delivery inventory is empty or incomplete')
    actual = {name: sha(child(DELIVERY, name)) for name in sorted(expected)}
    require(records == actual, 'Delivery inventory fingerprint changed')
    return actual

def release_evidence():
    """Bind all final receipts to this commit and these exact delivery bytes."""
    hashes = delivery_inventory()
    prefix = f'FuzeVPN-Android-v{VERSION_CODE}-'
    unsigned, signed = prefix+'release-unsigned.aab', prefix+'release-upload-signed.aab'
    mapping, embedded = prefix+'aab-mapping.txt', prefix+'aab-embedded-mapping.txt'
    archive, apk = prefix+'sources.tar.gz', prefix+'universal.apk'
    tree = git('rev-parse', 'HEAD^{tree}')
    inputs = json.loads(child(REPORT, 'build-inputs.json').read_text(encoding='utf-8'))
    require(inputs['commit'] == PIN and inputs['tree'] == tree and inputs['version'] == VERSION_NAME and
            inputs['version_code'] == VERSION_CODE and inputs['repository'] == CONFIG['source_repository'] and
            Path(inputs['source']).resolve(strict=True) == REPO and inputs.get('checks_skipped') is False and
            inputs.get('fuzevpn.usePatchedWireGuardAar') is True, 'Build inputs belong to another source or campaign')
    output = json.loads(child(REPORT, 'build-output.json').read_text(encoding='utf-8'))
    require(output['unsigned_aab_sha256'] == hashes[unsigned] and output['mapping_sha256'] == hashes[mapping] and
            hashes[mapping] == hashes[embedded] and output.get('source_clean') is True, 'Build output fingerprints differ')
    signature = json.loads(child(REPORT, signed+'.signature.json').read_text(encoding='utf-8'))
    require(signature['kind'] == 'aab' and signature['status'] == 'PASS' and signature['signature_verified'] is True and
            signature['payload_unchanged'] is True and Path(signature['input']) == DELIVERY/unsigned and
            Path(signature['output']) == DELIVERY/signed and signature['unsigned_sha256'] == hashes[unsigned] and
            signature['signed_sha256'] == hashes[signed] and signature['bytes'] == (DELIVERY/signed).stat().st_size,
            'Signing receipt differs from this delivery')
    qualification = json.loads(child(REPORT, 'qualification-aab.json').read_text(encoding='utf-8'))
    require(qualification['commit'] == PIN and Path(qualification['source']) == REPO and
            Path(qualification['delivery']) == DELIVERY and qualification['status'] == 'PASS' and
            bool(qualification['checks']) and all(row['status'] == 'PASS' for row in qualification['checks']) and
            qualification['certificate_sha256'] == signature['certificate_sha256'], 'Qualification belongs to another campaign or failed')
    artifacts = qualification['artifacts']
    require(len(artifacts) == 2, 'Qualification artifact set is incomplete')
    seen = set()
    for artifact in artifacts:
        name = Path(artifact['path']).name
        require(name in {signed, apk} and name not in seen and Path(artifact['path']) == DELIVERY/name and
                artifact['kind'] == ('aab' if name == signed else 'universal-apk') and artifact['status'] == 'PASS' and
                artifact['sha256'] == hashes[name] and artifact['bytes'] == (DELIVERY/name).stat().st_size,
                'Qualified artifact differs from the current delivery')
        seen.add(name)
    comparison = json.loads(child(REPORT, 'payload-comparison-vs-tested-apk.json').read_text(encoding='utf-8'))
    require(TESTED_APK is not None, '--tested-apk is required for final provenance')
    reject_links(TESTED_APK)
    require(comparison['aab_sha256'] == hashes[signed] and comparison['tested_apk_sha256'] == sha(TESTED_APK),
            'Payload comparison identifies another binary')
    entries = comparison['entries']
    require(entries and len(entries) == comparison['compared_entries'] == comparison['identical_entries'] and
            len({row['aab_entry'] for row in entries}) == len(entries) and all(row['same_bytes'] is True for row in entries),
            'Payload comparison is empty, duplicated or incomplete')
    identity = next((row['detail'] for row in qualification['checks']
                     if row['name'] == 'aab_and_generated_apk_native_identity'), None)
    require(identity and identity.get('all_identical') and identity.get('libraries') and
            comparison['native_identical'] == len(identity['libraries']) ==
            sum(row['aab_entry'].startswith('base/lib/') for row in entries), 'Native identity evidence is incomplete')
    association = json.loads(child(REPORT, 'bundle-source-association.json').read_text(encoding='utf-8'))
    require(association['commit'] == PIN and association['tree'] == tree and association['signed_aab'] == signed and
            association['signed_aab_sha256'] == hashes[signed] and association['source_archive'] == archive and
            association['source_archive_sha256'] == hashes[archive] and association['derived_universal_apk_sha256'] == hashes[apk],
            'Source association belongs to another commit or delivery')
    complete = json.loads(child(REPORT, 'source-export.complete.json').read_text(encoding='utf-8'))
    require(complete['commit'] == PIN and complete['tree'] == tree and complete['delivery_hashes'] == hashes and
            complete['inventory_sha256'] == sha(child(DELIVERY, 'SHA256SUMS')), 'Source export was interrupted or changed')
    return {'hashes': hashes, 'tree': tree, 'qualification': qualification, 'comparison': comparison,
            'signed_aab_sha256': hashes[signed]}

def save(name, data):
    output_guard()
    with child(REPORT, name).open('x', encoding='utf-8') as stream:
        json.dump(data, stream, indent=2, ensure_ascii=False)
        stream.write('\n')

def git(*args):
    return subprocess.check_output(['git', *args], cwd=REPO, env=ENV, encoding='utf-8').strip()

PUBLIC_TAG_TIMEOUT = 60  # seconds; the anonymous ls-remote is this tool's only network call

def git_network(*args, env, cwd):
    """git bounded by PUBLIC_TAG_TIMEOUT. Git for Windows' cmd\\git.exe starts the real git.exe, which keeps
    the output pipe open after the wrapper is killed: a timeout stops the whole process tree."""
    command = ['git', *args]
    with subprocess.Popen(command, cwd=cwd, env=env, stdin=subprocess.DEVNULL, stdout=subprocess.PIPE, encoding='utf-8') as process:
        try:
            output = process.communicate(timeout=PUBLIC_TAG_TIMEOUT)[0]
        except subprocess.TimeoutExpired:
            if os.name == 'nt':
                subprocess.run(['taskkill', '/T', '/F', '/PID', str(process.pid)], stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL)
            process.kill()
            process.communicate()
            raise
    if process.returncode:
        raise subprocess.CalledProcessError(process.returncode, command)
    return output.strip()

def source_guard():
    require(git('rev-parse', 'HEAD') == PIN, 'Source commit changed')
    require(not git('status', '--porcelain'), 'Source is not clean')
    require(git('remote', 'get-url', 'origin') == CONFIG['source_repository'], 'Source repository changed')
    require(CONFIG['source_commit'] == PIN, 'Select the intended release in config-build.json first')
    require(re.search('^version:\\s*' + re.escape(VERSION_NAME) + '\\+' + str(VERSION_CODE) + '\\s*$', (REPO / 'pubspec.yaml').read_text(), re.M) is not None, 'Source version changed')

def public_tag_guard():
    """Read-only and anonymous: the repository the app links must already publish tag v<version> on PIN.

    Never creates or pushes a tag; the owner publishes it. Annotated tags are compared by their peeled commit.
    """
    repository = CONFIG['source_repository']
    require(repository.startswith('https://'), 'Public source tag check needs an HTTPS source repository')
    linked = re.findall("^const String sourceCodeRepository = '([^']*)';\\s*$", (REPO / 'lib/widgets/third_party_notices.dart').read_text(encoding='utf-8'), re.M)
    require(linked == [repository.removesuffix('.git')], 'Source repository is not the one the application links')
    tag = 'refs/tags/v' + VERSION_NAME
    with tempfile.TemporaryDirectory(ignore_cleanup_errors=True) as empty:
        # Origin's URL (pinned by source_guard) from an empty directory: no system, global or repository
        # configuration, operator GIT_* variable or .netrc can authenticate the read.
        root = Path(empty).resolve()
        home, config = root / 'home', root / 'gitconfig'
        home.mkdir()
        config.write_bytes(b'')
        isolated = {'GIT_TERMINAL_PROMPT': '0', 'GCM_INTERACTIVE': 'Never', 'GIT_CONFIG_NOSYSTEM': '1', 'GIT_CONFIG_GLOBAL': str(config),
                    'GIT_CEILING_DIRECTORIES': str(root), 'HOME': str(home), 'USERPROFILE': str(home)}
        dropped = {'SSH_ASKPASS', *isolated}
        anonymous = {k: v for k, v in ENV.items() if not k.upper().startswith('GIT_') and k.upper() not in dropped} | isolated
        try:
            listing = git_network('-c', 'credential.helper=', '-c', 'credential.https://github.com.helper=', '-c', 'core.askPass=', '-c', 'http.extraHeader=',
                                  'ls-remote', '--tags', repository, tag, tag + '^{}', env=anonymous, cwd=home)
        except (subprocess.CalledProcessError, subprocess.TimeoutExpired) as error:
            raise RuntimeError('Anonymous read of the source repository failed; it must be public') from error
    refs = {}
    for line in listing.splitlines():
        commit, _, name = line.partition('\t')
        require(re.fullmatch('[0-9a-f]{40}', commit) is not None and name in {tag, tag + '^{}'} and name not in refs,
                'Unexpected public tag listing')
        refs[name] = commit
    require(tag in refs, f'Public source tag v{VERSION_NAME} is not published; the owner must publish it on {PIN}')
    require(refs.get(tag + '^{}', refs[tag]) == PIN, f'Public source tag v{VERSION_NAME} points to another commit; a published version cannot be reused')

def run(name, args, cwd=None, extra_env=None):
    cwd = REPO if cwd is None else cwd
    output_guard()
    log = child(REPORT, name + '.txt')
    started = datetime.now(timezone.utc).isoformat()
    print('RUN: ' + name, flush=True)
    with log.open('xb') as out:
        result = subprocess.run(list(map(str, args)), cwd=cwd, env=ENV | (extra_env or {}), stdin=subprocess.DEVNULL, stdout=out, stderr=subprocess.STDOUT)
    save(name + '.result.json', {'name': name, 'exit_code': result.returncode, 'started_utc': started, 'finished_utc': datetime.now(timezone.utc).isoformat(), 'log': log.name, 'log_sha256': sha(log)})
    if result.returncode:
        raise RuntimeError('Failed: ' + name + '; inspect its private log')
    print('PASS: ' + name, flush=True)

def build():
    source_guard()
    output_guard()
    require(not REPORT.exists() and (not DELIVERY.exists()), 'Choose a new run name; historical outputs must never be reused')
    REPORT.mkdir(parents=True, exist_ok=False)
    DELIVERY.mkdir(parents=True, exist_ok=False)
    save('build-inputs.json', {'repository': CONFIG['source_repository'], 'commit': PIN, 'tree': git('rev-parse', 'HEAD^{tree}'), 'version': VERSION_NAME, 'version_code': VERSION_CODE, 'source': str(REPO), 'signature_dir': str(KIT / 'signature'), 'checks_skipped': False, 'started': datetime.now(timezone.utc).isoformat(), 'scope': 'AAB ARM32/ARM64 and derived qualification APK', 'fuzevpn.usePatchedWireGuardAar': True})
    (REPO / 'android/local.properties').write_text('sdk.dir=' + CONFIG['android_sdk'].replace('\\', '/') + '\nflutter.sdk=' + CONFIG['flutter_root'].replace('\\', '/') + '\n', encoding='ascii')
    run('flutter-version', [FLUTTER, '--version'])
    run('java-version', [Path(CONFIG['java_home']) / 'bin/java.exe', '-version'])
    run('pub-get', [FLUTTER, 'pub', 'get', '--offline'])
    run('translations', [sys.executable, 'tools/generate_translations.py', '--check', '--require-all'])
    run('validation-docs', [sys.executable, 'tools/check_validation.py'])
    run('source-integrity', [sys.executable, 'tools/package_android_sources.py', '--check'])
    # x86_64 is shipped so x86 devices never run the ARM WireGuard runtime under translation
    # (Go 1.26.9 procyieldAsm reads CNTFRQ_EL0, which ndk_translation 0.2.3 rejects).
    run('build-aab', [FLUTTER, 'build', 'appbundle', '--release', '--no-pub', '--target-platform', 'android-arm64,android-arm,android-x64', '--android-project-arg=fuzevpn.usePatchedWireGuardAar=true'])
    source_guard()
    shutil.copyfile(REPO / 'build/app/outputs/bundle/release/app-release.aab', DELIVERY / f'FuzeVPN-Android-v{VERSION_CODE}-release-unsigned.aab')
    shutil.copyfile(REPO / 'build/app/outputs/mapping/release/mapping.txt', DELIVERY / f'FuzeVPN-Android-v{VERSION_CODE}-aab-mapping.txt')
    save('build-output.json', {'unsigned_aab_sha256': sha(DELIVERY / f'FuzeVPN-Android-v{VERSION_CODE}-release-unsigned.aab'), 'mapping_sha256': sha(DELIVERY / f'FuzeVPN-Android-v{VERSION_CODE}-aab-mapping.txt'), 'source_clean': True})

def success_receipt(name):
    record = json.loads(child(REPORT, name + '.result.json').read_text(encoding='utf-8'))
    require(record['name'] == name and record['exit_code'] == 0, 'Required command failed: ' + name)
    require(record['log_sha256'] == sha(child(REPORT, record['log'])), 'Command log changed: ' + name)
    return record

def local_validation():
    """Recompute canonical counts and freshness; never trust a copied PASS alone."""
    output_guard()
    receipt = success_receipt('project-validation')
    start, finish = instant(receipt['started_utc']), instant(receipt['finished_utc'])
    require(start <= finish, 'Validation clock bounds are invalid')
    directory = REPORT/'local-validation'
    reject_links(directory)
    spec = importlib.util.spec_from_file_location('maintained_validation_support', REPO/'tools/validation_support.py')
    support = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(support)
    steps = json.loads(child(directory, 'steps.json').read_text(encoding='utf-8-sig'))
    proof_files = {directory/'steps.json', directory/'summary.json', directory/'java-version.txt',
                   directory/'lint-results-debug.xml', directory/'lint-vital-release.txt'}
    for step in steps:
        begin, end = instant(step['startedAt']), instant(step['finishedAt'])
        require(start <= begin <= end <= finish, 'Validation step belongs to another run')
        log = Path(step['log']).absolute()
        reject_links(log)
        require(log.parent == directory, 'Validation log escaped this report')
        proof_files.add(log)
    reject_links(directory/'junit')
    proof_files.update((directory/'junit').glob('*.xml'))
    proof_files.update(directory/name/'results.json' for name in ('wireguard-gate', 'dependency-integrity'))
    for name, filenames in support.HOST_BOUNDARY_FILES.items():
        proof_files.update(directory/name/filename for filename in filenames)
    proof = []
    for path in sorted(proof_files):
        reject_links(path)
        support.fresh_file(path, start)
        proof.append({'path': path.relative_to(directory).as_posix(), 'sha256': sha(path)})
    data = support.summarize(directory)
    recorded = json.loads(child(directory, 'summary.json').read_text(encoding='utf-8-sig'))
    require(recorded.get('status') == 'passed' and recorded.get('checks') == data['checks'], 'Canonical validation receipt differs from recomputed results')
    generated = instant(recorded['generatedAt'])
    require(start <= generated <= finish, 'Canonical summary is outside this validation run')
    return data, proof

def validate():
    source_guard()
    output_guard()
    require(not (REPORT/'local-validation').exists(), 'Choose a new validation directory; no stale receipts may be reused')
    run('project-validation', [PWSH, '-NoProfile', '-File', REPO/'tools/validate_project.ps1',
        '-FlutterRoot', CONFIG['flutter_root'], '-JavaHome', CONFIG['java_home'],
        '-AndroidSdk', CONFIG['android_sdk'], '-PythonExecutable', sys.executable,
        '-OutputDirectory', REPORT/'local-validation'])
    data, proof = local_validation()
    save('project-validation.coverage.json', {'status': 'PASS', 'commit': PIN, 'checks': data['checks'], 'proof': proof})
    source_guard()

def load_qualifier():
    spec = importlib.util.spec_from_file_location('preserved_release_qualifier', KIT / 'outils/qualifier-release.py')
    mod = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(mod)
    return mod

def qualify():
    source_guard()
    original = DELIVERY / f'FuzeVPN-Android-v{VERSION_CODE}-release-unsigned.aab'
    signed = DELIVERY / f'FuzeVPN-Android-v{VERSION_CODE}-release-upload-signed.aab'
    run('sign-aab', [sys.executable, KIT / 'outils/signer-release.py', '--kind', 'aab', '--input', original, '--output', signed, '--expected-sha256', sha(original), '--report', REPORT])
    mod = load_qualifier()
    q = mod.Qualification(types.SimpleNamespace(source=REPO, delivery=DELIVERY, report=REPORT / 'qualification-aab.json'))
    q.data['scope'] = 'AAB-only delivery: same preserved checks; independent split-APK receipts are not required for this scope'
    q.data['commit'] = PIN

    def required(name, fn):
        result = q.check(name, fn)
        if result is None:
            save('qualification-aab-failure.json', q.data)
            raise RuntimeError('Qualification failed: ' + name)
        print('PASS: ' + name, flush=True)
        return result
    required('prerequisites', q.prerequisites)
    require(sha(q.bundletool) == 'a099cfa1543f55593bc2ed16a70a7c67fe54b1747bb7301f37fdfd6d91028e29', 'Release guard failed at original line 167')
    required('source_git_and_documented_criteria', q.source_control)
    receipt = json.loads((REPORT / (signed.name + '.signature.json')).read_text())
    require(receipt['kind'] == 'aab' and receipt['status'] == 'PASS', 'Release guard failed at original line 170')
    require(receipt['signature_verified'] and receipt['payload_unchanged'], 'Release guard failed at original line 171')
    require(Path(receipt['input']) == original and Path(receipt['output']) == signed, 'Release guard failed at original line 172')
    require(receipt['certificate_sha256'] == q.expected_certificate, 'Release guard failed at original line 173')
    require(receipt['unsigned_sha256'] == sha(original) and receipt['signed_sha256'] == sha(signed), 'Release guard failed at original line 174')
    require(receipt['bytes'] == signed.stat().st_size, 'Release guard failed at original line 175')
    required('signed_bundle_payload', lambda: mod.payload_comparison(original, signed, 'aab'))
    bundle = {'path': str(signed), 'kind': 'aab', 'sha256': sha(signed), 'bytes': signed.stat().st_size}
    bundle['signature'] = required('aab:signature', lambda: q.bundle_signature(signed))
    bundle['manifest'] = required('aab:manifest', lambda: q.bundle_manifest(signed))
    bundle['native'] = required('aab:native', lambda: mod.native_inventory(signed, mod.ARM_ABIS, apk=False, required_names=q.required_libraries))
    bundle['mapping'] = required('aab:mapping', lambda: q.bundle_mapping(signed))
    bundle['status'] = 'PASS'
    q.data['artifacts'].append(bundle)
    required('bundletool_universal_generation', lambda: q.universal(signed))
    with zipfile.ZipFile(signed) as aab, zipfile.ZipFile(DELIVERY / f'FuzeVPN-Android-v{VERSION_CODE}-universal.apk') as apk:
        pairs = [{'aab_entry': name, 'apk_entry': name.removeprefix('base/'), 'sha256': hashlib.sha256(aab.read(name)).hexdigest(), 'same_bytes': aab.read(name) == apk.read(name.removeprefix('base/'))} for name in aab.namelist() if name.startswith('base/lib/') and name.endswith('.so')]
        require(len(pairs) == len(mod.ARM_ABIS)*len(q.required_libraries) and all(item['same_bytes'] for item in pairs), 'Native payload differs between AAB and generated APK')
    required('aab_and_generated_apk_native_identity', lambda: {'libraries': pairs, 'all_identical': True})
    required('source_unchanged_after_qualification', q.source_control)
    q.data['inventory'] = required('delivery_sha256_inventory', q.inventory)
    q.data['status'] = 'PASS'
    q.data['finished_utc'] = datetime.now(timezone.utc).isoformat()
    save('qualification-aab.json', q.data)
    print('PASS: AAB signed and qualified', flush=True)

def export():
    source_guard()
    run('source-export', [sys.executable, 'tools/package_android_sources.py', '--output', DELIVERY / f'FuzeVPN-Android-v{VERSION_CODE}-sources.tar.gz', '--apk', DELIVERY / f'FuzeVPN-Android-v{VERSION_CODE}-universal.apk'])
    save('bundle-source-association.json', {'commit': PIN, 'tree': git('rev-parse', 'HEAD^{tree}'), 'signed_aab': f'FuzeVPN-Android-v{VERSION_CODE}-release-upload-signed.aab', 'signed_aab_sha256': sha(DELIVERY / f'FuzeVPN-Android-v{VERSION_CODE}-release-upload-signed.aab'), 'source_archive': f'FuzeVPN-Android-v{VERSION_CODE}-sources.tar.gz', 'source_archive_sha256': sha(DELIVERY / f'FuzeVPN-Android-v{VERSION_CODE}-sources.tar.gz'), 'derived_universal_apk_sha256': sha(DELIVERY / f'FuzeVPN-Android-v{VERSION_CODE}-universal.apk'), 'method': 'Local recorded build of the clean pinned commit; source archive records the generated qualification APK.'})
    with (DELIVERY / 'SHA256SUMS').open('x', encoding='ascii') as out:
        for path in sorted(DELIVERY.iterdir()):
            if path.is_file() and path.name != 'SHA256SUMS':
                out.write(sha(path) + '  ' + path.name + '\n')
    source_guard()
    save('source-export.complete.json', {'commit': PIN, 'tree': git('rev-parse', 'HEAD^{tree}'),
        'delivery_hashes': delivery_inventory(), 'inventory_sha256': sha(child(DELIVERY, 'SHA256SUMS'))})

def finalize():
    source_guard()
    public_tag_guard()
    output_guard()
    evidence = release_evidence()
    expected = ['flutter-version', 'java-version', 'pub-get', 'translations', 'validation-docs',
                'source-integrity', 'build-aab', 'sign-aab', 'project-validation', 'source-export']
    checks = [success_receipt(name) for name in expected]
    validation, proof = local_validation()
    coverage = json.loads(child(REPORT, 'project-validation.coverage.json').read_text(encoding='utf-8'))
    require(coverage.get('status') == 'PASS' and coverage.get('commit') == PIN and
            coverage.get('checks') == validation['checks'] and coverage.get('proof') == proof,
            'Canonical validation coverage changed after execution')
    qualification, comparison = evidence['qualification'], evidence['comparison']
    save('config-build-selected.json', CONFIG)
    record = {'status': 'PASS', 'version': f'{VERSION_NAME}+{VERSION_CODE}', 'source_commit': PIN,
        'source_tree': evidence['tree'], 'code_checks_executed': True,
        'validation_scope': validation['scope'], 'validation_checks': validation['checks'],
        'validation_proof': proof, 'qualification_checks_passed': len(qualification['checks']),
        'compared_payload_entries_identical': comparison['identical_entries'],
        'certificate_sha256': qualification['certificate_sha256'], 'signed_aab_sha256': evidence['signed_aab_sha256'],
        'delivery': str(DELIVERY), 'checks': checks, 'finished_utc': datetime.now(timezone.utc).isoformat(),
        'play_upload': False, 'backend_changes': False, 'vms_started': 0, 'limitations': qualification['limitations']}
    save('release-validation.json', record)
    print(json.dumps({k: v for k, v in record.items() if k not in ['checks', 'limitations']}, ensure_ascii=False))

def compare():
    source_guard()
    require(TESTED_APK is not None, '--tested-apk is required for payload comparison')
    signed = DELIVERY / f'FuzeVPN-Android-v{VERSION_CODE}-release-upload-signed.aab'
    with zipfile.ZipFile(signed) as aab, zipfile.ZipFile(TESTED_APK) as apk:
        names = sorted(n for n in aab.namelist() if not n.endswith('/') and
                       (n.startswith('base/assets/flutter_assets/') or
                        (n.startswith('base/dex/') and n.endswith('.dex')) or
                        (n.startswith('base/lib/') and n.endswith('.so'))))
        require(bool(names), 'No comparable payload entries')
        entries = []
        for name in names:
            target = name.removeprefix('base/dex/') if name.startswith('base/dex/') else name.removeprefix('base/')
            data = aab.read(name)
            require(target in apk.namelist(), 'Reference APK payload entry is missing: ' + target)
            entries.append({'aab_entry': name, 'tested_apk_entry': target, 'new_sha256': hashlib.sha256(data).hexdigest(), 'same_bytes': data == apk.read(target)})
        require(all((x['same_bytes'] for x in entries)), 'Payload differs from the reference tested APK')
    save('payload-comparison-vs-tested-apk.json', {'tested_apk_sha256': sha(TESTED_APK), 'aab_sha256': sha(signed), 'compared_entries': len(entries), 'identical_entries': len(entries), 'native_identical': sum((x['aab_entry'].startswith('base/lib/') for x in entries)), 'entries': entries})

def main(argv=None):
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('stage', choices=['build', 'validate', 'qualify', 'compare', 'export', 'finalize'])
    parser.add_argument('--kit', required=True)
    parser.add_argument('--source', default=str(Path(__file__).resolve().parents[1]))
    parser.add_argument('--run-name', required=True)
    parser.add_argument('--expected-commit', required=True)
    parser.add_argument('--tested-apk')
    parser.add_argument('--powershell')
    args = parser.parse_args(argv)
    configure(args)
    source_guard()
    globals()[args.stage]()
    return 0
if __name__ == '__main__':
    try:
        raise SystemExit(main())
    except (RuntimeError, OSError, ValueError, KeyError) as error:
        print('FAIL: ' + str(error), file=sys.stderr)
        raise SystemExit(2)
