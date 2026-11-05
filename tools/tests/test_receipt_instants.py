# SPDX-License-Identifier: Apache-2.0
"""A18-tooling-evidence-03: receipts written by PowerShell must be readable on Python 3.10.

The runner accepts Python 3.10 (tools/validate_project.ps1, docs/DEVELOPMENT.md).
Python 3.10's datetime.fromisoformat only reads isoformat() output: no "Z" and
three or six fractional digits. PowerShell's round-trip format "o" writes seven
digits ([DateTime]::UtcNow.ToString('o') ends in Z, [DateTimeOffset] in +00:00).
These tests run the real consumers with a fromisoformat restricted to the
documented Python 3.10 grammar, so they detect the defect on any newer Python.
"""
import ast
from datetime import datetime, timedelta, timezone
import importlib.util
import json
from pathlib import Path
import re
import unittest
from unittest import mock

TOOLS = Path(__file__).resolve().parents[1]
# https://docs.python.org/3.10/library/datetime.html#datetime.datetime.fromisoformat
# YYYY-MM-DD[*HH[:MM[:SS[.fff[fff]]]][+HH:MM[:SS[.ffffff]]]]
PY310_GRAMMAR = re.compile(r"[0-9]{4}-[0-9]{2}-[0-9]{2}(?:.[0-9]{2}(?::[0-9]{2}(?::[0-9]{2}(?:\.[0-9]{3}(?:[0-9]{3})?)?)?)?"
                           r"(?:[+-][0-9]{2}:[0-9]{2}(?::[0-9]{2}(?:\.[0-9]{6})?)?)?)?")


class Python310DateTime(datetime):
    @classmethod
    def fromisoformat(cls, value):
        if not isinstance(value, str) or not PY310_GRAMMAR.fullmatch(value):
            raise ValueError(f"Invalid isoformat string: {value!r}")
        return super().fromisoformat(value)


def load(name):
    spec = importlib.util.spec_from_file_location("receipt_" + name, TOOLS / (name + ".py"))
    module = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(module)
    return module


def powershell_o(instant: datetime, suffix: str) -> str:
    """[DateTime]::UtcNow.ToString('o') (suffix Z) or [DateTimeOffset]::UtcNow.ToString('o') (+00:00)."""
    return instant.astimezone(timezone.utc).strftime("%Y-%m-%dT%H:%M:%S.%f") + "7" + suffix


class PowerShellReceiptInstantTests(unittest.TestCase):
    REAL = ["2026-10-28T15:52:15.7165880Z", "2026-10-28T15:52:15.7165880+00:00", "2026-10-28T15:52:15Z",
            "2026-10-28T17:52:15.716588+02:00", "2026-10-28T15:52:15.716+00:00", "2026-10-28T15:52:15.1Z"]

    def setUp(self):
        self.support = load("validation_support")
        spec = importlib.util.spec_from_file_location("receipt_fixture", Path(__file__).with_name("test_release_evidence.py"))
        self.fixture_module = importlib.util.module_from_spec(spec)
        spec.loader.exec_module(self.fixture_module)
        fixture = self.fixture_module.MaintainedReleaseTest()
        fixture.setUp()
        self.addCleanup(fixture.doCleanups)
        self.fixture = fixture

    def test_emulation_reproduces_the_python_310_refusal(self):
        self.assertRaises(ValueError, Python310DateTime.fromisoformat, self.REAL[0])
        self.assertRaises(ValueError, Python310DateTime.fromisoformat, self.REAL[2])
        Python310DateTime.fromisoformat("2026-10-28T15:52:15.716588+00:00")

    def test_both_consumers_read_real_powershell_and_python_instants_identically(self):
        release = self.fixture.module
        expected = datetime(2026, 10, 28, 15, 52, 15, tzinfo=timezone.utc).timestamp()
        with mock.patch.object(self.support, "datetime", Python310DateTime), \
                mock.patch.object(release, "datetime", Python310DateTime):
            for value in self.REAL:
                with self.subTest(value=value):
                    fraction = float("0." + value[20:].split("Z")[0].split("+")[0]) if value[19] == "." else 0.0
                    self.assertAlmostEqual(expected + fraction, self.support.iso_instant(value, "receipt"), places=6)
                    self.assertAlmostEqual(expected + fraction, release.instant(value), places=6)

    def test_unzoned_or_malformed_receipt_instants_are_still_refused(self):
        release = self.fixture.module
        for value in ["2026-10-28T15:52:15.7165880", "2026-10-28 15:52:15Z", "2026-02-30T00:00:00Z",
                      "2026-10-28T15:52:15.1234567890Z", "2026-10-28T15:52:15+24:00", "٢026-10-28T15:52:15Z", "", None]:
            with self.subTest(value=value):
                with self.assertRaises(self.support.ValidationError):
                    self.support.iso_instant(value, "receipt")
                with self.assertRaises(RuntimeError):
                    release.instant(value)

    def powershell_receipts(self, directory: Path) -> None:
        """Rewrite the canonical fixture's clocks exactly as the PowerShell writers do."""
        steps_path = directory / "steps.json"
        steps = json.loads(steps_path.read_text(encoding="utf-8"))
        now = datetime.now(timezone.utc)
        for step in steps:  # tools/validate_project.ps1: [DateTime]::UtcNow.ToString('o')
            step["startedAt"] = powershell_o(now - timedelta(seconds=4), "Z")
            step["finishedAt"] = powershell_o(now - timedelta(seconds=1), "Z")
        steps_path.write_text(json.dumps(steps), encoding="utf-8")
        turnstile = directory / "turnstile-bridge/result.json"  # [DateTimeOffset]::UtcNow.ToString('o')
        record = json.loads(turnstile.read_text(encoding="utf-8"))
        record.update(startedAt=powershell_o(now - timedelta(seconds=3), "+00:00"),
                      finishedAt=powershell_o(now - timedelta(seconds=2), "+00:00"))
        turnstile.write_text(json.dumps(record), encoding="utf-8")
        epochs = directory / "command-epochs/execution.json"  # (Get-Date).ToUniversalTime().ToString('o')
        record = json.loads(epochs.read_text(encoding="utf-8"))
        record.update(started_utc=powershell_o(now - timedelta(seconds=3), "Z"),
                      ended_utc=powershell_o(now - timedelta(seconds=2), "Z"))
        epochs.write_text(json.dumps(record), encoding="utf-8")
        bridge = directory / "bridge-host/execution.json"  # (Get-Date).ToUniversalTime().ToString('o')
        record = json.loads(bridge.read_text(encoding="utf-8"))
        record.update(started_utc=powershell_o(now - timedelta(seconds=3), "Z"),
                      ended_utc=powershell_o(now - timedelta(seconds=2), "Z"))
        bridge.write_text(json.dumps(record), encoding="utf-8")

    def test_summarize_and_release_recount_accept_powershell_receipts_on_python_310(self):
        directory, _ = self.fixture.canonical_fixture()
        self.powershell_receipts(directory)
        with mock.patch.object(self.support, "datetime", Python310DateTime):
            data = self.support.summarize(directory)
        self.assertEqual("passed", data["status"])
        self.assertEqual(44, data["checks"]["turnstile-bridge"]["junit"]["passed"])
        self.assertEqual(94, data["checks"]["bridge-host"]["junit"]["passed"])
        (directory / "summary.json").write_text(json.dumps(data), encoding="utf-8")
        release = self.fixture.module
        # local_validation() loads its own copy of validation_support.py: patch the
        # class it imports so that copy also runs with the Python 3.10 grammar.
        with mock.patch("datetime.datetime", Python310DateTime), \
                mock.patch.object(release, "datetime", Python310DateTime):
            data, proof = release.local_validation()
        self.assertEqual("passed", data["status"])
        self.assertTrue(proof)

    def test_receipt_consumers_never_delegate_to_fromisoformat(self):
        for name in ["validation_support.py", "release_aab_safe.py"]:
            tree = ast.parse((TOOLS / name).read_text(encoding="utf-8"))
            calls = [node.lineno for node in ast.walk(tree) if isinstance(node, ast.Attribute) and node.attr == "fromisoformat"]
            with self.subTest(name=name):
                self.assertEqual([], calls)


if __name__ == "__main__":
    unittest.main()
