# SPDX-License-Identifier: Apache-2.0
"""A17-supply-chain-03: notices and source-distribution texts describe the pinned engine.

Every value is read from the repository's pinned records (WireGuardAarPolicy,
AAR metadata, go.mod/go.sum, the patch series), never copied into this test,
so a later engine update fails here until the documents follow it.
"""
import importlib.util
import json
from pathlib import Path
import re
import unittest

ROOT = Path(__file__).resolve().parents[2]
WIREGUARD = ROOT / "android/third_party/wireguard-android"
DOCUMENTS = ["THIRD_PARTY_NOTICES.md", "docs/SOURCE_DISTRIBUTION.md", "LICENSING.md"]
PSEUDO_VERSION = re.compile(r"v0\.0\.0-[0-9]{14}-[0-9a-f]{12}")
GO_VERSION = re.compile(r"\b(?:Go |go)([0-9]+\.[0-9]+\.[0-9]+)\b")
SHA256 = re.compile(r"\b[0-9a-f]{64}\b")


def pinned():
    policy = (ROOT / "android/buildSrc/src/main/java/com/fuzevpn/build/WireGuardAarPolicy.java").read_text(encoding="utf-8")
    approved = re.search(r'APPROVED_SHA256\s*=\s*"([0-9a-f]{64})"', policy)[1]
    metadata = json.loads((WIREGUARD / "dist/tunnel-1.0.20260102-fuzevpn-fgs.metadata.json").read_text(encoding="utf-8"))
    go = re.search(r"\bgo([0-9]+\.[0-9]+\.[0-9]+)\b", metadata["nativeBuild"]["go"])[1]
    module = re.search(r"(?m)^\s*golang\.zx2c4\.com/wireguard (v\S+)", (WIREGUARD / "tunnel/tools/libwg-go/go.mod").read_text(encoding="utf-8"))[1]
    sums = {line.split()[1].removesuffix("/go.mod") for line in
            (WIREGUARD / "tunnel/tools/libwg-go/go.sum").read_text(encoding="utf-8").splitlines() if line.strip()}
    series = (WIREGUARD / "patches/fuzevpn/series").read_text(encoding="utf-8").split()
    return {"aar": approved, "metadataAar": metadata["sha256"], "upstreamAar": metadata.get("upstreamAarSha256"),
            "go": go, "wireguardGo": module, "goSum": sums, "series": series}


class PinnedSupplyChainDocumentTests(unittest.TestCase):
    def setUp(self):
        self.pins = pinned()
        self.texts = {name: (ROOT / name).read_text(encoding="utf-8") for name in DOCUMENTS}

    def test_pinned_records_agree(self):
        self.assertEqual(self.pins["aar"], self.pins["metadataAar"])
        self.assertIn(self.pins["wireguardGo"], self.pins["goSum"])

    def test_notices_and_source_guide_name_the_current_engine(self):
        for name in ("THIRD_PARTY_NOTICES.md", "docs/SOURCE_DISTRIBUTION.md"):
            text = self.texts[name]
            with self.subTest(document=name):
                self.assertIn(self.pins["wireguardGo"], text)
                self.assertIn(self.pins["aar"], text)
                self.assertRegex(text, r"\bGo \**" + re.escape(self.pins["go"]))
        for patch in self.pins["series"]:
            self.assertIn(patch, self.texts["docs/SOURCE_DISTRIBUTION.md"])

    def test_no_document_keeps_another_engine_version(self):
        for name, text in self.texts.items():
            with self.subTest(document=name):
                self.assertEqual(set(), set(PSEUDO_VERSION.findall(text)) - self.pins["goSum"],
                                 "pseudo-versions absent from the pinned go.sum")
                self.assertEqual(set(), set(GO_VERSION.findall(text)) - {self.pins["go"]}, "Go versions other than the pinned one")
                lines = text.splitlines()
                for index, line in enumerate(lines):
                    context = (lines[index - 1] if index else "") + "\n" + line
                    if "AAR" in context and SHA256.search(line):
                        self.assertEqual(set(), set(SHA256.findall(line)) - {self.pins["aar"], self.pins["upstreamAar"]},
                                         f"AAR digest other than the approved or upstream one: {line}")
                self.assertNotRegex(text, r"(?i)\b(deux|two) patches\b")

    def test_historical_source_inventory_is_not_presented_as_current(self):
        licensing = self.texts["LICENSING.md"]
        self.assertNotRegex(licensing, r"SBOM\.spdx\.json\)\s+for versions")
        self.assertRegex(licensing, r"SBOM\.spdx\.json\)\s+is the historical")
        self.assertRegex(self.texts["THIRD_PARTY_NOTICES.md"], r"SBOM\.spdx\.json\)\s+reste l’inventaire \*\*historique\*\*")

    def test_readmes_present_the_source_inventory_as_historical(self):
        # Integration request (d), formerly a cross-lot request of A17-supply-chain-03.
        for name in ("README.md", "README.fr.md"):
            lines = (ROOT / name).read_text(encoding="utf-8").splitlines()
            with self.subTest(document=name):
                inventory = [line for line in lines if "(docs/SBOM.spdx.json)" in line]
                self.assertEqual(1, len(inventory), inventory)
                self.assertRegex(inventory[0], r"(?i)\bhistori")
                self.assertIn("14/10", inventory[0])
                self.assertIn("WireGuard", inventory[0])
                self.assertIn("(docs/SBOM.release.md)", inventory[0])
                self.assertIn("(THIRD_PARTY_NOTICES.md)", inventory[0])
                release = [line for line in lines if "SBOM.release.corrections-20261028.spdx.json" in line]
                self.assertEqual(1, len(release), release)
                self.assertNotRegex(release[0], r"(?i)\b(current|courant)\b")
                self.assertIn("(docs/SBOM.release.md)", release[0])

    def test_documents_follow_the_wireguard_tools_packaging_decision(self):
        # A17-supply-chain-05 (lot N): android/app/build.gradle.kts decides whether the
        # AAR's wireguard-tools executables (GPL-2.0, netlink LGPL-2.1) are shipped.
        # The licensing documents must not describe that decision as open once made.
        build = re.sub(r"//[^\n]*", "", (ROOT / "android/app/build.gradle.kts").read_text(encoding="utf-8"))
        excluded = {path for block in re.findall(r"excludes\s*\+=\s*setOf\(([^)]*)\)", build)
                    for path in re.findall(r'"([^"]+)"', block)}
        tools_excluded = {"lib/**/libwg.so", "lib/**/libwg-quick.so"} <= excluded
        names = ("LICENSING.md", "THIRD_PARTY_NOTICES.md", "docs/NATIVE_DEPENDENCIES.md", "docs/SBOM.release.md")
        documents = {name: " ".join((ROOT / name).read_text(encoding="utf-8").split()) for name in names}
        for name, text in documents.items():
            with self.subTest(document=name):
                self.assertEqual(tools_excluded, "packaging.jniLibs.excludes" in text)
                if tools_excluded:
                    self.assertNotRegex(text, r"(?i)\bstill open\b|reste à décider|or decide to exclude|offre écrite .{0,40}à décider")
        if tools_excluded:
            row = [line for line in (ROOT / "THIRD_PARTY_NOTICES.md").read_text(encoding="utf-8").splitlines()
                   if line.startswith("| wireguard-tools |")]
            self.assertEqual(1, len(row), row)
            self.assertIn("exclus de l’APK et de l’AAB", row[0])
            self.assertIn("native-libraries-approved", documents["LICENSING.md"])
            self.assertIn("native-libraries-approved", documents["THIRD_PARTY_NOTICES.md"])
            self.assertRegex(documents["LICENSING.md"], r"\| wireguard-tools [^|]*excluded from the APK and App Bundle")

    def test_generated_source_readme_describes_the_pinned_series(self):
        spec = importlib.util.spec_from_file_location("readme_exporter", ROOT / "tools/package_android_sources.py")
        exporter = importlib.util.module_from_spec(spec)
        spec.loader.exec_module(exporter)
        readme = exporter.source_readme(exporter.collect_versions(ROOT), [], []).decode("utf-8")
        for patch in self.pins["series"]:
            self.assertIn(f"`{patch}`", readme)
        self.assertIn(f"its {len(self.pins['series'])} patches", readme)
        self.assertIn(f"Go {self.pins['go']}", readme)
        self.assertIn(self.pins["wireguardGo"], readme)
        self.assertEqual(set(), set(GO_VERSION.findall(readme)) - {self.pins["go"]})


if __name__ == "__main__":
    unittest.main()
