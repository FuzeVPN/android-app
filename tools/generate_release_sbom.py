#!/usr/bin/env python3
# SPDX-License-Identifier: MPL-2.0
"""Offline SPDX inventory of release resolution and observed archive contents.

The source-input snapshot and an optional inspected AAB are separate subjects.
Lockfile selection is never promoted to proof of retention after R8. Go runtime
and module composition is read from the ELF Go build-info record, not strings.
Only Python's standard library is required. No artifact is executed/extracted.
"""
from __future__ import annotations

import argparse
from datetime import datetime
import hashlib
import json
from pathlib import Path, PurePosixPath
import re
import sys
from urllib.parse import quote
import xml.etree.ElementTree as ET
import zipfile

TOOL = "FuzeVPN generate_release_sbom.py/1"
LOCK = "android/gradle/dependency-locks/app-patched.lockfile"
AAR_METADATA = "android/third_party/wireguard-android/dist/tunnel-1.0.20260102-fuzevpn-fgs.metadata.json"
GO_MOD = "android/third_party/wireguard-android/tunnel/tools/libwg-go/go.mod"
RELEASE_CONFIGS = {"releaseCompileClasspath", "releaseRuntimeClasspath"}
NATIVE_DEPENDENCIES = "android/app/src/main/cpp/third_party/deps/DEPENDENCIES-METADATA.json"
VERIFICATION = "android/gradle/verification-metadata.xml"
# The submodule pins of the reviewed WireGuard import (libwg.so/libwg-quick.so).
WIREGUARD_IMPORT = "tools/import_wireguard_android.ps1"
WIREGUARD_TOOLS_LICENSE = "GPL-2.0-only"
# The only AABs that may still ship the AAR's wireguard-tools executables: those
# inspected before A17-supply-chain-05 excluded them (docs/SBOM.release.md).
PRE_EXCLUSION_AABS = frozenset({
    "f39d06bb0699f5f08f03726bbaf20e3bd6ec8185a5eae2f1e5cf9926322b1651",  # historical 0.2.10+74016
    "f6ca8698ad34420c03ea2923e9aaee4d7aef1f45efaa14303c15e6ca4c58953d",  # worktree build of 19/10
    "7b19aff4443c689cf657b64659690b09552f7a3e8148106e0a1cd607919136c5",  # worktree build of 28/10
})
SPDX_LICENSE_ID = re.compile(r"[A-Za-z0-9.+-]+")
DART_VERSION = re.compile(rb"(?<![0-9.])([0-9]+\.[0-9]+\.[0-9]+(?:-[0-9A-Za-z.]+)?) \((?:stable|beta|dev|main)\) \(")


def flutter_engine_components(text: str) -> list[dict]:
    """Release engine artifacts pinned by Gradle dependency verification.

    io.flutter:* is excluded from the dependency locks (android/build.gradle.kts);
    verification-metadata.xml is the reviewed record of their exact versions.
    """
    components = []
    for element in ET.fromstring(text).iter():
        if (element.tag.rsplit("}", 1)[-1] == "component" and element.get("group") == "io.flutter"
                and element.get("name", "").endswith("_release")):
            version = element.get("version", "")
            if not re.fullmatch(r"1\.0\.0-[0-9a-f]{40}", version):
                raise ValueError("Unrecognized Flutter engine artifact version in verification metadata")
            artifacts = [{"name": artifact.get("name"), "sha256": checksum.get("value")}
                for artifact in element if artifact.tag.rsplit("}", 1)[-1] == "artifact"
                for checksum in artifact if checksum.tag.rsplit("}", 1)[-1] == "sha256"]
            components.append({"name": element.get("name"), "version": version,
                "engineRevision": version.split("-", 1)[1], "artifacts": artifacts})
    if not components:
        raise ValueError("No pinned Flutter engine release artifact in dependency verification metadata")
    return sorted(components, key=lambda item: item["name"])


def source_purl(url: str, name: str, version: str) -> str:
    match = re.fullmatch(r"https://github\.com/([\w.-]+)/([\w.-]+?)(?:\.git)?", url or "")
    if match:
        return f"pkg:github/{quote(match[1].lower())}/{quote(match[2].lower())}@{quote(version, safe='')}"
    return f"pkg:generic/{quote(name)}@{quote(version, safe='')}"


def digest(data: bytes, algorithm: str = "sha256") -> str:
    return hashlib.new(algorithm, data).hexdigest()


def canonical(value: object) -> str:
    return json.dumps(value, ensure_ascii=False, sort_keys=True, separators=(",", ":"))


def identifier(kind: str, value: str) -> str:
    return f"SPDXRef-{kind}-{digest(value.encode())[:24]}"


def parse_gradle_lock(text: str) -> list[dict]:
    """Keep exact per-configuration versions, including compile/runtime splits."""
    selected = {}
    seen = {}
    for number, line in enumerate(text.splitlines(), 1):
        if not line or line.startswith("#") or line.startswith("empty="):
            continue
        coordinate, sep, raw_configs = line.partition("=")
        parts = coordinate.split(":")
        if not sep or len(parts) != 3 or not all(parts):
            raise ValueError(f"Malformed Gradle lock entry at line {number}")
        configs = sorted(RELEASE_CONFIGS.intersection(raw_configs.split(",")))
        if not configs:
            continue
        group, artifact, version = parts
        for config in configs:
            key = (group, artifact, config)
            if key in seen and seen[key] != version:
                raise ValueError(f"Conflicting versions for {group}:{artifact} in {config}")
            seen[key] = version
        item = selected.setdefault(coordinate, {"coordinate": coordinate,
            "group": group, "artifact": artifact, "version": version, "configurations": []})
        item["configurations"] = sorted(set(item["configurations"]) | set(configs))
    if not any("releaseRuntimeClasspath" in p["configurations"] for p in selected.values()):
        raise ValueError("No releaseRuntimeClasspath entries in selected lockfile")
    return [selected[key] for key in sorted(selected)]


def parse_pub_lock(text: str) -> list[dict]:
    """Read Pub's generated lock format; retain dev/non-Android scope explicitly."""
    packages = []
    current = None
    in_packages = False
    for line in text.splitlines():
        if line == "packages:":
            in_packages = True
            continue
        if in_packages and line and not line.startswith((" ", "#")):
            break
        match = re.fullmatch(r"  ([A-Za-z0-9_]+):", line) if in_packages else None
        if match:
            current = {"name": match[1]}
            packages.append(current)
            continue
        if current is not None:
            field = re.fullmatch(r"    (dependency|source|version): (.+)", line)
            checksum = re.fullmatch(r"      sha256: [\"']?([a-f0-9]{64})[\"']?", line)
            if field:
                current[field[1]] = field[2].strip("\"'")
            elif checksum:
                current["sha256"] = checksum[1]
    if not packages or any(not {"version", "source", "dependency"} <= p.keys() for p in packages):
        raise ValueError("Unrecognized or incomplete Pub lockfile")
    return sorted(packages, key=lambda p: p["name"])


def _uvarint(data: bytes, offset: int) -> tuple[int, int]:
    value = 0
    for shift in range(0, 70, 7):
        if offset >= len(data):
            raise ValueError("Truncated Go build-info varint")
        byte = data[offset]
        offset += 1
        value |= (byte & 127) << shift
        if byte < 128:
            return value, offset
    raise ValueError("Invalid Go build-info varint")


def _go_string(data: bytes, offset: int) -> tuple[str, int]:
    length, offset = _uvarint(data, offset)
    end = offset + length
    if end > len(data):
        raise ValueError("Truncated Go build-info string")
    return data[offset:end].decode("utf-8"), end


def go_build_info(data: bytes) -> dict | None:
    """Decode the pointer-free Go >=1.18 ELF record, including static runtime."""
    magic = b"\xff Go buildinf:"
    if not data.startswith(b"\x7fELF"):
        return None
    offset = data.find(magic)
    if offset < 0:
        return None
    if offset % 16 or offset + 32 > len(data) or data[offset + 14] not in (4, 8):
        raise ValueError("Invalid Go ELF build-info header")
    if not data[offset + 15] & 2:
        raise ValueError("Pointer-based Go build-info is unsupported; no version guessed")
    version, cursor = _go_string(data, offset + 32)
    # Module data has binary framing, unlike the UTF-8 Go version string.
    length, cursor = _uvarint(data, cursor)
    framed = data[cursor:cursor + length]
    if len(framed) != length or len(framed) < 33 or framed[-17:-16] != b"\n":
        raise ValueError("Invalid Go module-info framing")
    module_text = framed[16:-16].decode("utf-8")
    if not re.fullmatch(r"go[0-9]+\.[0-9]+(?:\.[0-9]+)?(?:[a-z0-9.-]+)?", version):
        raise ValueError("Invalid Go version in ELF build-info")
    result = {"goVersion": version, "modules": [], "settings": {}}
    for line in module_text.splitlines():
        fields = line.split("\t")
        if fields[0] == "path" and len(fields) == 2:
            result["path"] = fields[1]
        elif fields[0] in {"mod", "dep"} and len(fields) >= 3:
            result["modules"].append({"path": fields[1], "version": fields[2],
                "kind": fields[0], "goSum": fields[3] if len(fields) > 3 else None})
        elif fields[0] == "=>":
            # A replacement requires provenance beyond the original module's purl.
            raise ValueError("Go replacement module needs explicit attribution")
        elif fields[0] == "build" and len(fields) == 2 and "=" in fields[1]:
            key, value = fields[1].split("=", 1)
            # Do not export arbitrary linker flags or build-machine paths.
            if key in {"GOOS", "GOARCH", "GOARM", "GOARM64", "GOAMD64", "CGO_ENABLED",
                       "-buildmode", "-compiler", "-trimpath"}:
                result["settings"][key] = value
    if not result.get("path"):
        raise ValueError("Go build-info has no module path")
    return result


class Inventory:
    def __init__(self, created: str):
        self.created = created
        self.packages = {}
        self.files = {}
        self.relationships = []

    def annotation(self, value: dict) -> list[dict]:
        return [{"annotationDate": self.created, "annotationType": "OTHER",
            "annotator": f"Tool: {TOOL}", "comment": canonical(value)}]

    def package(self, kind: str, key: str, name: str, version: str | None = None,
                purl: str | None = None, evidence: dict | None = None) -> str:
        ref = identifier(kind, key)
        if ref not in self.packages:
            package = {"SPDXID": ref, "name": name, "downloadLocation": "NOASSERTION",
                "filesAnalyzed": False, "licenseConcluded": "NOASSERTION",
                "licenseDeclared": "NOASSERTION", "copyrightText": "NOASSERTION"}
            if version is not None:
                package["versionInfo"] = version
            if purl:
                package["externalRefs"] = [{"referenceCategory": "PACKAGE-MANAGER",
                    "referenceType": "purl", "referenceLocator": purl}]
            if evidence is not None:
                package["annotations"] = self.annotation(evidence)
            self.packages[ref] = package
        return ref

    def link(self, source: str, relation: str, target: str, comment: str | None = None):
        item = {"spdxElementId": source, "relationshipType": relation, "relatedSpdxElement": target}
        if comment:
            item["comment"] = comment
        if item not in self.relationships:
            self.relationships.append(item)

    def archive(self, data: bytes, label: str, origin: str, kind: str,
                engine_revisions: tuple[str, ...] = ()) -> tuple[str, list[dict]]:
        import io
        archive_hash = digest(data)
        ref = self.package("Archive", archive_hash, label, evidence={"scope": kind,
            "origin": origin, "sha256": archive_hash,
            "componentAttribution": "Entry hashes prove bytes, not all internal component versions"})
        package = self.packages[ref]
        package["checksums"] = [{"algorithm": "SHA256", "checksumValue": archive_hash}]
        package["primaryPackagePurpose"] = "APPLICATION" if kind.startswith("observed-") and kind.endswith("-aab") else "LIBRARY"
        entries = []
        sha1s = []
        with zipfile.ZipFile(io.BytesIO(data)) as archive:
            names = [entry.filename for entry in archive.infolist() if not entry.is_dir()]
            if len(names) != len(set(names)):
                raise ValueError("Ambiguous duplicate ZIP entry")
            if sum(entry.file_size for entry in archive.infolist()) > 1024 ** 3:
                raise ValueError("Archive exceeds 1 GiB uncompressed inventory limit")
            for name in sorted(names):
                if PurePosixPath(name).is_absolute() or ".." in PurePosixPath(name).parts:
                    raise ValueError("Invalid archive entry path")
                payload = archive.read(name)
                sha1 = digest(payload, "sha1")
                sha1s.append(sha1)
                file_ref = identifier("File", archive_hash + "!/" + name)
                self.files[file_ref] = {"SPDXID": file_ref, "fileName": name,
                    "checksums": [{"algorithm": "SHA256", "checksumValue": digest(payload)},
                        {"algorithm": "SHA1", "checksumValue": sha1}],
                    "licenseConcluded": "NOASSERTION", "licenseInfoInFiles": ["NOASSERTION"],
                    "copyrightText": "NOASSERTION"}
                self.link(ref, "CONTAINS", file_ref)
                entry = {"path": name, "sha256": digest(payload), "id": file_ref}
                if PurePosixPath(name).name == "libflutter.so":
                    # Read from the engine binary itself; never inferred from .flutter-version.
                    versions = sorted({match.decode() for match in DART_VERSION.findall(payload)})
                    entry["flutterEngine"] = {"dartVersions": versions,
                        "engineRevisions": sorted(r for r in engine_revisions if r.encode() in payload)}
                if name.endswith(".so"):
                    info = go_build_info(payload)
                    if info:
                        entry["goBuildInfo"] = info
                        self.files[file_ref]["annotations"] = self.annotation({"goBuildInfo": info,
                            "method": "ELF pointer-free Go build-info record"})
                        runtime = info["goVersion"].removeprefix("go")
                        runtime_id = self.package("GoRuntime", runtime, "Go runtime and standard library",
                            runtime, f"pkg:golang/stdlib@{runtime}",
                            {"scope": "statically-linked-runtime", "evidence": "Go ELF build-info; per-package symbol reachability not asserted"})
                        self.link(file_ref, "STATIC_LINK", runtime_id)
                        for module in info["modules"]:
                            module_id = self.package("GoModule", module["path"] + "@" + module["version"],
                                module["path"], module["version"],
                                "pkg:golang/" + quote(module["path"], safe="/") + "@" + quote(module["version"], safe=""),
                                {"scope": "Go-linked-module-record", "goSum": module["goSum"],
                                 "limitation": "Module record does not establish every package or vulnerable symbol is linked"})
                            self.link(file_ref, "STATIC_LINK", module_id)
                entries.append(entry)
        package["filesAnalyzed"] = True
        package["packageVerificationCode"] = {"packageVerificationCodeValue": digest("".join(sorted(sha1s)).encode(), "sha1")}
        return ref, entries


def generate(root: Path, *, created: str, lock: str = LOCK, aab: Path | None = None,
             binary_label: str | None = None, binary_origin: str | None = None,
             binary_sha256: str | None = None, binary_scope: str = "historical") -> dict:
    if not re.fullmatch(r"[0-9]{4}-[0-9]{2}-[0-9]{2}T[0-9]{2}:[0-9]{2}:[0-9]{2}Z", created):
        raise ValueError("--created must be an explicit UTC SPDX timestamp")
    datetime.strptime(created, "%Y-%m-%dT%H:%M:%SZ")
    if aab and not binary_label:
        raise ValueError("An inspected binary requires an explicit --binary-label (for example historical-74016)")
    if aab and not re.fullmatch(r"[a-f0-9]{64}", binary_sha256 or ""):
        raise ValueError("An inspected binary requires an explicit --binary-sha256 to prevent relabelling a later build")
    if binary_scope not in {"historical", "unsigned-worktree"}:
        raise ValueError("Unsupported binary scope; no source build or distribution attestation inferred")
    inputs = {}

    def read(path: str) -> bytes:
        target = root / path
        payload = target.read_bytes()
        inputs[path] = payload
        return payload

    locked = parse_gradle_lock(read(lock).decode("utf-8-sig"))
    pub = parse_pub_lock(read("pubspec.lock").decode("utf-8-sig"))
    pubspec = read("pubspec.yaml").decode("utf-8-sig")
    version_match = re.search(r"(?m)^version:\s*(\S+)\s*$", pubspec)
    if not version_match:
        raise ValueError("No application version in pubspec.yaml")
    version = version_match[1]
    flutter_version = read(".flutter-version").decode().strip()
    metadata = json.loads(read(AAR_METADATA).decode("utf-8-sig"))
    go_source_dir = GO_MOD.rsplit("/", 1)[0]
    source_hashes = metadata["nativeBuild"]["sourceHashes"]
    if not {"go.mod", "go.sum"} <= source_hashes.keys():
        raise ValueError("AAR provenance must identify its Go module lock inputs")
    for source_name, expected_hash in sorted(source_hashes.items()):
        if digest(read(go_source_dir + "/" + source_name)) != expected_hash:
            raise ValueError("Current Go source input differs from AAR provenance: " + source_name)
    # Native source/ABI provenance is an input, not evidence of an AAB rebuild.
    native_metadata = json.loads(read("android/native-provenance/import-metadata.json").decode("utf-8-sig"))
    native_dependencies = json.loads(read(NATIVE_DEPENDENCIES).decode("utf-8-sig"))
    read("android/app/src/main/cpp/third_party/openssl/IMPORT-METADATA.json")
    engine = flutter_engine_components(read(VERIFICATION).decode("utf-8-sig"))
    submodules = dict(re.findall(r"'tunnel/tools/([\w-]+)'\s*=\s*'([0-9a-f]{40})'", read(WIREGUARD_IMPORT).decode("utf-8-sig")))
    if "wireguard-tools" not in submodules:
        raise ValueError("The wireguard-tools submodule pin is missing from " + WIREGUARD_IMPORT)
    source_bom = json.loads(read("docs/SBOM.spdx.json").decode("utf-8-sig"))
    aar_path = str(PurePosixPath(AAR_METADATA).parent / metadata["artifact"])
    aar = read(aar_path)
    if digest(aar) != metadata["sha256"]:
        raise ValueError("Current WireGuard AAR differs from its metadata SHA-256")

    inventory = Inventory(created)
    engine_revisions = tuple(sorted({component["engineRevision"] for component in engine}))
    aar_id, aar_entries = inventory.archive(aar, metadata["artifact"], aar_path, "current-source-build-input-aar",
                                            engine_revisions)
    declared_go = re.search(r"\bgo(\d+\.\d+(?:\.\d+)?)\b", metadata["nativeBuild"]["go"])
    if not declared_go:
        raise ValueError("Unrecognized Go compiler version in AAR provenance")
    expected_abis = {"jni/" + p["file"]: p["sha256"] for p in metadata["nativeBuild"]["abi"]}
    declared_module = metadata["nativeBuild"]["module"].split()
    if len(declared_module) != 2:
        raise ValueError("Unrecognized WireGuard module provenance")
    for entry in aar_entries:
        if entry["path"] in expected_abis:
            if entry["sha256"] != expected_abis.pop(entry["path"]):
                raise ValueError("WireGuard ABI differs from recorded SHA-256")
            if entry.get("goBuildInfo", {}).get("goVersion") != "go" + declared_go[1]:
                raise ValueError("Embedded Go runtime differs from recorded compiler version")
            if not any(m["path"] == declared_module[0] and m["version"] == declared_module[1]
                       for m in entry["goBuildInfo"]["modules"]):
                raise ValueError("Embedded WireGuard module differs from AAR provenance")
    if expected_abis:
        raise ValueError("WireGuard AAR is missing an ABI recorded in its provenance")

    input_fingerprints = [{"path": path, "sha256": digest(payload)} for path, payload in sorted(inputs.items())]
    input_id = digest(canonical(input_fingerprints).encode())
    source_id = inventory.package("SourceInputs", input_id, "FuzeVPN Android release source-input snapshot", version,
        evidence={"scope": "source-input-snapshot-no-produced-binary", "inputDigest": input_id,
            "inputs": input_fingerprints, "variant": "release classpaths from " + lock,
            "limitation": "Dependency/provenance inputs only, not a fingerprint of the entire source tree"})
    inventory.link(aar_id, "BUILD_DEPENDENCY_OF", source_id)
    compiler_id = inventory.package("GoCompiler", declared_go[1], "Go compiler used for current WireGuard AAR",
        declared_go[1], evidence={"scope": "recorded-build-tool", "source": AAR_METADATA,
            "runtimeRepresentedSeparately": True})
    inventory.link(compiler_id, "BUILD_DEPENDENCY_OF", source_id)
    flutter_id = inventory.package("FlutterInput", flutter_version, "Flutter SDK selected source input",
        flutter_version, evidence={"scope": "source-build-input", "binaryEngineInternals": "not inferred from source version"})
    inventory.link(flutter_id, "BUILD_DEPENDENCY_OF", source_id)
    for key in ("openvpn3", "openssl"):
        item = native_metadata[key]
        pin = item.get("version", item.get("commit"))
        ref = inventory.package("NativeInput", key + "@" + str(pin), key, pin,
            evidence={"scope": "native-source-build-input", "metadata": item,
                "binaryPresence": "internal version not established for inspected AAB by this source record"})
        inventory.link(ref, "BUILD_DEPENDENCY_OF", source_id)

    def declare(ref: str, license_id: str | None, location: str | None) -> None:
        # Upstream declarations recorded in reviewed metadata; never a license conclusion.
        if isinstance(license_id, str) and SPDX_LICENSE_ID.fullmatch(license_id):
            inventory.packages[ref]["licenseDeclared"] = license_id
        if location:
            inventory.packages[ref]["downloadLocation"] = location

    # A17-supply-chain-04: Asio, fmt and lz4 are compiled into libfuzevpn_openvpn.so.
    native_sources = native_dependencies.get("sources")
    if not isinstance(native_sources, list) or not native_sources:
        raise ValueError("Native dependency metadata lists no source component")
    native_components = []
    for item in native_sources:
        name, reference, commit = item.get("name"), item.get("ref"), item.get("commit")
        if not all(isinstance(value, str) and value for value in (name, reference)) or not re.fullmatch(r"[0-9a-f]{40}", commit or ""):
            raise ValueError("Native dependency metadata needs a name, a reference and a full commit")
        evidence = {"scope": "native-source-build-input", "metadata": item, "source": NATIVE_DEPENDENCIES,
            "linkage": "compiled into libfuzevpn_openvpn.so with OpenVPN 3 Core",
            "binaryPresence": "declared by the native build provenance; internal version not read from an inspected binary"}
        if item.get("openvpnPatchDirectory"):
            evidence["patches"] = native_dependencies.get("asioPatches", [])
        ref = inventory.package("NativeInput", f"{name}@{commit}", name, reference,
            source_purl(item.get("url", ""), name, commit), evidence)
        declare(ref, item.get("license"), f"git+{item['url']}@{commit}" if item.get("url") else None)
        inventory.link(ref, "BUILD_DEPENDENCY_OF", source_id)
        native_components.append(name)
    # libwg.so and libwg-quick.so are upstream wireguard-tools binaries kept in the AAR.
    tools_commit = submodules["wireguard-tools"]
    tool_entries = [entry for entry in aar_entries if PurePosixPath(entry["path"]).name in {"libwg.so", "libwg-quick.so"}]
    tools_id = inventory.package("NativeComponent", "wireguard-tools@" + tools_commit, "wireguard-tools", tools_commit,
        "pkg:generic/wireguard-tools@" + tools_commit,
        {"scope": "prebuilt-native-component-of-the-wireguard-aar", "source": WIREGUARD_IMPORT,
         "files": [entry["path"] for entry in tool_entries],
         "licenseNote": "GPL-2.0-only; many files GPL-2.0-only OR MIT; netlink LGPL-2.1-or-later",
         "provenance": "carried unchanged from the official WireGuard Android AAR of the pinned tag and submodule"})
    declare(tools_id, WIREGUARD_TOOLS_LICENSE, "git+https://git.zx2c4.com/wireguard-tools@" + tools_commit)
    inventory.link(aar_id, "DEPENDS_ON", tools_id, "libwg.so/libwg-quick.so")
    for entry in tool_entries:
        inventory.link(entry["id"], "GENERATED_FROM", tools_id, "Upstream prebuilt binary carried in the approved AAR")
    # The Flutter engine (io.flutter:*) is outside the Gradle locks; dependency verification pins it.
    engine_ids = {}
    for component in engine:
        ref = inventory.package("FlutterEngine", component["name"] + "@" + component["version"],
            "io.flutter:" + component["name"], component["version"],
            f"pkg:maven/io.flutter/{component['name']}@{component['version']}",
            {"scope": "flutter-engine-release-build-input", "source": VERIFICATION,
             "engineRevision": component["engineRevision"], "artifacts": component["artifacts"],
             "lockfile": "io.flutter:* is excluded from the Gradle dependency locks (android/build.gradle.kts)",
             "binaryPresence": "established only by an inspected bundle (libflutter.so)"})
        inventory.link(ref, "BUILD_DEPENDENCY_OF", source_id)
        engine_ids[component["name"], component["engineRevision"]] = ref
    runtime_purls = []
    for item in locked:
        purl = f"pkg:maven/{item['group']}/{item['artifact']}@{item['version']}"
        ref = inventory.package("Maven", item["coordinate"], item["group"] + ":" + item["artifact"],
            item["version"], purl, {"scope": "gradle-locked-resolution", "lockfile": lock,
                "configurations": item["configurations"], "binaryPresenceAfterR8": "not-established"})
        if "releaseRuntimeClasspath" in item["configurations"]:
            runtime_purls.append(purl)
            inventory.link(source_id, "DEPENDS_ON", ref, "Selected releaseRuntimeClasspath; not proof of R8 retention")
        if "releaseCompileClasspath" in item["configurations"]:
            inventory.link(ref, "BUILD_DEPENDENCY_OF", source_id, "Selected releaseCompileClasspath")
    for item in pub:
        ref = inventory.package("Pub", item["name"] + "@" + item["version"], item["name"], item["version"],
            "pkg:pub/" + item["name"] + "@" + item["version"],
            {"scope": "pub-lock-including-development-and-nonandroid", "declaredRole": item["dependency"],
                "source": item["source"], "archiveSha256": item.get("sha256"), "binaryPresence": "not-established"})
        inventory.link(ref, "BUILD_DEPENDENCY_OF", source_id, "Pub resolution input; release reachability not inferred")
    old_purls = {ref["referenceLocator"] for p in source_bom["packages"] for ref in p.get("externalRefs", [])
        if ref.get("referenceType") == "purl"}
    old_maven_modules = {purl.rsplit("@", 1)[0] for purl in old_purls if purl.startswith("pkg:maven/")}
    coverage = {"releaseRuntimeCoordinates": len(runtime_purls),
        "nativeComponents": ["openvpn3", "openssl"] + native_components + ["wireguard-tools"],
        "flutterEngineArtifacts": [component["name"] + "@" + component["version"] for component in engine],
        "exactRuntimePurlsMissingFromLimitedSourceSbom": sorted(set(runtime_purls) - old_purls),
        "modulesAbsentFromLimitedSourceSbom": sorted(purl for purl in runtime_purls
            if purl.rsplit("@", 1)[0] not in old_maven_modules),
        "modulesWithDifferentVersionInLimitedSourceSbom": sorted(purl for purl in runtime_purls
            if purl not in old_purls and purl.rsplit("@", 1)[0] in old_maven_modules),
        "newInventoryCoversEveryRuntimeCoordinate": True,
        "retainedJavaComponentsAfterR8": "not-established; lock and bundle dependency metadata are not code retention proofs"}
    described = [source_id]
    observed = None
    if aab is not None:
        binary = aab.read_bytes()
        if digest(binary) != binary_sha256:
            raise ValueError("Inspected AAB differs from expected SHA-256; binary label was not applied")
        origin = binary_origin or aab.name
        archive_scope = "observed-historical-aab" if binary_scope == "historical" else "observed-unsigned-worktree-aab"
        binary_id, binary_entries = inventory.archive(binary, binary_label, origin, archive_scope, engine_revisions)
        described.append(binary_id)
        approved_tools = {PurePosixPath(entry["path"]).parent.name + "/" + PurePosixPath(entry["path"]).name: entry["sha256"]
            for entry in tool_entries}
        flutter_libraries, observed_tools, openvpn_libraries = [], [], []
        for entry in binary_entries:
            path = PurePosixPath(entry["path"])
            abi = path.parent.name
            if "flutterEngine" in entry:
                info = entry["flutterEngine"]
                for dart_version in info["dartVersions"]:
                    dart_id = inventory.package("DartRuntime", dart_version, "Dart SDK runtime", dart_version,
                        "pkg:github/dart-lang/sdk@" + quote(dart_version, safe=""),
                        {"scope": "observed-in-libflutter.so", "evidence": "Dart version banner read from the engine binary"})
                    inventory.link(entry["id"], "STATIC_LINK", dart_id)
                for revision in info["engineRevisions"]:
                    engine_id = engine_ids.get((abi.replace("-", "_") + "_release", revision))
                    if engine_id:
                        inventory.link(entry["id"], "GENERATED_FROM", engine_id,
                            "Pinned engine revision found in this libflutter.so")
                flutter_libraries.append({"path": entry["path"], "sha256": entry["sha256"], **info})
            elif path.name in {"libwg.so", "libwg-quick.so"}:
                identical = approved_tools.get(abi + "/" + path.name) == entry["sha256"]
                if identical:
                    inventory.link(entry["id"], "GENERATED_FROM", tools_id, "Byte-identical to the approved AAR entry")
                observed_tools.append({"path": entry["path"], "sha256": entry["sha256"],
                    "identicalToApprovedAar": identical, "declaredLicense": WIREGUARD_TOOLS_LICENSE})
            elif path.name == "libfuzevpn_openvpn.so":
                openvpn_libraries.append({"path": entry["path"], "sha256": entry["sha256"],
                    "declaredStaticComponents": ["openvpn3", "openssl"] + native_components,
                    "attribution": "declared by the current native build provenance; not read from this binary"})
        if observed_tools and binary_sha256 not in PRE_EXCLUSION_AABS:
            # A17-supply-chain-05: android/app/build.gradle.kts excludes them from every APK and AAB.
            raise ValueError("Inspected AAB still ships wireguard-tools executables excluded by "
                             "android/app/build.gradle.kts: " + ", ".join(item["path"] for item in observed_tools))
        observed = {"label": binary_label, "origin": origin, "scope": binary_scope, "sha256": digest(binary),
            "entryCount": len(binary_entries),
            "goLibraries": [{"path": e["path"], "sha256": e["sha256"], "buildInfo": e["goBuildInfo"]}
                for e in binary_entries if "goBuildInfo" in e],
            "flutterLibraries": flutter_libraries, "wireguardToolsLibraries": observed_tools,
            "openVpnLibraries": openvpn_libraries,
            "associationToSourceInputs": "not-attested; inspected binary and current source inputs remain separate subjects"}
        if not observed["goLibraries"]:
            raise ValueError("Inspected AAB has no verifiable Go build-info; no runtime version guessed")
    for path, payload in inputs.items():
        if (root / path).read_bytes() != payload:
            raise ValueError(f"Input changed during generation: {path}; retry with stable inputs")
    generator_hash = digest(Path(__file__).read_bytes())
    document_digest = digest(canonical({"inputs": input_fingerprints, "binary": observed,
        "created": created, "generatorSha256": generator_hash}).encode())
    for subject in described:
        inventory.link("SPDXRef-DOCUMENT", "DESCRIBES", subject)
    return {"spdxVersion": "SPDX-2.3", "dataLicense": "CC0-1.0", "SPDXID": "SPDXRef-DOCUMENT",
        "name": "FuzeVPN-Android-release-resolution-and-observed-content",
        "documentNamespace": "https://fuzevpn.com/sbom/release/" + document_digest,
        "creationInfo": {"created": created, "creators": [f"Tool: {TOOL}"],
            "comment": "Separate source-input resolution and optional explicitly scoped archive observation. No source-to-binary equivalence, delivery, R8 reachability, complete Flutter internals, vulnerability or license conclusion is asserted."},
        "documentDescribes": described,
        "annotations": inventory.annotation({"scope": "release-resolution-and-observed-archive-content",
            "generatorSha256": generator_hash, "coverage": coverage, "observedBinary": observed}),
        "packages": sorted(inventory.packages.values(), key=lambda p: p["SPDXID"]),
        "files": sorted(inventory.files.values(), key=lambda p: p["SPDXID"]),
        "relationships": sorted(inventory.relationships, key=canonical)}


def main(argv: list[str] | None = None) -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--root", type=Path, default=Path(__file__).resolve().parents[1])
    parser.add_argument("--lock", default=LOCK)
    parser.add_argument("--created", required=True, help="Explicit UTC timestamp; no wall-clock nondeterminism")
    parser.add_argument("--aab", type=Path)
    parser.add_argument("--binary-label")
    parser.add_argument("--binary-sha256", help="Expected inspected archive fingerprint; mandatory with --aab")
    parser.add_argument("--binary-scope", choices=["historical", "unsigned-worktree"], default="historical",
        help="Historical archive or unsigned local worktree build; neither asserts source-to-binary equivalence")
    parser.add_argument("--binary-origin", help="Public provenance locator, not a private absolute workstation path")
    parser.add_argument("--output", type=Path, required=True)
    args = parser.parse_args(argv)
    try:
        result = generate(args.root.resolve(), created=args.created, lock=args.lock,
            aab=args.aab, binary_label=args.binary_label, binary_origin=args.binary_origin,
            binary_sha256=args.binary_sha256, binary_scope=args.binary_scope)
        encoded = json.dumps(result, ensure_ascii=False, indent=2, sort_keys=True) + "\n"
        args.output.parent.mkdir(parents=True, exist_ok=True)
        args.output.write_text(encoded, encoding="utf-8", newline="\n")
    except (ValueError, OSError, KeyError, zipfile.BadZipFile) as error:
        print(f"SBOM generation failed: {error}", file=sys.stderr)
        return 1
    print(f"Wrote {args.output.name}: {len(result['packages'])} packages, {len(result['files'])} observed archive entries")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
