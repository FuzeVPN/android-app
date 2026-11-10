# SPDX-License-Identifier: Apache-2.0
"""A16-ui-l10n-08 / A18-tooling-evidence-01: pack validation survives python -O.

Synthetic packs in a private copy; the real tool runs in a subprocess exactly as
tools/validate_project.ps1 and tools/release_aab_safe.py run it, with and
without -O and PYTHONOPTIMIZE. The repository packs are never read or written.
"""
import ast
import importlib.util
import json
import os
from pathlib import Path
import shutil
import subprocess
import sys
import tempfile
import unittest

TOOLS = Path(__file__).resolve().parents[1]
SPEC = importlib.util.spec_from_file_location("generate_translations_under_test", TOOLS / "generate_translations.py")
generator = importlib.util.module_from_spec(SPEC)
SPEC.loader.exec_module(generator)

SOURCE = {
    "locale": "en",
    "arb": {
        "@@locale": "en",
        "greeting": "Hello {name}",
        "@greeting": {"description": "Greeting", "placeholders": {"name": {"type": "String"}}},
        "items": "{count, plural, one{{count} item} other{{count} items}}",
        "mode": "{mode, select, wireguard{WireGuard} openvpn{OpenVPN} other{VPN}}",
    },
    "android": {"vpn_title": "Connected to %1$s", "vpn_body": "Plain text"},
    "countries": {"FR": "France", "SX": "Sint Maarten"},
}
MODES = {"normal": ([], {}), "-O": (["-O"], {}), "PYTHONOPTIMIZE=1": ([], {"PYTHONOPTIMIZE": "1"}),
         "-OO": (["-OO"], {})}


def pack_for(language):
    pack = json.loads(json.dumps(SOURCE))
    pack["locale"] = language
    pack["arb"]["@@locale"] = language.replace("-", "_")
    pack["arb"]["greeting"] = f"[{language}] {{name}}"
    pack["countries"]["FR"] = f"France ({language})"
    return pack


class TranslationPackValidationTests(unittest.TestCase):
    def setUp(self):
        temporary = tempfile.TemporaryDirectory()
        self.addCleanup(temporary.cleanup)
        self.root = Path(temporary.name)
        (self.root / "tools").mkdir()
        shutil.copyfile(TOOLS / "generate_translations.py", self.root / "tools/generate_translations.py")
        self.packs = self.root / "lib/l10n/translations"
        self.packs.mkdir(parents=True)
        for language in generator.LANGUAGES:
            self.write(language, SOURCE if language == "en" else pack_for(language))
        self.assertEqual(0, self.run_tool("normal").returncode)  # Generate the reference outputs.

    def write(self, language, pack):
        (self.packs / f"{language}.json").write_text(json.dumps(pack, ensure_ascii=False, indent=2), encoding="utf-8")

    def run_tool(self, mode, *arguments):
        flags, extra = MODES[mode]
        environment = {key: value for key, value in os.environ.items() if key != "PYTHONOPTIMIZE"}
        environment.update(extra)
        return subprocess.run([sys.executable, "-B", *flags, str(self.root / "tools/generate_translations.py"), *arguments],
                              capture_output=True, text=True, encoding="utf-8", env=environment, cwd=self.root)

    def outputs(self):
        return {path: path.read_bytes() for path in sorted(self.root.rglob("*"))
                if path.is_file() and "translations" not in path.parts and path.suffix in {".arb", ".xml", ".dart"}}

    def mutations(self):
        def edit(language, change):
            pack = pack_for(language)
            change(pack)
            return language, pack
        return {
            "empty text": edit("de", lambda p: p["arb"].__setitem__("greeting", "   ")),
            "android argument renumbered": edit("de", lambda p: p["android"].__setitem__("vpn_title", "Verbunden mit %2$s")),
            "android argument dropped": edit("fr", lambda p: p["android"].__setitem__("vpn_title", "Connecte")),
            "ICU other case missing": edit("pl", lambda p: p["arb"].__setitem__("items", "{count, plural, one{{count} x}}")),
            "duplicate ICU case": edit("ru", lambda p: p["arb"].__setitem__("mode", "{mode, select, wireguard{A} wireguard{B} other{C}}")),
            "ICU select case renamed": edit("ja", lambda p: p["arb"].__setitem__("mode", "{mode, select, wg{A} openvpn{B} other{C}}")),
            "invalid ICU name": edit("it", lambda p: p["arb"].__setitem__("greeting", "Ciao {na-me}")),
            "replacement character": edit("tr", lambda p: p["countries"].__setitem__("SX", "Sint Maarten �")),
            "locale mismatch": edit("nl", lambda p: p.__setitem__("locale", "nb")),
            "metadata changed": edit("nl", lambda p: p["arb"]["@greeting"].__setitem__("description", "Changed")),
            "missing key": edit("ur", lambda p: p["countries"].pop("SX")),
            "extra section": edit("cs", lambda p: p.__setitem__("extra", {})),
            "duplicate country name": edit("nl", lambda p: p["countries"].__setitem__("SX", " france  (NL)")),
        }

    def test_reference_packs_validate_in_every_python_mode(self):
        for mode in MODES:
            with self.subTest(mode=mode):
                result = self.run_tool(mode, "--check", "--require-all")
                self.assertEqual(0, result.returncode, result.stdout + result.stderr)
                self.assertIn("Validated 70/70 complete packs", result.stdout)

    def test_contract_violations_are_refused_even_under_python_optimizations(self):
        # The audit trigger (empty text, %1$s -> %2$s) plus one ICU and one metadata
        # violation; every mutation is also checked in process below.
        reference = self.outputs()
        selected = ("empty text", "android argument renumbered", "ICU other case missing", "metadata changed",
                    "duplicate country name")
        for label, (language, pack) in ((name, self.mutations()[name]) for name in selected):
            self.write(language, pack)
            for mode in ("normal", "-O", "PYTHONOPTIMIZE=1"):
                for arguments in (("--check", "--require-all"), ()) if mode == "-O" else (("--check",),):
                    with self.subTest(label=label, mode=mode, arguments=arguments):
                        result = self.run_tool(mode, *arguments)
                        self.assertEqual(1, result.returncode, result.stdout + result.stderr)
                        self.assertNotIn("Validated", result.stdout)
                        self.assertIn("Translation validation failed", result.stderr)
                        self.assertNotIn("Traceback", result.stderr)
                        self.assertEqual(reference, self.outputs())  # Nothing regenerated.
            self.write(language, pack_for(language))

    def test_missing_pack_is_refused_under_python_optimizations(self):
        (self.packs / "el.json").unlink()
        for mode in MODES:
            with self.subTest(mode=mode):
                result = self.run_tool(mode, "--check")
                self.assertEqual(1, result.returncode, result.stdout + result.stderr)
                self.assertIn("Missing translation: el", result.stderr)

    def test_android_resources_keep_legacy_indonesian_and_hebrew_codes(self):
        resources = self.root / "android/app/src/main/res"
        for legacy, canonical in (("in", "id"), ("iw", "he")):
            with self.subTest(language=canonical):
                self.assertTrue((resources / f"values-{legacy}/strings.xml").exists())
                self.assertFalse((resources / f"values-{canonical}").exists())

    def test_each_native_message_case_needs_a_title_case(self):
        # Requested by the UI/l10n sub-lot (A16-ui-l10n-03): a message case without its title is refused.
        def packs(title):
            for language in generator.LANGUAGES:
                pack = SOURCE if language == "en" else pack_for(language)
                pack = json.loads(json.dumps(pack))
                pack["arb"]["notice_native_title"] = title
                pack["arb"]["notice_native_message"] = "{code, select, tunnel_failed{Tunnel failed} other{Error}}"
                self.write(language, pack)
        packs("{code, select, tunnel_failed{Tunnel} other{Error}}")
        self.assertEqual(0, self.run_tool("-O").returncode)
        packs("{code, select, other{Error}}")
        for mode in ("normal", "-O"):
            with self.subTest(mode=mode):
                result = self.run_tool(mode, "--check")
                self.assertEqual(1, result.returncode, result.stdout + result.stderr)
                self.assertIn("no title case for notice_native_message cases ['tunnel_failed']", result.stderr)

    def test_in_process_validation_raises_without_assert(self):
        for label, (language, pack) in self.mutations().items():
            with self.subTest(label=label), self.assertRaises(generator.TranslationError):
                generator.validate(pack, SOURCE, language)
        generator.validate(pack_for("de"), SOURCE, "de")


class NoAssertValidationTests(unittest.TestCase):
    def test_tools_never_validate_with_assert_statements(self):
        # python -O and PYTHONOPTIMIZE delete assert statements (A20-D2, A16-ui-l10n-08).
        for path in sorted(TOOLS.glob("*.py")):
            tree = ast.parse(path.read_text(encoding="utf-8"), filename=str(path))
            lines = [node.lineno for node in ast.walk(tree) if isinstance(node, ast.Assert)]
            with self.subTest(tool=path.name):
                self.assertEqual([], lines)


if __name__ == "__main__":
    unittest.main()
