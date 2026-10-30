# SPDX-License-Identifier: Apache-2.0
import importlib.util
from datetime import datetime, timedelta, timezone
import json
import os
from pathlib import Path
import re
import shutil
import subprocess
import sys
import tempfile
import time
import unittest
from unittest import mock

SPEC = importlib.util.spec_from_file_location("validation_support", Path(__file__).parents[1] / "validation_support.py")
support = importlib.util.module_from_spec(SPEC)
SPEC.loader.exec_module(support)


class ExecutedEvidenceTests(unittest.TestCase):
    def setUp(self):
        self.temp = tempfile.TemporaryDirectory()
        self.addCleanup(self.temp.cleanup)
        self.root = Path(self.temp.name)

    def flutter(self, *events):
        path = self.root / "flutter.log"
        path.write_text("\n".join(json.dumps(event) for event in events), encoding="utf-8")
        return path

    def test_loader_events_are_excluded_from_executed_count(self):
        path = self.flutter({"type": "testDone", "hidden": True, "result": "success"},
                            {"type": "testDone", "hidden": False, "result": "success", "skipped": False},
                            {"type": "done", "success": True})
        self.assertEqual(1, support.flutter_counts(path)["passed"])

    def test_flutter_skip_cannot_be_reported_as_pass(self):
        path = self.flutter({"type": "testDone", "hidden": False, "result": "success", "skipped": True},
                            {"type": "done", "success": True})
        with self.assertRaises(support.ValidationError):
            support.flutter_counts(path)

    def test_flutter_missing_completion_is_rejected(self):
        with self.assertRaises(support.ValidationError):
            support.flutter_counts(self.flutter({"type": "testDone", "hidden": False, "result": "success"}))

    def test_empty_successful_flutter_run_is_rejected(self):
        with self.assertRaises(support.ValidationError):
            support.flutter_counts(self.flutter({"type": "done", "success": True}))

    def test_font_run_requires_each_of_the_seven_cases(self):
        path = self.flutter({"type": "testDone", "hidden": False, "result": "success"},
                            {"type": "done", "success": True})
        with self.assertRaises(support.ValidationError):
            support.flutter_counts(path, font_subset=True)

    def junit(self, extra="", *, tests=1, skipped=0):
        path = self.root / "TEST-fixture.xml"
        path.write_text(f'<testsuite name="fixture" tests="{tests}" skipped="{skipped}" failures="0" errors="0">'
                        f'<testcase name="case" classname="fixture">{extra}</testcase></testsuite>', encoding="utf-8")
        return path

    def test_stale_junit_xml_is_rejected(self):
        path = self.junit()
        os.utime(path, (10, 10))
        with self.assertRaises(support.ValidationError):
            support.junit_counts(self.root, time.time())

    def test_junit_skip_and_inflated_declared_count_are_rejected(self):
        self.junit("<skipped/>", skipped=1)
        with self.assertRaises(support.ValidationError):
            support.junit_counts(self.root, 0)
        self.junit(tests=2)
        with self.assertRaises(support.ValidationError):
            support.junit_counts(self.root, 0)

    def test_isolated_suite_cannot_pass_without_its_six_required_cases(self):
        self.junit()
        with self.assertRaises(support.ValidationError):
            support.junit_counts(self.root, 0, isolated=True)

    def test_fresh_junit_counts_actual_cases(self):
        self.junit()
        self.assertEqual(1, support.junit_counts(self.root, time.time())["passed"])

    def test_duplicate_junit_receipts_cannot_inflate_the_count(self):
        path = self.junit()
        (self.root / "copied.xml").write_bytes(path.read_bytes())
        with self.assertRaises(support.ValidationError):
            support.junit_counts(self.root, 0)

    def test_all_six_fresh_isolated_cases_are_accepted(self):
        classes = {
            "WireGuardDeferredLoadingInstrumentedTest": [
                "idleAndIdentityOperationsDoNotConstructTheNativeBackend",
                "nativeBackendIsCreatedOnceOnTheWorkerWhenStartingWireGuard",
                "cancellationDuringLoadingDoesNotStartATunnel",
                "realBridgeAndOpenVpnCoreInitializeWithoutLoadingWireGuard"],
            "WireGuardLibrarySmokeInstrumentedTest": ["approvedLibraryLoadsAndReportsVersionWithoutStartingATunnel"],
            "WireGuardNetworkObservationInstrumentedTest": ["physicalOutageIsObservedWithoutFlutterOrAnActiveCommand"],
        }
        timestamp = datetime.now(timezone.utc).isoformat()
        for name, methods in classes.items():
            cases = ''.join(f'<testcase classname="com.fuzevpn.android.{name}" name="{method}"/>' for method in methods)
            (self.root / f"{name}.xml").write_text(
                f'<testsuite name="{name}" timestamp="{timestamp}" tests="{len(methods)}" failures="0" errors="0" skipped="0">{cases}</testsuite>', encoding="utf-8")
        self.assertEqual(6, support.junit_counts(self.root, time.time(), isolated=True)["passed"])

    def test_fatal_lint_is_not_a_successful_validation(self):
        path = self.root / "lint.xml"
        path.write_text('<issues><issue id="problem" severity="Fatal"/></issues>', encoding="utf-8")
        with self.assertRaises(support.ValidationError):
            support.lint_counts(path, 0)

    def test_python_skipped_cases_are_rejected(self):
        path = self.root / "python.log"
        path.write_text('Ran 2 tests in 0.01s\n\nOK (skipped=1)\n', encoding="utf-8")
        with self.assertRaises(support.ValidationError):
            support.python_counts(path)

    def test_partial_run_cannot_be_summarized_as_complete(self):
        (self.root / "steps.json").write_text('[{"name":"flutter-test","exitCode":0}]', encoding="utf-8")
        with self.assertRaises(support.ValidationError):
            support.summarize(self.root)

    # A18-tooling-evidence-07: without the symbolic-link privilege the link test
    # reports one explicit, motivated skip; that must not fail the whole run.
    LINK_TEST = ("test_filesystem_link_outside_root_is_refused (test_package_android_sources.SourcePackageTests"
                 "{suffix}) ... skipped 'Creating filesystem links and junctions is unavailable: [WinError 1314]'")

    def python_log(self, *lines, ran=3, outcome="OK (skipped=1)"):
        path = self.root / "python.log"
        path.write_text("\n".join([*lines, "", "-" * 70, f"Ran {ran} tests in 0.01s", "", outcome, ""]), encoding="utf-8")
        return path

    def test_python_motivated_link_skip_is_accepted_and_reported(self):
        for suffix in [".test_filesystem_link_outside_root_is_refused", ""]:  # Python 3.11+ and 3.10 forms
            with self.subTest(suffix=suffix):
                counts = support.python_counts(self.python_log("test_a (m.C.test_a) ... ok",
                                                               self.LINK_TEST.format(suffix=suffix)))
                self.assertEqual((3, 2, 1), (counts["total"], counts["passed"], counts["skipped"]))
                self.assertEqual(["test_package_android_sources.SourcePackageTests.test_filesystem_link_outside_root_is_refused"],
                                 [skip["test"] for skip in counts["acceptedSkips"]])
                self.assertIn("WinError 1314", counts["acceptedSkips"][0]["reason"])

    def test_python_unmotivated_or_unlisted_skips_are_still_rejected(self):
        link = self.LINK_TEST.format(suffix="")
        for lines, kwargs in [
            ((), {}),  # count only, no identified test
            (("test_other (test_x.Other.test_other) ... skipped 'Creating filesystem links and junctions is unavailable'",), {}),
            ((link.replace("Creating filesystem links and junctions is unavailable", "network unavailable"),), {}),
            ((link,), {"outcome": "OK (skipped=2)"}),
            ((link, link.replace("test_filesystem_link_outside_root_is_refused (", "test_other (")), {"outcome": "OK (skipped=2)"}),
            ((link,), {"ran": 1}),
            ((link,), {"outcome": "OK (skipped=1, expected failures=1)"}),
            ((link,), {"outcome": "FAILED (failures=1, skipped=1)"}),
        ]:
            with self.subTest(lines=lines, kwargs=kwargs), self.assertRaises(support.ValidationError):
                support.python_counts(self.python_log(*lines, **kwargs))

    def test_python_run_without_skip_is_unchanged(self):
        path = self.root / "python.log"
        path.write_text("Ran 2 tests in 0.01s\n\nOK\n", encoding="utf-8")
        self.assertEqual({"total": 2, "passed": 2, "skipped": 0, "acceptedSkips": []}, support.python_counts(path))


class InstrumentationRunWindowTests(unittest.TestCase):
    # Kept independent of the implementation's required set: these are the six
    # actual non-parameterized methods in the current Android test sources.
    METHODS = {
        "WireGuardDeferredLoadingInstrumentedTest": [
            "idleAndIdentityOperationsDoNotConstructTheNativeBackend",
            "nativeBackendIsCreatedOnceOnTheWorkerWhenStartingWireGuard",
            "cancellationDuringLoadingDoesNotStartATunnel",
            "realBridgeAndOpenVpnCoreInitializeWithoutLoadingWireGuard"],
        "WireGuardLibrarySmokeInstrumentedTest": ["approvedLibraryLoadsAndReportsVersionWithoutStartingATunnel"],
        "WireGuardNetworkObservationInstrumentedTest": ["physicalOutageIsObservedWithoutFlutterOrAnActiveCommand"],
    }

    def setUp(self):
        self.temp = tempfile.TemporaryDirectory()
        self.addCleanup(self.temp.cleanup)
        self.root = Path(self.temp.name)
        self.checked = int(time.time())
        self.started = self.checked - 10

    def iso(self, instant, offset=timezone.utc):
        return datetime.fromtimestamp(instant, offset).isoformat()

    def write_suites(self, timestamp, *, missing=None, renamed=False, skipped=False):
        for cls, methods in self.METHODS.items():
            if cls == missing:
                continue
            cases = []
            for index, name in enumerate(methods):
                name = f"unrelated-{index}" if renamed else name
                body = '<skipped/>' if skipped and index == 0 and cls.endswith("SmokeInstrumentedTest") else ''
                cases.append(f'<testcase classname="com.fuzevpn.android.{cls}" name="{name}">{body}</testcase>')
            skip_count = 1 if skipped and cls.endswith("SmokeInstrumentedTest") else 0
            stamp = '' if timestamp is None else f' timestamp="{timestamp}"'
            (self.root / f"TEST-{cls}.xml").write_text(
                f'<testsuite name="{cls}"{stamp} tests="{len(methods)}" failures="0" errors="0" skipped="{skip_count}">'
                + ''.join(cases) + '</testsuite>', encoding="utf-8")

    def counts(self, started=None, *, suite_offset=None):
        return support.junit_counts(self.root, self.started if started is None else started,
                                    isolated=True, checked_at=self.checked, suite_offset=suite_offset)

    def cli(self, started, *, suite_offset=None):
        return subprocess.run([sys.executable, '-B', *(['-O'] if sys.flags.optimize else []),
            str(Path(__file__).parents[1] / 'validation_support.py'), 'check-instrumentation',
            '--xml-directory', str(self.root), '--started-at', started,
            *(['--suite-utc-offset='+suite_offset] if suite_offset is not None else [])],
            capture_output=True, text=True)

    def test_old_original_and_same_bytes_with_fresh_copy_mtime_are_rejected(self):
        self.write_suites('2010-01-01T00:00:00Z')
        original = self.root / 'original'
        original.mkdir()
        for path in list(self.root.glob('*.xml')):
            destination = original / path.name
            path.replace(destination)
            os.utime(destination, (1262304000, 1262304000))
            shutil.copyfile(destination, path)
            self.assertEqual(destination.read_bytes(), path.read_bytes())
            self.assertGreaterEqual(path.stat().st_mtime, self.started)
        with self.assertRaisesRegex(support.ValidationError, 'outside the supplied instrumentation run window'):
            self.counts()
        with self.assertRaisesRegex(support.ValidationError, 'stale'):
            support.junit_counts(original, self.started, isolated=True, checked_at=self.checked)
        result = self.cli(self.iso(self.started))
        self.assertEqual(1, result.returncode, result.stdout + result.stderr)
        self.assertNotIn('"status": "passed"', result.stdout)

    def test_fresh_utc_z_and_numeric_offset_represent_the_same_run(self):
        for timestamp in [self.iso(self.checked - 5).replace('+00:00', 'Z'),
                          self.iso(self.checked - 5),
                          self.iso(self.checked - 5, timezone(timedelta(hours=2))),
                          self.iso(self.checked - 5, timezone(timedelta(hours=-7)))]:
            with self.subTest(timestamp=timestamp):
                self.write_suites(timestamp)
                self.assertEqual(6, self.counts()['passed'])

    def test_clock_allowance_is_fixed_at_two_seconds_on_both_edges(self):
        for instant in [self.started - 2, self.checked + 2]:
            with self.subTest(instant=instant):
                self.write_suites(self.iso(instant))
                self.assertEqual(6, self.counts()['passed'])
        for instant in [self.started - 2.001, self.checked + 2.001]:
            with self.subTest(instant=instant):
                self.write_suites(self.iso(instant))
                with self.assertRaisesRegex(support.ValidationError, 'outside the supplied instrumentation run window'):
                    self.counts()

    def test_future_declared_run_start_and_nonfinite_bounds_are_rejected(self):
        self.write_suites(self.iso(self.checked))
        with self.assertRaisesRegex(support.ValidationError, 'start is in the future'):
            self.counts(self.checked + 2.001)
        for started, checked in [(float('nan'), self.checked), (float('inf'), self.checked),
                                 (self.started, float('nan')), (self.started, float('inf'))]:
            with self.subTest(started=started, checked=checked), self.assertRaises(support.ValidationError):
                support.junit_counts(self.root, started, isolated=True, checked_at=checked)

    def test_missing_naive_unknown_offset_and_invalid_timestamps_are_rejected(self):
        for timestamp in [None, '', 'not-a-timestamp', '2026-02-30T12:00:00Z',
                          self.iso(self.checked - 5).replace('+00:00', ''),
                          self.iso(self.checked - 5).replace('+00:00', '-00:00'),
                          self.iso(self.checked - 5).replace('+00:00', '+99:00'),
                          self.iso(self.checked - 5).replace('+00:00', '+01:60'),
                          self.iso(self.checked - 5).replace('+00:00', '+00:99'),
                          self.iso(self.checked - 5).replace('+00:00', '+14:01')]:
            with self.subTest(timestamp=timestamp):
                self.write_suites(timestamp)
                with self.assertRaises(support.ValidationError):
                    self.counts()

    def test_naive_producer_timestamp_needs_explicit_offset_without_rewriting_xml(self):
        for offset, zone in [('UTC', timezone.utc), ('+02:00', timezone(timedelta(hours=2))),
                             ('-07:00', timezone(timedelta(hours=-7)))]:
            with self.subTest(offset=offset):
                timestamp = datetime.fromtimestamp(self.checked-5, zone).replace(tzinfo=None).isoformat()
                self.write_suites(timestamp)
                before = {p.name: p.read_bytes() for p in self.root.glob('*.xml')}
                with self.assertRaises(support.ValidationError):
                    self.counts()
                self.assertEqual(6, self.counts(suite_offset=offset)['passed'])
                result = self.cli(self.iso(self.started), suite_offset=offset)
                self.assertEqual(0, result.returncode, result.stdout+result.stderr)
                self.assertEqual(offset, json.loads(result.stdout)['freshness']['declaredNaiveSuiteUtcOffset'])
                self.assertEqual(before, {p.name: p.read_bytes() for p in self.root.glob('*.xml')})

    def test_naive_old_copy_cannot_be_admitted_by_declared_producer_offset(self):
        self.write_suites('2010-01-01T00:00:00')
        for offset in ['UTC', '+14:00', '-14:00']:
            with self.subTest(offset=offset), self.assertRaisesRegex(support.ValidationError, 'outside the supplied instrumentation run window'):
                self.counts(suite_offset=offset)

    def test_invalid_producer_offset_is_rejected_and_embedded_zone_is_authoritative(self):
        self.write_suites(self.iso(self.checked-5))
        for offset in ['local', 'Europe/Paris', '-00:00', '+15:00', '+14:01', '+02', '+02:99']:
            with self.subTest(offset=offset), self.assertRaises(support.ValidationError):
                self.counts(suite_offset=offset)
        self.assertEqual(6, self.counts(suite_offset='+02:00')['passed'])

    def test_every_suite_needs_its_own_run_timestamp(self):
        self.write_suites(self.iso(self.checked - 5))
        path = next(self.root.glob('*Smoke*.xml'))
        path.write_text(path.read_text().replace(self.iso(self.checked - 5), '2010-01-01T00:00:00Z'))
        with self.assertRaisesRegex(support.ValidationError, 'outside the supplied instrumentation run window'):
            self.counts()

    def test_six_exact_method_identities_missing_duplicates_and_skips_remain_guarded(self):
        self.write_suites(self.iso(self.checked - 5), renamed=True)
        with self.assertRaisesRegex(support.ValidationError, 'six isolated'):
            self.counts()
        self.write_suites(self.iso(self.checked - 5), skipped=True)
        with self.assertRaisesRegex(support.ValidationError, 'skips'):
            self.counts()
        self.write_suites(self.iso(self.checked - 5))
        path = next(self.root.glob('*Smoke*.xml'))
        duplicate = self.root/'duplicate.xml'
        shutil.copyfile(path, duplicate)
        with self.assertRaisesRegex(support.ValidationError, 'Duplicate JUnit case'):
            self.counts()
        duplicate.unlink()
        path.unlink()
        with self.assertRaisesRegex(support.ValidationError, 'six isolated'):
            self.counts()

    def test_canonical_host_junit_does_not_require_device_timestamps(self):
        path = self.root/'TEST-host.xml'
        for timestamp in ['', ' timestamp="local producer format"']:
            path.write_text(f'<testsuite tests="1" failures="0" errors="0" skipped="0"{timestamp}>'
                            '<testcase classname="host" name="method"/></testsuite>')
            self.assertEqual(1, support.junit_counts(self.root, self.started)['passed'])

    def test_cli_reports_normalized_utc_run_window_and_supplied_xml_limit(self):
        self.write_suites(self.iso(self.checked - 5))
        result = self.cli(self.iso(self.started, timezone(timedelta(hours=2))))
        self.assertEqual(0, result.returncode, result.stdout + result.stderr)
        data = json.loads(result.stdout)
        self.assertEqual(6, data['counts']['passed'])
        self.assertEqual(2, data['freshness']['clockSkewSeconds'])
        self.assertEqual(self.iso(self.started), data['freshness']['startedAt'])
        self.assertEqual('supplied isolated instrumentation XML', data['scope'])
        self.assertIn('does not execute instrumentation', data['note'])
        for started in ['2026-10-28T00:00:00', 'invalid', self.iso(time.time()+60),
                        self.iso(self.started).replace('+00:00', '+01:60'),
                        self.iso(self.started).replace('+00:00', '+00:99')]:
            with self.subTest(started=started):
                self.assertEqual(1, self.cli(started).returncode)

    # H-R35-01-01: ddmlib formats each suite timestamp with
    # SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss", Locale.getDefault()) in UTC.
    # Values below were produced by Temurin 17.0.20.1 with -Duser.language/
    # -Duser.country/-Duser.variant for 2026-10-29T12:34:56Z, 2010-01-01T00:00:00Z,
    # 2019-05-01T00:00:00Z and 2019-04-30T23:59:59Z.
    FIXED = 1793277296  # 2026-10-29T12:34:56Z

    @staticmethod
    def native(zero, text):
        return ''.join(chr(zero + int(c)) if c.isdigit() else c for c in text)

    def jvm_fresh(self):
        native = self.native
        return {
            'en-US': '2026-10-29T12:34:56', 'th-TH': '2569-10-29T12:34:56',
            'ar-SA': '٢٠٢٦-١٠-٢٩T١٢:٣٤:٥٦',
            'ar-EG': native(0x0660, '2026-10-29T12:34:56'), 'fa-IR': native(0x06F0, '2026-10-29T12:34:56'),
            'bn-BD': native(0x09E6, '2026-10-29T12:34:56'), 'mr-IN': native(0x0966, '2026-10-29T12:34:56'),
            'ne-NP': native(0x0966, '2026-10-29T12:34:56'), 'my-MM': native(0x1040, '2026-10-29T12:34:56'),
            'dz-BT': native(0x0F20, '2026-10-29T12:34:56'), 'ja-JP-JP': '8-10-29T12:34:56',
            'th-TH-TH': '๒๕๖๙-๑๐-๒๙T๑๒:๓๔:๕๖',
        }

    def fixed_counts(self, timestamp, *, instant=None, offset='UTC'):
        instant = self.FIXED if instant is None else instant
        self.write_suites(timestamp)
        for path in self.root.glob('*.xml'):
            os.utime(path, (instant, instant))
        return support.junit_counts(self.root, instant - 10, isolated=True, checked_at=instant + 5, suite_offset=offset)

    def test_fresh_ddmlib_campaign_is_read_for_every_producer_jvm_locale(self):
        self.assertEqual(self.native(0x0660, '2026-10-29T12:34:56'), self.jvm_fresh()['ar-SA'])
        self.assertEqual(self.native(0x0E50, '2569-10-29T12:34:56'), self.jvm_fresh()['th-TH-TH'])
        expected = {'en-US': 'gregorian/latin', 'th-TH': 'buddhist/latin', 'ar-SA': 'gregorian/U+0660',
                    'fa-IR': 'gregorian/U+06F0', 'ja-JP-JP': 'japanese-Reiwa/latin', 'th-TH-TH': 'buddhist/U+0E50'}
        for locale, timestamp in self.jvm_fresh().items():
            with self.subTest(locale=locale):
                counts = self.fixed_counts(timestamp)
                self.assertEqual(6, counts['passed'])
                if locale in expected:
                    self.assertEqual([expected[locale]], counts['suiteTimestampReadings'])
                # The producer's bytes are read, never rewritten.
                self.assertIn(f'timestamp="{timestamp}"', next(self.root.glob('*Smoke*.xml')).read_text(encoding='utf-8'))

    def test_producer_locale_never_admits_an_old_or_shifted_campaign(self):
        native = self.native
        old = {'en-US': '2010-01-01T00:00:00', 'th-TH': '2553-01-01T00:00:00', 'ja-JP-JP': '22-01-01T00:00:00',
               'ar-SA': native(0x0660, '2010-01-01T00:00:00'), 'th-TH-TH': native(0x0E50, '2553-01-01T00:00:00'),
               'my-MM': native(0x1040, '2010-01-01T00:00:00'),
               'previous-day': self.jvm_fresh()['th-TH'].replace('-29T', '-28T'),
               'one-hour-earlier': self.jvm_fresh()['ar-SA'].replace('١٢:', '١١:'),
               'neither-gregorian-nor-buddhist-year': '3112-10-29T12:34:56',
               'heisei-8-read-in-2010': '8-10-29T12:34:56'}
        for label, timestamp in old.items():
            instant = 1262304000 + 86400 * 400 if label == 'heisei-8-read-in-2010' else self.FIXED
            with self.subTest(label=label), self.assertRaisesRegex(support.ValidationError,
                                                                   'outside the supplied instrumentation run window'):
                self.fixed_counts(timestamp, instant=instant)

    def test_japanese_era_first_year_and_boundaries(self):
        reiwa, heisei_end = 1556668800, 1556668799  # 2019-05-01T00:00:00Z / 2019-04-30T23:59:59Z
        self.assertEqual(['japanese-Reiwa/latin'], self.fixed_counts('元-05-01T00:00:00', instant=reiwa)['suiteTimestampReadings'])
        self.assertEqual(['japanese-Heisei/latin'], self.fixed_counts('31-04-30T23:59:59', instant=heisei_end)['suiteTimestampReadings'])
        for timestamp, instant in [('31-05-01T00:00:00', reiwa), ('元-04-30T23:59:59', heisei_end)]:
            with self.subTest(timestamp=timestamp), self.assertRaises(support.ValidationError):
                self.fixed_counts(timestamp, instant=instant)

    def test_mixed_digits_foreign_characters_and_malformed_producer_years_are_refused(self):
        fresh = self.jvm_fresh()['ar-SA']
        for timestamp in [fresh[:5] + '10' + fresh[7:], ' ' + fresh, fresh + ' ', fresh.replace('T', ' '),
                          '0-10-29T12:34:56', '026-10-29T12:34:56', '02026-10-29T12:34:56',
                          '8-元-29T12:34:56', '2026،10-29T12:34:56', fresh.replace(':', '٫'),
                          '๒๕๖๙-10-29T12:34:56', '2026-10-29T12:34:56‏']:
            with self.subTest(timestamp=timestamp), self.assertRaises(support.ValidationError):
                self.fixed_counts(timestamp)
        with self.assertRaisesRegex(support.ValidationError, 'explicit Z or UTC offset'):
            self.fixed_counts(fresh, offset=None)

    def test_cli_accepts_fresh_native_digit_and_buddhist_campaign_with_powershell_start(self):
        stamp = datetime.fromtimestamp(self.checked - 5, timezone.utc)
        buddhist = stamp.replace(year=stamp.year + 543).strftime('%Y-%m-%dT%H:%M:%S')
        self.write_suites(self.native(0x0E50, buddhist))
        started = datetime.fromtimestamp(self.started, timezone.utc).strftime('%Y-%m-%dT%H:%M:%S') + '.1234567Z'
        result = self.cli(started, suite_offset='UTC')
        self.assertEqual(0, result.returncode, result.stdout + result.stderr)
        data = json.loads(result.stdout)
        self.assertEqual(['buddhist/U+0E50'], data['counts']['suiteTimestampReadings'])
        self.assertEqual(6, data['counts']['passed'])


class MandatoryHostBoundaryTests(unittest.TestCase):
    def setUp(self):
        # The consumer fixture is a physical complete receipt tree. Only its
        # synthetic command results are used; no JVM, Node or release is run.
        spec = importlib.util.spec_from_file_location('host_boundary_fixture', Path(__file__).with_name('test_release_evidence.py'))
        module = importlib.util.module_from_spec(spec)
        spec.loader.exec_module(module)
        self.fixture = module.MaintainedReleaseTest()
        self.fixture.setUp()
        self.addCleanup(self.fixture.doCleanups)
        self.directory, _ = self.fixture.canonical_fixture()
        self.steps_path = self.directory/'steps.json'
        self.steps = json.loads(self.steps_path.read_text())

    def test_complete_new_steps_have_counts_from_executed_logs(self):
        data = support.summarize(self.directory)
        self.assertEqual(44, data['checks']['turnstile-bridge']['junit']['passed'])
        self.assertEqual(20, data['checks']['turnstile-bridge']['javascript']['passed'])
        self.assertEqual(27, data['checks']['command-epochs']['junit']['passed'])
        self.assertEqual(43, data['checks']['bridge-host']['junit']['passed'])

    def test_runs_below_the_cases_executed_on_30_october_are_refused(self):
        # Integration of corrections-20261029: Turnstile 44 JUnit + 20 JavaScript
        # scenarios, command-epoch 27 and bridge-host 43 cases (measured runs; the
        # counts are those of lot N's re-audit pass, 30/10 12:10 UTC).
        # The former floors (35, 15, 14, 26, then 26 and 33) or one lost case no longer qualify.
        for name, filename, count in [('turnstile-bridge','junit.log',35), ('turnstile-bridge','junit.log',43),
                                      ('command-epochs','result.log',14), ('command-epochs','result.log',26),
                                      ('bridge-host','result.log',42), ('bridge-host','result.log',33),
                                      ('bridge-host','result.log',26), ('bridge-host','result.log',1)]:
            path = self.directory/name/filename
            original = path.read_text()
            path.write_text('JUnit version 4.13.2\n'+'.'*count+'\nTime: 0.01\n\nOK ('+str(count)+' tests)\n')
            with self.subTest(name=name, count=count), self.assertRaisesRegex(support.ValidationError, 'missing cases'):
                support.summarize(self.directory)
            path.write_text(original)
        path = self.directory/'turnstile-bridge/javascript.log'
        original = path.read_text()
        for count in (15, 19):
            path.write_text(f'Generated HTML/JavaScript: PASS ({count} scenarios, no network)\n')
            with self.subTest(javascript=count), self.assertRaisesRegex(support.ValidationError, 'scenarios'):
                support.summarize(self.directory)
        path.write_text(original)
        self.assertEqual({'turnstile-bridge': 44, 'command-epochs': 27, 'bridge-host': 43}, support.HOST_JUNIT_MINIMUMS)
        self.assertEqual(20, support.TURNSTILE_JAVASCRIPT_MINIMUM)

    def test_each_floor_is_the_number_of_cases_versioned_in_its_suite(self):
        # A floor below the suite would let added cases disappear unnoticed:
        # every @Test of the JUnit classes each runner executes (comments and
        # strings excluded) must be required. Adding a case raises the floor here.
        root = Path(__file__).resolve().parents[2]
        suites = {'bridge-host': sorted((root/'android/app/src/test/bridge-host').glob('*Test.kt')),
                  'command-epochs': [root/'android/app/src/test/command-epoch/SystemVpnCommandEpoch.template.kt'],
                  'turnstile-bridge': [root/'android/app/src/test/kotlin/com/fuzevpn/android/TurnstilePolicyTest.kt',
                                       root/'android/app/src/testHost/turnstile/NativeTurnstileBridgeHostTest.kt']}
        self.assertEqual(set(support.HOST_JUNIT_MINIMUMS), set(suites))
        for name, paths in suites.items():
            cases = 0
            for path in paths:
                code = re.sub(r'(?s)/\*.*?\*/|//[^\n]*|"(?:\\.|[^"\\\n])*"', '', path.read_text(encoding='utf-8'))
                cases += len(re.findall(r'(?m)^\s*@Test\b', code))
            with self.subTest(suite=name):
                self.assertTrue(paths)
                self.assertEqual(cases, support.HOST_JUNIT_MINIMUMS[name])

    def test_development_guide_states_the_current_floors(self):
        guide = ' '.join((Path(__file__).resolve().parents[2]/'docs/DEVELOPMENT.md').read_text(encoding='utf-8').split())
        floors = support.HOST_JUNIT_MINIMUMS
        self.assertIn(f"{floors['turnstile-bridge']} tests JUnit et {support.TURNSTILE_JAVASCRIPT_MINIMUM} scénarios JavaScript "
                      "pour `turnstile-bridge`", guide)
        self.assertIn(f"{floors['command-epochs']} tests pour `command-epochs` et {floors['bridge-host']} pour `bridge-host`", guide)
        self.assertIn(f"{len(support.WIREGUARD_GATE_CASES)} cas nommés", guide)
        self.assertIn('`native-libraries-approved`', guide)

    def test_runner_runs_the_bridge_host_suite_after_command_epochs(self):
        runner = (Path(__file__).resolve().parents[1]/'validate_project.ps1').read_text(encoding='utf-8')
        plan = re.search(r"\$stepNames = @\(([^)]*)\)", runner)
        self.assertIsNotNone(plan)
        names = re.findall(r"'([^']+)'", plan[1])
        self.assertEqual(names.index('command-epochs') + 1, names.index('bridge-host'))
        invoked = [match[1] for match in re.finditer(r"Invoke-(?:ValidationStep|ProjectScript) '([^']+)'", runner)]
        self.assertEqual(invoked.index('command-epochs') + 1, invoked.index('bridge-host'))
        start = runner.index("Invoke-ValidationStep 'bridge-host'")
        step = ' '.join(runner[start:runner.index('\n    Invoke-', start + 1)].split())
        for argument in ["$shell @('-NoProfile', '-File', (Join-Path $projectRoot 'android/app/src/test/bridge-host/run.ps1'),",
                         "'-JavaHome', $JavaHome, '-ModuleCache', $moduleCache,",
                         "'-OutputDirectory', (Join-Path $OutputDirectory 'bridge-host'))"]:
            self.assertIn(argument, step)
        # Every planned step is required by the aggregator.
        self.steps_path.write_text(json.dumps([s for s in self.steps if s['name'] in names]))
        support.summarize(self.directory)
        for name in names:
            with self.subTest(removed=name):
                self.steps_path.write_text(json.dumps([s for s in self.steps if s['name'] != name]))
                with self.assertRaisesRegex(support.ValidationError, 'incomplete'):
                    support.summarize(self.directory)

    def test_old_receipts_missing_either_new_step_cannot_pass(self):
        for removed in [('turnstile-bridge',), ('command-epochs',), ('bridge-host',), ('turnstile-bridge','command-epochs'),
                        ('turnstile-bridge','command-epochs','bridge-host')]:
            with self.subTest(removed=removed):
                self.steps_path.write_text(json.dumps([s for s in self.steps if s['name'] not in removed]))
                with self.assertRaisesRegex(support.ValidationError, 'incomplete'):
                    support.summarize(self.directory)

    def test_new_boundary_files_must_all_exist_and_be_fresh(self):
        for name, files in support.HOST_BOUNDARY_FILES.items():
            for filename in files:
                path = self.directory/name/filename
                content, modified = path.read_bytes(), path.stat().st_mtime
                with self.subTest(name=name, filename=filename, mode='missing'):
                    path.unlink()
                    with self.assertRaisesRegex(support.ValidationError, 'Missing or stale'):
                        support.summarize(self.directory)
                path.write_bytes(content)
                os.utime(path, (1,1))
                with self.subTest(name=name, filename=filename, mode='old'):
                    with self.assertRaisesRegex(support.ValidationError, 'Missing or stale'):
                        support.summarize(self.directory)
                os.utime(path, (modified, modified))

    def test_copied_old_or_unzoned_boundary_receipt_is_not_this_step(self):
        for name, filename, fields in [('turnstile-bridge','result.json',('startedAt','finishedAt')),
                                       ('command-epochs','execution.json',('started_utc','ended_utc')),
                                       ('bridge-host','execution.json',('started_utc','ended_utc'))]:
            path = self.directory/name/filename
            record = json.loads(path.read_text())
            for timestamp in ['2010-01-01T00:00:00Z', '2010-01-01T00:00:00']:
                changed = {**record, **dict.fromkeys(fields, timestamp)}
                path.write_text(json.dumps(changed))
                with self.subTest(name=name,timestamp=timestamp), self.assertRaises(support.ValidationError):
                    support.summarize(self.directory)
            path.write_text(json.dumps(record))

    def test_failed_exit_or_negative_control_cannot_qualify_new_steps(self):
        for name, filename, fields in [('turnstile-bridge','result.json',('compileExitCode','junitExitCode','javascriptExitCode')),
                                       ('command-epochs','execution.json',('junit_exit_code',)),
                                       ('bridge-host','execution.json',('junit_exit_code',))]:
            path = self.directory/name/filename
            record = json.loads(path.read_text())
            for field in fields:
                for value in [1, False, None]:
                    path.write_text(json.dumps({**record,field:value}))
                    with self.subTest(name=name,field=field,value=value), self.assertRaises(support.ValidationError):
                        support.summarize(self.directory)
            path.write_text(json.dumps(record))
        for name in ('command-epochs', 'bridge-host'):
            path = self.directory/name/'execution.json'
            record = json.loads(path.read_text())
            for value in (True, None):
                path.write_text(json.dumps({**record,'expect_failure':value}))
                with self.subTest(name=name, expect_failure=value), \
                        self.assertRaisesRegex(support.ValidationError, 'negative control cannot qualify ' + name):
                    support.summarize(self.directory)
            path.write_text(json.dumps(record))

    def test_host_junit_rejects_skips_missing_cases_and_duplicate_success(self):
        for name, filename, count in [('turnstile-bridge','junit.log',44),('command-epochs','result.log',27),
                                      ('bridge-host','result.log',43)]:
            path = self.directory/name/filename
            original = path.read_text()
            variations = [original.replace('.'*count, '.'*(count-1)+'I'),
                          original.replace('.'*count, '.'*(count-1)),
                          original.replace(str(count)+' tests',str(count-1)+' tests').replace('.'*count,'.'*(count-1)),
                          original+'\nOK ('+str(count)+' tests)\n']
            for changed in variations:
                path.write_text(changed)
                with self.subTest(name=name,changed=changed[-80:]), self.assertRaises(support.ValidationError):
                    support.summarize(self.directory)
            path.write_text(original)

    def test_javascript_requires_all_scenarios_without_skip_or_duplicate_summary(self):
        path = self.directory/'turnstile-bridge/javascript.log'
        original = path.read_text()
        for changed in [original.replace('20 scenarios','19 scenarios'),original+'Skipped: 1\n',original+original]:
            path.write_text(changed)
            with self.subTest(changed=changed), self.assertRaises(support.ValidationError):
                support.summarize(self.directory)

    def test_future_added_cases_are_counted_without_raising_a_fixed_ceiling(self):
        for name, filename, count in [('turnstile-bridge','junit.log',45),('command-epochs','result.log',28),
                                      ('bridge-host','result.log',44)]:
            (self.directory/name/filename).write_text('JUnit version 4.13.2\n'+'.'*count+'\nTime: 0.01\n\nOK ('+str(count)+' tests)\n')
        (self.directory/'turnstile-bridge/javascript.log').write_text('Generated HTML/JavaScript: PASS (21 scenarios, no network)\n')
        data = support.summarize(self.directory)
        self.assertEqual(45,data['checks']['turnstile-bridge']['junit']['passed'])
        self.assertEqual(21,data['checks']['turnstile-bridge']['javascript']['passed'])
        self.assertEqual(28,data['checks']['command-epochs']['junit']['passed'])
        self.assertEqual(44,data['checks']['bridge-host']['junit']['passed'])

    def test_duplicate_step_names_cannot_hide_ambiguous_execution_receipts(self):
        self.steps_path.write_text(json.dumps(self.steps+[next(s for s in self.steps if s['name']=='command-epochs')]))
        with self.assertRaisesRegex(support.ValidationError, 'incomplete'):
            support.summarize(self.directory)

    def test_wireguard_gate_cases_are_those_the_gate_script_runs(self):
        root = Path(__file__).resolve().parents[2]
        script = (root/'tools/test_wireguard_release_gate.ps1').read_text(encoding='utf-8')
        cases = re.findall(r"(?m)^\s*Invoke-(?:GateCase|NativeLibraryCase) '([^']+)'", script)
        self.assertEqual(tuple(cases), support.WIREGUARD_GATE_CASES)
        self.assertEqual(len(cases), len(set(cases)))
        self.assertIn('native-libraries-approved', cases)
        runner = (root/'tools/validate_project.ps1').read_text(encoding='utf-8')
        call = [line for line in runner.splitlines() if "Invoke-ProjectScript 'wireguard-gate'" in line]
        self.assertEqual(1, len(call))
        self.assertNotIn('-Only', call[0])  # the runner never narrows the gate to some cases

    def test_wireguard_gate_requires_every_named_case_and_the_native_library_inventory(self):
        # Review of R4 (round 2): 16 results sufficed although the gate has 17
        # cases; the case proving that libwg.so/libwg-quick.so are not packaged
        # (A17-supply-chain-05) could be lost, or padded by a duplicate.
        path = self.directory/'wireguard-gate/results.json'
        original = json.loads(path.read_text())
        self.assertEqual(17, support.summarize(self.directory)['checks']['wireguard-gate']['passed'])
        native = [result['name'] for result in original].index('native-libraries-approved')

        def with_native(**changes):
            changed = [dict(result) for result in original]
            changed[native].update(changes)
            return changed

        others = [result for result in original if result['name'] != 'native-libraries-approved']
        variants = {
            'the 16 former cases only': others,
            'native case replaced by a duplicate': others + [original[0]],
            'native case packages libwg.so': with_native(nativeLibraries=['libwg-go.so', 'libwg.so']),
            'native case packages libwg-quick.so': with_native(nativeLibraries=['libwg-quick.so', 'libwg-go.so']),
            'native case lost libwg-go.so': with_native(nativeLibraries=['libflutter.so']),
            'native case without inventory': [{key: value for key, value in result.items() if key != 'nativeLibraries'}
                                              for result in original],
            'native case failed': with_native(passed=False),
            'unnamed case': [dict(result, name=None) if index == 0 else result for index, result in enumerate(original)],
            'not a list': original[native],
        }
        for name in [result['name'] for result in original]:
            variants['missing ' + name] = [result for result in original if result['name'] != name]
        for label, changed in variants.items():
            path.write_text(json.dumps(changed))
            with self.subTest(label), self.assertRaisesRegex(support.ValidationError, 'integration gate: wireguard-gate'):
                support.summarize(self.directory)
        # A case added to the gate is counted without being required.
        path.write_text(json.dumps(original + [{'name': 'future-case', 'passed': True}]))
        self.assertEqual(18, support.summarize(self.directory)['checks']['wireguard-gate']['passed'])


REPOSITORY = Path(__file__).resolve().parents[2]
SUPPORT_SCRIPT = Path(__file__).resolve().parents[1] / 'validation_support.py'


def run_support(*arguments, environment=None):
    return subprocess.run([sys.executable, '-B', str(SUPPORT_SCRIPT), *map(str, arguments)],
                          capture_output=True, text=True, encoding='utf-8', errors='replace',
                          env=environment, timeout=120)


class GoToolchainReceiptTests(unittest.TestCase):
    """Reaudit C6: python-tests needs Go (tools/tests/test_wireguard_ipv6_length.py).

    The toolchain step must find the same toolchain as that test, refuse one
    below the "go" directive of the pinned libwg-go module and keep go-version.txt.
    """

    def setUp(self):
        temporary = tempfile.TemporaryDirectory()
        self.addCleanup(temporary.cleanup)
        self.root = Path(temporary.name)

    def test_minimum_is_the_go_directive_of_the_pinned_libwg_go_module(self):
        go_mod = (REPOSITORY/'android/third_party/wireguard-android/tunnel/tools/libwg-go/go.mod').read_text(encoding='utf-8')
        directive = re.search(r'(?m)^go ([0-9]+)\.([0-9]+)(?:\.([0-9]+))?\s*$', go_mod)
        self.assertIsNotNone(directive)
        self.assertEqual(tuple(int(part or 0) for part in directive.groups()), support.GO_MINIMUM)
        self.assertEqual((1, 23, 1), support.GO_MINIMUM)

    def test_go_versions_below_the_minimum_or_unreadable_are_refused(self):
        for output, expected in [('go version go1.23.1 windows/amd64\n', '1.23.1'),
                                 ('go version go1.26.3 windows/amd64\r\n', '1.26.3'),
                                 ('go version go1.100.0 linux/arm64', '1.100.0'),
                                 ('go version go1.24rc1 darwin/arm64', '1.24rc1'),
                                 ('go version go1.26.3 X:nodwarf5 windows/amd64', '1.26.3')]:
            with self.subTest(output=output):
                self.assertEqual(expected, support.go_version(output))
        for output in ['go version go1.23.0 windows/amd64', 'go version go1.22.12 windows/amd64',
                       'go version go1.9 windows/amd64', 'go version go1.23rc2 windows/amd64',
                       'go version go1.23 windows/amd64', 'go version devel go1.27-abcdef Mon Oct 26 windows/amd64',
                       'go version go2 windows/amd64', 'go1.26.3', '']:
            with self.subTest(output=output), self.assertRaises(support.ValidationError):
                support.go_version(output)

    def test_lookup_is_that_of_the_wireguard_go_test(self):
        spec = importlib.util.spec_from_file_location('wireguard_go_lookup', Path(__file__).with_name('test_wireguard_ipv6_length.py'))
        module = importlib.util.module_from_spec(spec)
        spec.loader.exec_module(module)
        explicit = self.root/'explicit go.exe'
        explicit.write_bytes(b'')
        on_path, empty = self.root/'bin', self.root/'empty'
        on_path.mkdir()
        empty.mkdir()
        found = on_path/('go.exe' if os.name == 'nt' else 'go')
        found.write_bytes(b'')
        found.chmod(0o755)
        for environment, expected in [({'FUZEVPN_GO': str(explicit), 'PATH': str(on_path)}, str(explicit)),
                                      ({'FUZEVPN_GO': '', 'PATH': str(on_path)}, found),
                                      ({'PATH': str(on_path)}, found),
                                      ({'PATH': str(empty)}, None)]:
            with self.subTest(environment=environment), mock.patch.dict(os.environ, environment):
                if 'FUZEVPN_GO' not in environment:
                    os.environ.pop('FUZEVPN_GO', None)
                self.assertEqual(module.go(), support.go_executable())
                actual = support.go_executable()
                if isinstance(expected, Path):
                    self.assertEqual(os.path.normcase(expected), os.path.normcase(actual))
                else:
                    self.assertEqual(expected, actual)

    def fake_go(self, version_line, exit_code=0):
        folder = self.root/f'fake go {len(list(self.root.iterdir()))}'
        folder.mkdir()
        if os.name == 'nt':
            go = folder/'go.cmd'
            go.write_text('@echo off\r\n>"%~dp0environment.txt" echo toolchain=%GOTOOLCHAIN% flags=%GOFLAGS% arguments=%*\r\n'
                          f'echo {version_line}\r\nexit /b {exit_code}\r\n', encoding='ascii')
        else:
            go = folder/'go'
            go.write_text('#!/bin/sh\necho "toolchain=$GOTOOLCHAIN flags=$GOFLAGS arguments=$*" > "$(dirname "$0")/environment.txt"\n'
                          f'echo "{version_line}"\nexit {exit_code}\n', encoding='ascii')
            go.chmod(0o755)
        return go

    def go_toolchain(self, go, output):
        # GO* overrides of the caller must not reach go: GOTOOLCHAIN could download another toolchain.
        return run_support('go-toolchain', '--output', output,
                           environment=dict(os.environ, FUZEVPN_GO=str(go), GOTOOLCHAIN='go1.99.0', GOFLAGS='-mod=mod'))

    def test_accepted_go_is_recorded_without_the_callers_go_overrides(self):
        go = self.fake_go('go version go1.26.3 windows/amd64')
        output = self.root/'go-version.txt'
        result = self.go_toolchain(go, output)
        self.assertEqual(0, result.returncode, result.stdout + result.stderr)
        receipt = json.loads(result.stdout)
        self.assertEqual((str(go), '1.26.3', '1.23.1'), (receipt['executable'], receipt['version'], receipt['minimum']))
        self.assertEqual(['go version go1.26.3 windows/amd64', f'executable: {go}'],
                         output.read_text(encoding='utf-8').splitlines())
        self.assertEqual('toolchain=local flags= arguments=version', (go.parent/'environment.txt').read_text().strip())

    def test_old_failing_or_missing_go_fails_without_a_receipt(self):
        for label, go, message in [('old', self.fake_go('go version go1.23.0 windows/amd64'), '1.23.1'),
                                   ('failing', self.fake_go('go version go1.26.3 windows/amd64', exit_code=3), 'exit'),
                                   ('unreadable', self.fake_go('go version devel windows/amd64'), 'Go version'),
                                   ('missing', self.root/'absent'/'go.exe', 'FUZEVPN_GO')]:
            output = self.root/f'{label}-go-version.txt'
            with self.subTest(label):
                result = self.go_toolchain(go, output)
                self.assertEqual(1, result.returncode, result.stdout + result.stderr)
                self.assertIn('FAIL', result.stderr)
                self.assertIn(message, result.stderr)
                self.assertFalse(output.exists())

    def test_runner_checks_go_in_the_toolchain_step_and_pins_it_for_python_tests(self):
        runner = (REPOSITORY/'tools/validate_project.ps1').read_text(encoding='utf-8')
        self.assertIn('[string]$GoExecutable = $env:FUZEVPN_GO,', runner)
        check = runner.index("go-toolchain --output (Join-Path $OutputDirectory 'go-version.txt')")
        pinned = runner.index('$env:FUZEVPN_GO = ($goToolchain | ConvertFrom-Json).executable')
        self.assertLess(runner.index("Invoke-ValidationStep 'toolchain'"), check)
        self.assertLess(check, pinned)
        self.assertLess(pinned, runner.index("Invoke-ValidationStep 'pub-offline'"))
        self.assertLess(pinned, runner.index("Invoke-ValidationStep 'python-tests'"))

    def test_self_hosted_workflow_declares_fuzevpn_go_like_the_other_toolchains(self):
        workflow = (REPOSITORY/'.github/workflows/validate.yml').read_text(encoding='utf-8')
        job = re.search(r'(?ms)^    env:\n(.*?)^    steps:', workflow)
        self.assertIsNotNone(job)
        self.assertIn('FLUTTER_ROOT: ${{ vars.FUZEVPN_FLUTTER_ROOT }}', job[1])
        self.assertIn('FUZEVPN_GO: ${{ vars.FUZEVPN_GO }}', job[1])

    def test_development_guide_states_the_go_check_and_its_ci_variable(self):
        guide = ' '.join((REPOSITORY/'docs/DEVELOPMENT.md').read_text(encoding='utf-8').split())
        section = guide[guide.index('## Validation locale unique et CI'):guide.index('## Préparation reproductible')]
        self.assertIn(f"Go ({'.'.join(map(str, support.GO_MINIMUM))} minimum", section)
        self.assertIn('`go-version.txt`', section)
        self.assertIn('`FUZEVPN_GO`', section[section.index('Configurer les variables de dépôt'):])


class GeneratedLocalizationFreshnessTests(unittest.TestCase):
    """Reaudit C8: pub get (generate: true) rewrites the versioned lib/l10n/generated.

    The runner fingerprints it before any pub get and fails if pub-offline
    produced anything else, so a stale versioned copy can no longer be hidden.
    """

    def setUp(self):
        temporary = tempfile.TemporaryDirectory()
        self.addCleanup(temporary.cleanup)
        self.root = Path(temporary.name)
        self.generated = self.root/'lib/l10n/generated'
        self.generated.mkdir(parents=True)
        (self.generated/'app_localizations.dart').write_bytes(b'abstract class AppLocalizations {}\r\n')
        (self.generated/'app_localizations_fr.dart').write_bytes(b'class AppLocalizationsFr {}\r\n')

    def test_identical_regeneration_passes_and_any_drift_is_named(self):
        before = support.tree_fingerprint(self.generated)
        self.assertEqual(['app_localizations.dart', 'app_localizations_fr.dart'], sorted(before))
        for path in self.generated.iterdir():
            path.write_bytes(path.read_bytes())  # same bytes, new mtime
        self.assertEqual([], support.fingerprint_changes(before, support.tree_fingerprint(self.generated)))
        french = self.generated/'app_localizations_fr.dart'
        original = french.read_bytes()
        for label, change, expected in [
                ('content', lambda: french.write_bytes(b'class AppLocalizationsFr { String get key; }\r\n'),
                 ['changed app_localizations_fr.dart']),
                ('line endings only', lambda: french.write_bytes(original.replace(b'\r\n', b'\n')),
                 ['changed app_localizations_fr.dart']),
                ('added', lambda: (self.generated/'nested').mkdir() or (self.generated/'nested/app_localizations_ur.dart').write_bytes(b''),
                 ['added nested/app_localizations_ur.dart']),
                ('removed', lambda: french.unlink(), ['removed app_localizations_fr.dart'])]:
            with self.subTest(label):
                change()
                self.assertEqual(expected, support.fingerprint_changes(before, support.tree_fingerprint(self.generated)))
                shutil.rmtree(self.generated/'nested', ignore_errors=True)
                french.write_bytes(original)

    def test_missing_or_empty_directory_is_refused(self):
        for directory in [self.root/'absent', self.root/'empty']:
            if directory.name == 'empty':
                directory.mkdir()
            with self.subTest(directory=directory.name), self.assertRaises(support.ValidationError):
                support.tree_fingerprint(directory)

    def test_cli_fingerprint_then_compare(self):
        fingerprint = self.root/'l10n-generated-before.json'
        recorded = run_support('fingerprint', '--directory', self.generated, '--output', fingerprint)
        self.assertEqual(0, recorded.returncode, recorded.stdout + recorded.stderr)
        self.assertEqual(2, len(json.loads(fingerprint.read_text(encoding='utf-8'))['files']))
        unchanged = run_support('compare-fingerprint', '--directory', self.generated, '--fingerprint', fingerprint)
        self.assertEqual(0, unchanged.returncode, unchanged.stdout + unchanged.stderr)
        original_fr = (self.generated/'app_localizations_fr.dart').read_bytes()
        (self.generated/'app_localizations_fr.dart').write_bytes(b'class Regenerated {}\r\n')
        stale = run_support('compare-fingerprint', '--directory', self.generated, '--fingerprint', fingerprint)
        self.assertEqual(1, stale.returncode, stale.stdout + stale.stderr)
        self.assertIn('changed app_localizations_fr.dart', stale.stderr)
        other = run_support('compare-fingerprint', '--directory', self.root, '--fingerprint', fingerprint)
        self.assertEqual(1, other.returncode, other.stdout + other.stderr)
        # A byte-for-byte copy elsewhere is still another directory: only the path guard refuses it.
        (self.generated/'app_localizations_fr.dart').write_bytes(original_fr)
        copy = self.root/'copy of generated'
        shutil.copytree(self.generated, copy)
        elsewhere = run_support('compare-fingerprint', '--directory', copy, '--fingerprint', fingerprint)
        self.assertEqual(1, elsewhere.returncode, elsewhere.stdout + elsewhere.stderr)
        self.assertIn('does not fingerprint', elsewhere.stdout + elsewhere.stderr)

    def test_runner_fingerprints_the_l10n_output_before_any_pub_get_and_compares_after_pub_offline(self):
        output = re.search(r'(?m)^output-dir:\s*(\S+)\s*$', (REPOSITORY/'l10n.yaml').read_text(encoding='utf-8'))
        self.assertIsNotNone(output)
        runner = (REPOSITORY/'tools/validate_project.ps1').read_text(encoding='utf-8')
        self.assertIn(f"$generatedDirectory = Join-Path $projectRoot '{output[1]}'", runner)
        snapshot = runner.index('fingerprint --directory $generatedDirectory --output $generatedLocalizations')
        compare = runner.index('compare-fingerprint --directory $generatedDirectory --fingerprint $generatedLocalizations')
        self.assertLess(runner.index("Invoke-ValidationStep 'toolchain'"), snapshot)
        self.assertLess(snapshot, runner.index("Invoke-ValidationStep 'prepare-pub-online'"))
        self.assertLess(runner.index("Invoke-ValidationStep 'pub-offline'"), compare)
        self.assertLess(compare, runner.index("Invoke-ValidationStep 'translations'"))
        # The comparison must stop the run: the next line throws on a non-zero exit.
        self.assertRegex(runner, r"compare-fingerprint --directory \$generatedDirectory --fingerprint \$generatedLocalizations"
                                 r"[^\n]*\n\s*if \(\$LASTEXITCODE -ne 0\) \{ throw ")


if __name__ == "__main__":
    unittest.main()
