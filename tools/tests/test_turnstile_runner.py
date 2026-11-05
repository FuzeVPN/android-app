# SPDX-License-Identifier: Apache-2.0
"""A06-turnstile-02: the Turnstile host runner works under Windows PowerShell 5.1.

The real tools/test_turnstile_bridge.ps1 runs in powershell.exe (5.1, the
Windows default) and, when present, in pwsh. Java and Node are replaced by
command scripts that behave like the real tools at the PowerShell boundary:
"java -version", compiler diagnostics and JUnit/Node warnings go to stderr.
No Kotlin, JUnit or Node test is executed here; the full runner with the real
toolchain is recorded in the correction report.
"""
import importlib.util
import json
import os
from pathlib import Path
import shutil
import subprocess
import tempfile
import unittest

TOOLS = Path(__file__).resolve().parents[1]
RUNNER = TOOLS / "test_turnstile_bridge.ps1"
_SPEC = importlib.util.spec_from_file_location("turnstile_receipts", TOOLS / "validation_support.py")
support = importlib.util.module_from_spec(_SPEC)
_SPEC.loader.exec_module(support)
JARS = [("org.jetbrains.kotlin", "kotlin-stdlib", "2.3.20"), ("org.jetbrains.kotlin", "kotlin-compiler-embeddable", "2.3.20"),
        ("org.jetbrains.kotlin", "kotlin-script-runtime", "2.3.20"), ("org.jetbrains.kotlin", "kotlin-reflect", "1.6.10"),
        ("org.jetbrains.kotlin", "kotlin-daemon-embeddable", "2.3.20"), ("org.jetbrains.kotlinx", "kotlinx-coroutines-core-jvm", "1.8.0"),
        ("org.jetbrains", "annotations", "23.0.0"), ("junit", "junit", "4.13.2"), ("org.hamcrest", "hamcrest-core", "1.3"),
        ("org.json", "json", "20240303")]
FAKE_JAVA = r"""@echo off
if "%~1"=="-version" goto version
if "%~3"=="org.jetbrains.kotlin.cli.jvm.K2JVMCompiler" goto compile
if "%~3"=="org.junit.runner.JUnitCore" goto junit
if "%~3"=="com.fuzevpn.android.TurnstileFixtureKt" goto fixture
exit /b 9
:version
>&2 echo openjdk version "17.0.20.1" 2026-08-18
>&2 echo OpenJDK Runtime Environment Temurin-17.0.20.1+1
exit /b 0
:compile
>&2 echo warning: diagnostic written to stderr by the compiler
exit /b %FAKE_COMPILE_EXIT%
:junit
echo JUnit version 4.13.2
echo ............................................
echo Time: 0.01
echo.
echo OK (44 tests)
>&2 echo JUnit stderr line
exit /b %FAKE_JUNIT_EXIT%
:fixture
>&2 echo fixture stderr line
exit /b 0
"""
FAKE_NODE = r"""@echo off
if "%~1"=="--version" goto version
echo Generated HTML/JavaScript: PASS (20 scenarios, no network)
exit /b 0
:version
>&2 echo node prints its banner to stdout; this stderr line must not abort
echo v24.16.0
exit /b 0
"""
FAKE_JUNIT_STDERR = "JUnit stderr line"


def fake_junit_receipt_passed(path):
    """Count the fake JUnit's merged junit.log as the aggregator counts a real one.

    The fake's single stderr line proves that native stderr is captured without
    stopping the runner, but its merged position is not deterministic (see
    FakeJUnitReceiptTests). It must be there exactly once and is the only line
    removed; the unchanged, strict support.host_junit_counts reads the rest.
    """
    lines = path.read_text(encoding="utf-8-sig").splitlines()
    if lines.count(FAKE_JUNIT_STDERR) != 1:
        raise AssertionError(f"the fake JUnit stderr line was not captured exactly once in {path.name}: {lines}")
    lines.remove(FAKE_JUNIT_STDERR)
    stdout_only = path.with_name(path.stem + ".without-fake-stderr.log")
    stdout_only.write_text("\n".join(lines) + "\n", encoding="utf-8")
    return support.host_junit_counts(stdout_only, support.HOST_JUNIT_MINIMUMS["turnstile-bridge"])["passed"]


class FakeJUnitReceiptTests(unittest.TestCase):
    """Pure Python, no shell: the merged junit.log layouts the runner can write.

    Invoke-TestNative merges the fake JUnit's stdout with its single stderr
    line (2>&1). The two pipes are read concurrently, so that line can land
    anywhere: probes of 8000 runs per shell (reaudit R2-c1) saw it at every
    index from 0 to 5, including inside the progress block, at index 1 under
    Windows PowerShell 5.1 and pwsh 7 and at index 2 under pwsh 7.
    """
    STDOUT = ["JUnit version 4.13.2", "." * 44, "Time: 0.01", "", "OK (44 tests)"]

    def setUp(self):
        temporary = tempfile.TemporaryDirectory()
        self.addCleanup(temporary.cleanup)
        self.root = Path(temporary.name)

    def receipt(self, lines, *, bom):
        # Set-Content -Encoding UTF8 writes CRLF, with a BOM under 5.1 only.
        path = self.root / f"junit-{len(list(self.root.iterdir())):03d}.log"
        path.write_bytes((b"\xef\xbb\xbf" if bom else b"") + "".join(line + "\r\n" for line in lines).encode("utf-8"))
        return path

    def test_every_merged_position_of_the_fake_stderr_line_counts_44(self):
        self.assertIn(">&2 echo " + FAKE_JUNIT_STDERR + "\n", FAKE_JAVA)
        for index in range(len(self.STDOUT) + 1):
            for bom in (True, False):
                lines = self.STDOUT[:index] + [FAKE_JUNIT_STDERR] + self.STDOUT[index:]
                with self.subTest(index=index, bom=bom):
                    self.assertEqual(44, fake_junit_receipt_passed(self.receipt(lines, bom=bom)))

    def test_foreign_lines_in_the_progress_block_are_still_refused(self):
        for foreign in ("JUnit stdout noise", "E", FAKE_JUNIT_STDERR + "."):
            lines = self.STDOUT[:1] + [foreign] + self.STDOUT[1:] + [FAKE_JUNIT_STDERR]
            with self.subTest(foreign=foreign), self.assertRaises(support.ValidationError):
                fake_junit_receipt_passed(self.receipt(lines, bom=True))

    def test_the_fake_stderr_line_must_be_captured_exactly_once(self):
        for lines in (self.STDOUT, self.STDOUT + [FAKE_JUNIT_STDERR] * 2):
            with self.subTest(lines=lines), self.assertRaisesRegex(AssertionError, "stderr line"):
                fake_junit_receipt_passed(self.receipt(lines, bom=False))


def shells():
    found = []
    windows = Path(os.environ.get("SystemRoot", r"C:\Windows")) / "System32/WindowsPowerShell/v1.0/powershell.exe"
    if windows.is_file():
        found.append(("Windows PowerShell 5.1", str(windows)))
    core = shutil.which("pwsh")
    if core:
        found.append(("PowerShell 7", core))
    return found


@unittest.skipUnless(os.name == "nt", "Windows PowerShell 5.1 is unavailable on this platform")
class TurnstileRunnerShellTests(unittest.TestCase):
    def setUp(self):
        temporary = tempfile.TemporaryDirectory()
        self.addCleanup(temporary.cleanup)
        self.root = Path(temporary.name)
        self.cache = self.root / "module cache"
        for group, name, version in JARS:
            jar = self.cache / group / name / version / "0000" / f"{name}-{version}.jar"
            jar.parent.mkdir(parents=True)
            jar.write_bytes(b"fixture")
        self.java = self.root / "fake java.cmd"
        self.java.write_text(FAKE_JAVA.replace("\n", "\r\n"), encoding="ascii")
        self.node = self.root / "fake node.cmd"
        self.node.write_text(FAKE_NODE.replace("\n", "\r\n"), encoding="ascii")

    def run_runner(self, shell, output, *, junit_exit="0", compile_exit="0", repository=None):
        environment = dict(os.environ, FAKE_JUNIT_EXIT=junit_exit, FAKE_COMPILE_EXIT=compile_exit)
        if Path(shell).name.lower() == "powershell.exe":
            # PowerShell 7 prepends its own module directories to PSModulePath and
            # removes them only when it starts powershell.exe itself. Launched here
            # through Python (validate_project.ps1 -> python), Windows PowerShell 5.1
            # would load the 7.x Microsoft.PowerShell.Utility and lose Get-FileHash.
            # Copies of os.environ keep Windows' upper-cased keys.
            environment = {key: value for key, value in environment.items() if key.upper() != "PSMODULEPATH"}
        arguments = [shell, "-NoProfile", "-NonInteractive", "-ExecutionPolicy", "Bypass", "-File", str(RUNNER),
                     "-Java", str(self.java), "-Node", str(self.node), "-ModuleCache", str(self.cache),
                     "-OutputDirectory", str(output)]
        if repository:
            arguments += ["-Repository", str(repository)]
        # The default -Repository (derived from the script location) is the
        # first Windows PowerShell 5.1 failure; it is exercised unless supplied.
        return subprocess.run(arguments, capture_output=True, text=True, encoding="utf-8", errors="replace",
                              env=environment, cwd=self.root, timeout=180)

    def test_runner_completes_under_windows_powershell_and_pwsh_with_native_stderr(self):
        available = shells()
        self.assertTrue(available and available[0][0] == "Windows PowerShell 5.1", available)
        for (label, shell), repository in [(entry, None) for entry in available] + [(available[0], TOOLS.parent)]:
            with self.subTest(shell=label, repository=repository):
                output = self.root / f"out {label} {bool(repository)}"
                result = self.run_runner(shell, output, repository=repository)
                self.assertEqual(0, result.returncode, result.stdout + result.stderr)
                record = json.loads((output / "result.json").read_text(encoding="utf-8-sig"))
                self.assertEqual([0, 0, 0], [record[key] for key in ("compileExitCode", "junitExitCode", "javascriptExitCode")])
                context = json.loads((output / "run-context.json").read_text(encoding="utf-8-sig"))
                self.assertEqual(str(TOOLS.parent), context["repository"])
                self.assertIn('version "17.0.20.1"', context["javaVersion"])
                # stderr and stdout are merged by the runner, so their line order is not guaranteed.
                self.assertIn("v24.16.0", context["nodeVersion"].splitlines())
                self.assertIn("OK (44 tests)", (output / "junit.log").read_text(encoding="utf-8-sig"))
                # The receipts are those the runner's aggregator reads, at its current
                # minimum, once the fake's own stderr line is set aside wherever it landed.
                self.assertEqual(44, fake_junit_receipt_passed(output / "junit.log"))
                self.assertIn("warning: diagnostic written to stderr", (output / "compile.log").read_text(encoding="utf-8-sig"))
                self.assertEqual("Generated HTML/JavaScript: PASS (20 scenarios, no network)",
                                 (output / "javascript.log").read_text(encoding="utf-8-sig").strip())

    def test_failures_still_stop_the_runner_without_a_receipt(self):
        for label, shell in shells():
            for case, kwargs in [("junit", {"junit_exit": "1"}), ("compile", {"compile_exit": "1"})]:
                with self.subTest(shell=label, case=case):
                    output = self.root / f"fail {label} {case}"
                    result = self.run_runner(shell, output, **kwargs)
                    self.assertNotEqual(0, result.returncode, result.stdout + result.stderr)
                    self.assertFalse((output / "result.json").exists())


if __name__ == "__main__":
    unittest.main()
