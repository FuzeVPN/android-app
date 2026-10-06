#!/usr/bin/env python3
# SPDX-License-Identifier: Apache-2.0
"""Export reviewed Android source inputs without reading workstation caches.

Python 3.10+, standard library only. See docs/SOURCE_DISTRIBUTION.md.
"""

from __future__ import annotations

import argparse
import base64
import gzip
import hashlib
import io
import json
import os
from pathlib import Path, PurePosixPath
import re
import stat
import sys
import tarfile
import tempfile
import zipfile


ROOT_FILES = (
    ".flutter-version", ".gitignore", ".gitattributes", "analysis_options.yaml", "l10n.yaml",
    "pubspec.yaml", "pubspec.lock", "README.md", "README.fr.md",
    "LICENSING.md", "CONTRIBUTING.md", "SECURITY.md", "THIRD_PARTY_NOTICES.md",
    "android/build.gradle.kts", "android/settings.gradle.kts",
    "android/gradle.properties", "android/gradlew", "android/gradlew.bat",
    "android/app/build.gradle.kts", "android/app/proguard-rules.pro",
    "android/buildSrc/build.gradle.kts",
)
OPTIONAL_NOTICE_FILES = (
    "LICENSE", "LICENSE.md", "LICENSE.txt", "COPYING", "COPYING.md", "COPYING.txt",
    "NOTICE", "NOTICE.md", "NOTICE.txt",
)
SOURCE_DIRS = (
    "lib", "test", "assets", "licenses", "patches", "docs", "tools",
    "android/app/src", "android/buildSrc", "android/gradle",
    "android/native-provenance", "android/third_party/wireguard-android",
    "android/source-distribution",
)
BUILD_POLICY_JAVA_DIRS = tuple(
    f"android/buildSrc/src/{scope}/java/com/fuzevpn/build" for scope in ("main", "test")
)
BUILD_POLICY_INPUTS = tuple(
    f"{directory}/{policy}{'Test' if '/src/test/' in directory else ''}.java"
    for directory in BUILD_POLICY_JAVA_DIRS
    for policy in ("AndroidManifestPolicy", "NativeBundlePolicy", "WireGuardAarPolicy")
)
EXCLUDED_DIRS = frozenset({
    ".git", ".gradle", ".cxx", ".dart_tool", ".idea", ".vscode",
    ".kotlin", "__pycache__", ".pytest_cache", "node_modules", "build",
    "cache", "coverage", "reports", "artifacts", "tmp", "temp", "failures",
    ".env", ".avd", "fuzevpn-vm",
})
EXCLUDED_FILES = frozenset({
    "local.properties", "key.properties", ".flutter-plugins-dependencies",
    ".ds_store", "credentials.json", "secrets.json", "service-account.json",
    "google-services.json", "desktop.ini", "thumbs.db",
})
EXCLUDED_SUFFIXES = frozenset({
    ".apk", ".aab", ".keystore", ".jks", ".p12", ".pfx", ".pyc",
    ".bak", ".tmp", ".log", ".swp", ".swo", ".env", ".dpapi",
    ".db", ".sqlite", ".sqlite3", ".kdbx", ".ovpn",
})
NATIVE_ROOT = "android/app/src/main/cpp/third_party"
NATIVE_LOCK = "android/native-provenance/bundle.sha256"
EXTRA_MANIFEST = "android/source-distribution/completeness.manifest.json"
WIREGUARD_ROOT = "android/third_party/wireguard-android"
GO_SUM = f"{WIREGUARD_ROOT}/tunnel/tools/libwg-go/go.sum"
OPENSSL_SHA256 = "603f5602e2eef00d77fbd429d34dcd5822bb301757a1bc9cdb24c670f1eb859a"
GO_SOURCE_SHA256 = "229c08b600b1446798109fae1f569228102c8473caba8104b6418cb5bc032878"


class PackageError(ValueError):
    """A required input cannot safely be included in the source export."""


def digest_stream(stream) -> str:
    digest = hashlib.sha256()
    while chunk := stream.read(1024 * 1024):
        digest.update(chunk)
    return digest.hexdigest()


def sha256_file(path: Path) -> str:
    with path.open("rb") as stream:
        return digest_stream(stream)


def json_bytes(value) -> bytes:
    return (json.dumps(value, ensure_ascii=False, sort_keys=True, indent=2) + "\n").encode("utf-8")


def safe_relative(value: str) -> PurePosixPath:
    if not value or "\\" in value or "\n" in value or "\r" in value:
        raise PackageError(f"Unsafe relative path: {value!r}")
    parts = value.rstrip("/").split("/")
    if value.startswith("/") or any(p in {"", "..", "."} or ":" in p for p in parts):
        raise PackageError(f"Unsafe relative path: {value!r}")
    return PurePosixPath(value)


def assert_regular(path: Path, root: Path) -> None:
    # A Windows junction can escape a root without being reported as a symlink.
    details = path.lstat()
    if stat.S_ISLNK(details.st_mode) or getattr(details, "st_file_attributes", 0) & 0x400:
        raise PackageError(f"Links/reparse points are not source inputs: {path}")
    if not (stat.S_ISREG(details.st_mode) or stat.S_ISDIR(details.st_mode)):
        raise PackageError(f"Unsupported filesystem input: {path}")
    if not path.resolve().is_relative_to(root):
        raise PackageError(f"Source path escapes its root: {path}")


def excluded(relative: str, *, directory: bool = False) -> bool:
    path = PurePosixPath(relative)
    parts = path.parts
    # This exact Java package is source, while build directories elsewhere
    # remain generated output. Only its direct .java files are exportable;
    # nested caches, non-Java files and credential exclusions still apply.
    if directory and relative in BUILD_POLICY_JAVA_DIRS:
        parts = parts[:-1]
    elif not directory and path.suffix == ".java" and str(path.parent) in BUILD_POLICY_JAVA_DIRS:
        parts = parts[:-2] + parts[-1:]
    name = path.name.lower()
    if parts[-1].lower() in EXCLUDED_DIRS:
        return True
    if any(part.lower() in EXCLUDED_DIRS or part.lower().startswith((".env", ".tmp", ".stage", ".staging"))
           for part in parts[:-1]):
        return True
    if directory:
        return parts[-1].lower() in EXCLUDED_DIRS or name.startswith((".env", ".tmp", ".stage", ".staging"))
    if name in EXCLUDED_FILES or name.startswith((
        ".env", "credentials.", "secrets.", "service-account", "mot-de-passe", "code-google-play",
    )):
        return True
    if path.suffix.lower() in EXCLUDED_SUFFIXES:
        return True
    if path.suffix.lower() in {".pem", ".key"}:
        # Upstream OpenVPN test identities are public fixtures. The independent
        # native manifest below must match every byte, including these fixtures.
        return not relative.startswith(f"{NATIVE_ROOT}/openvpn3-core/test/")
    return False


def collect_source_files(root: Path) -> dict[str, Path]:
    root = root.resolve()
    result: dict[str, Path] = {}

    def visit(path: Path, relative: str) -> None:
        is_dir = path.is_dir()
        if excluded(relative, directory=is_dir):
            return
        assert_regular(path, root)
        if is_dir:
            for child in sorted(path.iterdir(), key=lambda p: p.name):
                visit(child, f"{relative}/{child.name}")
        else:
            safe_relative(relative)
            result[relative] = path

    for relative in ROOT_FILES + OPTIONAL_NOTICE_FILES:
        path = root / relative
        if path.exists() or path.is_symlink():
            visit(path, relative)
    for relative in SOURCE_DIRS:
        path = root / relative
        if path.exists() or path.is_symlink():
            visit(path, relative)
    # The three generated filenames can never shadow real project inputs.
    return dict(sorted(result.items()))


def read_json(root: Path, relative: str):
    path = root / relative
    try:
        assert_regular(path, root)
        return json.loads(path.read_text(encoding="utf-8"))
    except (OSError, json.JSONDecodeError) as error:
        raise PackageError(f"Cannot read source metadata {relative}: {error}") from error


def match_text(root: Path, relative: str, expression: str) -> str:
    match = re.search(expression, (root / relative).read_text(encoding="utf-8"), re.MULTILINE)
    if match is None:
        raise PackageError(f"Version missing from {relative}: {expression}")
    return match.group(1)


def verify_native_lock(root: Path, entries: dict[str, dict]) -> None:
    verify_checksum_inventory(root, NATIVE_LOCK, NATIVE_ROOT, entries, "Independent native lock")


def verify_checksum_inventory(root: Path, inventory: str, base: str,
                              entries: dict[str, dict], label: str) -> None:
    expected = {}
    for line in (root / inventory).read_text(encoding="utf-8").splitlines():
        if not line or line.startswith("#"):
            continue
        match = re.fullmatch(r"([a-f0-9]{64})  (.+)", line)
        if match is None:
            raise PackageError(f"Malformed checksum inventory {inventory}: {line!r}")
        relative = str(safe_relative(match.group(2)))
        if relative in expected:
            raise PackageError(f"Duplicate checksum inventory entry: {relative}")
        expected[relative] = match.group(1)
    actual = {name[len(base) + 1:]: entry["sha256"]
              for name, entry in entries.items() if name.startswith(base + "/") and name != inventory}
    if actual != expected:
        changed = sorted(set(actual) ^ set(expected) |
                         {name for name in actual.keys() & expected.keys() if actual[name] != expected[name]})
        raise PackageError(label + " mismatch: " + ", ".join(changed[:12]))


def verify_source_archive(path: Path, *, go_module: str | None = None) -> str | None:
    """Check archive paths without extracting anything; check canonical Go h1."""
    seen = set()
    if zipfile.is_zipfile(path):
        overall = hashlib.sha256()
        with zipfile.ZipFile(path) as archive:
            for item in sorted(archive.infolist(), key=lambda member: member.filename):
                name = item.filename
                safe_relative(name)
                if name in seen:
                    raise PackageError(f"Duplicate archive member in {path.name}: {name}")
                seen.add(name)
                if stat.S_ISLNK(item.external_attr >> 16):
                    raise PackageError(f"Archive contains a link: {path.name}: {name}")
                if go_module and not name.startswith(go_module + "/"):
                    raise PackageError(f"Unexpected Go module archive root: {name}")
                with archive.open(item) as stream:
                    file_digest = digest_stream(stream)
                overall.update(f"{file_digest}  {name}\n".encode("utf-8"))
        if not seen:
            raise PackageError(f"Empty source archive: {path.name}")
        # This is Go's golang.org/x/mod/sumdb/dirhash.Hash1 algorithm.
        return "h1:" + base64.b64encode(overall.digest()).decode("ascii") if go_module else None
    if go_module:
        raise PackageError(f"A canonical Go source ZIP is required: {path.name}")
    try:
        with tarfile.open(path, "r:*") as archive:
            for item in archive:
                safe_relative(item.name)
                if item.name in seen or not (item.isfile() or item.isdir()):
                    raise PackageError(f"Duplicate/link/special archive member: {path.name}: {item.name}")
                seen.add(item.name)
    except tarfile.TarError as error:
        raise PackageError(f"Invalid source archive: {path.name}") from error
    if not seen:
        raise PackageError(f"Empty source archive: {path.name}")
    return None


def collect_versions(root: Path) -> dict:
    native = read_json(root, f"{NATIVE_ROOT}/IMPORT-METADATA.json")
    openssl = read_json(root, f"{NATIVE_ROOT}/openssl/IMPORT-METADATA.json")
    dependencies = read_json(root, f"{NATIVE_ROOT}/deps/DEPENDENCIES-METADATA.json")
    wireguard = read_json(root, f"{WIREGUARD_ROOT}/FUZEVPN-IMPORT-METADATA.json")
    aar = read_json(root, f"{WIREGUARD_ROOT}/dist/tunnel-1.0.20260102-fuzevpn-fgs.metadata.json")
    go_sums = {}
    for line in (root / GO_SUM).read_text(encoding="utf-8").splitlines():
        name, version, expected = line.split()
        if not version.endswith("/go.mod"):
            go_sums[name] = {"version": version, "go_sum": expected}
    return {
        "application": match_text(root, "pubspec.yaml", r"^version:\s*(\S+)$"),
        "flutter": (root / ".flutter-version").read_text(encoding="utf-8").strip(),
        "gradle": match_text(root, "android/gradle/wrapper/gradle-wrapper.properties", r"gradle-([\d.]+)-"),
        "android_gradle_plugin": match_text(root, "android/settings.gradle.kts", r'id\("com.android.application"\) version "([^"]+)"'),
        "kotlin": match_text(root, "android/settings.gradle.kts", r'id\("org.jetbrains.kotlin.android"\) version "([^"]+)"'),
        "java": match_text(root, "android/app/build.gradle.kts", r"sourceCompatibility = JavaVersion.VERSION_(\d+)"),
        "android_compile_sdk": match_text(root, "android/app/build.gradle.kts", r"compileSdk = (\d+)"),
        "android_min_sdk": match_text(root, "android/app/build.gradle.kts", r"minSdk = (\d+)"),
        "ndk": match_text(root, "android/app/build.gradle.kts", r'ndkVersion = "([^"]+)"'),
        "cmake": match_text(root, "android/app/build.gradle.kts", r'version = "(3\.[^"]+)"'),
        "openvpn3": native["openvpn3"],
        "openssl": openssl,
        "native_dependencies": dependencies["sources"],
        "wireguard_android": wireguard["source"],
        "wireguard_aar_sha256": aar["sha256"],
        "go_toolchain": aar["nativeBuild"]["go"].split()[2].removeprefix("go"),
        "go_modules": go_sums,
        "release_abis": ["arm64-v8a", "armeabi-v7a"],
    }


def verify_inputs(root: Path, entries: dict[str, dict], versions: dict) -> list[str]:
    mandatory = list(ROOT_FILES + BUILD_POLICY_INPUTS) + [
        NATIVE_LOCK, "android/gradle/verification-metadata.xml",
        "android/gradle/dependency-locks/app-maven.lockfile",
        "android/gradle/dependency-locks/app-patched.lockfile",
        "android/gradle/dependency-locks/url_launcher_android.lockfile",
        f"{NATIVE_ROOT}/openssl/source/openssl-3.5.9.tar.gz",
        f"{NATIVE_ROOT}/openssl/source/openssl-3.5.9.tar.gz.asc",
        f"{NATIVE_ROOT}/openssl/source/pubkeys.asc",
        f"{WIREGUARD_ROOT}/tunnel/tools/wireguard-tools/COPYING",
        f"{WIREGUARD_ROOT}/tunnel/tools/elf-cleaner/COPYING",
        f"{WIREGUARD_ROOT}/tunnel/tools/libwg-go/api-android.go",
        f"{WIREGUARD_ROOT}/tunnel/tools/libwg-go/go.mod", GO_SUM,
        "docs/SOURCE_DISTRIBUTION.md", "tools/package_android_sources.py",
        "tools/tests/test_package_android_sources.py",
    ]
    missing = [f"Missing required input: {name}" for name in mandatory if name not in entries]
    verify_native_lock(root, entries)
    if versions["openssl"]["version"] != "3.5.9":
        raise PackageError("This exporter requires the reviewed OpenSSL 3.5.9 bundle")
    source = f"{NATIVE_ROOT}/openssl/source/openssl-3.5.9.tar.gz"
    if source in entries:
        if entries[source]["sha256"] != OPENSSL_SHA256 or versions["openssl"]["sourceSha256"] != OPENSSL_SHA256:
            raise PackageError("Official OpenSSL 3.5.9 source archive SHA-256 mismatch")
        verify_source_archive(root / source)
    aar = f"{WIREGUARD_ROOT}/dist/tunnel-1.0.20260102-fuzevpn-fgs.aar"
    if entries.get(aar, {}).get("sha256") != versions["wireguard_aar_sha256"]:
        raise PackageError("WireGuard AAR does not match its distribution metadata")
    if EXTRA_MANIFEST not in entries:
        return missing + ["Missing reviewed supplementary native source manifest"]
    inventory = "android/source-distribution/SHA256SUMS"
    if inventory not in entries:
        missing.append("Missing supplementary source checksum inventory")
    else:
        verify_checksum_inventory(root, inventory, "android/source-distribution", entries,
                                  "Supplementary source inventory")
    extras = read_json(root, EXTRA_MANIFEST)
    if extras.get("schema") != 1 or not isinstance(extras.get("missing_sources"), list):
        raise PackageError("Unsupported supplementary source manifest")
    missing.extend(str(item) for item in extras["missing_sources"])
    components = {}
    for item in extras.get("components", []):
        name = item["name"]
        if name in components:
            raise PackageError(f"Duplicate supplementary source component: {name}")
        components[name] = item
        relative = str(safe_relative(item["path"]))
        if not relative.startswith("android/source-distribution/archives/"):
            raise PackageError(f"Supplementary source archive outside its allowlist: {relative}")
        if relative not in entries:
            missing.append(f"Missing {name} source archive: {relative}")
            continue
        if entries[relative]["sha256"] != item["sha256"]:
            raise PackageError(f"Supplementary source archive hash mismatch: {relative}")
        module = versions["go_modules"].get(name)
        if module:
            if item["version"] != module["version"]:
                raise PackageError(f"Go module version differs from go.sum: {name}")
            actual = verify_source_archive(root / relative, go_module=f"{name}@{module['version']}")
            if actual != module["go_sum"]:
                raise PackageError(f"Canonical Go source checksum differs from go.sum: {name}")
        else:
            verify_source_archive(root / relative)
    required = {source["name"] for source in versions["native_dependencies"]} | set(versions["go_modules"]) | {"go"}
    for name in sorted(required - components.keys()):
        missing.append(f"Missing complete source component: {name}")
    for source in versions["native_dependencies"]:
        item = components.get(source["name"])
        if item and item.get("commit") != source["commit"]:
            raise PackageError(f"Native source commit differs from the compiled prefix: {source['name']}")
    go = components.get("go")
    if go and (go.get("version") != versions["go_toolchain"] or go.get("sha256") != GO_SOURCE_SHA256):
        raise PackageError("Official Go 1.24.3 source archive identity mismatch")
    return sorted(set(missing))


def apk_records(paths: list[Path]) -> list[dict]:
    records = []
    seen = set()
    for path in paths:
        if path.suffix.lower() != ".apk" or not path.is_file() or path.is_symlink():
            raise PackageError(f"An existing regular APK is required: {path}")
        if path.name in seen:
            raise PackageError(f"APK basenames must be distinct: {path.name}")
        seen.add(path.name)
        records.append({"file": path.name, "sha256": sha256_file(path), "bytes": path.stat().st_size})
    return sorted(records, key=lambda record: record["file"])


def source_readme(versions: dict, apks: list[dict], missing: list[str]) -> bytes:
    native = versions["openssl"]
    rows = [
        ("FuzeVPN", versions["application"]), ("Flutter", versions["flutter"]),
        ("Java", versions["java"]), ("Gradle", versions["gradle"]),
        ("Android Gradle Plugin", versions["android_gradle_plugin"]),
        ("Kotlin", versions["kotlin"]), ("Android Platform", versions["android_compile_sdk"]),
        ("NDK", versions["ndk"]), ("CMake", versions["cmake"]),
        ("Go", versions["go_toolchain"]), ("OpenSSL", native["version"]),
        ("OpenVPN 3 Core", versions["openvpn3"]["commit"]),
        ("WireGuard Android", versions["wireguard_android"]["tag"] + " / " + versions["wireguard_android"]["commit"]),
    ]
    rows += [(item["name"], item["ref"] + " / " + item["commit"]) for item in versions["native_dependencies"]]
    rows += [(name, item["version"]) for name, item in sorted(versions["go_modules"].items())]
    coverage = "PARTIAL: see missing source inputs below." if missing else "All required project/native source inputs are present."
    text = f"""# FuzeVPN Android source distribution

{coverage}

This snapshot packages the reviewed application/native inputs, their licences,
patches, native dependency archives, checksums and build policies. It is not a
legal certification or a promise of identical APK bytes on every workstation.
Flutter/Android SDKs, Java, MSYS2/Perl/make and resolved Maven/Pub dependencies
remain separately installed build prerequisites. No signing key is included.

## Exact source and tool versions

| Input | Version / revision |
| --- | --- |
"""
    text += "".join(f"| {name} | `{version}` |\n" for name, version in rows)
    text += f"""
Release ABIs: arm64-v8a and armeabi-v7a. Minimum Android API:
{versions['android_min_sdk']}. OpenSSL prefix API: {native['androidApi']}.
OpenSSL archive SHA-256: `{native['sourceSha256']}`.
OpenSSL detached signature and official public certificates are included;
their independent provenance is described in docs/NATIVE_DEPENDENCIES.md.
The exporter verifies their bytes against the reviewed native lock; it does
not repeat an OpenPGP trust decision.

## Verify and build

1. Inspect SOURCE_MANIFEST.json, including source coverage and associated APK
   hashes. Verify all files with `sha256sum -c SHA256SUMS` from this directory.
2. Follow docs/DEVELOPMENT.md to install the exact toolchain above and create
   android/local.properties for this workstation. Run `flutter pub get`.
   Source exports deliberately exclude machine paths, credentials and caches.
3. Review android/source-distribution/README.md and its manifest for the full
   dependency source archives; go.sum authenticates canonical Go module ZIPs.
4. For native rebuilding, follow docs/NATIVE_DEPENDENCIES.md. WireGuard applies
   patches/wireguard-android/0001-go-backend-real-foreground-service.patch then
   0002-go-backend-protected-start.patch; imported sources already contain them.
   The Go runtime patch remains in tunnel/tools/libwg-go. The two copies of
   each WireGuard patch and all build scripts are included.
5. Build ARM64 and ARMv7 using the release commands in docs/DEVELOPMENT.md with
   `-Pfuzevpn.usePatchedWireGuardAar=true`. Keep dependency locking and checksum
   verification enabled. Signing is supplied separately in the release environment.

The native prefix archives and patched AAR are included because provenance
checks require their exact bytes. Rebuilding them can change bytes; review
the new provenance and update the independent locks through the documented
procedure rather than disabling those checks. Public upstream OpenVPN test
keys are retained as hash-verified fixtures, not deployment credentials.

## Associated APK files

"""
    if apks:
        text += "".join(f"- `{item['file']}`: SHA-256 `{item['sha256']}`\n" for item in apks)
        text += "\nThe APK files themselves are not included in this archive.\n"
    else:
        text += "No APK hashes were supplied. This archive alone does not establish APK correspondence.\n"
    text += "\n## Missing required source inputs\n\n"
    text += "".join(f"- {item}\n" for item in missing) if missing else "None detected by the exporter's required-input checks.\n"
    text += "\nShip this archive and its SHA-256 next to the associated APKs; keep their source availability and notices documented.\n"
    return text.encode("utf-8")


class HashingReader:
    def __init__(self, stream):
        self.stream = stream
        self.digest = hashlib.sha256()
        self.bytes = 0

    def read(self, size=-1):
        data = self.stream.read(size)
        self.digest.update(data)
        self.bytes += len(data)
        return data


def write_archive(root: Path, output: Path, prefix: str, files: dict[str, Path], manifest: dict) -> str:
    output = output.resolve()
    if output.exists():
        raise PackageError(f"Refusing to replace an existing source export: {output}")
    generated = {
        "SOURCE_MANIFEST.json": json_bytes(manifest),
        "README-SOURCE.md": source_readme(manifest["versions"], manifest["associated_apks"], manifest["missing_sources"]),
    }
    sums = {name: entry["sha256"] for name, entry in manifest["files"].items()}
    sums.update({name: hashlib.sha256(data).hexdigest() for name, data in generated.items()})
    generated["SHA256SUMS"] = "".join(f"{digest}  {name}\n" for name, digest in sorted(sums.items())).encode("utf-8")
    output.parent.mkdir(parents=True, exist_ok=True)
    descriptor, temporary_name = tempfile.mkstemp(prefix=".source-package-", suffix=".tmp", dir=output.parent)
    temporary = Path(temporary_name)
    try:
        with os.fdopen(descriptor, "wb") as target:
            with gzip.GzipFile(filename="", fileobj=target, mode="wb", compresslevel=9, mtime=0) as compressed:
                with tarfile.open(fileobj=compressed, mode="w|", format=tarfile.PAX_FORMAT) as archive:
                    for name in sorted(files.keys() | generated.keys()):
                        info = tarfile.TarInfo(f"{prefix}/{name}")
                        info.uid = info.gid = info.mtime = 0
                        info.uname = info.gname = ""
                        info.mode = 0o755 if PurePosixPath(name).name == "gradlew" or name.endswith(".sh") else 0o644
                        if name in generated:
                            info.size = len(generated[name])
                            archive.addfile(info, io.BytesIO(generated[name]))
                        else:
                            expected = manifest["files"][name]
                            assert_regular(files[name], root)
                            info.size = expected["bytes"]
                            with files[name].open("rb") as source:
                                reader = HashingReader(source)
                                archive.addfile(info, reader)
                                if reader.bytes != info.size or reader.digest.hexdigest() != expected["sha256"] or source.read(1):
                                    raise PackageError(f"Source changed during packaging: {name}")
        result = sha256_file(temporary)
        # Publishing with a hard link refuses an existing target atomically,
        # including another exporter racing this one. Both paths share a volume.
        os.link(temporary, output)
        return result
    finally:
        temporary.unlink(missing_ok=True)


def package_sources(root: Path, output: Path | None = None, apks: list[Path] | None = None,
                    *, allow_incomplete: bool = False, check_only: bool = False) -> dict:
    root = root.resolve()
    files = collect_source_files(root)
    entries = {name: {"bytes": path.stat().st_size, "sha256": sha256_file(path)} for name, path in files.items()}
    versions = collect_versions(root)
    missing = verify_inputs(root, entries, versions)
    if missing and not allow_incomplete:
        raise PackageError("Incomplete source distribution; export refused:\n" + "\n".join(missing))
    apk_inputs = apk_records(apks or [])
    manifest = {
        "schema": 1, "coverage_status": "partial" if missing else "required-project-native-inputs-present",
        "versions": versions, "associated_apks": apk_inputs,
        "missing_sources": missing, "files": entries,
        "export_policy": {"root_files": ROOT_FILES, "optional_notice_files": OPTIONAL_NOTICE_FILES,
                          "source_directories": SOURCE_DIRS,
                          "build_policy_java_directories": BUILD_POLICY_JAVA_DIRS,
                          "excludes": sorted(EXCLUDED_DIRS | EXCLUDED_FILES | EXCLUDED_SUFFIXES),
                          "tar_mtime": 0, "gzip_mtime": 0},
    }
    result = {"version": versions["application"], "source_entries": len(files),
              "uncompressed_bytes": sum(entry["bytes"] for entry in entries.values()),
              "coverage_status": manifest["coverage_status"], "missing_sources": missing,
              "associated_apks": apk_inputs}
    if check_only:
        return result
    version = versions["application"]
    if not re.fullmatch(r"[A-Za-z0-9._+-]+", version):
        raise PackageError(f"Unsafe application version in pubspec.yaml: {version!r}")
    output = (output or root / "artifacts" / f"FuzeVPN-Android-sources-{version}.tar.gz").resolve()
    relative_output = output.relative_to(root).as_posix() if output.is_relative_to(root) else None
    if relative_output and (relative_output in ROOT_FILES + OPTIONAL_NOTICE_FILES or any(relative_output.startswith(name + "/") for name in SOURCE_DIRS)):
        raise PackageError("Output must be outside the source allowlist (use artifacts/ or build/)")
    archive_digest = write_archive(root, output, f"FuzeVPN-Android-source-{version}", files, manifest)
    result.update({"output": str(output), "sha256": archive_digest})
    return result


def main(argv=None) -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--root", type=Path, default=Path(__file__).resolve().parents[1])
    parser.add_argument("--output", type=Path, help="New .tar.gz output; existing files are never overwritten")
    parser.add_argument("--apk", type=Path, action="append", default=[], help="Associate an APK SHA-256 without including the APK; repeatable")
    parser.add_argument("--check", action="store_true", help="Validate and inventory only; create no archive")
    parser.add_argument("--allow-incomplete", action="store_true", help="Explicit diagnostic export labelled partial when required sources are missing")
    args = parser.parse_args(argv)
    try:
        result = package_sources(args.root, args.output, args.apk,
                                 allow_incomplete=args.allow_incomplete, check_only=args.check)
    except (OSError, PackageError, KeyError, ValueError) as error:
        print(f"Source export failed: {error}", file=sys.stderr)
        return 1
    print(json.dumps(result, ensure_ascii=False, sort_keys=True, indent=2))
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
