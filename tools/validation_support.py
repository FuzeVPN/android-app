#!/usr/bin/env python3
# SPDX-License-Identifier: Apache-2.0
"""Count executed validation results; reject skipped, missing or stale evidence."""
from __future__ import annotations

import argparse
from datetime import datetime, timedelta, timezone
import hashlib
import json
import math
import os
from pathlib import Path
import re
import shutil
import subprocess
import sys
import unicodedata
import xml.etree.ElementTree as ET


class ValidationError(ValueError):
    pass


INSTRUMENTATION_CLOCK_SKEW_SECONDS = 2.0
ISOLATED_INSTRUMENTATION_CASES = {
    ("com.fuzevpn.android.WireGuardDeferredLoadingInstrumentedTest", name)
    for name in (
        "idleAndIdentityOperationsDoNotConstructTheNativeBackend",
        "nativeBackendIsCreatedOnceOnTheWorkerWhenStartingWireGuard",
        "cancellationDuringLoadingDoesNotStartATunnel",
        "realBridgeAndOpenVpnCoreInitializeWithoutLoadingWireGuard",
    )
} | {
    ("com.fuzevpn.android.WireGuardLibrarySmokeInstrumentedTest",
     "approvedLibraryLoadsAndReportsVersionWithoutStartingATunnel"),
    ("com.fuzevpn.android.WireGuardNetworkObservationInstrumentedTest",
     "physicalOutageIsObservedWithoutFlutterOrAnActiveCommand"),
}


def suite_utc_offset(value: str | None) -> str | None:
    """Only explicit fixed offsets; no collector-local timezone or DST inference."""
    if value is None:
        return None
    if value == "UTC":
        return "Z"
    if not re.fullmatch(r"[+-](?:0[0-9]|1[0-4]):[0-5][0-9]", value) or value == "-00:00" or (
        value[1:3] == "14" and value[4:] != "00"
    ):
        raise ValidationError("--suite-utc-offset must be UTC or an explicit offset from -14:00 to +14:00")
    return value


# ASCII digits only ([0-9], never \d). Up to nine fractional digits: PowerShell's
# round-trip format "o" writes seven. Parsed without datetime.fromisoformat, whose
# Python 3.10 grammar accepts only isoformat() output (no "Z", 3 or 6 digits).
INSTANT = re.compile(r"([0-9]{4})-([0-9]{2})-([0-9]{2})T([0-9]{2}):([0-9]{2}):([0-9]{2})"
                     r"(?:\.([0-9]{1,9}))?(Z|[+-][0-9]{2}:[0-9]{2})?")


def zone_offset(text: str) -> timezone:
    if text == "Z":
        return timezone.utc
    hours, minutes = int(text[1:3]), int(text[4:6])
    if hours > 23 or minutes > 59:
        raise ValueError("UTC offset out of range")
    delta = timedelta(hours=hours, minutes=minutes)
    return timezone(-delta if text[0] == "-" else delta)


def civil_instant(year: int, month: int, day: int, hour: int, minute: int, second: int,
                  fraction: str | None, zone: str) -> float:
    stamp = datetime(year, month, day, hour, minute, second, tzinfo=zone_offset(zone))
    return stamp.timestamp() + (int(fraction.ljust(9, "0")) / 1e9 if fraction else 0.0)


def iso_instant(value: str, label: str) -> float:
    """Zoned receipt instant (Python or PowerShell writer), identical on Python 3.10+."""
    match = INSTANT.fullmatch(value) if isinstance(value, str) else None
    if match is None or match[8] is None:
        raise ValidationError(f"{label} must be an ISO-8601 instant with seconds and an explicit Z or UTC offset")
    try:
        return civil_instant(*map(int, match.groups()[:6]), match[7], match[8])
    except (ValueError, OverflowError, OSError) as error:
        raise ValidationError(f"Invalid {label}") from error


def instrumentation_timestamp(value: str, label: str, *, naive_offset: str | None = None) -> float:
    """Require an unambiguous instant; never infer the collector's local timezone."""
    match = INSTANT.fullmatch(value) if isinstance(value, str) else None
    zone = (match[8] or naive_offset) if match else None
    if zone is None:
        raise ValidationError(f"{label} must be ISO-8601 with seconds and an explicit Z or UTC offset")
    if zone == "-00:00":
        raise ValidationError(f"{label} has an unknown UTC offset (-00:00)")
    if zone != "Z" and not re.fullmatch(r"[+-](?:0[0-9]|1[0-4]):[0-5][0-9]", zone):
        raise ValidationError(f"{label} must be ISO-8601 with seconds and an explicit Z or UTC offset")
    if zone != "Z" and zone[1:3] == "14" and zone[4:] != "00":
        raise ValidationError(f"{label} UTC offset exceeds fourteen hours")
    try:
        return civil_instant(*map(int, match.groups()[:6]), match[7], zone)
    except (ValueError, OverflowError, OSError) as error:
        raise ValidationError(f"Invalid {label}") from error


# ddmlib's XmlTestRunListener formats suite timestamps with
# SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss", Locale.getDefault()) in UTC. The
# producer JVM's locale may select native decimal digits (ar-SA, fa-IR, bn-BD,
# th-TH-TH...), the Thai Buddhist calendar (th-TH: Gregorian year + 543) or the
# Japanese imperial calendar (ja-JP-JP: unpadded era year, first year written
# as U+5143). The bytes are never rewritten: each candidate reading is converted
# to an instant and must still fall inside the supplied run window.
BUDDHIST_YEAR_OFFSET = 543
JAPANESE_ERAS = (  # (name, first UTC day); an era ends where the next begins.
    ("Meiji", datetime(1868, 1, 1, tzinfo=timezone.utc)),
    ("Taisho", datetime(1912, 7, 30, tzinfo=timezone.utc)),
    ("Showa", datetime(1926, 12, 25, tzinfo=timezone.utc)),
    ("Heisei", datetime(1989, 1, 8, tzinfo=timezone.utc)),
    ("Reiwa", datetime(2019, 5, 1, tzinfo=timezone.utc)),
)
PRODUCER_STAMP = re.compile(r"([0-9]{1,4}|元)-([0-9]{2})-([0-9]{2})T([0-9]{2}):([0-9]{2}):([0-9]{2})"
                            r"(?:\.([0-9]{1,9}))?(Z|[+-][0-9]{2}:[0-9]{2})?")


def latin_digits(value: str, label: str) -> tuple[str, str]:
    """Map one script's decimal digits to ASCII; refuse mixed digit systems."""
    zeros, result = set(), []
    for character in value:
        if unicodedata.category(character) == "Nd":
            digit = unicodedata.decimal(character)
            zeros.add(ord(character) - digit)
            result.append(str(digit))
        elif character in "-T:.+Z元":
            result.append(character)
        else:
            raise ValidationError(f"{label} contains a character outside the ddmlib timestamp format")
    if len(zeros) > 1:
        raise ValidationError(f"{label} mixes digit systems")
    zero = zeros.pop() if zeros else ord("0")
    return "".join(result), "latin" if zero == ord("0") else f"U+{zero:04X}"


def suite_timestamp(value: str, label: str, *, naive_offset: str | None, earliest: float,
                    latest: float) -> tuple[float, str]:
    """Read one device suite timestamp independently of the producer JVM's locale."""
    if not isinstance(value, str):
        raise ValidationError(f"{label} must be ISO-8601 with seconds and an explicit Z or UTC offset")
    normalized, digits = latin_digits(value, label)
    match = PRODUCER_STAMP.fullmatch(normalized)
    zone = (match[8] or naive_offset) if match else None
    if zone is None:
        raise ValidationError(f"{label} must be ISO-8601 with seconds and an explicit Z or UTC offset")
    # The zone policy (explicit, -00:00 refused, at most fourteen hours) is unchanged.
    instrumentation_timestamp("2000-01-01T00:00:00" + zone, label)
    year, fields = match[1], (*map(int, match.groups()[1:6]), match[7], zone)
    candidates = []
    if len(year) == 4:
        candidates += [("gregorian", int(year)), ("buddhist", int(year) - BUDDHIST_YEAR_OFFSET)]
    elif year == "元" or len(year) <= 2:
        era_year = 1 if year == "元" else int(year)
        for index, (era, start) in enumerate(JAPANESE_ERAS):
            if era_year >= 1:
                candidates.append((f"japanese-{era}", start.year + era_year - 1, start,
                                   JAPANESE_ERAS[index + 1][1] if index + 1 < len(JAPANESE_ERAS) else None))
    readable = False
    for candidate in candidates:
        calendar, gregorian_year = candidate[:2]
        try:
            instant = civil_instant(gregorian_year, *fields)
        except (ValueError, OverflowError, OSError):
            continue
        if len(candidate) == 4 and not (candidate[2].timestamp() <= instant and
                                        (candidate[3] is None or instant < candidate[3].timestamp())):
            continue  # Not a date of that era.
        readable = True
        if earliest <= instant <= latest:
            return instant, f"{calendar}/{digits}"
    if not readable:
        raise ValidationError(f"Invalid {label}")
    raise ValidationError(f"{label} is outside the supplied instrumentation run window")


def flutter_counts(path: Path, *, font_subset: bool = False) -> dict:
    events = []
    for line in path.read_text(encoding="utf-8-sig").splitlines():
        if line.lstrip().startswith("{"):
            try:
                events.append(json.loads(line))
            except json.JSONDecodeError as error:
                raise ValidationError(f"Malformed Flutter event in {path.name}") from error
    done = [event for event in events if event.get("type") == "done"]
    if len(done) != 1 or done[0].get("success") is not True:
        raise ValidationError(f"Flutter run incomplete or failed: {path.name}")
    tests = [event for event in events if event.get("type") == "testDone" and not event.get("hidden")]
    counts = {"total": len(tests), "passed": 0, "failed": 0, "skipped": 0}
    for test in tests:
        if test.get("skipped"):
            counts["skipped"] += 1
        elif test.get("result") == "success":
            counts["passed"] += 1
        else:
            counts["failed"] += 1
    if not tests or counts["failed"] or counts["skipped"]:
        raise ValidationError(f"Flutter has no executed cases, failures or skips: {counts}")
    if font_subset:
        names = [event.get("test", {}).get("name", "") for event in events if event.get("type") == "testStart"]
        if sum("APP10 recovery controls remain reachable" in name for name in names) != 1 or sum(
            "disconnected status keeps its word" in name for name in names
        ) != 6 or counts["passed"] != 7:
            raise ValidationError("The mandatory seven bundled-font regressions did not all execute")
    return counts


def fresh_file(path: Path, started_at: float) -> None:
    if not path.is_file() or path.stat().st_mtime + 2 < started_at:
        raise ValidationError(f"Missing or stale result: {path}")


def junit_counts(directory: Path, started_at: float, *, isolated: bool = False,
                 checked_at: float | None = None, suite_offset: str | None = None) -> dict:
    # Canonical host JUnit retains its existing mtime contract. Device XML is
    # transported separately: its suite timestamps must identify this run window.
    if isolated:
        naive_offset = suite_utc_offset(suite_offset)
        checked_at = datetime.now(timezone.utc).timestamp() if checked_at is None else checked_at
        if not math.isfinite(started_at) or not math.isfinite(checked_at):
            raise ValidationError("Instrumentation run bounds must be finite instants")
        if started_at > checked_at + INSTRUMENTATION_CLOCK_SKEW_SECONDS:
            raise ValidationError("Instrumentation start is in the future beyond the two-second clock allowance")
    files = sorted(directory.glob("*.xml"))
    if not files:
        raise ValidationError(f"No JUnit XML results in {directory}")
    counts = {"total": 0, "passed": 0, "failures": 0, "errors": 0, "skipped": 0, "classes": 0}
    identities, readings = set(), set()
    for path in files:
        fresh_file(path, started_at)
        try:
            root = ET.parse(path).getroot()
        except ET.ParseError as error:
            raise ValidationError(f"Malformed JUnit XML: {path}") from error
        suites = [root] if root.tag == "testsuite" else list(root.iter("testsuite"))
        if not suites:
            raise ValidationError(f"No test suites in {path}")
        for suite in suites:
            if isolated:
                _, reading = suite_timestamp(suite.get("timestamp", ""), f"JUnit suite timestamp in {path.name}",
                                             naive_offset=naive_offset,
                                             earliest=started_at - INSTRUMENTATION_CLOCK_SKEW_SECONDS,
                                             latest=checked_at + INSTRUMENTATION_CLOCK_SKEW_SECONDS)
                readings.add(reading)
            cases = suite.findall("testcase")
            actual = len(cases)
            if int(suite.get("tests", "0")) != actual:
                raise ValidationError(f"JUnit declared/actual test counts disagree: {path}")
            failures = sum(case.find("failure") is not None for case in cases)
            errors = sum(case.find("error") is not None for case in cases)
            skipped = sum(case.find("skipped") is not None for case in cases)
            for key, value in (("failures", failures), ("errors", errors), ("skipped", skipped)):
                if int(suite.get(key, "0")) != value:
                    raise ValidationError(f"JUnit declared/actual {key} disagree: {path}")
                counts[key] += value
            counts["total"] += actual
            counts["passed"] += actual - failures - errors - skipped
            counts["classes"] += 1
            for case in cases:
                name = case.get("classname", suite.get("name", ""))
                identity = (name, case.get("name"))
                if identity in identities:
                    raise ValidationError(f"Duplicate JUnit case counted twice: {identity}")
                identities.add(identity)
    if not counts["total"] or counts["failures"] or counts["errors"] or counts["skipped"]:
        raise ValidationError(f"JUnit has no executed cases, failures, errors or skips: {counts}")
    if isolated and not ISOLATED_INSTRUMENTATION_CASES <= identities:
        raise ValidationError("The six isolated WireGuard instrumentation cases are missing")
    if isolated:
        counts["suiteTimestampReadings"] = sorted(readings)
    return counts


def lint_counts(path: Path, started_at: float) -> dict:
    fresh_file(path, started_at)
    root = ET.parse(path).getroot()
    issues = [{"id": issue.get("id"), "severity": issue.get("severity")} for issue in root.findall("issue")]
    errors = sum(issue["severity"] in {"Error", "Fatal"} for issue in issues)
    if errors:
        raise ValidationError(f"Lint contains {errors} Error/Fatal findings")
    return {"errors": errors, "warnings": sum(issue["severity"] == "Warning" for issue in issues), "issues": issues}


# The only skips a Python run may report: an environment prerequisite the test
# cannot create itself, identified by module.Class.method and the start of the
# reason it prints. Each one is listed in the receipt; any other skip refuses.
ACCEPTED_PYTHON_SKIPS = {
    "test_package_android_sources.SourcePackageTests.test_filesystem_link_outside_root_is_refused":
        "Creating filesystem links and junctions is unavailable",
    # The runner itself is Windows-only; these only skip outside Windows.
    **{f"test_turnstile_runner.TurnstileRunnerShellTests.{name}": "Windows PowerShell 5.1 is unavailable on this platform"
       for name in ("test_runner_completes_under_windows_powershell_and_pwsh_with_native_stderr",
                    "test_failures_still_stop_the_runner_without_a_receipt")},
}


def python_counts(path: Path) -> dict:
    text = path.read_text(encoding="utf-8-sig")
    counts = re.findall(r"(?m)^Ran ([0-9]+) tests? in ", text)
    outcome = re.findall(r"(?m)^OK(?: \(skipped=([0-9]+)\))?\s*$", text)
    if len(counts) != 1 or int(counts[0]) == 0 or len(outcome) != 1:
        raise ValidationError("Python unittest did not execute successfully without skips")
    total, skipped = int(counts[0]), int(outcome[0] or 0)
    # Verbose (-v) lines name each skip: "test_x (module.Class[.test_x]) ... skipped 'reason'".
    reported = re.findall(r"(?m)^(test\w*) \(([\w.]+)\)(?:\r?\n[^\r\n]*)? \.\.\. skipped '(.*)'\s*$", text)
    accepted = []
    for method, owner, reason in reported:
        identity = owner if owner.endswith("." + method) else f"{owner}.{method}"
        # Discovery names the module "test_x"; a package import names it "tools.tests.test_x".
        prefix = next((reason for name, reason in ACCEPTED_PYTHON_SKIPS.items()
                       if identity == name or identity.endswith("." + name)), None)
        if prefix is None or not reason.startswith(prefix):
            raise ValidationError(f"Python unittest skipped a test without an accepted prerequisite: {identity}")
        accepted.append({"test": identity, "reason": reason})
    if skipped != len(accepted) or skipped >= total:
        raise ValidationError("Python unittest did not execute successfully without skips")
    return {"total": total, "passed": total - skipped, "skipped": skipped, "acceptedSkips": accepted}


HOST_BOUNDARY_FILES = {
    "turnstile-bridge": ("result.json", "junit.log", "javascript.log"),
    "command-epochs": ("execution.json", "result.log"),
    "bridge-host": ("execution.json", "result.log"),
}
# Cases each host suite executed on 29/10/2026 (corrections-20261029; bridge-host
# on 31/10/2026 after lot K of corrections-20261031): a run with fewer has lost
# tests. A receipt with more is counted; tools/tests pins each floor to the @Test
# count of its sources.
HOST_JUNIT_MINIMUMS = {"turnstile-bridge": 44, "command-epochs": 27, "bridge-host": 94}
TURNSTILE_JAVASCRIPT_MINIMUM = 20
# Named cases of tools/test_wireguard_release_gate.ps1, which the runner runs
# without -Only. native-libraries-approved proves that the AAR's wireguard-tools
# executables are not packaged (A17-supply-chain-05).
WIREGUARD_GATE_CASES = (
    "release-config-no-flag", "release-config-false", "profile-config-no-flag", "profile-config-false",
    "release-apk-no-flag", "release-bundle-false", "profile-apk-false", "profile-bundle-no-flag",
    "debug-config-maven", "release-config-approved", "profile-config-approved", "debug-config-approved",
    "warm-release-false", "combined-debug-release-no-flag", "dependencies-no-flag", "dependencies-approved",
    "native-libraries-approved")
WIREGUARD_TOOLS_LIBRARIES = ("libwg.so", "libwg-quick.so")


def wireguard_gate_counts(path: Path) -> dict:
    """Require each named gate case once, passed, and the inventory of native-libraries-approved."""
    results = json.loads(path.read_text(encoding="utf-8-sig"))
    failure = ValidationError("Incomplete or failed integration gate: wireguard-gate")
    if type(results) is not list or any(type(result) is not dict or result.get("passed") is not True for result in results):
        raise failure
    names = [result.get("name") for result in results]
    if any(type(name) is not str for name in names) or len(set(names)) != len(names) or set(WIREGUARD_GATE_CASES) - set(names):
        raise failure
    packaged = results[names.index("native-libraries-approved")].get("nativeLibraries")
    if type(packaged) is str:
        packaged = [packaged]
    if (type(packaged) is not list or any(type(library) is not str for library in packaged)
            or "libwg-go.so" not in packaged or set(packaged) & set(WIREGUARD_TOOLS_LIBRARIES)):
        raise failure
    return {"passed": len(results)}


def host_junit_counts(path: Path, minimum: int) -> dict:
    """Count JUnitCore's actual progress, rejecting ignores and repeated summaries."""
    text = path.read_text(encoding="utf-8-sig")
    totals = re.findall(r"(?m)^OK \((\d+) tests?\)\s*$", text)
    progress = re.findall(r"(?ms)^JUnit version [^\r\n]+\r?\n(.*?)^Time: ", text)
    if len(totals) != 1 or len(progress) != 1:
        raise ValidationError(f"Missing or repeated successful JUnitCore run: {path.name}")
    dots = re.sub(r"\s", "", progress[0])
    count = int(totals[0])
    if count < minimum or dots != "." * count:
        raise ValidationError(f"JUnitCore has missing cases, skips, errors or inconsistent counts: {path.name}")
    return {"total": count, "passed": count, "skipped": 0}


def host_boundary_counts(directory: Path, name: str, step: dict) -> dict:
    def instant(value: str) -> float:
        return iso_instant(value, f"Host boundary timestamp ({name})")

    begin, end = instant(step["startedAt"]), instant(step["finishedAt"])
    if begin > end:
        raise ValidationError(f"Host boundary step clock bounds are invalid: {name}")
    folder = directory / name
    for filename in HOST_BOUNDARY_FILES[name]:
        fresh_file(folder / filename, begin)
    record = json.loads((folder / HOST_BOUNDARY_FILES[name][0]).read_text(encoding="utf-8-sig"))
    first, last = ("startedAt", "finishedAt") if name == "turnstile-bridge" else ("started_utc", "ended_utc")
    started, finished = instant(record[first]), instant(record[last])
    if not begin - 2 <= started <= finished <= end + 2:
        raise ValidationError(f"Host boundary receipt belongs to another run: {name}")
    fields = ("compileExitCode", "junitExitCode", "javascriptExitCode") if name == "turnstile-bridge" else ("junit_exit_code",)
    if any(type(record.get(key)) is not int or record[key] != 0 for key in fields):
        raise ValidationError(f"Host boundary command failed or has no exit receipt: {name}")
    if name != "turnstile-bridge" and record.get("expect_failure") is not False:
        raise ValidationError(f"A negative control cannot qualify {name}")
    counts = {"junit": host_junit_counts(folder / ("junit.log" if name == "turnstile-bridge" else "result.log"),
                                       HOST_JUNIT_MINIMUMS[name])}
    if name == "turnstile-bridge":
        javascript = (folder / "javascript.log").read_text(encoding="utf-8-sig").strip()
        match = re.fullmatch(r"Generated HTML/JavaScript: PASS \((\d+) scenarios, no network\)", javascript)
        if not match or int(match[1]) < TURNSTILE_JAVASCRIPT_MINIMUM:
            raise ValidationError("Turnstile generated-document scenarios are missing, skipped or incomplete")
        counts["javascript"] = {"total": int(match[1]), "passed": int(match[1]), "skipped": 0}
    return counts


# tools/tests/test_wireguard_ipv6_length.py (python-tests) builds the pinned
# wireguard-go with GOTOOLCHAIN=local: Go must satisfy the "go" directive of
# android/third_party/wireguard-android/tunnel/tools/libwg-go/go.mod.
GO_MINIMUM = (1, 23, 1)
GO_VERSION = re.compile(r"go version go([0-9]+)\.([0-9]+)(?:\.([0-9]+))?((?:rc|beta)[0-9]+)?(?: X:\S+)? \S+/\S+")


def go_executable() -> str | None:
    """The lookup of tools/tests/test_wireguard_ipv6_length.py: FUZEVPN_GO, else go on PATH."""
    explicit = os.environ.get("FUZEVPN_GO")
    return explicit if explicit else shutil.which("go")


def go_version(output: str) -> str:
    """Read `go version`; refuse an unreadable toolchain or one below GO_MINIMUM."""
    lines = output.strip().splitlines()
    match = GO_VERSION.fullmatch(lines[0].strip()) if lines else None
    if match is None:
        raise ValidationError(f"Unreadable Go version: {output.strip()!r}")
    release = (int(match[1]), int(match[2]), int(match[3] or 0))
    # A pre-release (go1.24rc1) precedes its release (1.24.0).
    if release + (0 if match[4] else 1,) < GO_MINIMUM + (1,):
        minimum = ".".join(map(str, GO_MINIMUM))
        raise ValidationError(f"Go {minimum} or newer is required (libwg-go/go.mod); found {lines[0].strip()}")
    return f"{match[1]}.{match[2]}" + (f".{match[3]}" if match[3] else "") + (match[4] or "")


def go_toolchain(output: Path) -> dict:
    """Check the Go toolchain python-tests will use and record go-version.txt."""
    executable = go_executable()
    if not executable or not Path(executable).is_file():
        raise ValidationError(f"A Go toolchain is required: set FUZEVPN_GO or put go on PATH (found {executable!r})")
    executable = os.path.abspath(executable)
    # As the test does: no GO* override of the caller, never a toolchain switch or download.
    environment = {key: value for key, value in os.environ.items() if not key.startswith("GO")}
    environment.update({"GOTOOLCHAIN": "local", "GOENV": "off", "GOWORK": "off"})
    result = subprocess.run([executable, "version"], env=environment, capture_output=True, text=True,
                            encoding="utf-8", errors="replace", timeout=120)
    if result.returncode != 0:
        raise ValidationError(f"{executable} version exited with {result.returncode}: {(result.stdout + result.stderr).strip()}")
    version = go_version(result.stdout)
    output.write_text(f"{result.stdout.strip()}\nexecutable: {executable}\n", encoding="utf-8")
    return {"status": "passed", "executable": executable, "version": version,
            "minimum": ".".join(map(str, GO_MINIMUM)), "receipt": str(output)}


def tree_fingerprint(directory: Path) -> dict:
    """SHA-256 of every file below directory, keyed by POSIX relative path."""
    if not directory.is_dir():
        raise ValidationError(f"Missing directory: {directory}")
    files = {path.relative_to(directory).as_posix(): hashlib.sha256(path.read_bytes()).hexdigest()
             for path in sorted(directory.rglob("*")) if path.is_file()}
    if not files:
        raise ValidationError(f"No files to fingerprint in {directory}")
    return files


def fingerprint_changes(before: dict, after: dict) -> list[str]:
    return ([f"added {name}" for name in sorted(after.keys() - before.keys())]
            + [f"removed {name}" for name in sorted(before.keys() - after.keys())]
            + [f"changed {name}" for name in sorted(before.keys() & after.keys()) if before[name] != after[name]])


def compare_fingerprint(directory: Path, fingerprint: Path) -> dict:
    recorded = json.loads(fingerprint.read_text(encoding="utf-8-sig"))
    if recorded.get("directory") != str(directory.resolve()) or type(recorded.get("files")) is not dict:
        raise ValidationError(f"{fingerprint.name} does not fingerprint {directory}")
    changes = fingerprint_changes(recorded["files"], tree_fingerprint(directory))
    if changes:
        raise ValidationError(f"{directory} differs from its state before pub get ({'; '.join(changes)}): "
                              "the versioned generated files are stale; regenerate and commit them")
    return {"status": "unchanged", "directory": str(directory.resolve()), "files": len(recorded["files"])}


def summarize(directory: Path) -> dict:
    steps = json.loads((directory / "steps.json").read_text(encoding="utf-8-sig"))
    by_name = {step["name"]: step for step in steps}
    required = {"toolchain", "pub-offline", "translations", "google-sdk-notices", "flutter-analyze", "flutter-test", "flutter-fonts",
                "python-tests", "buildsrc", "android-test-lint", "wireguard-gate", "dependency-integrity",
                "build-provenance", "wireguard-protected-start", "openvpn-state", "openvpn-network",
                "openvpn-boundaries", "source-export", "evidence-registry", "isolated-configuration",
                "turnstile-bridge", "command-epochs", "bridge-host"}
    if len(by_name) != len(steps) or required - by_name.keys() or any(step["exitCode"] != 0 for step in steps):
        raise ValidationError("Validation is incomplete or a command failed")
    started = iso_instant(by_name["android-test-lint"]["startedAt"], "android-test-lint startedAt")
    checks = {
        "flutter": flutter_counts(directory / "flutter-test.log"),
        "fonts": flutter_counts(directory / "flutter-fonts.log", font_subset=True),
        "jvm": junit_counts(directory / "junit", started),
        "lint": lint_counts(directory / "lint-results-debug.xml", started),
        "python": python_counts(directory / "python-tests.log"),
    }
    buildsrc = (directory / "buildsrc.log").read_text(encoding="utf-8-sig")
    assertions = [int(value) for value in re.findall(r"(?:AndroidManifestPolicy: |NativeBundlePolicy: |WireGuard AAR policy: )(\d+) (?:checks|tests) passed", buildsrc)]
    if len(assertions) != 3 or min(assertions) < 1:
        raise ValidationError("The three executable buildSrc policy suites did not all execute")
    checks["buildSrc"] = {"assertions": sum(assertions), "suites": len(assertions)}
    checks["wireguard-gate"] = wireguard_gate_counts(directory / "wireguard-gate" / "results.json")
    for name, minimum in (("dependency-integrity", 4),):
        results = json.loads((directory / name / "results.json").read_text(encoding="utf-8-sig"))
        if len(results) < minimum or any(result.get("passed") is not True for result in results):
            raise ValidationError(f"Incomplete or failed integration gate: {name}")
        checks[name] = {"passed": len(results)}
    for name in HOST_BOUNDARY_FILES:
        checks[name] = host_boundary_counts(directory, name, by_name[name])
    vital = directory / "lint-vital-release.txt"
    fresh_file(vital, started)
    if vital.read_text(encoding="utf-8-sig").strip() != "No issues found.":
        raise ValidationError("Unexpected Vital Release lint findings")
    return {"status": "passed", "scope": "local automated checks", "instrumentation": "not executed",
            "generatedAt": datetime.now(timezone.utc).isoformat(), "checks": checks, "steps": steps,
            "note": "The seven font cases repeat existing Flutter cases with additional font assertions; no device or production qualification is implied."}


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    sub = parser.add_subparsers(dest="command", required=True)
    local = sub.add_parser("summarize")
    local.add_argument("--directory", type=Path, required=True)
    instrument = sub.add_parser("check-instrumentation")
    instrument.add_argument("--xml-directory", type=Path, required=True)
    instrument.add_argument("--started-at", required=True,
        help="Actual run start, ISO-8601 with seconds and Z/UTC offset. Every suite needs its own timestamp; allowance is fixed at two seconds.")
    instrument.add_argument("--suite-utc-offset",
        help="Declare the producer's actual fixed UTC offset (UTC or +/-HH:MM) for suite timestamps lacking a timezone. Never changes XML; omitted means reject ambiguous suite timestamps.")
    toolchain = sub.add_parser("go-toolchain", help="Check the Go toolchain of the wireguard-go test (FUZEVPN_GO, else go on PATH) and record its version.")
    toolchain.add_argument("--output", type=Path, required=True)
    snapshot = sub.add_parser("fingerprint", help="Record the SHA-256 of every file below a directory.")
    snapshot.add_argument("--directory", type=Path, required=True)
    snapshot.add_argument("--output", type=Path, required=True)
    compare = sub.add_parser("compare-fingerprint", help="Fail unless a directory still has exactly its recorded files.")
    compare.add_argument("--directory", type=Path, required=True)
    compare.add_argument("--fingerprint", type=Path, required=True)
    args = parser.parse_args()
    try:
        if args.command == "summarize":
            result = summarize(args.directory)
            (args.directory / "summary.json").write_text(json.dumps(result, indent=2) + "\n", encoding="utf-8")
        elif args.command == "go-toolchain":
            result = go_toolchain(args.output)
        elif args.command == "fingerprint":
            files = tree_fingerprint(args.directory)
            args.output.write_text(json.dumps({"directory": str(args.directory.resolve()), "files": files}, indent=2) + "\n",
                                   encoding="utf-8")
            result = {"status": "recorded", "directory": str(args.directory.resolve()), "files": len(files)}
        elif args.command == "compare-fingerprint":
            result = compare_fingerprint(args.directory, args.fingerprint)
        else:
            started = instrumentation_timestamp(args.started_at, "--started-at")
            checked = datetime.now(timezone.utc)
            result = {"status": "passed", "scope": "supplied isolated instrumentation XML",
                      "counts": junit_counts(args.xml_directory, started, isolated=True, checked_at=checked.timestamp(),
                                             suite_offset=args.suite_utc_offset),
                      "freshness": {"source": "each testsuite timestamp and file mtime",
                          "startedAt": datetime.fromtimestamp(started, timezone.utc).isoformat(),
                          "checkedAt": checked.isoformat(), "clockSkewSeconds": INSTRUMENTATION_CLOCK_SKEW_SECONDS,
                          "timezone": "suite Z/offset or explicit producer offset required; compared as UTC instants",
                          "producerLocale": "native digits, Buddhist and Japanese era years are read, never rewritten; every reading must fall inside the window",
                          "declaredNaiveSuiteUtcOffset": args.suite_utc_offset},
                      "note": "Only supplied XML is checked. This command does not execute instrumentation or authenticate locally supplied results."}
        print(json.dumps(result, indent=2))
        return 0
    except (OSError, ValueError, KeyError, ET.ParseError) as error:
        print(f"FAIL: {error}", file=sys.stderr)
        return 1


if __name__ == "__main__":
    raise SystemExit(main())
