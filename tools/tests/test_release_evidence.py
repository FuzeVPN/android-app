# SPDX-License-Identifier: Apache-2.0
"""Synthetic fixtures only. No build, signing, VM, production, or private kit."""
import ast
import contextlib
from datetime import datetime, timedelta, timezone
import hashlib
import importlib.util
import io
import json
import os
from pathlib import Path
import shutil
import stat
import subprocess
import tempfile
from types import SimpleNamespace
import unittest
from unittest import mock
import zipfile

TOOLS = Path(__file__).resolve().parents[1]
WIREGUARD_GATE_CASES = (
    'release-config-no-flag', 'release-config-false', 'profile-config-no-flag', 'profile-config-false',
    'release-apk-no-flag', 'release-bundle-false', 'profile-apk-false', 'profile-bundle-no-flag',
    'debug-config-maven', 'release-config-approved', 'profile-config-approved', 'debug-config-approved',
    'warm-release-false', 'combined-debug-release-no-flag', 'dependencies-no-flag', 'dependencies-approved',
    'native-libraries-approved')

def load(name):
    spec = importlib.util.spec_from_file_location('test_' + name, TOOLS/(name+'.py'))
    module = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(module)
    return module

class MaintainedReleaseTest(unittest.TestCase):
    def setUp(self):
        self.module = load('release_aab_safe')
        temporary = tempfile.TemporaryDirectory()
        self.addCleanup(temporary.cleanup)
        self.root = Path(temporary.name)
        self.module.REPO = self.root
        self.module.KIT = self.root
        self.module.REPORT = self.root/'report'
        self.module.DELIVERY = self.root/'delivery'
        self.module.REPORT.mkdir()
        self.module.DELIVERY.mkdir()
        self.module.PIN = 'a'*40
        self.module.VERSION_NAME = '1.2.3'
        self.module.VERSION_CODE = 123
        self.module.EXPECTED_FLUTTER = 2
        self.module.CONFIG = {'source_commit': 'a'*40, 'source_repository': 'https://example.invalid/repository.git'}
        self.module.ENV = {}
        (self.root/'pubspec.yaml').write_text('version: 1.2.3+123\n', encoding='utf-8')
        # The licences page link: source_repository without .git must be this repository.
        (self.root/'lib/widgets').mkdir(parents=True)
        (self.root/'lib/widgets/third_party_notices.dart').write_text(
            "const String sourceCodeRepository = 'https://example.invalid/repository';\n", encoding='utf-8')

    def canonical_fixture(self):
        (self.root/'tools').mkdir()
        shutil.copyfile(TOOLS/'validation_support.py', self.root/'tools/validation_support.py')
        directory = self.module.REPORT/'local-validation'
        directory.mkdir()
        now = datetime.now(timezone.utc)
        names = ['toolchain', 'pub-offline', 'translations', 'google-sdk-notices', 'flutter-analyze', 'flutter-test', 'flutter-fonts',
            'python-tests', 'buildsrc', 'android-test-lint', 'wireguard-gate', 'dependency-integrity',
            'build-provenance', 'wireguard-protected-start', 'openvpn-state', 'openvpn-network', 'openvpn-boundaries',
            'source-export', 'evidence-registry', 'isolated-configuration', 'turnstile-bridge', 'command-epochs', 'bridge-host']
        steps = []
        for name in names:
            log = directory/(name+'.log')
            log.write_text('synthetic boundary', encoding='utf-8')
            steps.append({'name': name, 'exitCode': 0, 'log': str(log),
                'startedAt': (now-timedelta(seconds=4)).isoformat(), 'finishedAt': (now-timedelta(seconds=1)).isoformat()})
        (directory/'steps.json').write_text(json.dumps(steps), encoding='utf-8')
        events = [{'type': 'testDone', 'hidden': False, 'result': 'success', 'skipped': False}, {'type': 'done', 'success': True}]
        (directory/'flutter-test.log').write_text('\n'.join(map(json.dumps, events)), encoding='utf-8')
        font_names = ['APP10 recovery controls remain reachable'] + [f'disconnected status keeps its word {i}' for i in range(6)]
        fonts = []
        for name in font_names:
            fonts += [{'type': 'testStart', 'test': {'name': name}}, events[0]]
        fonts.append(events[1])
        (directory/'flutter-fonts.log').write_text('\n'.join(map(json.dumps, fonts)), encoding='utf-8')
        (directory/'python-tests.log').write_text('Ran 1 test in 0.01s\n\nOK\n', encoding='utf-8')
        (directory/'buildsrc.log').write_text('AndroidManifestPolicy: 1 checks passed\nNativeBundlePolicy: 1 checks passed\nWireGuard AAR policy: 1 tests passed\n', encoding='utf-8')
        (directory/'java-version.txt').write_text('synthetic JDK metadata', encoding='utf-8')
        (directory/'lint-results-debug.xml').write_text('<issues/>', encoding='utf-8')
        (directory/'lint-vital-release.txt').write_text('No issues found.\n', encoding='utf-8')
        (directory/'junit').mkdir()
        junit = directory/'junit/TEST-fixture.xml'
        junit.write_text('<testsuite name="fixture" tests="1" failures="0" errors="0" skipped="0"><testcase classname="fixture" name="case"/></testsuite>', encoding='utf-8')
        # The 17 named cases of tools/test_wireguard_release_gate.ps1, as it writes them.
        gate = []
        for name in WIREGUARD_GATE_CASES:
            rejected = not name.startswith(('debug-', 'dependencies-', 'native-')) and not name.endswith('-approved')
            gate.append({'name': name, 'passed': True, 'expectedRejection': rejected, 'exitCode': 1 if rejected else 0})
        gate[-1]['nativeLibraries'] = ['libc++_shared.so', 'libflutter.so', 'libfuzevpn_openvpn.so', 'libwg-go.so']
        (directory/'wireguard-gate').mkdir()
        (directory/'wireguard-gate/results.json').write_text(json.dumps(gate), encoding='utf-8')
        (directory/'dependency-integrity').mkdir()
        (directory/'dependency-integrity/results.json').write_text(json.dumps([{'passed': True}]*4), encoding='utf-8')
        # Cases executed by each host suite on 30/10/2026 (validation_support minimums).
        for name, count in [('turnstile-bridge', 44), ('command-epochs', 27), ('bridge-host', 94)]:
            folder = directory/name
            folder.mkdir()
            (folder/'compile.log').write_text('synthetic compilation success', encoding='utf-8')
            log = 'junit.log' if name == 'turnstile-bridge' else 'result.log'
            (folder/log).write_text('JUnit version 4.13.2\n'+'.'*count+'\nTime: 0.01\n\nOK ('+str(count)+' tests)\n', encoding='utf-8')
            if name == 'turnstile-bridge':
                record = {'startedAt': (now-timedelta(seconds=3)).isoformat(),
                          'finishedAt': (now-timedelta(seconds=1)).isoformat(),
                          'compileExitCode': 0, 'junitExitCode': 0, 'javascriptExitCode': 0}
                (folder/'javascript.log').write_text('Generated HTML/JavaScript: PASS (20 scenarios, no network)\n', encoding='utf-8')
                receipt = 'result.json'
            else:
                record = {'started_utc': (now-timedelta(seconds=3)).isoformat(),
                          'ended_utc': (now-timedelta(seconds=1)).isoformat(),
                          'junit_exit_code': 0, 'expect_failure': False}
                receipt = 'execution.json'
            (folder/receipt).write_text(json.dumps(record), encoding='utf-8')
        helper = load('validation_support')
        data = helper.summarize(directory)
        (directory/'summary.json').write_text(json.dumps(data), encoding='utf-8')
        log = self.module.REPORT/'project-validation.txt'
        log.write_text('synthetic canonical validation', encoding='utf-8')
        (self.module.REPORT/'project-validation.result.json').write_text(json.dumps({
            'name': 'project-validation', 'exit_code': 0, 'log': log.name, 'log_sha256': self.module.sha(log),
            'started_utc': (now-timedelta(seconds=5)).isoformat(), 'finished_utc': (now+timedelta(seconds=5)).isoformat()}), encoding='utf-8')
        return directory, junit

    def release_fixture(self):
        prefix = 'FuzeVPN-Android-v123-'
        for name in self.module.delivery_names():
            content = b'synthetic mapping' if name.endswith('mapping.txt') else ('synthetic '+name).encode()
            (self.module.DELIVERY/name).write_bytes(content)
        hashes = {name: self.module.sha(self.module.DELIVERY/name) for name in self.module.delivery_names()}
        manifest = self.module.DELIVERY/'SHA256SUMS'
        manifest.write_text(''.join(f'{hashes[name]}  {name}\n' for name in sorted(hashes)), encoding='ascii')
        unsigned, signed, apk = (prefix+'release-unsigned.aab', prefix+'release-upload-signed.aab', prefix+'universal.apk')
        self.module.TESTED_APK = self.root/'tested.apk'
        self.module.TESTED_APK.write_bytes(b'synthetic tested APK')
        documents = {
            'build-inputs.json': {'commit': 'a'*40, 'tree': 'c'*40, 'version': '1.2.3', 'version_code': 123,
                'repository': self.module.CONFIG['source_repository'], 'source': str(self.root),
                'checks_skipped': False, 'fuzevpn.usePatchedWireGuardAar': True},
            'build-output.json': {'unsigned_aab_sha256': hashes[unsigned], 'mapping_sha256': hashes[prefix+'aab-mapping.txt'], 'source_clean': True},
            signed+'.signature.json': {'kind': 'aab', 'status': 'PASS', 'signature_verified': True, 'payload_unchanged': True,
                'input': str(self.module.DELIVERY/unsigned), 'output': str(self.module.DELIVERY/signed),
                'unsigned_sha256': hashes[unsigned], 'signed_sha256': hashes[signed],
                'bytes': (self.module.DELIVERY/signed).stat().st_size, 'certificate_sha256': 'f'*64},
            'qualification-aab.json': {'commit': 'a'*40, 'source': str(self.root), 'delivery': str(self.module.DELIVERY),
                'status': 'PASS', 'certificate_sha256': 'f'*64, 'limitations': ['synthetic fixtures only'],
                'checks': [{'name': 'aab_and_generated_apk_native_identity', 'status': 'PASS',
                    'detail': {'all_identical': True, 'libraries': [{'same_bytes': True}]}}],
                'artifacts': [{'path': str(self.module.DELIVERY/name), 'kind': kind, 'sha256': hashes[name],
                    'bytes': (self.module.DELIVERY/name).stat().st_size, 'status': 'PASS'} for name, kind in [(signed, 'aab'), (apk, 'universal-apk')]]},
            'payload-comparison-vs-tested-apk.json': {'aab_sha256': hashes[signed], 'tested_apk_sha256': self.module.sha(self.module.TESTED_APK),
                'compared_entries': 1, 'identical_entries': 1, 'native_identical': 1,
                'entries': [{'aab_entry': 'base/lib/arm64-v8a/fixture.so', 'same_bytes': True}]},
            'bundle-source-association.json': {'commit': 'a'*40, 'tree': 'c'*40, 'signed_aab': signed,
                'signed_aab_sha256': hashes[signed], 'source_archive': prefix+'sources.tar.gz',
                'source_archive_sha256': hashes[prefix+'sources.tar.gz'], 'derived_universal_apk_sha256': hashes[apk]},
            'source-export.complete.json': {'commit': 'a'*40, 'tree': 'c'*40,
                'delivery_hashes': hashes, 'inventory_sha256': self.module.sha(manifest)},
        }
        for name, data in documents.items():
            (self.module.REPORT/name).write_text(json.dumps(data), encoding='utf-8')
        return documents, hashes

    def check_release(self):
        with mock.patch.object(self.module, 'git', return_value='c'*40):
            return self.module.release_evidence()

    def replace_document(self, name, document):
        (self.module.REPORT/name).write_text(json.dumps(document), encoding='utf-8')

    def git_reply(self, *args):
        return {'rev-parse': 'a'*40, 'status': '', 'remote': 'https://example.invalid/repository.git'}[args[0]]

    def test_import_has_no_configuration_or_external_action(self):
        with (mock.patch.object(Path, 'read_text', side_effect=AssertionError('unexpected file read')),
              mock.patch.object(subprocess, 'run', side_effect=AssertionError('unexpected process'))):
            self.assertIsNone(load('release_aab_safe').CONFIG)

    def test_source_guard_rejects_each_different_source_even_with_optimization(self):
        with mock.patch.object(self.module, 'git', side_effect=self.git_reply):
            self.module.source_guard()
        variants = [('rev-parse', 'b'*40), ('status', ' M changed'), ('remote', 'https://wrong.invalid/r.git')]
        for command, wrong in variants:
            def changed(*args):
                return wrong if args[0] == command else self.git_reply(*args)
            with self.subTest(command=command), mock.patch.object(self.module, 'git', side_effect=changed):
                with self.assertRaises(RuntimeError):
                    self.module.source_guard()

    def test_configuration_and_version_guards_survive_optimization(self):
        with mock.patch.object(self.module, 'git', side_effect=self.git_reply):
            self.module.CONFIG['source_commit'] = 'b'*40
            with self.assertRaises(RuntimeError):
                self.module.source_guard()
            self.module.CONFIG['source_commit'] = 'a'*40
            (self.root/'pubspec.yaml').write_text('version: 1.2.3+124\n', encoding='utf-8')
            with self.assertRaises(RuntimeError):
                self.module.source_guard()

    def test_no_assert_statement_remains_in_maintained_tool(self):
        tree = ast.parse((TOOLS/'release_aab_safe.py').read_text(encoding='utf-8'))
        self.assertFalse(any(isinstance(node, ast.Assert) for node in ast.walk(tree)))
        with self.assertRaises(RuntimeError):
            self.module.require(False, 'failed explicitly')

    def test_finalize_never_writes_pass_for_failed_receipt(self):
        log = self.module.REPORT/'flutter-version.txt'
        log.write_text('synthetic failure', encoding='utf-8')
        (self.module.REPORT/'flutter-version.result.json').write_text(json.dumps({
            'name': 'flutter-version', 'exit_code': 1, 'log': log.name, 'log_sha256': self.module.sha(log)}), encoding='utf-8')
        # The published tag is faked so that only the failed receipt can refuse.
        with (mock.patch.object(self.module, 'source_guard'), mock.patch.object(self.module, 'release_evidence', return_value={}),
              mock.patch.object(self.module, 'git', return_value='a'*40+'\trefs/tags/v1.2.3'),
              mock.patch.object(self.module, 'git_network', return_value='a'*40+'\trefs/tags/v1.2.3'),
              mock.patch.object(subprocess, 'run', side_effect=AssertionError('external action'))):
            with self.assertRaisesRegex(RuntimeError, 'Required command failed: flutter-version'):
                self.module.finalize()
        self.assertFalse((self.module.REPORT/'release-validation.json').exists())

    def finalize_with_tag_listing(self, listing):
        """finalize() on accepted synthetic receipts; only the anonymous tag listing varies."""
        self.ls_remote = []
        def fake_git(*args, **options):
            if 'ls-remote' not in args:
                return self.git_reply(*args)
            self.ls_remote.append((args, options))
            if isinstance(listing, Exception):
                raise listing
            return listing
        validation = {'scope': 'synthetic', 'checks': {'fixture': True}}
        evidence = {'tree': 'c'*40, 'signed_aab_sha256': 'e'*64, 'comparison': {'identical_entries': 1},
                    'qualification': {'checks': [{'status': 'PASS'}], 'certificate_sha256': 'f'*64, 'limitations': []}}
        for path in self.module.REPORT.iterdir():
            path.unlink()
        coverage = self.module.REPORT/'project-validation.coverage.json'
        coverage.write_text(json.dumps({'status': 'PASS', 'commit': 'a'*40, 'checks': validation['checks'], 'proof': []}), encoding='utf-8')
        with (mock.patch.object(self.module, 'git', side_effect=fake_git),
              mock.patch.object(self.module, 'git_network', side_effect=fake_git),
              mock.patch.object(self.module, 'release_evidence', return_value=evidence),
              mock.patch.object(self.module, 'success_receipt', side_effect=lambda name: {'name': name, 'exit_code': 0}),
              mock.patch.object(self.module, 'local_validation', return_value=(validation, [])),
              mock.patch.object(subprocess, 'run', side_effect=AssertionError('external action')),
              contextlib.redirect_stdout(io.StringIO())):
            self.module.finalize()

    def assert_refused_before_any_receipt(self):
        self.assertEqual(['project-validation.coverage.json'], [path.name for path in self.module.REPORT.iterdir()])

    def test_finalize_refuses_unpublished_source_tag(self):
        # D4 PUBLIC-SOURCE-TAG-404: the licences page links tree/v<versionName>.
        with self.assertRaisesRegex(RuntimeError, 'v1.2.3 is not published'):
            self.finalize_with_tag_listing('')
        self.assert_refused_before_any_receipt()

    def test_finalize_refuses_source_tag_on_another_commit(self):
        listings = {'lightweight': 'b'*40+'\trefs/tags/v1.2.3',
                    'annotated': 'd'*40+'\trefs/tags/v1.2.3\n'+'b'*40+'\trefs/tags/v1.2.3^{}'}
        for kind, listing in listings.items():
            with self.subTest(kind=kind):
                with self.assertRaisesRegex(RuntimeError, 'another commit'):
                    self.finalize_with_tag_listing(listing)
                self.assert_refused_before_any_receipt()

    def test_finalize_refuses_when_anonymous_read_fails(self):
        # Not public (git exits 128), or a stalled HTTPS read stopped after PUBLIC_TAG_TIMEOUT.
        for error in (subprocess.CalledProcessError(128, ['git', 'ls-remote']), subprocess.TimeoutExpired(['git', 'ls-remote'], 60)):
            with self.subTest(error=type(error).__name__):
                with self.assertRaisesRegex(RuntimeError, 'Anonymous read'):
                    self.finalize_with_tag_listing(error)
                self.assert_refused_before_any_receipt()

    def test_finalize_refuses_unexpected_public_tag_listing(self):
        # Only '<40 hex>\t<requested ref>' lines, once each; nothing is skipped or guessed.
        published = 'a'*40+'\trefs/tags/v1.2.3'
        listings = {'decoy tag': published+'\n'+'a'*40+'\trefs/tags/v1.2.30',
                    'short SHA': published+'\n'+'a'*39+'\trefs/tags/v1.2.3^{}',
                    'non-hex SHA': 'g'*40+'\trefs/tags/v1.2.3',
                    'duplicate line': published+'\n'+published,
                    'space separated': 'a'*40+' refs/tags/v1.2.3'}
        for kind, listing in listings.items():
            with self.subTest(kind=kind):
                with self.assertRaisesRegex(RuntimeError, 'Unexpected public tag listing'):
                    self.finalize_with_tag_listing(listing)
                self.assert_refused_before_any_receipt()

    def test_finalize_refuses_repository_the_application_does_not_link(self):
        # A mirror or fork can carry the tag while the licences page link (tree/v<version>) stays 404.
        notices = self.root/'lib/widgets/third_party_notices.dart'
        mirror = 'https://example.invalid/mirror.git'
        cases = {'mirror': (mirror, notices.read_text(encoding='utf-8')),
                 'no declaration': ('https://example.invalid/repository.git', "// sourceCodeRepository = 'https://example.invalid/repository';\n")}
        for kind, (repository, dart) in cases.items():
            with self.subTest(kind=kind):
                self.module.CONFIG['source_repository'] = repository
                self.git_reply = lambda *args: {'rev-parse': 'a'*40, 'status': '', 'remote': repository}[args[0]]
                notices.write_text(dart, encoding='utf-8')
                with self.assertRaisesRegex(RuntimeError, 'the one the application links'):
                    self.finalize_with_tag_listing('a'*40+'\trefs/tags/v1.2.3')
                self.assertEqual([], self.ls_remote)
                self.assert_refused_before_any_receipt()

    def test_linked_repository_is_read_from_the_application_source(self):
        # lib/widgets/third_party_notices.dart as shipped: only its repository, with or without .git, is accepted.
        self.module.REPO = TOOLS.parent
        listing = 'a'*40+'\trefs/tags/v1.2.3'
        with (mock.patch.object(self.module, 'git', return_value=listing), mock.patch.object(self.module, 'git_network', return_value=listing),
              mock.patch.object(subprocess, 'check_output', side_effect=AssertionError('external action'))):
            for repository in ('https://github.com/FuzeVPN/android-app.git', 'https://github.com/FuzeVPN/android-app'):
                self.module.CONFIG['source_repository'] = repository
                self.module.public_tag_guard()
            for repository in ('https://github.com/other/android-app.git', 'https://github.com/FuzeVPN/android-app.git.git',
                               'https://github.com/FuzeVPN/android-app/'):
                self.module.CONFIG['source_repository'] = repository
                with self.subTest(repository=repository), self.assertRaisesRegex(RuntimeError, 'the one the application links'):
                    self.module.public_tag_guard()

    def test_anonymous_read_ignores_operator_git_settings(self):
        # Origin's URL from an empty directory: no system, global or repository configuration, operator GIT_*
        # variable (GIT_DIR, GIT_CONFIG_*), askpass or .netrc (HOME/USERPROFILE) can authenticate the read.
        self.module.ENV = {'PATH': 'synthetic', 'HOME': 'operator-home', 'USERPROFILE': 'operator-profile',
                           'GIT_DIR': 'operator-repository', 'GIT_ASKPASS': 'synthetic', 'SSH_ASKPASS': 'synthetic',
                           'GIT_CONFIG_PARAMETERS': "'http.extraheader'='synthetic'", 'GIT_CONFIG_COUNT': '1',
                           'GIT_CONFIG_KEY_0': 'http.extraHeader', 'GIT_CONFIG_VALUE_0': 'synthetic'}
        started = []
        class Git:
            """subprocess.Popen stand-in: records how git is started and answers with a published tag."""
            returncode = 0
            def __init__(self, command, **options):
                home = Path(options['env']['HOME'])
                started.append((command, options, sorted(home.iterdir()), Path(options['env']['GIT_CONFIG_GLOBAL']).read_bytes()))
            def __enter__(self):
                return self
            def __exit__(self, *error):
                return False
            def communicate(self, timeout=None):
                started.append(timeout)
                return 'a'*40+'\trefs/tags/v1.2.3\n', None
        with (mock.patch.object(subprocess, 'Popen', Git),
              mock.patch.object(subprocess, 'check_output', side_effect=AssertionError('untimed git'))):
            self.module.public_tag_guard()
        (command, options, home_entries, global_config), timeout = started
        home = Path(options['env']['HOME'])
        self.assertEqual(['git', '-c', 'credential.helper=', '-c', 'credential.https://github.com.helper=', '-c', 'core.askPass=',
                          '-c', 'http.extraHeader=', 'ls-remote', '--tags', 'https://example.invalid/repository.git',
                          'refs/tags/v1.2.3', 'refs/tags/v1.2.3^{}'], command)
        self.assertEqual({'PATH': 'synthetic', 'GIT_TERMINAL_PROMPT': '0', 'GCM_INTERACTIVE': 'Never', 'GIT_CONFIG_NOSYSTEM': '1',
                          'GIT_CONFIG_GLOBAL': str(home.parent/'gitconfig'), 'GIT_CEILING_DIRECTORIES': str(home.parent),
                          'HOME': str(home), 'USERPROFILE': str(home)}, options['env'])
        self.assertEqual(([], b''), (home_entries, global_config))
        self.assertEqual((home, subprocess.DEVNULL, subprocess.PIPE), (options['cwd'], options['stdin'], options['stdout']))
        self.assertEqual(60, timeout)
        self.assertFalse(home.parent.exists())

    def test_anonymous_read_timeout_stops_the_git_process_tree(self):
        # Git for Windows' cmd\git.exe runs the real git.exe; killing only the wrapper leaves the pipe open.
        events = []
        class Git:
            """subprocess.Popen stand-in for a stalled HTTPS read."""
            pid, returncode = 4242, None
            def __init__(self, command, **options):
                events.append('start')
            def __enter__(self):
                return self
            def __exit__(self, *error):
                return False
            def communicate(self, timeout=None):
                if timeout is not None:
                    raise subprocess.TimeoutExpired('git', timeout)
                events.append('drained')
                return '', None
            def kill(self):
                events.append('kill')
        with (mock.patch.object(subprocess, 'Popen', Git),
              mock.patch.object(subprocess, 'check_output', side_effect=AssertionError('untimed git')),
              mock.patch.object(subprocess, 'run', side_effect=lambda command, **options: events.append(command))):
            with self.assertRaisesRegex(RuntimeError, 'Anonymous read') as refused:
                self.module.public_tag_guard()
        self.assertIsInstance(refused.exception.__cause__, subprocess.TimeoutExpired)
        tree = [['taskkill', '/T', '/F', '/PID', '4242']] if os.name == 'nt' else []
        self.assertEqual(['start', *tree, 'kill', 'drained'], events)

    def test_finalize_refuses_origin_without_anonymous_https_read(self):
        ssh = 'git@example.invalid:repository.git'
        self.module.CONFIG['source_repository'] = ssh
        self.git_reply = lambda *args: {'rev-parse': 'a'*40, 'status': '', 'remote': ssh}[args[0]]
        with self.assertRaisesRegex(RuntimeError, 'HTTPS'):
            self.finalize_with_tag_listing('a'*40+'\trefs/tags/v1.2.3')
        self.assertEqual([], self.ls_remote)
        self.assert_refused_before_any_receipt()

    def test_finalize_accepts_annotated_tag_peeled_to_pinned_commit(self):
        self.module.ENV = {'PATH': 'synthetic', 'GIT_ASKPASS': 'synthetic-askpass', 'SSH_ASKPASS': 'synthetic-askpass'}
        self.finalize_with_tag_listing('d'*40+'\trefs/tags/v1.2.3\n'+'a'*40+'\trefs/tags/v1.2.3^{}\n')
        self.assertEqual('PASS', json.loads((self.module.REPORT/'release-validation.json').read_text(encoding='utf-8'))['status'])
        self.assertEqual(1, len(self.ls_remote))
        args, options = self.ls_remote[0]
        # One read-only query of origin's URL; no credential helper, askpass, extra header or prompt may authenticate it.
        self.assertEqual(('-c', 'credential.helper=', '-c', 'credential.https://github.com.helper=', '-c', 'core.askPass=',
                          '-c', 'http.extraHeader=', 'ls-remote', '--tags', 'https://example.invalid/repository.git',
                          'refs/tags/v1.2.3', 'refs/tags/v1.2.3^{}'), args)
        temporary = {'GIT_CONFIG_GLOBAL', 'GIT_CEILING_DIRECTORIES', 'HOME', 'USERPROFILE'}
        self.assertEqual({'PATH': 'synthetic', 'GIT_TERMINAL_PROMPT': '0', 'GCM_INTERACTIVE': 'Never', 'GIT_CONFIG_NOSYSTEM': '1'},
                         {k: v for k, v in options['env'].items() if k not in temporary})

    def test_finalize_accepts_lightweight_tag_on_pinned_commit(self):
        self.finalize_with_tag_listing('a'*40+'\trefs/tags/v1.2.3')
        self.assertEqual('PASS', json.loads((self.module.REPORT/'release-validation.json').read_text(encoding='utf-8'))['status'])
        self.assertEqual(1, len(self.ls_remote))

    def test_run_uses_configured_repository_and_refuses_existing_log(self):
        with mock.patch.object(subprocess, 'run', return_value=SimpleNamespace(returncode=0)) as command:
            self.module.run('fixture', ['synthetic-only'])
            self.assertEqual(self.root, command.call_args.kwargs['cwd'])
            with self.assertRaises(FileExistsError):
                self.module.run('fixture', ['synthetic-only'])
            self.assertEqual(1, command.call_count)

    def test_build_refuses_existing_report_before_any_external_action(self):
        with mock.patch.object(self.module, 'source_guard'), mock.patch.object(subprocess, 'run', side_effect=AssertionError('external action')):
            with self.assertRaises(RuntimeError):
                self.module.build()

    def test_payload_mismatch_cannot_create_success_receipt(self):
        self.module.TESTED_APK = self.root/'tested.apk'
        with zipfile.ZipFile(self.module.TESTED_APK, 'w') as archive:
            archive.writestr('classes.dex', b'tested')
        bundle = self.module.DELIVERY/'FuzeVPN-Android-v123-release-upload-signed.aab'
        with zipfile.ZipFile(bundle, 'w') as archive:
            archive.writestr('base/dex/classes.dex', b'different')
        with mock.patch.object(self.module, 'source_guard'):
            with self.assertRaises(RuntimeError):
                self.module.compare()
        self.assertFalse((self.module.REPORT/'payload-comparison-vs-tested-apk.json').exists())

    def test_canonical_receipt_recomputes_all_suites_and_fonts(self):
        self.canonical_fixture()
        data, proof = self.module.local_validation()
        self.assertEqual(7, data['checks']['fonts']['passed'])
        self.assertEqual(1, data['checks']['jvm']['passed'])
        self.assertIn('python-tests.log', {item['path'] for item in proof})
        self.assertIn('flutter-fonts.log', {item['path'] for item in proof})
        self.assertEqual(44, data['checks']['turnstile-bridge']['junit']['passed'])
        self.assertEqual(20, data['checks']['turnstile-bridge']['javascript']['passed'])
        self.assertEqual(27, data['checks']['command-epochs']['junit']['passed'])
        self.assertEqual(94, data['checks']['bridge-host']['junit']['passed'])
        self.assertEqual(17, data['checks']['wireguard-gate']['passed'])
        self.assertTrue({'turnstile-bridge/result.json',
                         'turnstile-bridge/junit.log', 'turnstile-bridge/javascript.log',
                         'command-epochs/execution.json', 'command-epochs/result.log',
                         'bridge-host/execution.json', 'bridge-host/result.log'} <= {item['path'] for item in proof})

    def test_stale_junit_rejected_even_with_recorded_success(self):
        _, junit = self.canonical_fixture()
        os.utime(junit, (1, 1))
        with self.assertRaises(ValueError):
            self.module.local_validation()
        self.assertFalse((self.module.REPORT/'release-validation.json').exists())

    def test_missing_font_result_cannot_reuse_summary_pass(self):
        directory, _ = self.canonical_fixture()
        (directory/'flutter-fonts.log').unlink()
        with self.assertRaises((ValueError, OSError)):
            self.module.local_validation()

    def test_validation_calls_single_canonical_runner(self):
        self.module.CONFIG.update(flutter_root='synthetic-flutter', java_home='synthetic-java', android_sdk='synthetic-sdk')
        self.module.PWSH = Path('synthetic-pwsh')
        with (mock.patch.object(self.module, 'source_guard'), mock.patch.object(self.module, 'run') as run,
              mock.patch.object(self.module, 'local_validation', return_value=({'checks': {'fixture': True}}, []))):
            self.module.validate()
        arguments = list(map(str, run.call_args.args[1]))
        self.assertIn(str(self.root/'tools/validate_project.ps1'), arguments)
        self.assertNotIn('-PlanOnly', arguments)

    def test_reparse_parent_is_rejected_before_output_write(self):
        original = Path.lstat
        def fake(path, *args, **kwargs):
            if path == self.root:
                return SimpleNamespace(st_mode=stat.S_IFDIR, st_file_attributes=0x400)
            return original(path, *args, **kwargs)
        with mock.patch.object(Path, 'lstat', fake):
            with self.assertRaises(RuntimeError):
                self.module.output_guard()

    def test_complete_synthetic_release_receipts_bind_to_current_binary(self):
        _, hashes = self.release_fixture()
        result = self.check_release()
        self.assertEqual(hashes['FuzeVPN-Android-v123-release-upload-signed.aab'], result['signed_aab_sha256'])

    def test_other_commit_tree_or_version_build_input_is_rejected(self):
        documents, _ = self.release_fixture()
        original = documents['build-inputs.json']
        for key, value in [('commit', 'b'*40), ('tree', 'b'*40), ('version', 'wrong'), ('version_code', 999)]:
            self.replace_document('build-inputs.json', {**original, key: value})
            with self.subTest(key=key), self.assertRaisesRegex(RuntimeError, 'Build inputs'):
                self.check_release()

    def test_wrong_unsigned_or_mapping_build_output_is_rejected(self):
        documents, _ = self.release_fixture()
        for field in ('unsigned_aab_sha256', 'mapping_sha256'):
            self.replace_document('build-output.json', {**documents['build-output.json'], field: '0'*64})
            with self.subTest(field=field), self.assertRaisesRegex(RuntimeError, 'Build output'):
                self.check_release()

    def test_qualification_from_another_commit_or_binary_is_rejected(self):
        documents, _ = self.release_fixture()
        original = documents['qualification-aab.json']
        self.replace_document('qualification-aab.json', {**original, 'commit': 'b'*40})
        with self.assertRaisesRegex(RuntimeError, 'Qualification belongs'):
            self.check_release()
        changed = json.loads(json.dumps(original))
        changed['artifacts'][0]['sha256'] = '0'*64
        self.replace_document('qualification-aab.json', changed)
        with self.assertRaisesRegex(RuntimeError, 'Qualified artifact'):
            self.check_release()
        changed = json.loads(json.dumps(original))
        changed['artifacts'][1]['kind'] = 'apk'
        self.replace_document('qualification-aab.json', changed)
        with self.assertRaisesRegex(RuntimeError, 'Qualified artifact'):
            self.check_release()

    def test_comparison_for_another_aab_is_rejected(self):
        documents, _ = self.release_fixture()
        self.replace_document('payload-comparison-vs-tested-apk.json', {**documents['payload-comparison-vs-tested-apk.json'], 'aab_sha256': '0'*64})
        with self.assertRaisesRegex(RuntimeError, 'another binary'):
            self.check_release()

    def test_source_association_from_another_commit_or_archive_is_rejected(self):
        documents, _ = self.release_fixture()
        for field, value in [('commit', 'b'*40), ('source_archive_sha256', '0'*64), ('derived_universal_apk_sha256', '0'*64)]:
            self.replace_document('bundle-source-association.json', {**documents['bundle-source-association.json'], field: value})
            with self.subTest(field=field), self.assertRaisesRegex(RuntimeError, 'Source association'):
                self.check_release()

    def test_empty_partial_or_duplicate_inventory_is_rejected(self):
        self.release_fixture()
        manifest = self.module.DELIVERY/'SHA256SUMS'
        original = manifest.read_text(encoding='ascii').splitlines(keepends=True)
        for value in ('', ''.join(original[:-1]), ''.join(original+[original[0]])):
            manifest.write_text(value, encoding='ascii')
            with self.subTest(inventory=value[:20]), self.assertRaisesRegex(RuntimeError, '[Ii]nventory'):
                self.check_release()

    def test_changed_binary_cannot_be_admitted_by_regenerated_inventory(self):
        self.release_fixture()
        (self.module.DELIVERY/'FuzeVPN-Android-v123-release-upload-signed.aab').write_bytes(b'other synthetic binary')
        manifest = self.module.DELIVERY/'SHA256SUMS'
        manifest.write_text(''.join(self.module.sha(self.module.DELIVERY/name)+'  '+name+'\n' for name in sorted(self.module.delivery_names())), encoding='ascii')
        with self.assertRaisesRegex(RuntimeError, 'Signing receipt'):
            self.check_release()

    def test_interrupted_export_without_completion_marker_is_rejected(self):
        self.release_fixture()
        (self.module.REPORT/'source-export.complete.json').unlink()
        with self.assertRaises(FileNotFoundError):
            self.check_release()

    def test_unexpected_private_delivery_file_is_rejected_before_hashing(self):
        self.release_fixture()
        (self.module.DELIVERY/'unexpected.p12').write_bytes(b'synthetic prohibited extension')
        with mock.patch.object(self.module, 'sha', side_effect=AssertionError('must not hash unknown files')):
            with self.assertRaisesRegex(RuntimeError, 'missing or unexpected'):
                self.check_release()

    def test_streaming_sha_does_not_require_python311_file_digest(self):
        source = self.root/'synthetic.bin'
        source.write_bytes(b'synthetic')
        with mock.patch.object(hashlib, 'file_digest', side_effect=AssertionError('not available on Python 3.10'), create=True):
            self.assertEqual(hashlib.sha256(b'synthetic').hexdigest(), self.module.sha(source))

class EvidenceSnapshotTest(unittest.TestCase):
    def setUp(self):
        self.module = load('archive_evidence')
        temporary = tempfile.TemporaryDirectory()
        self.addCleanup(temporary.cleanup)
        self.root = Path(temporary.name)
        self.source = self.root/'approved-report.json'
        self.source.write_bytes(b'{"synthetic": true}\n')
        self.output = self.root/'snapshots'
        self.output.mkdir()
        self.digest = hashlib.sha256(self.source.read_bytes()).hexdigest()

    def test_exact_snapshot_is_new_and_receipt_contains_no_host_path(self):
        first, receipt = self.module.snapshot(self.source, self.output, self.digest, 'fixture')
        second, _ = self.module.snapshot(self.source, self.output, self.digest, 'fixture')
        self.assertNotEqual(first, second)
        self.assertEqual(self.source.read_bytes(), (first/self.source.name).read_bytes())
        self.assertEqual(self.digest, receipt['sha256'])
        self.assertNotIn(str(self.root), (first/'RECEIPT.json').read_text(encoding='utf-8'))

    def test_changed_historical_bytes_are_refused_without_touching_prior_snapshots(self):
        sentinel = self.output/'previous-evidence.txt'
        sentinel.write_text('preserve', encoding='utf-8')
        with self.assertRaises(ValueError):
            self.module.snapshot(self.source, self.output, '0'*64, 'fixture')
        self.assertEqual([sentinel], list(self.output.iterdir()))
        self.assertTrue(self.source.is_file())

    def test_secret_or_unsupported_paths_are_rejected_before_read(self):
        with mock.patch.object(Path, 'open', side_effect=AssertionError('must not read')):
            with self.assertRaises(ValueError):
                self.module.snapshot(self.root/'mot-de-passe-keystore.txt', self.output, self.digest, 'fixture')
            with self.assertRaises(ValueError):
                self.module.snapshot(self.root/'upload.p12', self.output, self.digest, 'fixture')

    def test_path_traversal_label_is_rejected(self):
        with self.assertRaises(ValueError):
            self.module.snapshot(self.source, self.output, self.digest, '../other')
        self.assertEqual([], list(self.output.iterdir()))

    def test_windows_reparse_output_parent_is_rejected_without_copy(self):
        original = Path.lstat
        def fake(path, *args, **kwargs):
            if path == self.output:
                return SimpleNamespace(st_mode=stat.S_IFDIR, st_file_attributes=0x400)
            return original(path, *args, **kwargs)
        with mock.patch.object(Path, 'lstat', fake):
            with self.assertRaises(ValueError):
                self.module.snapshot(self.source, self.output, self.digest, 'fixture')
        self.assertEqual([], list(self.output.iterdir()))

if __name__ == '__main__':
    unittest.main()
