# SPDX-License-Identifier: Apache-2.0
"""Tests exercise export safety, byte reproducibility and source provenance."""

import hashlib
import importlib.util
import io
import json
import os
from pathlib import Path
import tarfile
import tempfile
import unittest
from unittest.mock import patch
import zipfile


TOOL = Path(__file__).resolve().parents[1] / "package_android_sources.py"
SPEC = importlib.util.spec_from_file_location("package_android_sources", TOOL)
package = importlib.util.module_from_spec(SPEC)
SPEC.loader.exec_module(package)
VERIFY_INPUTS = package.verify_inputs


class SourcePackageTests(unittest.TestCase):
    def setUp(self):
        self.temporary = tempfile.TemporaryDirectory()
        self.addCleanup(self.temporary.cleanup)
        self.directory = Path(self.temporary.name)
        self.root = self.directory / "project"
        self.root.mkdir()
        self.write("lib/main.dart", "void main() {}\n")
        self.write("android/gradlew", "#!/bin/sh\nexit 0\n")
        self.write("docs/example.md", "Source instructions\n")
        self.versions = {
            "application": "0.1.1+65001", "flutter": "3.44.7", "gradle": "9.5.0",
            "android_gradle_plugin": "9.3.0", "kotlin": "2.3.20", "java": "17",
            "android_compile_sdk": "36", "android_min_sdk": "26", "ndk": "28.2.13676358",
            "cmake": "3.22.1", "go_toolchain": "1.24.3", "native_dependencies": [],
            "go_modules": {}, "openvpn3": {"commit": "pinned-core"},
            "wireguard_android": {"tag": "1.0.20260102", "commit": "pinned-wireguard"},
            "openssl": {"version": "3.5.9", "sourceSha256": "official-hash", "androidApi": 26},
        }
        self.addCleanup(patch.stopall)
        patch.object(package, "collect_versions", return_value=self.versions).start()
        self.validation = patch.object(package, "verify_inputs", return_value=[]).start()

    def write(self, name, content):
        path = self.root / name
        path.parent.mkdir(parents=True, exist_ok=True)
        path.write_bytes(content.encode() if isinstance(content, str) else content)
        return path

    def members(self, output):
        with tarfile.open(output, "r:gz") as archive:
            return {item.name.split("/", 1)[1]: archive.extractfile(item).read()
                    for item in archive if item.isfile()}

    def test_export_is_byte_reproducible_and_all_files_verify(self):
        first, second = self.directory / "first.tar.gz", self.directory / "second.tar.gz"
        result = package.package_sources(self.root, first)
        for source in self.root.rglob("*"):
            os.utime(source, (1234567890, 1234567890))
        package.package_sources(self.root, second)
        self.assertEqual(first.read_bytes(), second.read_bytes())
        self.assertEqual(hashlib.sha256(first.read_bytes()).hexdigest(), result["sha256"])
        content = self.members(first)
        self.assertEqual(b"void main() {}\n", content["lib/main.dart"])
        self.assertNotIn(str(self.root).encode(), content["SOURCE_MANIFEST.json"])
        self.assertNotIn(b"_root", content["SOURCE_MANIFEST.json"])
        for line in content["SHA256SUMS"].decode().splitlines():
            expected, name = line.split("  ", 1)
            self.assertEqual(expected, hashlib.sha256(content[name]).hexdigest())
        with tarfile.open(first) as archive:
            names = archive.getnames()
            self.assertEqual(sorted(names), names)
            for item in archive:
                self.assertEqual((0, 0, 0, "", ""), (item.mtime, item.uid, item.gid, item.uname, item.gname))
                self.assertEqual(0o755 if item.name.endswith("/gradlew") else 0o644, item.mode)

    def test_excludes_credentials_local_paths_and_generated_outputs(self):
        excluded = [
            "android/local.properties", "android/key.properties", "lib/.env",
            "assets/release.keystore", "assets/client.p12", "lib/account.key",
            "lib/account.pem", "tools/credentials.json", "tools/__pycache__/cache.pyc",
            "android/buildSrc/build/classes/Main.class", "android/app/src/main/.cxx/cache",
            "android/app/src/main/.gradle/cache", "android/third_party/wireguard-android/.git",
            "test/widget/failures/actual.png", "tools/cache/output.json", "tools/.staging/files.txt",
            "reports/customer.json", "build/secret.json", "artifacts/client.apk",
            "docs/.env/config.json", "tools/.env.production/nested/config",
            "tools/config.env", "assets/account.dpapi", "test/session.sqlite3",
            "lib/users.db", "tools/passwords.kdbx", "assets/client.ovpn",
            "tools/service-account-production.json", "docs/mot-de-passe-google.txt",
            "test/code-google-play.txt",
        ]
        for name in excluded:
            self.write(name, "DO NOT EXPORT")
        fixtures = f"{package.NATIVE_ROOT}/openvpn3-core/test/unittests/pki/key.pem"
        self.write(fixtures, "PUBLIC UPSTREAM TEST FIXTURE")
        self.write(f"{package.WIREGUARD_ROOT}/dist/reviewed.aar", b"reviewed binary dependency")
        names = package.collect_source_files(self.root)
        self.assertTrue(set(excluded).isdisjoint(names))
        self.assertIn(fixtures, names)
        self.assertIn(f"{package.WIREGUARD_ROOT}/dist/reviewed.aar", names)

    def test_public_licensing_and_contribution_documents_are_included(self):
        documents = ["README.fr.md", "LICENSE", "LICENSING.md", "CONTRIBUTING.md", "SECURITY.md", ".gitattributes"]
        for name in documents:
            self.write(name, "Public source distribution instructions\n")
        self.assertTrue(set(documents).issubset(package.collect_source_files(self.root)))

    def test_build_policy_sources_are_exported_without_generated_or_sensitive_inputs(self):
        for name in package.BUILD_POLICY_INPUTS:
            self.write(name, f"package com.fuzevpn.build;\nclass {Path(name).stem} {{}}\n")
        excluded = [
            "android/buildSrc/build/classes/java/com/fuzevpn/build/Policy.java",
            "android/buildSrc/src/main/java/com/example/build/Other.java",
        ]
        for directory in package.BUILD_POLICY_JAVA_DIRS:
            excluded += [f"{directory}/{name}" for name in (
                "Compiled.class", ".env", "credentials.java", "secrets.json",
                "release.keystore", "cache/Hidden.java", ".gradle/Generated.java",
                "nested/Other.java",
            )]
        for name in excluded:
            self.write(name, "DO NOT EXPORT")
        output = self.directory / "build-policy-sources.tar.gz"
        package.package_sources(self.root, output)
        contents = self.members(output)
        manifest = json.loads(contents["SOURCE_MANIFEST.json"])
        self.assertEqual(6, len(package.BUILD_POLICY_INPUTS))
        for name in package.BUILD_POLICY_INPUTS:
            self.assertEqual((self.root / name).read_bytes(), contents[name])
            self.assertEqual(hashlib.sha256(contents[name]).hexdigest(), manifest["files"][name]["sha256"])
        self.assertTrue(set(excluded).isdisjoint(contents))

    def test_completeness_requires_all_six_build_policy_sources(self):
        versions = dict(self.versions, wireguard_aar_sha256="0" * 64)
        aar = f"{package.WIREGUARD_ROOT}/dist/tunnel-1.0.20260102-fuzevpn-fgs.aar"
        entries = {aar: {"sha256": "0" * 64}}
        with patch.object(package, "verify_native_lock"):
            missing = VERIFY_INPUTS(self.root, entries, versions)
            for name in package.BUILD_POLICY_INPUTS:
                self.assertIn(f"Missing required input: {name}", missing)
            entries.update({name: {"sha256": "0" * 64} for name in package.BUILD_POLICY_INPUTS})
            missing = VERIFY_INPUTS(self.root, entries, versions)
            for name in package.BUILD_POLICY_INPUTS:
                self.assertNotIn(f"Missing required input: {name}", missing)

    def test_apk_hashes_are_associated_without_packaging_apks(self):
        apk = self.directory / "signed-output.apk"
        apk.write_bytes(b"APK bytes used for this release")
        output = self.directory / "source.tar.gz"
        package.package_sources(self.root, output, [apk])
        contents = self.members(output)
        manifest = json.loads(contents["SOURCE_MANIFEST.json"])
        self.assertEqual([{ "file": apk.name, "bytes": apk.stat().st_size,
                           "sha256": hashlib.sha256(apk.read_bytes()).hexdigest()}], manifest["associated_apks"])
        self.assertFalse(any(name.endswith(".apk") for name in contents))
        self.assertNotIn(str(apk).encode(), contents["SOURCE_MANIFEST.json"])
        self.assertIn(apk.name.encode(), contents["README-SOURCE.md"])

    def test_missing_sources_require_explicit_partial_export(self):
        self.validation.return_value = ["Missing complete source component: fmt"]
        output = self.directory / "partial.tar.gz"
        with self.assertRaisesRegex(package.PackageError, "Incomplete source distribution"):
            package.package_sources(self.root, output)
        self.assertFalse(output.exists())
        package.package_sources(self.root, output, allow_incomplete=True)
        contents = self.members(output)
        manifest = json.loads(contents["SOURCE_MANIFEST.json"])
        self.assertEqual("partial", manifest["coverage_status"])
        self.assertEqual(self.validation.return_value, manifest["missing_sources"])
        self.assertIn(b"PARTIAL", contents["README-SOURCE.md"])

    def test_check_mode_creates_no_archive(self):
        output = self.directory / "check-only.tar.gz"
        result = package.package_sources(self.root, output, check_only=True)
        self.assertFalse(output.exists())
        self.assertNotIn("output", result)
        self.assertEqual(3, result["source_entries"])

    def test_existing_output_is_preserved_and_source_outputs_are_refused(self):
        output = self.directory / "previous.tar.gz"
        output.write_bytes(b"previous reviewed export")
        with self.assertRaisesRegex(package.PackageError, "existing source export"):
            package.package_sources(self.root, output)
        self.assertEqual(b"previous reviewed export", output.read_bytes())
        with self.assertRaisesRegex(package.PackageError, "outside the source allowlist"):
            package.package_sources(self.root, self.root / "docs/output.tar.gz")

    def test_filesystem_link_outside_root_is_refused(self):
        secret = self.directory / "private.txt"
        secret.write_text("private", encoding="utf-8")
        link = self.root / "lib/linked.txt"
        try:
            link.symlink_to(secret)
        except OSError as error:
            self.skipTest(f"Creating filesystem links is unavailable: {error}")
        with self.assertRaisesRegex(package.PackageError, "Links/reparse"):
            package.collect_source_files(self.root)

    def test_mutation_after_inventory_aborts_without_publishing(self):
        original = package.sha256_file
        def mutate_after_hash(path):
            digest = original(path)
            if path.name == "main.dart":
                path.write_bytes(b"void main() { changed(); }\n")
            return digest
        with patch.object(package, "sha256_file", side_effect=mutate_after_hash):
            with self.assertRaisesRegex(package.PackageError, "Source changed during packaging"):
                package.package_sources(self.root, self.directory / "changed.tar.gz")
        self.assertFalse((self.directory / "changed.tar.gz").exists())
        self.assertEqual([], list(self.directory.glob(".source-package-*")))

    def test_independent_native_manifest_detects_added_and_changed_inputs(self):
        relative = "openvpn3-core/test/unittests/pki/key.pem"
        source = self.write(f"{package.NATIVE_ROOT}/{relative}", "public fixture")
        digest = package.sha256_file(source)
        self.write(package.NATIVE_LOCK, f"{digest}  {relative}\n")
        entries = {f"{package.NATIVE_ROOT}/{relative}": {"sha256": digest}}
        package.verify_native_lock(self.root, entries)
        entries[f"{package.NATIVE_ROOT}/{relative}"]["sha256"] = "0" * 64
        with self.assertRaisesRegex(package.PackageError, "native lock mismatch"):
            package.verify_native_lock(self.root, entries)
        entries[f"{package.NATIVE_ROOT}/{relative}"]["sha256"] = digest
        entries[f"{package.NATIVE_ROOT}/unexpected.txt"] = {"sha256": digest}
        with self.assertRaisesRegex(package.PackageError, "native lock mismatch"):
            package.verify_native_lock(self.root, entries)

    def test_zip_traversal_duplicate_and_symlink_members_are_rejected(self):
        for invalid in ["../outside", "/absolute", "C:/secret", "module/./hidden", "module//hidden"]:
            source = self.directory / "invalid.zip"
            with zipfile.ZipFile(source, "w") as archive:
                archive.writestr(invalid, b"data")
            with self.assertRaises(package.PackageError):
                package.verify_source_archive(source)
        source = self.directory / "link.zip"
        link = zipfile.ZipInfo("module/link")
        link.create_system = 3
        link.external_attr = 0o120777 << 16
        with zipfile.ZipFile(source, "w") as archive:
            archive.writestr(link, b"../../outside")
        with self.assertRaisesRegex(package.PackageError, "contains a link"):
            package.verify_source_archive(source)
        source = self.directory / "duplicate.zip"
        import warnings
        with warnings.catch_warnings():
            warnings.simplefilter("ignore", UserWarning)
            with zipfile.ZipFile(source, "w") as archive:
                archive.writestr("module/file", b"first")
                archive.writestr("module/file", b"second")
        with self.assertRaisesRegex(package.PackageError, "Duplicate archive"):
            package.verify_source_archive(source)

    def test_tar_links_and_special_files_are_rejected_without_extraction(self):
        for entry_type in [tarfile.SYMTYPE, tarfile.LNKTYPE, tarfile.FIFOTYPE]:
            source = self.directory / "unsafe.tar.gz"
            with tarfile.open(source, "w:gz") as archive:
                member = tarfile.TarInfo("source/link")
                member.type = entry_type
                member.linkname = "../../outside"
                archive.addfile(member)
            with self.assertRaisesRegex(package.PackageError, "link/special"):
                package.verify_source_archive(source)
        self.assertFalse((self.directory / "outside").exists())

    def test_go_module_checksum_uses_canonical_names_and_bytes(self):
        source = self.directory / "module.zip"
        root = "example.com/module@v1.0.0"
        with zipfile.ZipFile(source, "w") as archive:
            archive.writestr(root + "/go.mod", b"module example.com/module\n")
            archive.writestr(root + "/file.go", b"package module\n")
        first = package.verify_source_archive(source, go_module=root)
        self.assertTrue(first.startswith("h1:"))
        # Recompressing/reordering unchanged source does not affect Go h1.
        with zipfile.ZipFile(source, "w", compression=zipfile.ZIP_DEFLATED) as archive:
            archive.writestr(root + "/file.go", b"package module\n")
            archive.writestr(root + "/go.mod", b"module example.com/module\n")
        self.assertEqual(first, package.verify_source_archive(source, go_module=root))
        with zipfile.ZipFile(source, "w") as archive:
            archive.writestr(root + "/file.go", b"package module // modified\n")
            archive.writestr(root + "/go.mod", b"module example.com/module\n")
        self.assertNotEqual(first, package.verify_source_archive(source, go_module=root))
        with self.assertRaisesRegex(package.PackageError, "Unexpected Go module archive root"):
            package.verify_source_archive(source, go_module="example.com/other@v1.0.0")


if __name__ == "__main__":
    unittest.main()
