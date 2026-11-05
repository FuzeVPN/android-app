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
LINK_SKIP_REASON = "Creating filesystem links and junctions is unavailable"


def make_symlink(link: Path, target: Path) -> None:
    link.symlink_to(target)  # Windows needs SeCreateSymbolicLinkPrivilege or developer mode.


def make_junction(link: Path, target: Path) -> None:
    # A directory junction is a real reparse point that any Windows account can create.
    if os.name != "nt":
        raise OSError("Directory junctions exist only on Windows")
    import _winapi
    _winapi.CreateJunction(str(target), str(link))


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
        with patch.object(package, "verify_native_lock"), patch.object(package, "verify_application_inputs", return_value=[]):
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
        secret = self.directory / "private"
        secret.mkdir()
        (secret / "private.txt").write_text("private", encoding="utf-8")
        created, errors = [], []
        # A symbolic link needs a privilege on Windows; a junction does not. Each
        # link that can be created must be refused, so an account without the
        # symbolic-link privilege still exercises a real reparse point.
        for kind, make, target in [("symlink", make_symlink, secret / "private.txt"),
                                   ("junction", make_junction, secret)]:
            link = self.root / f"lib/linked-{kind}"
            try:
                make(link, target)
            except OSError as error:
                errors.append(f"{kind}: {error}")
                continue
            created.append(kind)
            with self.subTest(kind=kind), self.assertRaisesRegex(package.PackageError, "Links/reparse"):
                package.collect_source_files(self.root)
            if kind == "junction":
                os.rmdir(link)  # Removes the junction only, never its target.
            else:
                link.unlink()
            self.assertTrue((secret / "private.txt").is_file())
        if not created:
            self.skipTest(f"{LINK_SKIP_REASON}: {'; '.join(errors)}")
        self.assertEqual(["lib/main.dart"], [name for name in package.collect_source_files(self.root) if name.startswith("lib/")])

    def test_missing_symlink_privilege_still_refuses_a_real_reparse_point(self):
        # A18-tooling-evidence-07: model the account without SeCreateSymbolicLinkPrivilege.
        refused = OSError(22, "A required privilege is not held by the client", None, 1314)
        loader, stream = unittest.TestLoader(), io.StringIO()
        with patch(f"{__name__}.make_symlink", side_effect=refused):
            result = unittest.TextTestRunner(stream=stream, verbosity=2).run(
                loader.loadTestsFromName("test_filesystem_link_outside_root_is_refused", SourcePackageTests))
            if os.name == "nt":
                self.assertTrue(result.wasSuccessful(), stream.getvalue())
                self.assertEqual([], result.skipped, stream.getvalue())
        with patch(f"{__name__}.make_symlink", side_effect=refused), \
                patch(f"{__name__}.make_junction", side_effect=OSError("junctions unavailable")):
            stream = io.StringIO()
            suite = unittest.TestSuite([loader.loadTestsFromName(name, SourcePackageTests) for name in
                                        ("test_check_mode_creates_no_archive", "test_filesystem_link_outside_root_is_refused")])
            result = unittest.TextTestRunner(stream=stream, verbosity=2).run(suite)
        self.assertEqual(1, len(result.skipped), stream.getvalue())
        self.assertTrue(result.skipped[0][1].startswith(LINK_SKIP_REASON))
        # The runner's counter accepts exactly this explicit, motivated skip.
        spec = importlib.util.spec_from_file_location("link_skip_support", TOOL.with_name("validation_support.py"))
        support = importlib.util.module_from_spec(spec)
        spec.loader.exec_module(support)
        log = Path(self.temporary.name) / "python-tests.log"
        log.write_text(stream.getvalue(), encoding="utf-8")
        counts = support.python_counts(log)
        self.assertEqual((2, 1, 1), (counts["total"], counts["passed"], counts["skipped"]))
        self.assertTrue(counts["acceptedSkips"][0]["test"].endswith(
            "test_package_android_sources.SourcePackageTests.test_filesystem_link_outside_root_is_refused"))

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


class PhysicalApplicationCompletenessTests(unittest.TestCase):
    """Real package validation on complete and deliberately incomplete source trees.

    Only official archive identities are replaced with small fixture identities;
    collection, manifest/resource parsing, inventories and validation all run.
    """

    def setUp(self):
        self.temporary = tempfile.TemporaryDirectory()
        self.addCleanup(self.temporary.cleanup)
        self.root = Path(self.temporary.name) / "project"
        self.root.mkdir()
        for name in package.ROOT_FILES + package.APPLICATION_INPUTS + package.BUILD_POLICY_INPUTS + package.RELEASE_VALIDATION_INPUTS:
            # Python inputs are parsed by the runner-input derivation: keep them valid Python.
            self.write(name, "# public fixture input\n" if name.endswith(".py") else "public fixture input\n")
        self.write(".flutter-version", "3.44.7\n")
        self.write("pubspec.yaml", """name: fixture
version: 1.0.0+1
flutter:
  assets:
    - assets/images/icon.png
    - 'assets/flags/' # directory declaration
  fonts:
    - family: Fixture
      fonts:
        - asset: "assets/fonts/example.ttf"
""")
        self.write("android/gradle/wrapper/gradle-wrapper.properties", "distributionUrl=gradle-9.5.0-bin.zip\n")
        self.write("android/settings.gradle.kts", 'id("com.android.application") version "9.3.0"\nid("org.jetbrains.kotlin.android") version "2.3.20"\n')
        self.write("android/app/build.gradle.kts", 'namespace = "com.fuzevpn.android"\nsourceCompatibility = JavaVersion.VERSION_17\ncompileSdk = 36\nminSdk = 26\nndkVersion = "28.2.13676358"\nversion = "3.22.1"\n')
        self.write("lib/main.dart", "void main() {}\n")
        self.write("android/app/src/main/kotlin/com/fuzevpn/android/SharedVpnHost.kt", "package com.fuzevpn.android\nclass FuzeVpnApplication\n")
        for name in ("assets/images/icon.png", "assets/flags/fr.svg", "assets/fonts/example.ttf"):
            self.write(name, "fixture asset")
        self.write("android/app/src/main/AndroidManifest.xml", '''<manifest xmlns:android="http://schemas.android.com/apk/res/android"><application android:name="com.fuzevpn.android.FuzeVpnApplication" android:icon="@mipmap/ic_launcher" android:label="@string/app_name" android:theme="@style/AppTheme" android:fullBackupContent="@xml/backup_rules"><activity android:name=".MainActivity"/></application></manifest>''')
        self.write("android/app/src/main/res/mipmap-anydpi/ic_launcher.xml", '<bitmap xmlns:android="http://schemas.android.com/apk/res/android" android:src="@drawable/foreground"/>')
        self.write("android/app/src/main/res/drawable/foreground.xml", '<vector xmlns:android="http://schemas.android.com/apk/res/android"><path android:fillColor="@color/background"/></vector>')
        self.write("android/app/src/main/res/values/strings.xml", '<resources><string name="app_name">Fixture</string></resources>')
        self.write("android/app/src/main/res/values/styles.xml", '<resources><style name="AppTheme" parent="@android:style/Theme.Material"/></resources>')
        self.write("android/app/src/main/res/values/colors.xml", '<resources><color name="background">#ffffff</color></resources>')
        self.write("android/app/src/main/res/xml/backup_rules.xml", '<full-backup-content/>')

        archive = self.archive(f"{package.NATIVE_ROOT}/openssl/source/openssl-3.5.9.tar.gz")
        go_archive = self.archive("android/source-distribution/archives/go-fixture.src.tar.gz")
        self.addCleanup(patch.stopall)
        patch.object(package, "OPENSSL_SHA256", package.sha256_file(archive)).start()
        patch.object(package, "GO_SOURCE_SHA256", package.sha256_file(go_archive)).start()
        self.write_json(f"{package.NATIVE_ROOT}/IMPORT-METADATA.json", {"openvpn3": {"commit": "fixture-core"}})
        self.write_json(f"{package.NATIVE_ROOT}/openssl/IMPORT-METADATA.json", {"version": "3.5.9", "sourceSha256": package.OPENSSL_SHA256, "androidApi": 26})
        self.write_json(f"{package.NATIVE_ROOT}/deps/DEPENDENCIES-METADATA.json", {"sources": []})
        for name in ("openssl-3.5.9.tar.gz.asc", "pubkeys.asc"):
            self.write(f"{package.NATIVE_ROOT}/openssl/source/{name}", "public fixture")
        self.write_json(f"{package.WIREGUARD_ROOT}/FUZEVPN-IMPORT-METADATA.json", {"source": {"tag": "fixture", "commit": "fixture-wireguard"}})
        aar = self.write(f"{package.WIREGUARD_ROOT}/dist/tunnel-1.0.20260102-fuzevpn-fgs.aar", "fixture AAR")
        self.write_json(f"{package.WIREGUARD_ROOT}/dist/tunnel-1.0.20260102-fuzevpn-fgs.metadata.json", {"sha256": package.sha256_file(aar), "nativeBuild": {"go": "go version go1.26.9 windows/amd64"}})
        for name in ("wireguard-tools/COPYING", "elf-cleaner/COPYING", "libwg-go/api-android.go", "libwg-go/go.mod", "libwg-go/go.sum"):
            self.write(f"{package.WIREGUARD_ROOT}/tunnel/tools/{name}", "" if name.endswith("go.sum") else "public source")
        self.write(f"{package.WIREGUARD_ROOT}/patches/fuzevpn/series", "0001-fixture.patch\n0002-fixture.patch\n")
        for name in ("android/gradle/verification-metadata.xml", "android/gradle/dependency-locks/app-maven.lockfile", "android/gradle/dependency-locks/app-patched.lockfile", "android/gradle/dependency-locks/url_launcher_android.lockfile", "docs/SOURCE_DISTRIBUTION.md", "tools/package_android_sources.py", "tools/tests/test_package_android_sources.py"):
            self.write(name, "# public fixture input" if name.endswith(".py") else "public fixture input")
        self.inventory(package.NATIVE_ROOT, package.NATIVE_LOCK)
        self.write_json(package.EXTRA_MANIFEST, {"schema": 1, "components": [{"name": "go", "version": "1.26.9", "path": "android/source-distribution/archives/go-fixture.src.tar.gz", "sha256": package.GO_SOURCE_SHA256}], "missing_sources": []})
        self.inventory("android/source-distribution", "android/source-distribution/SHA256SUMS")

    def write(self, name, content):
        path = self.root / name
        path.parent.mkdir(parents=True, exist_ok=True)
        path.write_bytes(content.encode("utf-8") if isinstance(content, str) else content)
        return path

    def write_json(self, name, content):
        return self.write(name, json.dumps(content) + "\n")

    def archive(self, name):
        path = self.root / name
        path.parent.mkdir(parents=True, exist_ok=True)
        with tarfile.open(path, "w:gz") as target:
            data = b"public fixture source\n"
            member = tarfile.TarInfo("fixture/source.txt")
            member.size = len(data)
            target.addfile(member, io.BytesIO(data))
        return path

    def inventory(self, base, destination):
        source = self.root / base
        lines = [f"{package.sha256_file(path)}  {path.relative_to(source).as_posix()}\n" for path in sorted(source.rglob("*")) if path.is_file() and path != self.root / destination]
        self.write(destination, "".join(lines))

    def test_complete_physical_application_passes_without_validation_mocks(self):
        result = package.package_sources(self.root, check_only=True)
        self.assertEqual("required-project-native-inputs-present", result["coverage_status"])
        self.assertEqual([], result["missing_sources"])

    def test_each_missing_entry_point_is_refused_and_explicit_partial_is_reported(self):
        for name in package.APPLICATION_INPUTS:
            with self.subTest(input=name):
                path = self.root / name
                content = path.read_bytes()
                path.unlink()
                try:
                    with self.assertRaisesRegex(package.PackageError, "Incomplete source distribution"):
                        package.package_sources(self.root, check_only=True)
                    result = package.package_sources(self.root, check_only=True, allow_incomplete=True)
                    self.assertEqual("partial", result["coverage_status"])
                    self.assertIn(f"Missing required application input: {name}", result["missing_sources"])
                finally:
                    path.write_bytes(content)

    def test_incomplete_physical_archive_is_refused_or_explicitly_labelled_partial(self):
        (self.root / "lib/main.dart").unlink()
        output = self.root.parent / "incomplete.tar.gz"
        with self.assertRaisesRegex(package.PackageError, "Missing required application input: lib/main.dart"):
            package.package_sources(self.root, output)
        self.assertFalse(output.exists())
        package.package_sources(self.root, output, allow_incomplete=True)
        with tarfile.open(output) as archive:
            manifest = json.load(archive.extractfile("FuzeVPN-Android-source-1.0.0+1/SOURCE_MANIFEST.json"))
            readme = archive.extractfile("FuzeVPN-Android-source-1.0.0+1/README-SOURCE.md").read()
            self.assertFalse(any(name.endswith("/lib/main.dart") for name in archive.getnames()))
        self.assertEqual("partial", manifest["coverage_status"])
        self.assertIn("Missing required application input: lib/main.dart", manifest["missing_sources"])
        self.assertIn(b"PARTIAL", readme)

    def test_pubspec_assets_fonts_and_nonempty_directories_are_required(self):
        for name in ("assets/images/icon.png", "assets/flags/fr.svg", "assets/fonts/example.ttf"):
            with self.subTest(input=name):
                path = self.root / name
                content = path.read_bytes()
                path.unlink()
                try:
                    with self.assertRaisesRegex(package.PackageError, "Missing Flutter asset/font input"):
                        package.package_sources(self.root, check_only=True)
                finally:
                    path.write_bytes(content)

    def test_flutter_paths_use_yaml_block_indentation_and_reject_inline_or_alias_inputs(self):
        pubspec = self.root / "pubspec.yaml"
        original = pubspec.read_text(encoding="utf-8")
        wider = "\n".join("  " + line if line.startswith(" ") else line for line in original.splitlines()) + "\n"
        pubspec.write_text(wider, encoding="utf-8")
        self.assertEqual([], package.package_sources(self.root, check_only=True)["missing_sources"])
        for declaration in ("  assets: [assets/missing.png]", "  assets:\n    - *external_assets"):
            pubspec.write_text("name: fixture\nversion: 1.0.0+1\nflutter:\n" + declaration + "\n", encoding="utf-8")
            with self.assertRaisesRegex(package.PackageError, "block-style"):
                package.package_sources(self.root, check_only=True)

    def test_manifest_resources_and_transitive_drawable_colors_are_required(self):
        for name, reference in (("xml/backup_rules.xml", "xml/backup_rules"), ("mipmap-anydpi/ic_launcher.xml", "mipmap/ic_launcher"), ("drawable/foreground.xml", "drawable/foreground"), ("values/colors.xml", "color/background"), ("values/strings.xml", "string/app_name")):
            with self.subTest(input=name):
                path = self.root / "android/app/src/main/res" / name
                content = path.read_bytes()
                path.unlink()
                try:
                    with self.assertRaisesRegex(package.PackageError, f"Missing Android resource: @{reference}"):
                        package.package_sources(self.root, check_only=True)
                finally:
                    path.write_bytes(content)

    def test_manifest_local_components_require_sources(self):
        manifest = self.root / "android/app/src/main/AndroidManifest.xml"
        manifest.write_text(manifest.read_text().replace("</application>", '<service xmlns:android="http://schemas.android.com/apk/res/android" android:name=".RequiredService"/></application>'), encoding="utf-8")
        with self.assertRaisesRegex(package.PackageError, "Missing Android component source: com.fuzevpn.android.RequiredService"):
            package.package_sources(self.root, check_only=True)
        self.write("android/app/src/main/kotlin/com/fuzevpn/android/RequiredService.kt", "public source")
        self.assertEqual([], package.package_sources(self.root, check_only=True)["missing_sources"])
        (self.root / "android/app/src/main/kotlin/com/fuzevpn/android/SharedVpnHost.kt").unlink()
        with self.assertRaisesRegex(package.PackageError, "Missing Android component source: com.fuzevpn.android.FuzeVpnApplication"):
            package.package_sources(self.root, check_only=True)

    def test_dart_imported_fixtures_parts_and_local_package_sources_are_required(self):
        self.write("test/regression_test.dart", "import 'fixtures/synthetic_tls_fixture.dart';\nimport 'package:fixture/core/helper.dart';\nimport '../lib/main.dart';\nimport 'package:flutter_test/flutter_test.dart';\n")
        self.write("lib/core/helper.dart", "part 'helper_part.dart';\n")
        with self.assertRaisesRegex(package.PackageError, "Missing Dart source/fixture: test/fixtures/synthetic_tls_fixture.dart"):
            package.package_sources(self.root, check_only=True)
        self.write("test/fixtures/synthetic_tls_fixture.dart", "const syntheticFixture = 'public test data';\n")
        with self.assertRaisesRegex(package.PackageError, "Missing Dart source/fixture: lib/core/helper_part.dart"):
            package.package_sources(self.root, check_only=True)
        self.write("lib/core/helper_part.dart", "part of 'helper.dart';\n")
        self.assertEqual([], package.package_sources(self.root, check_only=True)["missing_sources"])
        self.write("test/regression_test.dart", "import '../../outside.dart';\n")
        with self.assertRaisesRegex(package.PackageError, "Unsafe relative path"):
            package.package_sources(self.root, check_only=True)

    def test_static_golden_test_fixture_cannot_be_omitted(self):
        self.write("test/widget/golden_test.dart", "void test() { matchesGoldenFile('goldens/fixture.png'); }\n")
        with self.assertRaisesRegex(package.PackageError, "Missing golden fixture: test/widget/goldens/fixture.png"):
            package.package_sources(self.root, check_only=True)
        self.write("test/widget/goldens/fixture.png", b"synthetic golden fixture bytes")
        self.assertEqual([], package.package_sources(self.root, check_only=True)["missing_sources"])

    def test_resource_or_pubspec_traversal_and_xml_entities_are_rejected(self):
        pubspec = self.root / "pubspec.yaml"
        original = pubspec.read_text(encoding="utf-8")
        pubspec.write_text(original.replace("assets/images/icon.png", "../private.png"), encoding="utf-8")
        with self.assertRaisesRegex(package.PackageError, "Unsafe relative path"):
            package.package_sources(self.root, check_only=True, allow_incomplete=True)
        pubspec.write_text(original, encoding="utf-8")
        self.write("android/app/src/main/res/xml/backup_rules.xml", '<!DOCTYPE foo [<!ENTITY value "text">]><full-backup-content/>')
        with self.assertRaisesRegex(package.PackageError, "XML declarations/entities"):
            package.package_sources(self.root, check_only=True)

    def test_required_validation_workflow_is_exported_and_cannot_be_omitted(self):
        relative = ".github/workflows/validate.yml"
        self.assertIn(relative, package.collect_source_files(self.root))
        (self.root / relative).unlink()
        with self.assertRaisesRegex(package.PackageError, "Missing required input: .github/workflows/validate.yml"):
            package.package_sources(self.root, check_only=True)

    # A18-tooling-evidence-02: inputs required by the runner and by compilation.
    def assert_missing(self, expected):
        with self.assertRaisesRegex(package.PackageError, expected):
            package.package_sources(self.root, check_only=True)
        self.assertIn("partial", package.package_sources(self.root, check_only=True, allow_incomplete=True)["coverage_status"])

    def test_scripts_and_files_used_by_the_validation_runner_are_required(self):
        self.write(package.VALIDATION_RUNNER, "\n".join([
            "$projectRoot = [IO.Path]::GetFullPath((Join-Path $PSScriptRoot '..'))",
            "$OutputDirectory = Join-Path $projectRoot ('build/reports/validation/')",
            "Invoke-ValidationStep 'translations' $PythonExecutable @('tools/generate_translations.py', '--check')",
            "Invoke-ValidationStep 'python-tests' $PythonExecutable @('-m', 'unittest', 'discover', '-s', 'tools/tests', '-v')",
            "Invoke-ValidationStep 'fonts' $flutter @('test', 'test/widget/app_ui_test.dart')",
            "Invoke-ProjectScript 'turnstile-bridge' 'test_turnstile_bridge.ps1' @('-OutputDirectory', (Join-Path $OutputDirectory 'x'))",
            "Invoke-ValidationStep 'command-epochs' $shell @('-File', (Join-Path $projectRoot 'android/app/src/test/command-epoch/run.ps1'))",
            "$properties | Set-Content -LiteralPath (Join-Path $projectRoot 'android/local.properties')"]) + "\n")
        runner = [
            "if (-not $Repository) { $Repository = Split-Path -Parent (Split-Path -Parent $MyInvocation.MyCommand.Path) }",
            "$testRepository = [IO.Path]::GetFullPath($Repository)",
            "$testHostRoot = Join-Path $testRepository 'android/app/src/testHost/turnstile'",
            "$testSourceRoot = Join-Path $testRepository 'android/app/src/main/kotlin/com/fuzevpn/android'",
            "if (-not $OutputDirectory) { $OutputDirectory = Join-Path $testRepository 'build/reports/turnstile' }",
            "$testSources = @((Join-Path $testSourceRoot 'TurnstilePolicy.kt'), (Join-Path $testHostRoot 'HostTest.kt'))",
            "& $Node (Join-Path $testHostRoot 'turnstile-document-test.cjs') $testOutput"]
        epochs = ["$repository = [IO.Path]::GetFullPath((Join-Path $PSScriptRoot '../../../../..'))",
                  '$native="$repository/android/app/src/main/kotlin/com/fuzevpn/android"',
                  '$bridge=[IO.File]::ReadAllText("$native/AndroidVpnBridge.kt")',
                  '$template=[IO.File]::ReadAllText("$PSScriptRoot/SystemVpnCommandEpoch.template.kt")']
        required = {
            "tools/generate_translations.py": "print('fixture')\n",
            "test/widget/app_ui_test.dart": "void main() {}\n",
            "tools/test_turnstile_bridge.ps1": "\n".join(runner) + "\n",
            "android/app/src/test/command-epoch/run.ps1": "\n".join(epochs) + "\n",
            "android/app/src/main/kotlin/com/fuzevpn/android/TurnstilePolicy.kt": "package com.fuzevpn.android\nobject TurnstilePolicy\n",
            "android/app/src/testHost/turnstile/HostTest.kt": "package com.fuzevpn.android\nclass HostTest { val policy = TurnstilePolicy }\n",
            "android/app/src/testHost/turnstile/turnstile-document-test.cjs": "'use strict';\n",
            "android/app/src/test/command-epoch/SystemVpnCommandEpoch.template.kt": "package com.fuzevpn.android\n",
            "android/app/src/main/kotlin/com/fuzevpn/android/AndroidVpnBridge.kt": "package com.fuzevpn.android\nclass AndroidVpnBridge\n",
        }
        for name, content in required.items():
            self.write(name, content)
        self.assertEqual([], package.package_sources(self.root, check_only=True)["missing_sources"])
        for name in required:
            with self.subTest(removed=name):
                path = self.root / name
                content = path.read_bytes()
                path.unlink()
                try:
                    self.assert_missing("Missing (validation runner input|Kotlin source declaring)")
                finally:
                    path.write_bytes(content)

    def test_kotlin_sources_referenced_without_import_or_by_project_imports_are_required(self):
        kotlin = "android/app/src/main/kotlin/com/fuzevpn/android/"
        self.write(kotlin + "MainActivity.kt", "package com.fuzevpn.android\n\nimport android.app.Activity\n"
                   "import com.fuzevpn.android.openvpn.OpenVpnController\n\n"
                   "/** NotAReference in a comment. */\nclass MainActivity : Activity() {\n"
                   "    private var bridge: NativeTurnstileBridge? = null\n"
                   "    private val label = \"Text ${Formatter.format(1)} and NotAReference\"\n"
                   "    fun `Backtick NotAReference`() = OpenVpnController()\n}\n"
                   # Inside an Activity subclass a bare name may be a nested type inherited
                   # from Activity (review of A18-tooling-evidence-02), so the name check
                   # relies on references outside such bodies; the export check below
                   # still requires every file of the source set.
                   "internal object Wiring {\n"
                   "    val bridge: NativeTurnstileBridge? = null\n"
                   "    val label = \"Text ${Formatter.format(1)}\"\n}\n")
        sources = {kotlin + "NativeTurnstileBridge.kt": "package com.fuzevpn.android\ninternal class NativeTurnstileBridge\n",
                   kotlin + "Formatter.kt": "package com.fuzevpn.android\nobject Formatter { fun format(value: Int) = value }\n",
                   kotlin + "openvpn/OpenVpnController.kt": "package com.fuzevpn.android.openvpn\nclass OpenVpnController\n"}
        for name, content in sources.items():
            self.write(name, content)
        self.assertEqual([], package.package_sources(self.root, check_only=True)["missing_sources"])
        for name, expected in [(kotlin + "NativeTurnstileBridge.kt", "declaring NativeTurnstileBridge for main"),
                               (kotlin + "Formatter.kt", "declaring Formatter for main"),
                               (kotlin + "openvpn/OpenVpnController.kt", "com.fuzevpn.android.openvpn.OpenVpnController")]:
            with self.subTest(removed=name):
                path = self.root / name
                content = path.read_bytes()
                path.unlink()
                try:
                    self.assert_missing(expected)
                finally:
                    path.write_bytes(content)
            with self.subTest(omitted_from_export=name):
                self.assertIn(f"Missing discovered input: {name} (Gradle main source set uses every file of "
                              "android/app/src/main/kotlin)", self.missing_without({name}))
        # A test-only helper is part of the unit-test compile set.
        self.write("android/app/src/test/kotlin/com/fuzevpn/android/BridgeTest.kt",
                   "package com.fuzevpn.android\nclass BridgeTest { val fake = FakeClock(); val real = Formatter }\n")
        self.assert_missing("declaring FakeClock for test")
        self.write("android/app/src/test/kotlin/com/fuzevpn/android/FakeClock.kt", "package com.fuzevpn.android\nclass FakeClock\n")
        self.assertEqual([], package.package_sources(self.root, check_only=True)["missing_sources"])

    def missing_without(self, removed):
        """Real verify_inputs() on an export that lacks `removed` while the reviewed tree keeps them."""
        files = package.collect_source_files(self.root)
        entries = {name: {"bytes": path.stat().st_size, "sha256": package.sha256_file(path)}
                   for name, path in files.items() if name not in removed}
        return package.verify_inputs(self.root, entries, package.collect_versions(self.root))

    def test_inputs_named_by_python_steps_and_unit_test_modules_are_required(self):
        # Review of A18-tooling-evidence-02: the runner's Python steps and the
        # unit-test modules it discovers read repository files through literal joins.
        self.write(package.VALIDATION_RUNNER, "\n".join([
            "$projectRoot = [IO.Path]::GetFullPath((Join-Path $PSScriptRoot '..'))",
            "Invoke-ValidationStep 'translations' $PythonExecutable @('tools/generate_translations.py', '--check')",
            "Invoke-ValidationStep 'registry' $PythonExecutable @('tools/check_registry.py')",
            "Invoke-ValidationStep 'python-tests' $PythonExecutable @('-m', 'unittest', 'discover', '-s', 'tools/tests', '-v')"]) + "\n")
        self.write("tools/generate_translations.py", "\n".join([
            "from pathlib import Path",
            "ROOT = Path(__file__).resolve().parents[1]",
            "PACKS = ROOT / 'lib/l10n/translations'",
            "LANGUAGES = 'en fr zh-Hans'.split()",
            "def validate(language):",
            "    return PACKS / f'{language}.missing'  # a parameter: never enumerated",
            "def main():",
            "    source = PACKS / 'en.json'",
            "    for language in LANGUAGES:",
            "        path = PACKS / f'{language}.json'",
            "        require(path.exists(), f'Missing translation: {language}')  # a required probe",
            "        output = ROOT / f'lib/l10n/app_{language.replace(\"-\", \"_\")}.arb'",
            "        notes = ROOT / f'lib/l10n/notes/{language}-{language}.txt'",
            "        extra = ROOT / f'lib/l10n/extra_{language}.json'",
            "        if extra.exists():",
            "            pass",
            "        branch = ROOT / ('lib/l10n/a.json' if language == 'fr' else 'lib/l10n/b.json')",
            "    (ROOT / 'build/generated.txt').write_text('generated output')",
            "    if (ROOT / 'lib/l10n/optional.json').is_file() and LANGUAGES:",
            "        pass",
            "    stale = [path for path in [ROOT / 'lib/l10n/generated.dart'] if not path.exists()]"]) + "\n")
        self.write("tools/check_registry.py", "\n".join([
            "import argparse",
            "from pathlib import Path",
            "def read(root):",
            "    return (root / 'docs/registry.json').read_text()",
            "def main(argv=None):",
            "    parser = argparse.ArgumentParser()",
            "    parser.add_argument('--root', type=Path, default=Path(__file__).resolve().parents[1])",
            "    args = parser.parse_args(argv)",
            "    root = args.root.resolve()",
            "    return read(root)"]) + "\n")
        self.write("tools/tests/test_fixture_series.py", "\n".join([
            "from pathlib import Path",
            "import tempfile",
            "import unittest",
            "TOOLS = Path(__file__).resolve().parents[1]",
            "REPOSITORY = TOOLS.parent",
            "HELPER = TOOLS / 'fixture_series.ps1'",
            "DATA = Path(__file__).with_name('fixture_data.json')",
            "class FixtureTests(unittest.TestCase):",
            "    def test_reads(self):",
            "        root = Path(tempfile.mkdtemp())",
            "        (root / 'tools/created_by_the_test.py').write_text('')",
            "        return REPOSITORY / 'android/app/src/test/fixture.txt'"]) + "\n")
        required = {
            "lib/l10n/translations/en.json": "{}\n", "lib/l10n/translations/fr.json": "{}\n",
            "lib/l10n/translations/zh-Hans.json": "{}\n", "lib/l10n/app_en.arb": "{}\n", "lib/l10n/app_fr.arb": "{}\n",
            "lib/l10n/app_zh_Hans.arb": "{}\n", "lib/l10n/notes/en-en.txt": "en\n", "lib/l10n/notes/fr-fr.txt": "fr\n",
            "lib/l10n/notes/zh-Hans-zh-Hans.txt": "zh\n", "docs/registry.json": "{}\n",
            "lib/l10n/generated.dart": "// generated, checked for staleness\n",
            "tools/fixture_series.ps1": "$series = Join-Path $PSScriptRoot 'fixture_series.json'\n",
            "tools/fixture_series.json": "[]\n", "tools/tests/fixture_data.json": "{}\n",
            "android/app/src/test/fixture.txt": "fixture\n",
        }
        for name, content in required.items():
            self.write(name, content)
        self.assertEqual([], package.package_sources(self.root, check_only=True)["missing_sources"])
        for name in required:
            with self.subTest(removed=name):
                path = self.root / name
                content = path.read_bytes()
                path.unlink()
                try:
                    self.assert_missing("Missing validation runner input: " + name.replace(".", r"\.") + r" \(used by tools/")
                finally:
                    path.write_bytes(content)
        # Parameters, conditional branches, probed (optional) paths, build
        # outputs and paths under a temporary root are never required.
        unrequired = {"lib/l10n/translations/en.missing", "lib/l10n/notes/en-fr.txt", "lib/l10n/extra_en.json",
                      "lib/l10n/a.json", "lib/l10n/b.json", "build/generated.txt", "lib/l10n/optional.json",
                      "tools/created_by_the_test.py"}
        reported = "\n".join(package.package_sources(self.root, check_only=True)["missing_sources"])
        for name in unrequired:
            self.assertNotIn(name, reported)

    def test_files_read_by_dart_tests_are_required(self):
        self.write("test/l10n/catalogue_test.dart", "\n".join([
            "import 'dart:io';",
            "void main() {",
            "  File('lib/l10n/translations/en.json').readAsStringSync();",
            "  Directory(",
            "    'docs/fixtures',",
            "  ).listSync();",
            "  File(\"test/data/sample.txt\");",
            "  File('build/reports/capture-$name.png');",
            "  ProfileFile('lib/not_a_dart_io_file.json');",
            "}"]) + "\n")
        required = {"lib/l10n/translations/en.json": "{}\n", "docs/fixtures/a.txt": "a\n", "test/data/sample.txt": "s\n"}
        for name, content in required.items():
            self.write(name, content)
        self.assertEqual([], package.package_sources(self.root, check_only=True)["missing_sources"])
        for name, expected in (("lib/l10n/translations/en.json", "lib/l10n/translations/en.json"),
                               ("docs/fixtures/a.txt", "docs/fixtures"), ("test/data/sample.txt", "test/data/sample.txt")):
            with self.subTest(removed=name):
                path = self.root / name
                content = path.read_bytes()
                path.unlink()
                try:
                    self.assert_missing(r"Missing Dart test file input: " + expected.replace(".", r"\.")
                                        + r" \(read by test/l10n/catalogue_test\.dart\)")
                finally:
                    path.write_bytes(content)

    def test_every_file_of_compiled_analysed_or_discovered_directories_is_required(self):
        self.write(package.VALIDATION_RUNNER, "\n".join([
            "$projectRoot = [IO.Path]::GetFullPath((Join-Path $PSScriptRoot '..'))",
            "$lockInputs = @(Get-ChildItem (Join-Path $projectRoot 'android/gradle/dependency-locks') -File | ForEach-Object { $_.Name })",
            "Get-ChildItem -LiteralPath (Join-Path $projectRoot 'build/app/test-results') -Filter 'TEST-*.xml'",
            "Invoke-ValidationStep 'python-tests' $PythonExecutable @('-m', 'unittest', 'discover', '-s', 'tools/tests', '-v')",
            "Invoke-ProjectScript 'turnstile-bridge' 'test_turnstile_bridge.ps1' @()",
            "Invoke-ValidationStep 'buildsrc' $wrapper @('-p', 'buildSrc', 'check') (Join-Path $projectRoot 'android')",
            "Invoke-ValidationStep 'bridge-host' $shell @('-NoProfile', '-File', (Join-Path $projectRoot 'android/app/src/test/bridge-host/run.ps1'))"]) + "\n")
        self.write("tools/test_turnstile_bridge.ps1", "\n".join([
            "$testRepository = Split-Path -Parent (Split-Path -Parent $MyInvocation.MyCommand.Path)",
            "$testHostRoot = Join-Path $testRepository 'android/app/src/testHost/turnstile'",
            "$testSources = @(Get-ChildItem -LiteralPath (Join-Path $testHostRoot 'stubs') -Filter '*.kt' -File | ForEach-Object FullName)"]) + "\n")
        # Integration of android/app/src/test/bridge-host (lot N): listings by
        # "$PSScriptRoot/stubs" and by the script's own directory with a filter.
        self.write("android/app/src/test/bridge-host/run.ps1", "\n".join([
            "$repository = [IO.Path]::GetFullPath((Join-Path $PSScriptRoot '../../../../..'))",
            "$path = Get-ChildItem -LiteralPath \"$ModuleCache/$group/$name/$version\" -Recurse -Filter \"$name-$version.jar\"",
            "$sources += Get-ChildItem -LiteralPath \"$PSScriptRoot/stubs\" -Filter '*.kt' | Sort-Object Name",
            "$sources += Get-ChildItem -LiteralPath $PSScriptRoot -Filter '*Test.kt' | Sort-Object Name"]) + "\n")
        kotlin = "android/app/src/main/kotlin/com/fuzevpn/android/"
        discovered = {
            "tools/tests/test_discovered_module.py": "import unittest\n",
            "test/widget/standalone_test.dart": "void main() {}\n",
            "lib/src/unreferenced.dart": "const value = 1;\n",
            kotlin + "TopLevelOnly.kt": "package com.fuzevpn.android\n\ninternal fun topLevelHelper() = 1\n",
            "android/app/src/test/kotlin/com/fuzevpn/android/TopLevelTestHelper.kt": "package com.fuzevpn.android\n\nfun testHelper() = 2\n",
            "android/app/src/main/res/drawable/unreferenced.xml": "<shape/>\n",
            package.TURNSTILE_HOST_ROOT + "stubs/Extra.kt": "package android.extra\nclass Extra\n",
            # A directory a runner script names is used as a whole, whatever a later filter lists.
            package.TURNSTILE_HOST_ROOT + "stubs/README.txt": "in a directory named by the runner\n",
            "android/gradle/dependency-locks/extra.lockfile": "empty=\n",
            "assets/flags/de.svg": "fixture asset",
            "android/app/src/test/bridge-host/stubs/Android.kt": "package android.app\nclass Activity\n",
            "android/app/src/test/bridge-host/AndroidVpnBridgeHostTest.kt": "package com.fuzevpn.android\nclass AndroidVpnBridgeHostTest\n",
        }
        witnesses = {
            "docs/notes.md": "not compiled\n", "tools/tests/helper_data.txt": "not a test module\n",
            # The script's own directory is listed with a filter, not named as a whole.
            "android/app/src/test/bridge-host/Manual.kt": "package com.fuzevpn.android\nclass Manual\n",
            "android/app/src/test/bridge-host/README.md": "documentation, not matched by '*Test.kt'\n",
            "tools/tests/nested/test_not_a_package.py": "import unittest\n",
            # The Gradle project directory holds export roots: workstation files there are not inputs.
            "android/fuzevpn_android.iml": "<module/>\n", "android/app/java_pid1.hprof": "heap dump\n",
        }
        for name, content in {**discovered, **witnesses}.items():
            self.write(name, content)
        self.assertEqual([], self.missing_without(set()))
        for name in discovered:
            with self.subTest(removed=name):
                reported = self.missing_without({name})
                self.assertTrue(any(f"Missing discovered input: {name} (" in item for item in reported), reported)
        for name in witnesses:
            with self.subTest(witness=name):
                self.assertEqual([], self.missing_without({name}))

    def test_nested_types_inherited_from_external_supertypes_are_not_reported(self):
        # Review: Builder() in a VpnService subclass and LayoutParams in a
        # ViewGroup subclass are valid Kotlin, not missing project sources.
        kotlin = "android/app/src/main/kotlin/com/fuzevpn/android/"
        self.write(kotlin + "Svc.kt", "\n".join([
            "package com.fuzevpn.android",
            "",
            "import android.net.ConnectivityManager",
            "import android.net.VpnService",
            "import android.view.ViewGroup",
            "",
            "class Svc : VpnService() {",
            "    fun open() = Builder().setMtu(1280)",
            "    inner class Session { fun again() = Builder() }",
            "}",
            "",
            "class Group(context: android.content.Context) : ViewGroup(context) {",
            "    fun params() = LayoutParams(1, 1)",
            "    override fun onLayout(changed: Boolean, l: Int, t: Int, r: Int, b: Int) = Unit",
            "}",
            "",
            "class Monitor {",
            "    private val callback = object : ConnectivityManager.NetworkCallback() {",
            "        fun state() = BlockedStatus.Unknown",
            "    }",
            "}"]) + "\n")
        self.assertEqual([], package.package_sources(self.root, check_only=True)["missing_sources"])
        # Names outside those bodies, or in classes extending project types, are still checked.
        self.write(kotlin + "Local.kt", "\n".join([
            "package com.fuzevpn.android",
            "",
            "open class LocalBase",
            "class Local : LocalBase() { fun f() = AbsentInLocal() }",
            "fun outside() = AbsentOutside()",
            "class Late : android.app.Service() { fun g() = Builder() }"]) + "\n")
        self.assert_missing("declaring AbsentInLocal for main")
        reported = "\n".join(package.package_sources(self.root, check_only=True, allow_incomplete=True)["missing_sources"])
        self.assertIn("declaring AbsentOutside for main", reported)
        self.assertNotIn("Builder", reported)
        self.assertNotIn("LayoutParams", reported)
        self.assertNotIn("BlockedStatus", reported)

    def test_cmake_sources_scripts_and_local_headers_are_required(self):
        cpp = package.NATIVE_BUILD_ROOT + "/"
        self.write(cpp + "CMakeLists.txt", "# add_library(ignored SHARED comment.cpp)\nadd_library(fixture SHARED\n    openvpn_jni.cpp\n"
                   "    openvpn_profile.cpp)\nif(ON)\n  include(core.cmake)\n  target_sources(fixture PRIVATE adapter.cpp)\nendif()\n"
                   'include("${CMAKE_CURRENT_LIST_DIR}/verify.cmake")\ntarget_sources(fixture PRIVATE ${GENERATED}/skipped.cpp)\n')
        files = {cpp + "openvpn_jni.cpp": '#include "profile.h"\n#include <jni.h>\n#include "openvpn/client/cliconnect.hpp"\n',
                 cpp + "openvpn_profile.cpp": '#include "profile.h"\n', cpp + "profile.h": '#include "network.h"\n',
                 cpp + "network.h": "#pragma once\n", cpp + "core.cmake": "set(X 1)\n", cpp + "verify.cmake": "set(Y 1)\n",
                 cpp + "adapter.cpp": "int adapter;\n"}
        for name, content in files.items():
            self.write(name, content)
        header = self.write(f"{package.NATIVE_ROOT}/openvpn3-core/openvpn/client/cliconnect.hpp", "// third-party header\n")
        self.inventory(package.NATIVE_ROOT, package.NATIVE_LOCK)
        self.assertEqual([], package.package_sources(self.root, check_only=True)["missing_sources"])
        for name in files:
            with self.subTest(removed=name):
                path = self.root / name
                content = path.read_bytes()
                path.unlink()
                try:
                    self.assert_missing("Missing native (build input|header)")
                finally:
                    path.write_bytes(content)
        header.unlink()
        self.inventory(package.NATIVE_ROOT, package.NATIVE_LOCK)
        self.assert_missing("Missing native header: openvpn/client/cliconnect.hpp")

    def test_source_files_dropped_by_exclusion_rules_in_compiled_roots_are_reported(self):
        for name in ("android/app/src/main/kotlin/com/fuzevpn/android/cache/CacheEntry.kt", "lib/build/generated.dart",
                     "tools/tmp/helper.py", "test/reports/fixture_test.dart"):
            with self.subTest(name=name):
                path = self.write(name, "// source\n")
                try:
                    self.assertNotIn(name, package.collect_source_files(self.root))
                    self.assert_missing("Source file excluded by export rules: " + name)
                finally:
                    path.unlink()
        self.write("tools/__pycache__/cached.cpython-314.pyc", b"\x00")
        self.assertEqual([], package.package_sources(self.root, check_only=True)["missing_sources"])

    def test_generated_readme_describes_the_pinned_patch_series_and_checks(self):
        versions = package.collect_versions(self.root)
        self.assertEqual(["0001-fixture.patch", "0002-fixture.patch"], versions["wireguard_patch_series"])
        readme = package.source_readme(versions, [], []).decode("utf-8")
        self.assertIn("its 2 patches", readme)
        self.assertIn("`0001-fixture.patch`, then `0002-fixture.patch`", readme)
        self.assertIn("Go 1.26.9", readme)
        self.assertNotIn("All required application/build/native source inputs are present", readme)
        self.assertIn("not a build of this archive", readme)
        # The coverage sentence names what is checked and what is not followed.
        flat = " ".join(readme.split())
        self.assertNotIn("files used by the validation runner and its scripts", flat)
        for phrase in ("Python scripts and unit-test modules it runs", "files read by Dart tests",
                       "compiled, analysed or discovered as a whole",
                       "Paths computed from data, parameters or the environment are not followed"):
            self.assertIn(phrase, flat)
        (self.root / package.WIREGUARD_ROOT / "patches/fuzevpn/series").unlink()
        self.assert_missing("Missing required input: android/third_party/wireguard-android/patches/fuzevpn/series")


class RepositoryExportCompletenessTests(unittest.TestCase):
    """The audit's undetected omissions, replayed on this repository's real tree."""

    @classmethod
    def setUpClass(cls):
        cls.root = TOOL.parents[1]
        cls.entries = {name: {} for name in package.collect_source_files(cls.root)}
        cls.baseline = set(cls.closures(cls.entries))

    @classmethod
    def closures(cls, entries):
        # The reference checks of verify_inputs(); lock and archive checks are covered above.
        return (package.verify_application_inputs(cls.root, entries) + package.validation_runner_inputs(cls.root, entries)
                + package.kotlin_source_closure(cls.root, entries) + package.native_source_closure(cls.root, entries)
                + package.discovered_source_inputs(cls.root, entries))

    def test_each_audit_omission_is_detected(self):
        kotlin = "android/app/src/main/kotlin/com/fuzevpn/android/"
        cases = {
            "turnstile runner": ["tools/test_turnstile_bridge.ps1"],
            "turnstile host sources": [name for name in self.entries if name.startswith(package.TURNSTILE_HOST_ROOT) and not name.endswith(".md")],
            "one turnstile stub": [package.TURNSTILE_HOST_ROOT + "stubs/Webkit.kt"],
            "command-epoch runner": ["android/app/src/test/command-epoch/run.ps1"],
            "command-epoch template": ["android/app/src/test/command-epoch/SystemVpnCommandEpoch.template.kt"],
            "other runner scripts": ["tools/test_wireguard_release_gate.ps1", "tools/test_dependency_integrity.ps1",
                                     "tools/check_validation.py", "tools/generate_translations.py"],
            "Kotlin class used by MainActivity": [kotlin + "NativeTurnstileBridge.kt"],
            "Kotlin VPN bridge": [kotlin + "AndroidVpnBridge.kt"],
            "CMake-listed C++ source": ["android/app/src/main/cpp/openvpn_core_adapter.cpp"],
            "local C++ header": ["android/app/src/main/cpp/openvpn_profile.h"],
            # Review of A18-tooling-evidence-02 (export_variants_probe.py).
            "translation pack read by the translations step": ["lib/l10n/translations/fr.json"],
            "en pack read by the translations step and Flutter tests": ["lib/l10n/translations/en.json"],
            "WireGuard patch helper read by a Python test": ["tools/wireguard_patch_series.ps1"],
            "discovered Python test module": ["tools/tests/test_receipt_instants.py"],
            "main Kotlin file with top-level functions only": [kotlin + "SessionEndAttempt.kt"],
            "Dart test discovered by flutter test": ["test/l10n/expanded_catalogues_test.dart"],
            "Android resource compiled as a whole": ["android/app/src/main/res/values/strings.xml"],
            # Integration of 29/10: bridge-host suite on the runner, third native host executable.
            "bridge-host runner and sources": [name for name in self.entries  # README.md: documentation only.
                                               if name.startswith("android/app/src/test/bridge-host/")
                                               and not name.endswith(".md")],
            "one bridge-host stub": ["android/app/src/test/bridge-host/stubs/AndroidNet.kt"],
            "one bridge-host fake": ["android/app/src/test/bridge-host/fakes/HarnessControl.kt"],
            "bridge-host test class": ["android/app/src/test/bridge-host/AndroidVpnBridgeHostTest.kt"],
            "profile host test compiled by the boundaries script": ["android/app/src/test/cpp/openvpn_profile_host_test.cpp"],
            "one native host header (include root)": ["android/app/src/test/cpp/host/client/ovpncli.cpp"],
        }
        for label, removed in cases.items():
            present = [name for name in removed if name in self.entries]
            with self.subTest(case=label):
                self.assertTrue(present)
                reduced = {name: entry for name, entry in self.entries.items() if name not in present}
                added = set(self.closures(reduced)) - self.baseline
                self.assertTrue(added, f"{label}: omission not detected")
                # Each omitted file is named (a C/C++ header by its #include spelling).
                self.assertTrue(all(any(Path(name).name in item for item in added) for name in present), added)

    def test_new_files_of_lots_s_and_n_are_exported_and_each_one_is_required(self):
        # Files added on 29/10 by the native lot N (corrections of 29/10) and by lot S (test/session/).
        kotlin, tests = "android/app/src/main/kotlin/com/fuzevpn/android/", "android/app/src/test/kotlin/com/fuzevpn/android/"
        named = [kotlin + "openvpn/BoundedNativeCall.kt", kotlin + "openvpn/OwnedNativeOperations.kt",
                 tests + "PlayBillingBridgeTest.kt", tests + "WireGuardControllerBoundsTest.kt",
                 tests + "WireGuardControllerTimeoutTest.kt", tests + "WireGuardRecoveryBridgeSequenceTest.kt",
                 tests + "openvpn/BoundedNativeCallTest.kt", tests + "openvpn/OwnedNativeOperationsTest.kt",
                 "android/app/src/test/cpp/openvpn_profile_host_test.cpp"]
        prefixes = ("android/app/src/test/bridge-host/", "test/session/")
        reviewed = sorted({name for name in named if (self.root / name).is_file()} | {
            path.relative_to(self.root).as_posix() for prefix in prefixes
            for path in (self.root / prefix).rglob("*") if path.is_file()})
        self.assertTrue(any(name.startswith(prefixes[0]) for name in reviewed))
        self.assertTrue(any(name.startswith(prefixes[1]) for name in reviewed))
        for name in reviewed:
            with self.subTest(file=name):
                self.assertIn(name, self.entries)
                if name.endswith(".md"):
                    continue  # Exported documentation (bridge-host/README.md) that no step reads.
                reduced = {other: entry for other, entry in self.entries.items() if other != name}
                added = set(self.closures(reduced)) - self.baseline
                self.assertTrue(any(name in item for item in added), (name, added))

    def test_reviewed_tree_has_no_missing_or_false_reference(self):
        # No false positive on the real tree (Kotlin, Python, Dart and PowerShell derivations).
        self.assertEqual([], sorted(self.baseline))


if __name__ == "__main__":
    unittest.main()
