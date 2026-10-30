# SPDX-License-Identifier: Apache-2.0
"""A10-wireguard-05: the reviewed WireGuard patch series applies whatever the line endings.

The upstream files touched by the series are reconstructed from the reviewed
tree (android/third_party/wireguard-android) by reverse application, then
staged as `git archive` writes them with core.autocrlf=false (LF) or true
(CRLF). The real helper used by tools/import_wireguard_android.ps1 must apply
the reviewed patch bytes to both and reproduce the reviewed sources (ignoring
CR) and the byte-exact runtime patch files pinned in the import metadata.
"""
import hashlib
import json
import os
from pathlib import Path
import re
import shutil
import subprocess
import tempfile
import unittest

TOOLS = Path(__file__).resolve().parents[1]
REPOSITORY = TOOLS.parent
REVIEWED = REPOSITORY / "android/third_party/wireguard-android"
PATCH_DIRECTORY = REPOSITORY / "patches/wireguard-android"
HELPER = TOOLS / "wireguard_patch_series.ps1"


def lf(data: bytes) -> bytes:
    return data.replace(b"\r\n", b"\n")


def crlf(data: bytes) -> bytes:
    return lf(data).replace(b"\n", b"\r\n")


def powershell():
    windows = Path(os.environ.get("SystemRoot", r"C:\Windows")) / "System32/WindowsPowerShell/v1.0/powershell.exe"
    return str(windows) if windows.is_file() else shutil.which("pwsh")


@unittest.skipUnless(powershell(), "PowerShell is unavailable on this platform")
class WireGuardPatchSeriesTests(unittest.TestCase):
    def setUp(self):
        temporary = tempfile.TemporaryDirectory()
        self.addCleanup(temporary.cleanup)
        self.root = Path(temporary.name)
        series = (REVIEWED / "patches/fuzevpn/series").read_text(encoding="utf-8").split()
        self.patches = [PATCH_DIRECTORY / name for name in series]
        for patch in self.patches:  # The two reviewed copies are identical.
            self.assertEqual(patch.read_bytes(), (REVIEWED / "patches/fuzevpn" / patch.name).read_bytes())
        self.targets = list(dict.fromkeys(match.decode() for patch in self.patches
                                          for match in re.findall(rb"(?m)^\+\+\+ b/([^\t\r\n]+)", patch.read_bytes())))
        self.upstream = self.reconstruct_upstream()

    def git(self, directory, *arguments, check=True):
        return subprocess.run(["git", "-c", "core.autocrlf=false", "-c", "core.eol=lf", *arguments], cwd=directory,
                              capture_output=True, text=True, check=check)

    def reconstruct_upstream(self):
        recon = self.root / "reconstruction"
        for relative in self.targets:
            if (REVIEWED / relative).is_file():
                (recon / relative).parent.mkdir(parents=True, exist_ok=True)
                (recon / relative).write_bytes(lf((REVIEWED / relative).read_bytes()))
        self.git(self.root, "init", "-q", str(recon))
        for patch in reversed(self.patches):
            normalized = self.root / ("reverse-" + patch.name)
            normalized.write_bytes(lf(patch.read_bytes()))
            self.git(recon, "apply", "-R", "--whitespace=nowarn", str(normalized))
        return {relative: (recon / relative).read_bytes() for relative in self.targets if (recon / relative).is_file()}

    def stage(self, name, convert):
        staged = self.root / name
        for relative, data in self.upstream.items():
            (staged / relative).parent.mkdir(parents=True, exist_ok=True)
            (staged / relative).write_bytes(convert(data))
        self.git(self.root, "init", "-q", str(staged))
        return staged

    def apply_series(self, staged):
        patches = ",".join("'" + str(patch).replace("'", "''") + "'" for patch in self.patches)
        command = (f". '{str(HELPER).replace(chr(39), chr(39) * 2)}'; $ErrorActionPreference = 'Stop'; "
                   f"Invoke-WireGuardPatchSeries -StagedSource '{str(staged).replace(chr(39), chr(39) * 2)}' -Patches @({patches})")
        return subprocess.run([powershell(), "-NoProfile", "-NonInteractive", "-ExecutionPolicy", "Bypass", "-Command", command],
                              capture_output=True, text=True, encoding="utf-8", errors="replace", timeout=180)

    def test_reconstructed_upstream_reproduces_the_audit_failure_with_strict_application(self):
        # The previous import applied the reviewed bytes directly (git apply --check).
        failures = {}
        for name, convert in (("lf", lf), ("crlf", crlf)):
            staged = self.stage("strict-" + name, convert)
            for patch in self.patches:
                if self.git(staged, "apply", "--check", str(patch), check=False).returncode:
                    failures[name] = patch.name
                    break
                self.git(staged, "apply", str(patch))
        # Audit matrix (28/10): LF export -> 0001 refused; CRLF export -> 0002 refused.
        self.assertIn("crlf", failures)
        if [patch.name[:4] for patch in self.patches[:3]] == ["0001", "0002", "0003"]:
            self.assertEqual({"lf": self.patches[0].name, "crlf": self.patches[1].name}, failures)

    def test_series_applies_to_lf_and_crlf_exports_and_reproduces_the_reviewed_sources(self):
        metadata = json.loads((REVIEWED / "FUZEVPN-IMPORT-METADATA.json").read_text(encoding="utf-8"))["nativeRuntime"]
        pinned = {metadata["runtimePatch"]: metadata["runtimePatchSha256"],
                  metadata["runtimePatchManifest"]: metadata["runtimePatchManifestSha256"]}
        before = {patch: hashlib.sha256(patch.read_bytes()).hexdigest() for patch in self.patches}
        for name, convert in (("lf", lf), ("crlf", crlf)):
            with self.subTest(export=name):
                staged = self.stage("import-" + name, convert)
                untouched = staged / "tunnel/untouched.bat"
                untouched.write_bytes(b"@echo off\r\nrem keeps its CRLF bytes\r\n")
                result = self.apply_series(staged)
                self.assertEqual(0, result.returncode, result.stdout + result.stderr)
                for relative in self.targets:
                    produced = (staged / relative).read_bytes()
                    self.assertEqual(lf((REVIEWED / relative).read_bytes()), produced, relative)
                    self.assertNotIn(b"\r\n", produced, relative)
                for relative, digest in pinned.items():
                    self.assertEqual(digest, hashlib.sha256((staged / relative).read_bytes()).hexdigest(), relative)
                self.assertEqual(b"@echo off\r\nrem keeps its CRLF bytes\r\n", untouched.read_bytes())
        self.assertEqual(before, {patch: hashlib.sha256(patch.read_bytes()).hexdigest() for patch in self.patches})

    def test_a_patch_that_does_not_match_the_sources_is_still_refused(self):
        staged = self.stage("conflict", lf)
        target = staged / self.targets[0]
        target.write_bytes(target.read_bytes().replace(b"<manifest", b"<changed-manifest", 1))
        result = self.apply_series(staged)
        self.assertNotEqual(0, result.returncode)
        self.assertIn("does not apply cleanly", result.stdout + result.stderr)

    def test_reimport_differs_from_the_aar_provenance_and_the_documents_say_how_to_proceed(self):
        # Review of A10-wireguard-05: a reimport is identical to the reviewed tree
        # except for CR, so jni.c no longer matches the approved AAR's sourceHashes.
        provenance = json.loads((REVIEWED / "dist/tunnel-1.0.20260102-fuzevpn-fgs.metadata.json")
                                .read_text(encoding="utf-8"))["nativeBuild"]["sourceHashes"]
        jni = "tunnel/tools/libwg-go/jni.c"
        reviewed = (REVIEWED / jni).read_bytes()
        self.assertIn(jni, self.targets)
        self.assertEqual(provenance["jni.c"], hashlib.sha256(reviewed).hexdigest())
        staged = self.stage("provenance", lf)
        result = self.apply_series(staged)
        self.assertEqual(0, result.returncode, result.stdout + result.stderr)
        produced = (staged / jni).read_bytes()
        self.assertEqual(lf(reviewed), produced)
        self.assertNotEqual(provenance["jni.c"], hashlib.sha256(produced).hexdigest())
        for document in ("docs/NATIVE_DEPENDENCIES.md", "docs/SOURCE_DISTRIBUTION.md"):
            text = " ".join((REPOSITORY / document).read_text(encoding="utf-8").split())
            with self.subTest(document=document):
                self.assertNotIn("reproduit l’arbre revu à fins de ligne près", text)
                self.assertNotIn("produit les sources revues à fins de ligne près", text)
                for required in ("n’est pas identique à l’octet", "`nativeBuild.sourceHashes`", "`jni.c`",
                                 "`tools/generate_release_sbom.py`", "`build_wireguard_native.ps1`",
                                 "`build_wireguard_patched_aar.ps1`", "`WireGuardAarPolicy`",
                                 "l’arbre versionné reste la référence", "`wireguard-tools`", "`elf-cleaner`",
                                 "`core.autocrlf`"):
                    self.assertIn(required, text)

    def test_import_script_uses_the_helper_and_exports_committed_bytes(self):
        script = (TOOLS / "import_wireguard_android.ps1").read_text(encoding="utf-8")
        self.assertIn(". (Join-Path $PSScriptRoot 'wireguard_patch_series.ps1')", script)
        self.assertIn("Invoke-WireGuardPatchSeries -StagedSource $stagedSource", script)
        self.assertRegex(script, r"git -C \$WireGuardAndroidSource -c core\.autocrlf=false -c core\.eol=lf archive")
        self.assertNotRegex(script, r"apply --check \$patch\.path")


if __name__ == "__main__":
    unittest.main()
