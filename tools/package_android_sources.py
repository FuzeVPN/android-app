#!/usr/bin/env python3
# SPDX-License-Identifier: Apache-2.0
"""Export reviewed Android source inputs without reading workstation caches.

Python 3.10+, standard library only. See docs/SOURCE_DISTRIBUTION.md.
"""

from __future__ import annotations

import argparse
import ast
import base64
import fnmatch
import functools
import gzip
import hashlib
import io
import json
import os
import posixpath
from pathlib import Path, PurePosixPath
import re
import stat
import sys
import tarfile
import tempfile
import zipfile
import xml.etree.ElementTree as ET


ROOT_FILES = (
    ".flutter-version", ".gitignore", ".gitattributes", "analysis_options.yaml", "l10n.yaml",
    "pubspec.yaml", "pubspec.lock", "README.md", "README.fr.md",
    "LICENSING.md", "CONTRIBUTING.md", "SECURITY.md", "THIRD_PARTY_NOTICES.md",
    "android/build.gradle.kts", "android/settings.gradle.kts",
    "android/gradle.properties", "android/gradlew", "android/gradlew.bat",
    "android/app/build.gradle.kts", "android/app/proguard-rules.pro",
    "android/buildSrc/build.gradle.kts",
    ".github/workflows/validate.yml",
)
APPLICATION_INPUTS = (
    "lib/main.dart", "android/app/src/main/AndroidManifest.xml",
    "android/app/src/main/kotlin/com/fuzevpn/android/MainActivity.kt",
    "android/app/src/main/cpp/CMakeLists.txt", "android/app/src/main/cpp/openvpn_jni.cpp",
)
RELEASE_VALIDATION_INPUTS = (
    "tools/validate_project.ps1", "tools/prepare_isolated_instrumentation.ps1",
    "tools/isolated_instrumentation.gradle", "tools/validation_support.py",
    "tools/tests/test_validation_support.py", "tools/generate_release_sbom.py",
    "tools/tests/test_generate_release_sbom.py", "docs/SBOM.release.md",
    "docs/SBOM.release.sources.spdx.json",
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
# The validation runner and the repository scripts it invokes (A18-tooling-evidence-02).
VALIDATION_RUNNER = "tools/validate_project.ps1"
# Gradle compiles every file of these source sets; test/androidTest also see main.
KOTLIN_SOURCE_SETS = {
    "main": ("android/app/src/main/kotlin/", "android/app/src/main/java/"),
    "test": ("android/app/src/test/kotlin/", "android/app/src/test/java/"),
    "androidTest": ("android/app/src/androidTest/kotlin/", "android/app/src/androidTest/java/"),
}
# Directories compiled, analysed or discovered as a whole: every file there is an
# input, whether or not another source names it (review of A18-tooling-evidence-02).
WHOLE_DIRECTORY_INPUTS = (
    ("lib", (".dart",), "flutter analyze/test"),
    ("test", (".dart",), "flutter analyze/test"),
    ("integration_test", (".dart",), "flutter analyze/test"),
) + tuple(
    (directory.rstrip("/"), (".kt", ".java"), f"Gradle {name} source set")
    for name, directories in KOTLIN_SOURCE_SETS.items() for directory in directories
) + (
    ("android/app/src/main/res", None, "Android resource compilation"),
    ("android/buildSrc/src", (".java", ".kt", ".kts", ".groovy"), "buildSrc build"),
)
# tools/test_turnstile_bridge.ps1 compiles these with doubles for Android and
# Flutter; its classpath only provides the Kotlin, JUnit and JSON jars.
TURNSTILE_HOST_ROOT = "android/app/src/testHost/turnstile/"
TURNSTILE_HOST_PROVIDED = ("kotlin.", "java.", "javax.", "org.junit.", "org.json.", "org.hamcrest.", "org.jetbrains.annotations.")
NATIVE_BUILD_ROOT = "android/app/src/main/cpp"
# Directories compiled or executed as a whole; an exclusion rule must never drop a source file there.
COMPILED_SOURCE_ROOTS = ("lib", "test", "tools", "android/app/src", "android/buildSrc/src")
SOURCE_SUFFIXES = frozenset({".dart", ".kt", ".kts", ".java", ".c", ".cc", ".cpp", ".cxx", ".h", ".hpp",
                             ".cmake", ".ps1", ".py", ".cjs", ".js", ".gradle"})
EXTRA_MANIFEST = "android/source-distribution/completeness.manifest.json"
WIREGUARD_ROOT = "android/third_party/wireguard-android"
GO_SUM = f"{WIREGUARD_ROOT}/tunnel/tools/libwg-go/go.sum"
OPENSSL_SHA256 = "603f5602e2eef00d77fbd429d34dcd5822bb301757a1bc9cdb24c670f1eb859a"
GO_SOURCE_SHA256 = "9735d7dcdb65b35d3fa577f04064737c03b89cf1a2b71e6e69fe2f3c6f9fd4ca"


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


def yaml_path_scalar(value: str) -> str:
    """Read path scalars in the project's block-style Flutter asset declarations.

    Reject unsupported YAML syntax instead of silently overlooking an input.
    This keeps the exporter standard-library-only; it is not a YAML evaluator.
    """
    value = value.strip()
    if value.startswith('"'):
        try:
            result, end = json.JSONDecoder().raw_decode(value)
        except ValueError as error:
            raise PackageError("Invalid quoted Flutter asset path") from error
        if not isinstance(result, str) or value[end:].strip().split("#", 1)[0].strip():
            raise PackageError("Unsupported Flutter asset path declaration")
    elif value.startswith("'"):
        match = re.fullmatch(r"'((?:[^']|'')*)'\s*(?:#.*)?", value)
        if match is None:
            raise PackageError("Invalid quoted Flutter asset path")
        result = match.group(1).replace("''", "'")
    else:
        result = re.split(r"\s+#", value, maxsplit=1)[0].strip()
        if not result or result[0] in "[]{}&*!|>@":
            raise PackageError("Use block-style scalar Flutter asset paths in pubspec.yaml")
    safe_relative(result)
    return result


def flutter_input_paths(root: Path) -> list[str]:
    """Collect assets and font files explicitly referenced by pubspec.yaml."""
    result = []
    inside_flutter = False
    found_flutter = False
    section = None
    child_indent = None
    asset_indent = None
    for line in (root / "pubspec.yaml").read_text(encoding="utf-8").splitlines():
        if not line.strip() or line.lstrip().startswith("#"):
            continue
        if "\t" in line[:len(line) - len(line.lstrip())]:
            raise PackageError("Tabs are unsupported in pubspec.yaml indentation")
        indent = len(line) - len(line.lstrip(" "))
        text = line.strip()
        if indent == 0:
            inside_flutter = bool(re.fullmatch(r"flutter:\s*(?:#.*)?", text))
            if text.startswith("flutter:") and not inside_flutter:
                raise PackageError("Use a block-style flutter section in pubspec.yaml")
            found_flutter |= inside_flutter
            section = None
            child_indent = None
            asset_indent = None
            continue
        if not inside_flutter:
            continue
        if child_indent is None:
            child_indent = indent
        if indent <= child_indent:
            if indent != child_indent:
                raise PackageError("Inconsistent Flutter section indentation in pubspec.yaml")
            key, separator, tail = text.partition(":")
            section = key if separator and key in {"assets", "fonts"} else None
            asset_indent = None
            if section and tail.strip() and not tail.lstrip().startswith("#"):
                raise PackageError("Use block-style Flutter assets/fonts in pubspec.yaml")
            continue
        if section == "assets":
            if asset_indent is None:
                asset_indent = indent
            if indent > asset_indent:
                continue  # Optional path-map selectors such as flavors.
            if indent != asset_indent or not text.startswith("- "):
                raise PackageError("Unsupported Flutter asset declaration in pubspec.yaml")
            value = text[2:].strip()
            if value.startswith("path:"):
                value = value[5:]
            result.append(yaml_path_scalar(value))
        elif section == "fonts":
            nested_fonts = re.fullmatch(r"(?:-\s+)?fonts:\s*(.*)", text)
            if nested_fonts and nested_fonts.group(1) and not nested_fonts.group(1).startswith("#"):
                raise PackageError("Use block-style Flutter fonts in pubspec.yaml")
            if re.match(r"-\s*[*&]", text):
                raise PackageError("Use block-style Flutter font declarations in pubspec.yaml")
            match = re.match(r"(?:-\s+)?asset:\s*(.*)$", text)
            if match:
                result.append(yaml_path_scalar(match.group(1)))
    if not found_flutter:
        raise PackageError("Missing Flutter application section in pubspec.yaml")
    return sorted(set(result))


def read_source_xml(root: Path, relative: str) -> ET.Element:
    text = (root / relative).read_text(encoding="utf-8")
    if re.search(r"<!\s*(?:DOCTYPE|ENTITY)\b", text, re.IGNORECASE):
        raise PackageError(f"XML declarations/entities are not source resource inputs: {relative}")
    try:
        return ET.fromstring(text)
    except ET.ParseError as error:
        raise PackageError(f"Invalid Android resource XML: {relative}") from error


def verify_application_inputs(root: Path, entries: dict[str, dict]) -> list[str]:
    """Require application entry points and resolve declared resource inputs."""
    missing = [f"Missing required application input: {name}" for name in APPLICATION_INPUTS if name not in entries]
    for relative in flutter_input_paths(root):
        name = str(safe_relative(relative))
        if relative.endswith("/"):
            present = any(path.startswith(name + "/") for path in entries)
        else:
            present = name in entries
        if not present:
            missing.append(f"Missing Flutter asset/font input: {relative}")

    package_name = match_text(root, "pubspec.yaml", r"^name:\s*(\S+)$")
    for origin in entries:
        if not origin.startswith(("lib/", "test/")) or not origin.endswith(".dart"):
            continue
        content = (root / origin).read_text(encoding="utf-8")
        for directive in re.finditer(r"^\s*(?:import|export|part(?:\s+of)?)\s+([^;]+);", content, re.MULTILINE):
            for reference in re.findall(r"['\"]([^'\"\r\n]+)['\"]", directive[1]):
                if reference.startswith(f"package:{package_name}/"):
                    relative = "lib/" + reference[len(f"package:{package_name}/"):]
                elif ":" in reference:
                    continue  # SDK and external package sources are prerequisites.
                else:
                    relative = str(PurePosixPath(origin).parent / reference)
                relative = str(safe_relative(posixpath.normpath(relative)))
                if relative not in entries:
                    missing.append(f"Missing Dart source/fixture: {relative} (referenced by {origin})")
        if origin.startswith("test/"):
            for reference in re.findall(r"matchesGoldenFile\(\s*['\"]([^'\"$\r\n]+)['\"]", content):
                if reference.endswith("/"):
                    continue  # Prefix of a concatenated, generated capture path.
                relative = str(safe_relative(posixpath.normpath(str(PurePosixPath(origin).parent / reference))))
                if any(part.lower() in EXCLUDED_DIRS for part in PurePosixPath(relative).parts):
                    continue  # Explicit build/reports captures are generated review outputs.
                if relative not in entries:
                    missing.append(f"Missing golden fixture: {relative} (referenced by {origin})")
            # flutter test runs from the project root: File('lib/...') and
            # Directory('test/...') literals read reviewed repository inputs.
            for kind, single, double in re.findall(
                    r"(?<![\w$.])(File|Directory)\(\s*(?:'([^'$\\\r\n]+)'|\"([^\"$\\\r\n]+)\")\s*[,)]", content):
                reference = single or double
                relative = None if ":" in reference else repository_relative("", reference)
                if not relative or excluded(relative) or excluded(relative, directory=True):
                    continue  # Absolute, outside the project, or a generated build/report path.
                present = (relative in entries if kind == "File"
                           else any(path.startswith(relative + "/") for path in entries))
                if not present:
                    missing.append(f"Missing Dart test file input: {relative} (read by {origin})")

    manifest = "android/app/src/main/AndroidManifest.xml"
    if manifest not in entries:
        return sorted(set(missing))
    document = read_source_xml(root, manifest)
    namespace = match_text(root, "android/app/build.gradle.kts", r'namespace = "([^"]+)"')
    local_resource_packages = {None, namespace}
    application_id = re.search(r'applicationId = "([^"]+)"', (root / "android/app/build.gradle.kts").read_text(encoding="utf-8"))
    if application_id:
        local_resource_packages.add(application_id[1])
    android = "{http://schemas.android.com/apk/res/android}"
    for element in document.iter():
        attribute = "targetActivity" if element.tag == "activity-alias" else "name"
        if element.tag not in {"application", "activity", "activity-alias", "service", "receiver", "provider"}:
            continue
        name = element.get(android + attribute, "")
        if name.startswith("."):
            name = namespace + name
        elif name and "." not in name:
            name = namespace + "." + name
        if name.startswith(namespace + "."):
            qualified = name.split("$", 1)[0]
            source = qualified.replace(".", "/")
            present = any(f"android/app/src/main/{language}/{source}.{suffix}" in entries
                          for language, suffix in (("kotlin", "kt"), ("java", "java")))
            # Kotlin permits several top-level classes in one source file;
            # FuzeVpnApplication is declared in SharedVpnHost.kt in this app.
            if not present:
                package_name, _, class_name = qualified.rpartition(".")
                for path in entries:
                    if not (path.startswith(("android/app/src/main/kotlin/", "android/app/src/main/java/"))
                            and path.endswith((".kt", ".java"))):
                        continue
                    content = (root / path).read_text(encoding="utf-8")
                    declaration = re.search(r"^\s*package\s+([\w.]+)", content, re.MULTILINE)
                    if declaration and declaration[1] == package_name and re.search(r"\b(?:class|object|interface)\s+" + re.escape(class_name) + r"\b", content):
                        present = True
                        break
            if not present:
                missing.append(f"Missing Android component source: {name}")

    resources = {}
    prefix = "android/app/src/main/res/"
    for relative in entries:
        if not relative.startswith(prefix):
            continue
        parts = PurePosixPath(relative[len(prefix):]).parts
        if len(parts) != 2:
            continue
        resource_type = parts[0].split("-", 1)[0]
        if resource_type == "values" and relative.endswith(".xml"):
            for element in read_source_xml(root, relative):
                resource_name = element.get("name")
                resource_kind = element.get("type") if element.tag == "item" else element.tag
                if resource_kind in {"string-array", "integer-array"}:
                    resource_kind = "array"
                if resource_name and resource_kind not in {"public", "declare-styleable"}:
                    resources.setdefault((resource_kind, resource_name), []).append((relative, element))
        elif resource_type != "values":
            resource_name = PurePosixPath(parts[1]).stem.removesuffix(".9")
            element = read_source_xml(root, relative) if relative.endswith(".xml") else None
            resources.setdefault((resource_type, resource_name), []).append((relative, element))

    pending = [(manifest, document)]
    visited = set()
    expression = re.compile(r"@(?:(?P<package>[A-Za-z_][A-Za-z0-9_.]*):)?(?P<type>[A-Za-z_][A-Za-z0-9_]*)/(?P<name>[A-Za-z_][A-Za-z0-9_.]*)")
    while pending:
        origin, element = pending.pop()
        for node in element.iter():
            for value in list(node.attrib.values()) + [node.text or ""]:
                for reference in expression.finditer(value):
                    if reference["package"] not in local_resource_packages:
                        continue  # Framework and dependency resources are not app source files.
                    key = (reference["type"], reference["name"])
                    if key in visited:
                        continue
                    visited.add(key)
                    if key not in resources:
                        missing.append(f"Missing Android resource: @{key[0]}/{key[1]} (referenced by {origin})")
                    else:
                        pending.extend((path, xml) for path, xml in resources[key] if xml is not None)
    return sorted(set(missing))


def repository_relative(base: str, relative: str) -> str | None:
    value = posixpath.normpath(posixpath.join(base, relative.replace("\\", "/")))
    return None if value == ".." or value.startswith("../") or value.startswith("/") else ("" if value == "." else value)


def powershell_bases(text: str, script: str) -> dict[str, str]:
    """Repository directories held by a script's variables ($PSScriptRoot chains)."""
    directory = posixpath.dirname(script)
    bases = {"PSScriptRoot": directory}
    assignments = re.findall(r"(?m)\$(\w+)\s*=\s*([^\r\n;]+)", text)
    for _ in range(5):  # Chains such as $root -> $sources -> file.
        for name, expression in assignments:
            expression = expression.strip()
            value = None
            parent = re.search(r"Split-Path -Parent \(?\s*(?:\$PSScriptRoot|\(Split-Path -Parent \$MyInvocation\.MyCommand\.Path\))", expression)
            joined = re.search(r"Join-Path\s+\$(\w+)\s+'([^']+)'", expression)
            if parent:
                value = posixpath.dirname(directory)
            elif joined and joined[1] in bases:
                value = repository_relative(bases[joined[1]], joined[2])
            elif (alias := re.fullmatch(r"\[IO\.Path\]::GetFullPath\(\$(\w+)\)", expression)) and alias[1] in bases:
                value = bases[alias[1]]
            elif (quoted := re.fullmatch(r'"\$(\w+)/([^"$]+)"', expression)) and quoted[1] in bases:
                value = repository_relative(bases[quoted[1]], quoted[2])
            if value is not None and bases.get(name, value) == value:
                bases[name] = value
    return bases


def powershell_repository_paths(text: str, script: str) -> set[str]:
    """Repository paths that a project PowerShell script reads through literal paths.

    Resolves `$x = Join-Path $base 'literal'` chains rooted at the repository
    (derived from $PSScriptRoot or the script's own location) and literal
    `Join-Path`, `"$base/..."` and dot-sourced paths. Paths built from other
    variables (toolchains, outputs, caches) are not repository inputs.
    """
    bases = powershell_bases(text, script)
    paths = set()
    for base, relative in re.findall(r"Join-Path\s+\$(\w+)\s+'([^']+)'", text) + re.findall(r'"\$(\w+)/([^"$]+)"', text):
        if base in bases and (value := repository_relative(bases[base], relative)):
            paths.add(value)
    return paths


def listed_files(root: Path, directory: str, pattern: str = "*", *, recursive: bool) -> set[str]:
    """Files of a reviewed-tree directory as a listing step sees them (export exclusions apply)."""
    found: set[str] = set()
    top = root / directory
    if not directory or excluded(directory, directory=True) or not top.is_dir():
        return found
    for current, directories, filenames in os.walk(top):
        relative_directory = Path(current).relative_to(root).as_posix()
        directories[:] = sorted(name for name in directories
                                if recursive and not excluded(f"{relative_directory}/{name}", directory=True))
        for name in filenames:
            relative = f"{relative_directory}/{name}"
            if fnmatch.fnmatch(name, pattern) and not excluded(relative):
                found.add(relative)
    return found


def powershell_discovered_paths(root: Path, text: str, script: str) -> set[str]:
    """Files that `Get-ChildItem <dir> [-Filter 'x'] [-Recurse]` lists in the reviewed tree.

    <dir> is `(Join-Path $base 'dir')`, `"$base/dir"` or a bare `$base` such as
    the script's own `$PSScriptRoot` (android/app/src/test/bridge-host/run.ps1).
    """
    bases = powershell_bases(text, script)
    found: set[str] = set()
    for call in re.finditer(r"Get-ChildItem\b([^|\r\n]*)", text):
        arguments = call[1]
        joined = (re.search(r"\(\s*Join-Path\s+\$(\w+)\s+'([^']+)'\s*\)", arguments)
                  or re.search(r'"\$(\w+)/([^"$]+)"', arguments)
                  or re.search(r"-(?:Literal)?Path\s+\$(\w+)()(?![\w/:.(\[])", arguments))
        if not joined or joined[1] not in bases:
            continue  # Toolchains, caches and outputs are not repository inputs.
        directory = repository_relative(bases[joined[1]], joined[2])
        pattern = re.search(r"-Filter\s+'([^']+)'", arguments)
        found |= listed_files(root, directory or "", pattern[1] if pattern else "*",
                              recursive=bool(re.search(r"-Recurse\b", arguments)))
    return found


def unittest_modules(root: Path, start: str) -> set[str]:
    """Modules `python -m unittest discover -s start` loads: test*.py, below only into packages."""
    found: set[str] = set()
    pending = [start] if (root / start).is_dir() and not excluded(start, directory=True) else []
    while pending:
        directory = pending.pop()
        for child in sorted((root / directory).iterdir(), key=lambda path: path.name):
            relative = f"{directory}/{child.name}"
            if child.is_dir():
                if (child / "__init__.py").is_file() and not excluded(relative, directory=True):
                    pending.append(relative)
            elif fnmatch.fnmatch(child.name, "test*.py") and not excluded(relative):
                found.add(relative)
    return found


PYTHON_SCOPES = (ast.Module, ast.FunctionDef, ast.AsyncFunctionDef, ast.Lambda, ast.ClassDef,
                 ast.ListComp, ast.SetComp, ast.DictComp, ast.GeneratorExp)
PYTHON_PATH_TYPES = frozenset({"Path", "PurePath", "PurePosixPath", "PureWindowsPath", "PosixPath", "WindowsPath"})
PYTHON_PROBES = frozenset({"exists", "is_file", "is_dir", "is_symlink"})
PYTHON_STRING_METHODS = frozenset({"replace", "removeprefix", "removesuffix", "strip", "lower", "upper"})
PYTHON_VALUE_LIMIT = 512


class PythonRepositoryPaths:
    """Repository paths that a project Python script names through literal joins.

    Paths are anchored only at `Path(__file__)` (`.parent`, `.parents[n]`,
    `/ 'literal'`, `.joinpath`, `.with_name`), at names bound to such paths and
    at an argparse `--root`-style default. Strings come from literals, f-strings
    and loops over literal sequences, enumerated jointly so that two uses of one
    loop variable never mix iterations. Conditional expressions, values computed
    from data, the environment or unknown parameters, and paths only probed with
    exists()/is_file()/is_dir() are not followed.
    """

    def __init__(self, text: str, script: str):
        self.script = script
        self.tree = ast.parse(text, filename=script)
        self.parent: dict[ast.AST, ast.AST] = {}
        for node in ast.walk(self.tree):
            for child in ast.iter_child_nodes(node):
                self.parent[child] = node
        self.bindings: dict[ast.AST, dict[str, list]] = {}
        self.options: dict[str, ast.AST] = {}
        self.probes: dict[tuple, list[ast.Call]] = {}
        for node in ast.walk(self.tree):
            self.collect(node)
        self.active: set[int] = set()
        self.conventions: dict[str, tuple | None] = {}

    def scope(self, node):
        node = self.parent.get(node)
        while node is not None and not isinstance(node, PYTHON_SCOPES):
            node = self.parent.get(node)
        return node

    def bind(self, scope, name, kind, value=None):
        self.bindings.setdefault(scope, {}).setdefault(name, []).append((kind, value))

    def bind_target(self, at, target, kind, value):
        if isinstance(target, ast.Name):
            self.bind(self.scope(at), target.id, kind, value)
        elif isinstance(target, (ast.Tuple, ast.List, ast.Starred)):
            for name in ast.walk(target):
                if isinstance(name, ast.Name):
                    self.bind(self.scope(at), name.id, "unknown")

    def collect(self, node):
        if isinstance(node, ast.Assign):
            for target in node.targets:
                self.bind_target(node, target, "value", node.value)
        elif isinstance(node, (ast.AnnAssign, ast.NamedExpr)) and node.value is not None:
            self.bind_target(node, node.target, "value", node.value)
        elif isinstance(node, ast.AugAssign):
            self.bind_target(node, node.target, "unknown", None)
        elif isinstance(node, (ast.For, ast.AsyncFor, ast.comprehension)):
            self.bind_target(node, node.target, "element", node.iter)
        elif isinstance(node, (ast.With, ast.AsyncWith)):
            for item in node.items:
                if item.optional_vars is not None:
                    self.bind_target(node, item.optional_vars, "unknown", None)
        elif isinstance(node, ast.ExceptHandler) and node.name:
            self.bind(self.scope(node), node.name, "unknown")
        elif isinstance(node, (ast.Import, ast.ImportFrom)):
            for alias in node.names:
                self.bind(self.scope(node), (alias.asname or alias.name).split(".")[0], "unknown")
        elif isinstance(node, (ast.Global, ast.Nonlocal)):
            for name in node.names:
                self.bind(self.scope(node), name, "unknown")
        elif isinstance(node, ast.Call) and isinstance(node.func, ast.Attribute):
            if node.func.attr in PYTHON_PROBES and isinstance(node.func.value, ast.Name):
                self.probes.setdefault((self.scope(node), node.func.value.id), []).append(node)
            if node.func.attr == "add_argument":
                options = [argument.value for argument in node.args
                           if isinstance(argument, ast.Constant) and isinstance(argument.value, str)]
                keywords = {keyword.arg: keyword.value for keyword in node.keywords}
                long_options = [option for option in options if option.startswith("--")]
                destination = keywords.get("dest")
                name = (destination.value if isinstance(destination, ast.Constant)
                        else long_options[0][2:].replace("-", "_") if long_options else None)
                if name and "default" in keywords:
                    self.options[name] = keywords["default"]
        if isinstance(node, (ast.FunctionDef, ast.AsyncFunctionDef, ast.ClassDef)):
            self.bind(self.scope(node), node.name, "unknown")
        if isinstance(node, (ast.FunctionDef, ast.AsyncFunctionDef, ast.Lambda)):
            arguments = node.args
            for argument in arguments.posonlyargs + arguments.args + arguments.kwonlyargs + [
                    item for item in (arguments.vararg, arguments.kwarg) if item is not None]:
                self.bind(node, argument.arg, "parameter")

    @staticmethod
    def extend(environment, key, text):
        values = dict(environment)
        if values.get(key, text) != text:
            return None
        values[key] = text
        return frozenset(values.items())

    @staticmethod
    def join(base, relative):
        return None if ":" in relative else repository_relative(base, relative)

    @staticmethod
    def up(path, count):
        for _ in range(count):
            if path == "":
                return None  # Above the repository: not a repository input.
            path = posixpath.dirname(path)
        return path

    def sibling(self, path, name):
        directory = self.up(path, 1)
        return None if directory is None else self.join(directory, name)

    def product(self, left, right, kind, combine):
        items = set()
        for left_environment, left_text in left[1]:
            for right_environment, right_text in right[1]:
                environment = left_environment
                for key, text in right_environment:
                    if environment is not None:
                        environment = self.extend(environment, key, text)
                value = None if environment is None else combine(left_text, right_text)
                if value is not None:
                    items.add((environment, value))
                    if len(items) > PYTHON_VALUE_LIMIT:
                        return None
        return (kind, frozenset(items)) if items else None

    @staticmethod
    def mapped(value, kind, function):
        items = set()
        for environment, text in value[1]:
            result = function(text)
            if result is not None:
                items.add((environment, result))
        return (kind, frozenset(items)) if items and len(items) <= PYTHON_VALUE_LIMIT else None

    def lookup(self, name, at):
        scope, innermost = self.scope(at), True
        while scope is not None:
            # A class body is visible to its own statements only, not to its methods.
            if innermost or not isinstance(scope, ast.ClassDef):
                table = self.bindings.get(scope, {})
                if name in table:
                    return self.combine(name, table[name], scope)
            innermost = False
            scope = self.scope(scope)
        return None

    def combine(self, name, entries, scope):
        result = None
        for kind, value in entries:
            if kind == "value":
                item = self.evaluate(value)
            elif kind == "element":
                sequence = self.evaluate(value)
                item = None
                if sequence is not None and sequence[0] == "seq":
                    key = (id(scope), name)
                    pairs = set()
                    for old, text in sequence[1]:
                        environment = self.extend(old, key, text)
                        if environment is not None:
                            pairs.add((environment, text))
                    item = ("str", frozenset(pairs)) if pairs else None
            elif kind == "parameter":
                item = self.convention(name)
            else:
                return None
            # Several different bindings (branches, re-assignments) are not followed.
            if item is None or (result is not None and item != result):
                return None
            result = item
        return result

    def convention(self, name):
        """A parameter named like the script's single repository-path binding receives it."""
        if name in self.conventions:
            return self.conventions[name]
        self.conventions[name] = None  # Recursion guard.
        values = [self.evaluate(value) if kind == "value" else None
                  for table in self.bindings.values() for kind, value in table.get(name, ()) if kind != "parameter"]
        if name in self.options:
            values.append(self.evaluate(self.options[name]))
        result = values[0] if values and values[0] is not None and values[0][0] == "path" else None
        if result is not None and any(value != result for value in values):
            result = None
        self.conventions[name] = result
        return result

    def is_namespace(self, name):
        return any(kind == "value" and isinstance(value, ast.Call) and isinstance(value.func, ast.Attribute)
                   and value.func.attr == "parse_args"
                   for table in self.bindings.values() for kind, value in table.get(name, ()))

    def evaluate(self, node):
        key = id(node)
        if key in self.active:
            return None
        self.active.add(key)
        try:
            return self.evaluate_node(node)
        finally:
            self.active.discard(key)

    def evaluate_node(self, node):
        empty = frozenset()
        if isinstance(node, ast.Constant):
            return ("str", frozenset({(empty, node.value)})) if isinstance(node.value, str) else None
        if isinstance(node, ast.Name):
            return ("path", frozenset({(empty, self.script)})) if node.id == "__file__" else self.lookup(node.id, node)
        if isinstance(node, ast.JoinedStr):
            result = ("str", frozenset({(empty, "")}))
            for part in node.values:
                if isinstance(part, ast.Constant) and isinstance(part.value, str):
                    item = ("str", frozenset({(empty, part.value)}))
                elif isinstance(part, ast.FormattedValue) and part.conversion == -1 and part.format_spec is None:
                    item = self.evaluate(part.value)
                else:
                    return None
                if item is None or item[0] != "str":
                    return None
                result = self.product(result, item, "str", lambda left, right: left + right)
                if result is None:
                    return None
            return result
        if isinstance(node, ast.BinOp):
            left = self.evaluate(node.left)
            right = self.evaluate(node.right) if left is not None else None
            if left is None or right is None:
                return None
            if isinstance(node.op, ast.Div) and left[0] == "path" and right[0] == "str":
                return self.product(left, right, "path", self.join)
            if isinstance(node.op, ast.Add) and left[0] == right[0] == "str":
                return self.product(left, right, "str", lambda first, second: first + second)
            return None
        if isinstance(node, (ast.List, ast.Tuple, ast.Set)):
            items = set()
            for element in node.elts:
                value = self.evaluate(element)
                if value is None or value[0] != "str":
                    return None
                items |= value[1]
            return ("seq", frozenset(items)) if items else None
        if isinstance(node, ast.Subscript):
            target, index = node.value, node.slice
            if (isinstance(target, ast.Attribute) and target.attr == "parents" and isinstance(index, ast.Constant)
                    and isinstance(index.value, int) and not isinstance(index.value, bool) and index.value >= 0):
                base = self.evaluate(target.value)
                if base is not None and base[0] == "path":
                    return self.mapped(base, "path", lambda path: self.up(path, index.value + 1))
            return None
        if isinstance(node, ast.Attribute):
            if node.attr == "parent":
                base = self.evaluate(node.value)
                return self.mapped(base, "path", lambda path: self.up(path, 1)) if base and base[0] == "path" else None
            if isinstance(node.value, ast.Name) and node.attr in self.options and self.is_namespace(node.value.id):
                return self.evaluate(self.options[node.attr])
            return None
        if isinstance(node, ast.Call):
            return self.evaluate_call(node)
        return None

    def evaluate_call(self, node):
        function = node.func
        if isinstance(function, ast.Name):
            if len(node.args) != 1 or node.keywords:
                return None
            value = self.evaluate(node.args[0])
            if function.id in PYTHON_PATH_TYPES:
                return value if value is not None and value[0] == "path" else None
            if function.id in {"sorted", "list", "tuple", "set", "frozenset"}:
                return value if value is not None and value[0] == "seq" else None
            return None
        if not isinstance(function, ast.Attribute):
            return None
        receiver = self.evaluate(function.value)
        if receiver is None:
            return None
        constants = [argument.value for argument in node.args
                     if isinstance(argument, ast.Constant) and isinstance(argument.value, str)]
        literal = len(constants) == len(node.args) and not node.keywords
        if receiver[0] == "path":
            if function.attr in {"resolve", "absolute"} and not node.args:
                return receiver
            if function.attr == "joinpath" and node.args and not node.keywords:
                result = receiver
                for argument in node.args:
                    value = self.evaluate(argument)
                    if value is None or value[0] != "str":
                        return None
                    result = self.product(result, value, "path", self.join)
                    if result is None:
                        return None
                return result
            if function.attr == "with_name" and literal and len(constants) == 1:
                return self.mapped(receiver, "path", lambda path: self.sibling(path, constants[0]))
            return None
        if receiver[0] == "str" and literal:
            if function.attr == "split" and len(constants) <= 1:
                items = {(environment, part) for environment, text in receiver[1] for part in text.split(*constants)}
                return ("seq", frozenset(items)) if items and len(items) <= PYTHON_VALUE_LIMIT else None
            if function.attr in PYTHON_STRING_METHODS:
                try:
                    return self.mapped(receiver, "str", lambda text: getattr(text, function.attr)(*constants))
                except TypeError:
                    return None
        return None

    def guarded(self, call) -> bool:
        """A probe whose true result selects the branch reading the path (`if p.exists():`)."""
        node, parent = call, self.parent.get(call)
        while isinstance(parent, ast.BoolOp):
            node, parent = parent, self.parent.get(parent)
        if isinstance(parent, (ast.If, ast.While, ast.IfExp)):
            return parent.test is node
        return isinstance(parent, ast.comprehension) and node in parent.ifs

    def optional(self, node) -> bool:
        """Paths read only when they exist; `require(p.exists())` or `if not p.exists()` keeps them required."""
        parent = self.parent.get(node)
        if isinstance(parent, ast.BinOp) and parent.left is node:
            return self.optional(parent)
        if isinstance(parent, ast.Attribute) and parent.value is node:
            call = self.parent.get(parent)
            if parent.attr == "joinpath":
                return isinstance(call, ast.Call) and self.optional(call)
            return parent.attr in PYTHON_PROBES and isinstance(call, ast.Call) and call.func is parent and self.guarded(call)
        if isinstance(parent, ast.Assign) and len(parent.targets) == 1 and isinstance(parent.targets[0], ast.Name):
            probes = self.probes.get((self.scope(parent), parent.targets[0].id), [])
            return bool(probes) and all(self.guarded(call) for call in probes)
        return False

    def paths(self) -> set[str]:
        found = set()
        for node in ast.walk(self.tree):
            joined = isinstance(node, ast.BinOp) and isinstance(node.op, ast.Div)
            called = (isinstance(node, ast.Call) and isinstance(node.func, ast.Attribute)
                      and node.func.attr in {"joinpath", "with_name"})
            if (joined or called) and not self.optional(node):
                value = self.evaluate(node)
                if value is not None and value[0] == "path":
                    found.update(text for _, text in value[1])
        return found


def python_repository_paths(text: str, script: str) -> set[str]:
    return set(_python_repository_paths(text, script))


@functools.lru_cache(maxsize=None)
def _python_repository_paths(text: str, script: str) -> frozenset[str]:
    # A pure function of the script text: repeated completeness checks reuse it.
    try:
        return frozenset(PythonRepositoryPaths(text, script).paths())
    except SyntaxError as error:
        raise PackageError(f"Cannot parse Python script used by the validation runner: {script}: {error}") from error


def exported_directory(relative: str) -> bool:
    """A directory inside the exported source roots, all of whose reviewed files are collected."""
    return any(relative == directory or relative.startswith(directory + "/") for directory in SOURCE_DIRS)


def validation_runner_inputs(root: Path, entries: dict[str, dict]) -> list[str]:
    """Inputs read by tools/validate_project.ps1 and by every repository script it runs.

    PowerShell and Python scripts are followed recursively; files that
    Get-ChildItem lists or `unittest discover -s` loads in the reviewed tree are
    inputs too, as are the repository paths the scripts name literally.
    """
    if VALIDATION_RUNNER not in entries:
        return []  # Already reported as a missing required input.
    missing, pending, seen, wholes = [], [VALIDATION_RUNNER], set(), set()
    while pending:
        script = pending.pop()
        if script in seen:
            continue
        seen.add(script)
        text = (root / script).read_text(encoding="utf-8-sig")
        discovered: set[str] = set()
        listings: set[str] = set()  # Discovery roots: only what discovery loads is an input.
        if script.endswith(".py"):
            try:
                required = python_repository_paths(text, script)
            except PackageError as error:
                missing.append(str(error))  # The runner step importing it would fail as well.
                required = set()
        else:
            required = powershell_repository_paths(text, script)
            discovered = powershell_discovered_paths(root, text, script)
        if script == VALIDATION_RUNNER:
            # Steps run with the project root as working directory.
            required.update("tools/" + name for name in re.findall(r"Invoke-ProjectScript\s+'[^']+'\s+'([^']+)'", text))
            required.update(re.findall(r"\$PythonExecutable\s+@\('([^']+\.py)'", text))
            for start in re.findall(r"'-s',\s*'([^']+)'", text):
                required.add(start)
                listings.add(start)
                discovered |= unittest_modules(root, start)
            required.update(re.findall(r"'(test/[^'*]+\.dart)'", text))
        for relative, found in sorted({(name, False) for name in required} | {(name, True) for name in discovered}):
            if not relative or excluded(relative) or excluded(relative, directory=True):
                continue  # Build outputs, caches and workstation files are never source inputs.
            if relative.endswith((".ps1", ".py")) and (root / relative).is_file():
                pending.append(relative)  # Its own inputs count even when the script itself is absent.
            if relative in entries:
                continue
            if found:
                missing.append(f"Missing discovered input: {relative} (discovered by {script})")
            elif (relative not in listings and exported_directory(relative) and (root / relative).is_dir()
                  and (listed := listed_files(root, relative, recursive=True))):
                # A directory a script names (source or include root, listing) is used
                # as a whole: each of its reviewed files is an input. A directory holding
                # export roots (the Gradle project `android`) relies on the explicit
                # inputs instead, so that workstation files there never block the check.
                for name in sorted(listed - entries.keys() - wholes):
                    wholes.add(name)  # Reported once, for the first script naming a directory holding it.
                    missing.append(f"Missing discovered input: {name} (every file of {relative} is used by {script})")
            elif not any(name.startswith(relative + "/") for name in entries):
                missing.append(f"Missing validation runner input: {relative} (used by {script})")
    return missing


def discovered_source_inputs(root: Path, entries: dict[str, dict]) -> list[str]:
    """Every file of the directories compiled, analysed or bundled as a whole in the reviewed tree."""
    missing = []
    for directory, suffixes, consumer in WHOLE_DIRECTORY_INPUTS:
        for relative in sorted(listed_files(root, directory, recursive=True)):
            if (suffixes is None or relative.endswith(suffixes)) and relative not in entries:
                missing.append(f"Missing discovered input: {relative} ({consumer} uses every file of {directory})")
    declared_inputs = flutter_input_paths(root) if (root / "pubspec.yaml").is_file() else []
    for declared in declared_inputs:
        if declared.endswith("/"):
            directory = str(safe_relative(declared))
            for relative in sorted(listed_files(root, directory, recursive=False)):
                if relative not in entries:
                    missing.append(f"Missing discovered input: {relative} (pubspec.yaml bundles every file of {declared})")
    return missing


KOTLIN_IMPLICIT_NAMES = frozenset("""
Any Unit Nothing String Int Long Short Byte Double Float Boolean Char Number CharSequence Comparable Enum Annotation
Array IntArray LongArray ShortArray ByteArray DoubleArray FloatArray BooleanArray CharArray UInt ULong UShort UByte
UIntArray ULongArray UShortArray UByteArray Pair Triple Lazy LazyThreadSafetyMode Result Function Throwable Exception Error
RuntimeException IllegalStateException IllegalArgumentException IndexOutOfBoundsException UnsupportedOperationException
NumberFormatException NullPointerException ClassCastException AssertionError NoSuchElementException ArithmeticException
ConcurrentModificationException UninitializedPropertyAccessException NotImplementedError NoWhenBranchMatchedException
KotlinNullPointerException TypeCastException CharacterCodingException Iterable MutableIterable Iterator MutableIterator
ListIterator MutableListIterator Collection MutableCollection List MutableList Set MutableSet Map MutableMap ArrayList HashMap
LinkedHashMap HashSet LinkedHashSet ArrayDeque RandomAccess Comparator Sequence IntRange LongRange CharRange UIntRange
ULongRange ClosedRange OpenEndRange ClosedFloatingPointRange IntProgression LongProgression CharProgression Regex RegexOption
MatchResult MatchGroup MatchGroupCollection MatchNamedGroupCollection StringBuilder Appendable Charsets Typography HexFormat
CharCategory CharDirectionality Volatile Synchronized Transient Strictfp JvmStatic JvmField JvmName JvmOverloads JvmInline
JvmRecord JvmMultifileClass JvmSuppressWildcards JvmWildcard JvmDefault JvmDefaultWithCompatibility JvmSerializableLambda
Throws Suppress Deprecated ReplaceWith DeprecationLevel PublishedApi OptIn RequiresOptIn SinceKotlin DslMarker Target
Retention Repeatable MustBeDocumented AnnotationTarget AnnotationRetention UnsafeVariance ParameterName ExtensionFunctionType
Metadata DeepRecursiveFunction DeepRecursiveScope ExperimentalStdlibApi ExperimentalUnsignedTypes IndexedValue Grouping
FileAlreadyExistsException NoSuchFileException AccessDeniedException FileSystemException FileTreeWalk FileWalkDirection
OnErrorAction Thread Runnable System Math StrictMath Runtime Process ProcessBuilder ThreadLocal InheritableThreadLocal Class
ClassLoader Integer Character Void Object AutoCloseable Cloneable Readable Package StackTraceElement Override
FunctionalInterface SafeVarargs SuppressWarnings InterruptedException SecurityException ReflectiveOperationException
ClassNotFoundException NoSuchMethodException NoSuchFieldException IllegalAccessException InstantiationException
CloneNotSupportedException ArrayIndexOutOfBoundsException ArrayStoreException NegativeArraySizeException
IllegalMonitorStateException IllegalThreadStateException StringIndexOutOfBoundsException TypeNotPresentException
EnumConstantNotPresentException LinkageError NoClassDefFoundError UnsatisfiedLinkError ExceptionInInitializerError
VirtualMachineError InternalError OutOfMemoryError StackOverflowError UnknownError ThreadGroup Record Module ModuleLayer
StackWalker ProcessHandle Companion BuildConfig
""".split())
KOTLIN_MEMBER_ONLY_IMPORTS = frozenset({"org.junit.Assert"})


def kotlin_code(text: str) -> str:
    """Kotlin code without comments, string contents or backtick names; ${...} templates are kept."""
    result: list[str] = []
    length = len(text)

    def code(index: int, template: bool) -> int:
        depth = 0
        while index < length:
            if text.startswith("//", index):
                end = text.find("\n", index)
                index = length if end < 0 else end
            elif text.startswith("/*", index):
                level, index = 1, index + 2
                while index < length and level:
                    if text.startswith("/*", index):
                        level, index = level + 1, index + 2
                    elif text.startswith("*/", index):
                        level, index = level - 1, index + 2
                    else:
                        index += 1
                result.append(" ")
            elif text.startswith('"""', index) or text[index] == '"':
                raw = text.startswith('"""', index)
                index = string(index + (3 if raw else 1), raw)
                result.append(' "" ')
            elif text[index] == "'":
                end = index + 1
                while end < length and text[end] not in "'\n":
                    end += 2 if text[end] == "\\" else 1
                index = end + 1
                result.append(" ")
            elif text[index] == "`":
                end = text.find("`", index + 1)
                index = length if end < 0 else end + 1
                result.append(" ")
            else:
                character = text[index]
                if template and character == "{":
                    depth += 1
                elif template and character == "}":
                    if depth == 0:
                        return index + 1
                    depth -= 1
                result.append(character)
                index += 1
        return index

    def string(index: int, raw: bool) -> int:
        while index < length:
            if raw and text.startswith('"""', index):
                index += 3
                while index < length and text[index] == '"':
                    index += 1
                return index
            if text.startswith("${", index):
                result.append(" ")
                index = code(index + 2, True)
                result.append(" ")
                continue
            if not raw and text[index] == "\\":
                index += 2
                continue
            if not raw and text[index] in '"\n':
                return index + 1
            index += 1
        return index

    code(0, False)
    return "".join(result)


@functools.lru_cache(maxsize=None)
def kotlin_parse(text: str) -> tuple[str, str, frozenset[str]]:
    """Package, code without comments/strings, and declared names of one Kotlin source text."""
    code = kotlin_code(text)
    package_match = re.search(r"(?m)^\s*package\s+([\w.]+)", code)
    return package_match[1] if package_match else "", code, frozenset(kotlin_declarations(code))


def kotlin_declarations(code: str) -> set[str]:
    names = set(re.findall(r"\b(?:class|interface|object|typealias|val|var)\s+([A-Z]\w*)", code))
    names.update(re.findall(r"\bfun\s+(?:<[^>]*>\s*)?(?:[\w.]+\.)?([A-Z]\w*)\s*\(", code))
    for match in re.finditer(r"\benum\s+class\s+\w+[^{;]*\{", code):
        depth, index = 0, match.end()
        while index < len(code) and not (depth == 0 and code[index] in ";}"):
            depth += code[index] in "({[" or -(code[index] in ")]}")
            index += 1
        flat = re.sub(r"\([^()]*\)|\{[^{}]*\}", "", code[match.end():index])
        names.update(re.findall(r"(?:^|,)\s*(?:@\w+\s*)*([A-Za-z_]\w*)", flat))
    for parameters in re.findall(r"\b(?:fun|class|interface|typealias)\s*(?:\w+\s*)?<([^<>]*(?:<[^<>]*>[^<>]*)*)>", code):
        names.update(re.findall(r"(?:^|,)\s*(?:(?:in|out|reified)\s+)?([A-Z]\w*)", parameters))
    return names


def kotlin_balanced_end(code: str, index: int, opening: str, closing: str) -> int:
    """Index just after the group opened at `index`, or `index` when no group starts there."""
    if index >= len(code) or code[index] != opening:
        return index
    depth = 0
    while index < len(code):
        depth += (code[index] == opening) - (code[index] == closing)
        index += 1
        if depth == 0:
            break
    return index


def kotlin_inherited_bodies(code: str, external) -> list[tuple[int, int]]:
    """Body spans of classes and objects whose supertype list names an external type.

    Inside them, nested types inherited from that supertype (VpnService.Builder,
    ViewGroup.LayoutParams...) are valid without import or qualification.
    """
    spans = []
    for keyword in re.finditer(r"(?<![\w:.])(?:class|object|interface)\b", code):
        index = re.compile(r"\s*(?:[A-Za-z_]\w*)?\s*").match(code, keyword.end()).end()
        index = kotlin_balanced_end(code, index, "<", ">")
        index = re.compile(r"\s*(?:(?:@[\w.]+(?:\([^()]*\))?|private|protected|internal|public)\s+)*"
                           r"(?:constructor\s*)?").match(code, index).end()
        index = kotlin_balanced_end(code, index, "(", ")")
        colon = re.compile(r"\s*:(?!:)").match(code, index)
        if not colon:
            continue
        start = index = colon.end()
        depth, body = 0, None
        while index < len(code):
            character = code[index]
            if character in "(<[":
                depth += 1
            elif character in ")>]" and not code.startswith("->", index - 1):
                depth -= 1
            elif depth <= 0 and character == "{":
                body = index
                break
            elif depth <= 0 and character in ";}=":
                break
            elif (depth <= 0 and character == "\n" and not code[start:index].rstrip().endswith(",")
                  and code[index:].lstrip()[:1] not in (",", "{")):
                break
            index += 1
        items, depth, current = [], 0, ""
        for character in code[start:index]:
            depth += (character in "(<[") - (character in ")>]")
            if character == "," and depth <= 0:
                items.append(current)
                current = ""
            else:
                current += character
        items.append(current)
        names = [match[1] for item in items
                 if (match := re.match(r"\s*(?:@[\w.]+(?:\([^()]*\))?\s+)*([A-Za-z_][\w.]*)", item))]
        if body is not None and any(external(name.rstrip(".")) for name in names):
            spans.append((body, kotlin_balanced_end(code, body, "{", "}")))
    return spans


def kotlin_compile_closure(root: Path, sources: list[str], label: str, *,
                           provided: tuple[str, ...] | None = None, cache: dict | None = None) -> list[str]:
    """Report names a Kotlin compile set cannot resolve because a source is absent.

    Same-package declarations need no import, so a missing file shows up as an
    unresolved name in another file. `provided` lists the only external
    packages on the classpath (host runners); otherwise only project imports
    (com.fuzevpn.*) must resolve within the set.
    """
    parsed, packages, cache = {}, {}, {} if cache is None else cache
    for relative in sources:
        if relative not in cache:
            cache[relative] = kotlin_parse((root / relative).read_text(encoding="utf-8-sig"))
        package_name, code, declared = parsed[relative] = cache[relative]
        packages.setdefault(package_name, set()).update(declared)

    def owned(name: str) -> bool:
        return name.startswith("com.fuzevpn.") if provided is None else not name.startswith(provided)

    missing = []
    for relative, (package_name, code, declared) in parsed.items():
        imported, unchecked, qualified = set(), False, {}
        for name, star, alias in re.findall(r"(?m)^\s*import\s+([\w.]+?)(\.\*)?(?:\s+as\s+(\w+))?\s*$", code):
            segments = name.split(".")
            first_type = next((index for index, part in enumerate(segments) if part[:1].isupper()), None)
            if star:
                if name in packages:
                    imported |= packages[name]
                elif owned(name) and first_type is None:
                    missing.append(f"Missing Kotlin package {name} for {label} (imported by {relative})")
                elif name not in KOTLIN_MEMBER_ONLY_IMPORTS:
                    unchecked = True  # External wildcard: its names cannot be listed offline.
                continue
            imported.add(alias or segments[-1])
            qualified[alias or segments[-1]] = name
            if first_type is not None and owned(name):
                owner, declaration = ".".join(segments[:first_type]), segments[first_type]
                if declaration not in packages.get(owner, ()):
                    missing.append(f"Missing Kotlin source declaring {owner}.{declaration} for {label} (imported by {relative})")
        if unchecked:
            continue
        body = re.sub(r"(?m)^\s*(?:package|import)\s+[^\n]*", " ", code)
        known = packages.get(package_name, set()) | declared | imported | KOTLIN_IMPLICIT_NAMES

        def external(type_name: str) -> bool:
            head = type_name.split(".", 1)[0]
            if not head[:1].isupper():
                return not owned(type_name)  # Fully qualified supertype.
            # Imported external type; same-package, implicit or unresolved names are not external.
            return head in qualified and not owned(qualified[head])

        inherited = kotlin_inherited_bodies(body, external)
        unresolved = set()
        for match in re.finditer(r"(?<![\w.$@])([A-Z][a-z][A-Za-z0-9_]*)(?!\w)", body):
            if match[1] not in known and not any(start <= match.start() < end for start, end in inherited):
                unresolved.add(match[1])
        for name in sorted(unresolved):
            missing.append(f"Missing Kotlin source declaring {name} for {label} (referenced by {relative})")
    return missing


def kotlin_source_closure(root: Path, entries: dict[str, dict]) -> list[str]:
    def files(prefixes):
        return sorted(name for name in entries if name.startswith(prefixes) and name.endswith(".kt"))
    cache: dict = {}
    main = files(KOTLIN_SOURCE_SETS["main"])
    missing = kotlin_compile_closure(root, main, "main", cache=cache)
    for name in ("test", "androidTest"):
        own = files(KOTLIN_SOURCE_SETS[name])
        found = kotlin_compile_closure(root, main + own, name, cache=cache)
        missing += [item for item in found if any(f"by {source})" in item for source in own)]
    runner = "tools/test_turnstile_bridge.ps1"
    if runner in entries:
        host = sorted(path for path in powershell_repository_paths((root / runner).read_text(encoding="utf-8-sig"), runner)
                      if path.endswith(".kt") and path in entries)
        host += files((TURNSTILE_HOST_ROOT + "stubs/",))
        if host:
            missing += kotlin_compile_closure(root, sorted(set(host)), "the Turnstile host runner",
                                              provided=TURNSTILE_HOST_PROVIDED, cache=cache)
    return missing


def native_source_closure(root: Path, entries: dict[str, dict]) -> list[str]:
    """Sources and CMake scripts named by the app's CMake lists, and quoted local includes."""
    missing, sources = [], []
    pending, seen = [f"{NATIVE_BUILD_ROOT}/CMakeLists.txt"], set()
    while pending:
        script = pending.pop()
        if script in seen or script not in entries:
            continue
        seen.add(script)
        directory = posixpath.dirname(script)
        text = re.sub(r"#[^\n]*", "", (root / script).read_text(encoding="utf-8-sig"))
        for command, arguments in re.findall(r"(?i)\b(add_library|add_executable|target_sources|include)\s*\(([^)]*)\)", text):
            for quoted, bare in re.findall(r'"([^"]*)"|(\S+)', arguments):
                token = (quoted or bare).replace("${CMAKE_CURRENT_LIST_DIR}/", "").replace("${CMAKE_CURRENT_SOURCE_DIR}/", "")
                is_script = command.lower() == "include"
                if "${" in token or "$<" in token or not re.search(r"\.cmake$" if is_script else r"\.(?:c|cc|cpp|cxx|h|hpp)$", token):
                    continue
                relative = repository_relative(directory, token)
                if relative is None or relative.startswith(NATIVE_ROOT + "/"):
                    continue  # third_party is verified byte for byte by the native lock.
                if relative not in entries:
                    missing.append(f"Missing native build input: {relative} (listed by {script})")
                elif is_script:
                    pending.append(relative)
                else:
                    sources.append(relative)
    scanned = set()
    while sources:
        source = sources.pop()
        if source in scanned:
            continue
        scanned.add(source)
        for header in re.findall(r'(?m)^\s*#\s*include\s*"([^"]+)"', (root / source).read_text(encoding="utf-8-sig", errors="replace")):
            relative = repository_relative(posixpath.dirname(source), header)
            if relative in entries:
                sources.append(relative)
            elif not any(name.startswith(NATIVE_ROOT + "/") and name.endswith("/" + header) for name in entries):
                missing.append(f"Missing native header: {header} (included by {source})")
    return missing


def excluded_compiled_sources(root: Path) -> list[str]:
    """Source files that an exclusion rule would silently drop from compiled roots."""
    found = []
    for base in COMPILED_SOURCE_ROOTS:
        top = root / base
        if not top.is_dir():
            continue
        for directory, _, filenames in os.walk(top):
            relative_directory = Path(directory).relative_to(root).as_posix()
            if relative_directory == NATIVE_ROOT or relative_directory.startswith(NATIVE_ROOT + "/"):
                continue  # Governed byte for byte by the independent native lock.
            for name in filenames:
                relative = f"{relative_directory}/{name}"
                if (Path(name).suffix.lower() in SOURCE_SUFFIXES or name == "CMakeLists.txt") and excluded(relative):
                    found.append(f"Source file excluded by export rules: {relative}")
    return sorted(found)


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
    series_path = root / WIREGUARD_ROOT / "patches/fuzevpn/series"
    series = [line.strip() for line in series_path.read_text(encoding="utf-8").splitlines()
              if line.strip()] if series_path.is_file() else []
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
        "wireguard_patch_series": series,
        "wireguard_aar_sha256": aar["sha256"],
        "go_toolchain": aar["nativeBuild"]["go"].split()[2].removeprefix("go"),
        "go_modules": go_sums,
        "release_abis": ["arm64-v8a", "armeabi-v7a"],
    }


def verify_inputs(root: Path, entries: dict[str, dict], versions: dict) -> list[str]:
    mandatory = list(ROOT_FILES + BUILD_POLICY_INPUTS + RELEASE_VALIDATION_INPUTS) + [
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
        f"{WIREGUARD_ROOT}/patches/fuzevpn/series",
        "docs/SOURCE_DISTRIBUTION.md", "tools/package_android_sources.py",
        "tools/tests/test_package_android_sources.py",
    ]
    missing = [f"Missing required input: {name}" for name in mandatory if name not in entries]
    missing.extend(verify_application_inputs(root, entries))
    missing.extend(validation_runner_inputs(root, entries))
    missing.extend(discovered_source_inputs(root, entries))
    missing.extend(kotlin_source_closure(root, entries))
    missing.extend(native_source_closure(root, entries))
    missing.extend(excluded_compiled_sources(root))
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
        raise PackageError("Official Go 1.26.9 source archive identity mismatch")
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
    coverage = "PARTIAL: see missing source inputs below." if missing else (
        "No missing input was detected by the exporter's checks: declared build, validation and\n"
        "native inputs; Dart imports, goldens and files read by Dart tests; Android\n"
        "manifest/resources; Kotlin and CMake/C++ references; repository paths named literally\n"
        "by the validation runner and by the PowerShell and Python scripts and unit-test modules it runs;\n"
        "every file of the directories compiled, analysed or discovered as a whole (Dart sources\n"
        "and tests, Gradle source sets and resources, declared asset directories, directories\n"
        "those scripts name such as include roots, unit-test modules, Get-ChildItem listings);\n"
        "native and source-archive locks. Paths computed\n"
        "from data, parameters or the environment are not followed.\n"
        "These are static checks, not a build of this archive.")
    series = versions.get("wireguard_patch_series") or []
    wireguard_go = versions["go_modules"].get("golang.zx2c4.com/wireguard", {}).get("version", "see go.sum")
    patch_steps = (", then ".join(f"`{name}`" for name in series) if series
                   else "the patches listed in android/third_party/wireguard-android/patches/fuzevpn/series (MISSING)")
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
   its {len(series)} patches in the order of
   android/third_party/wireguard-android/patches/fuzevpn/series: {patch_steps}
   (reviewed copies in patches/wireguard-android/); imported sources already
   contain them. The series pins Go {versions['go_toolchain']} and wireguard-go
   `{wireguard_go}` (FUZEVPN-IMPORT-METADATA.json, nativeRuntime) and adds the Go
   runtime CLOCK_BOOTTIME patch kept in tunnel/tools/libwg-go. Both copies of
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
                          "application_inputs": APPLICATION_INPUTS,
                          "release_validation_inputs": RELEASE_VALIDATION_INPUTS,
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
