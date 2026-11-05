#!/usr/bin/env python3
# SPDX-License-Identifier: MPL-2.0
"""Generate or check lib/widgets/google_sdk_notices.dart (A17-supply-chain-05).

Offline: reads the local Gradle module cache only. Every Google AAR of the
release runtime classpath (android/gradle/dependency-locks/app-patched.lockfile)
that declares third_party_licenses.json/.txt is verified against
android/gradle/verification-metadata.xml, and each notice is reproduced from
the AAR bytes. Components sharing an identical text are grouped. `--check`
fails when the versioned Dart file differs, e.g. after a Google SDK update.
Versioned from the UI/l10n correction of 2026-10-29; output unchanged.
"""
from __future__ import annotations

import argparse
import hashlib
import io
import json
import os
from pathlib import Path
import re
import sys
import xml.etree.ElementTree as ET
import zipfile

LOCK = "android/gradle/dependency-locks/app-patched.lockfile"
VERIFICATION = "android/gradle/verification-metadata.xml"
OUTPUT = "lib/widgets/google_sdk_notices.dart"
GOOGLE_GROUPS = ("com.google.", "com.android.billingclient")


class NoticeError(ValueError):
    pass


def release_google_coordinates(root: Path) -> list[str]:
    coordinates = []
    for line in (root / LOCK).read_text(encoding="utf-8").splitlines():
        coordinate, _, configurations = line.partition("=")
        if coordinate.startswith(GOOGLE_GROUPS) and "releaseRuntimeClasspath" in configurations.split(","):
            coordinates.append(coordinate)
    if not coordinates:
        raise NoticeError("No Google release runtime coordinate in " + LOCK)
    return sorted(coordinates)


def verification(root: Path) -> dict:
    result = {}
    for component in ET.parse(root / VERIFICATION).getroot().iter():
        if component.tag.rsplit("}", 1)[-1] != "component":
            continue
        for artifact in component:
            if artifact.tag.rsplit("}", 1)[-1] != "artifact":
                continue
            for checksum in artifact:
                if checksum.tag.rsplit("}", 1)[-1] == "sha256":
                    key = (component.get("group"), component.get("name"), component.get("version"), artifact.get("name"))
                    result[key] = checksum.get("value")
    return result


def find_artifact(cache: Path, coordinate: str) -> Path | None:
    group, name, version = coordinate.split(":")
    folder = cache / group / name / version
    aars = sorted(folder.glob(f"*/{name}-{version}.aar"))
    if len(aars) > 1:
        raise NoticeError(f"Ambiguous cached AAR for {coordinate}")
    if aars:
        return aars[0]
    if sorted(folder.glob(f"*/{name}-{version}.jar")):
        return None  # A JAR-only module carries no Android third_party_licenses files.
    raise NoticeError(f"Missing cached artifact for {coordinate}; prepare the Gradle cache offline first")


def escaped(chunk: str) -> str:
    """Single-quoted Dart literal with escapes."""
    body = "".join(
        {"\\": "\\\\", "'": "\\'", "$": "\\$", "\n": "\\n", "\t": "\\t"}.get(character)
        or (f"\\x{ord(character):02X}" if ord(character) < 32 else character)
        for character in chunk
    )
    return f"'{body}'"


def dart_literal(text: str) -> str:
    """Adjacent Dart literals that reproduce `text` exactly (raw runs stay readable)."""
    parts: list[str] = []
    run: list[str] = []

    def flush():
        chunk = "".join(run)
        run.clear()
        while chunk:
            first, separator, rest = chunk.partition("\n")
            if separator and not first.strip():
                parts.append(escaped(first + separator))
                chunk = rest
                continue
            break
        if not chunk:
            return
        tail = len(chunk) - len(chunk.rstrip("'"))
        body = chunk[:len(chunk) - tail] if tail else chunk
        if "'''" in body:
            raise NoticeError("A notice contains a raw Dart string terminator")
        if body:
            if "\n" not in body and not body.strip():
                parts.append(escaped(body))
            else:
                parts.append(f"r'''{body}'''")
        if tail:
            parts.append(escaped("'" * tail))

    for character in text:
        if ord(character) < 32 and character not in "\n\t":
            flush()
            parts.append(escaped(character))
        else:
            run.append(character)
    flush()
    parts = parts or ["''"]
    return "\n".join(["    " + parts[0]] + ["        " + part for part in parts[1:]])


def render(root: Path, cache: Path) -> str:
    verified = verification(root)
    texts: dict[str, set[str]] = {}
    provenance = []
    for coordinate in release_google_coordinates(root):
        group, name, version = coordinate.split(":")
        aar = find_artifact(cache, coordinate)
        if aar is None:
            continue
        data = aar.read_bytes()
        digest = hashlib.sha256(data).hexdigest()
        if verified.get((group, name, version, aar.name)) != digest:
            raise NoticeError(f"Unverified AAR for {coordinate}: {digest}")
        with zipfile.ZipFile(io.BytesIO(data)) as archive:
            if "third_party_licenses.json" not in archive.namelist():
                continue
            index = json.loads(archive.read("third_party_licenses.json"))
            notices = archive.read("third_party_licenses.txt")
        provenance.append(f"//   {coordinate}\n"
                          f"//     aar sha256 {digest} (verification-metadata.xml)\n"
                          f"//     third_party_licenses.txt sha256 {hashlib.sha256(notices).hexdigest()}")
        for component, span in index.items():
            start, length = span["start"], span["length"]
            if not (isinstance(start, int) and isinstance(length, int) and 0 <= start and start + length <= len(notices)):
                raise NoticeError(f"Invalid notice span for {component} in {coordinate}")
            texts.setdefault(notices[start:start + length].decode("utf-8"), set()).add(component)
    if not texts:
        raise NoticeError("No Google SDK notice found")
    entries = sorted(texts.items(), key=lambda item: (sorted(item[1], key=str.lower),
                                                      hashlib.sha256(item[0].encode()).hexdigest()))
    lines = [
        "// GENERATED FILE - DO NOT EDIT.",
        "// Third-party notices declared by the Google Android SDK AARs of the release",
        "// runtime classpath (third_party_licenses.json/.txt). Android packaging drops",
        "// these files, so the application license page reproduces them verbatim.",
        "// Generator: tools/generate_google_sdk_notices.py; rerun it whenever a",
        "// Google SDK version changes.",
        "//",
        "// Source AARs (local Gradle cache, checked against",
        "// android/gradle/verification-metadata.xml):",
        *provenance,
        "",
        "/// One distinct notice text and every SDK component that declares it.",
        "final class GoogleSdkNotice {",
        "  const GoogleSdkNotice(this.packages, this.sha256, this.text);",
        "",
        "  final List<String> packages;",
        "",
        "  /// SHA-256 of the UTF-8 text as stored in the AAR.",
        "  final String sha256;",
        "  final String text;",
        "}",
        "",
        "const List<GoogleSdkNotice> googleSdkNotices = <GoogleSdkNotice>[",
    ]
    for text, components in entries:
        names = ", ".join(escaped(component) for component in sorted(components, key=str.lower))
        lines.append("  GoogleSdkNotice(")
        if len(names) <= 64:
            lines.append(f"    <String>[{names}],")
        else:
            lines.append("    <String>[")
            lines.extend(f"      {escaped(component)}," for component in sorted(components, key=str.lower))
            lines.append("    ],")
        lines.append(f"    '{hashlib.sha256(text.encode('utf-8')).hexdigest()}',")
        lines.append(dart_literal(text) + ",")
        lines.append("  ),")
    lines.append("];")
    return "\n".join(lines) + "\n"


def default_cache(root: Path) -> Path:
    home = os.environ.get("GRADLE_USER_HOME") or str(root / ".gradle")
    return Path(home) / "caches/modules-2/files-2.1"


def main(argv: list[str] | None = None) -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--root", type=Path, default=Path(__file__).resolve().parents[1])
    parser.add_argument("--module-cache", type=Path, help="Gradle modules-2/files-2.1 directory (default: GRADLE_USER_HOME or .gradle)")
    parser.add_argument("--output", type=Path, help="Dart file to write or check (default: " + OUTPUT + ")")
    parser.add_argument("--check", action="store_true", help="Fail if the versioned file differs; write nothing")
    args = parser.parse_args(argv)
    root = args.root.resolve()
    output = args.output or root / OUTPUT
    try:
        content = render(root, args.module_cache or default_cache(root)).encode("utf-8")
        if args.check:
            if not output.is_file() or output.read_bytes() != content:
                print(f"Google SDK notices are stale: run tools/generate_google_sdk_notices.py ({output.name})", file=sys.stderr)
                return 1
        else:
            output.parent.mkdir(parents=True, exist_ok=True)
            output.write_bytes(content)
    except (OSError, ValueError, KeyError, zipfile.BadZipFile, ET.ParseError) as error:
        print(f"Google SDK notice generation failed: {error}", file=sys.stderr)
        return 1
    print(f"Google SDK notices {'match' if args.check else 'written'}: {output.name}, {len(content)} bytes")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
