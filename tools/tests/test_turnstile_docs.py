# SPDX-License-Identifier: Apache-2.0
"""docs/GOOGLE_AUTH.md states the Turnstile deadlines that the sources enforce.

Integration of corrections-20261029 (lot N and the root): the provider startup
bound (TurnstilePolicy.STARTUP_TIMEOUT_MS -> provider_error), the native
deadline (TurnstilePolicy.TIMEOUT_MS) and the Dart guard
(NativeSecurityChallengeGateway.defaultSolveTimeout -> provider_error). Every
value is read from the sources, so a change there fails here until the
document follows it.
"""
from pathlib import Path
import re
import unittest

ROOT = Path(__file__).resolve().parents[2]
KOTLIN = ROOT / "android/app/src/main/kotlin/com/fuzevpn/android"


def milliseconds(name: str) -> int:
    text = (KOTLIN / "TurnstilePolicy.kt").read_text(encoding="utf-8")
    return int(re.search(rf"\bconst val {name} = ([0-9_]+)L\b", text)[1].replace("_", ""))


def runnable_code(name: str) -> str:
    text = (KOTLIN / "NativeTurnstileBridge.kt").read_text(encoding="utf-8")
    return re.search(rf"\bval {name} = Runnable \{{[^}}]*finishError\(this, \"([a-z_]+)\"\)", text)[1]


def dart_guard() -> tuple[int, str]:
    text = (ROOT / "lib/core/security_challenge.dart").read_text(encoding="utf-8")
    duration = re.search(r"static const defaultSolveTimeout = Duration\(([^)]*)\);", text)[1]
    units = {"minutes": 60, "seconds": 1}
    seconds = sum(units[unit] * int(value) for unit, value in re.findall(r"(minutes|seconds): ([0-9]+)", duration))
    # The first TimeoutException handler is solve()'s guard (cancel() has its own 2 s bound).
    gateway = text[text.index("class NativeSecurityChallengeGateway"):]
    solve = gateway[gateway.index("Future<SecurityChallengeResult> solve("):gateway.index("Future<void> cancel(")]
    code = re.search(r"on TimeoutException \{.*?throw SecurityChallengeException\('([a-z_]+)'\)", solve, re.S)[1]
    return seconds, code


def spoken(seconds: int) -> str:
    minutes, rest = divmod(seconds, 60)
    return f"{minutes} min {rest} s" if minutes and rest else (f"{minutes} min" if minutes else f"{rest} s")


class TurnstileDeadlineDocumentTests(unittest.TestCase):
    def setUp(self):
        self.text = " ".join((ROOT / "docs/GOOGLE_AUTH.md").read_text(encoding="utf-8").split())

    def test_sources_keep_the_documented_order_of_deadlines(self):
        startup, deadline = milliseconds("STARTUP_TIMEOUT_MS") // 1000, milliseconds("TIMEOUT_MS") // 1000
        guard, _ = dart_guard()
        self.assertLess(startup, deadline)
        self.assertGreater(guard, deadline)  # The Dart guard only covers a native side that never answers.

    def test_provider_startup_failure_and_dart_guard_are_documented(self):
        startup, deadline = milliseconds("STARTUP_TIMEOUT_MS") // 1000, milliseconds("TIMEOUT_MS") // 1000
        guard, guard_code = dart_guard()
        startup_code, deadline_code = runnable_code("startup"), runnable_code("timeout")
        self.assertEqual("provider_error", startup_code)
        self.assertEqual("provider_error", guard_code)
        for expected in ("`TurnstilePolicy.STARTUP_TIMEOUT_MS`", f"{startup} s", f"`{startup_code}`",
                         "`TurnstilePolicy.TIMEOUT_MS`", f"{deadline} s", f"`{deadline_code}`",
                         "`NativeSecurityChallengeGateway.defaultSolveTimeout`", spoken(guard),
                         "`solveTimeout`", "`interrupted`"):
            with self.subTest(expected=expected):
                self.assertTrue(expected in self.text, f"{expected} is missing from docs/GOOGLE_AUTH.md")


if __name__ == "__main__":
    unittest.main()
