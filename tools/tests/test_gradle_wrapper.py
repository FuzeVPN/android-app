# SPDX-License-Identifier: Apache-2.0
"""A17-supply-chain-07 and A17-supply-chain-06: the Gradle wrapper is the official 9.8.2 one.

The JAR is the one `gradle wrapper` writes for Gradle 9.8.2; its SHA-256 is the
value published at
https://services.gradle.org/distributions/gradle-9.8.2-wrapper.jar.sha256.
The properties pin the 9.8.2 distribution (not affected by GHSA-j5m7-59rp-24f5,
GHSA-xwqc-3h47-hg64 and GHSA-mvvg-497x-hmj8) by its published SHA-256, which
the repository's gradlew scripts also check before extracting it.
"""
import hashlib
from pathlib import Path
import unittest

TOOLS = Path(__file__).resolve().parents[1]
REPOSITORY = TOOLS.parent
WRAPPER = REPOSITORY / "android/gradle/wrapper"
OFFICIAL_WRAPPER_JAR_SHA256 = "3b8a25775a69158b5ad2b1d17a80a88dc7b40a352a73eb27d06c612a7ce68e98"
DISTRIBUTION_SHA256 = "21bd5da2de49b642904077f38c0efdc7778e92b3ed0889392dca61b97e389607"


class GradleWrapperTests(unittest.TestCase):
    def test_wrapper_jar_is_the_official_gradle_9_8_2_jar(self):
        jar = (WRAPPER / "gradle-wrapper.jar").read_bytes()
        self.assertEqual(OFFICIAL_WRAPPER_JAR_SHA256, hashlib.sha256(jar).hexdigest())

    def test_properties_pin_the_verified_9_8_2_distribution(self):
        properties = (WRAPPER / "gradle-wrapper.properties").read_text(encoding="utf-8")
        self.assertRegex(properties, r"(?m)^distributionUrl=https\\://services\.gradle\.org/distributions/gradle-9\.8\.2-bin\.zip$")
        self.assertRegex(properties, rf"(?m)^distributionSha256Sum={DISTRIBUTION_SHA256}$")
        self.assertRegex(properties, r"(?m)^validateDistributionUrl=true$")

    def test_gradlew_scripts_check_the_same_distribution(self):
        for script in ("gradlew", "gradlew.bat"):
            with self.subTest(script=script):
                text = (REPOSITORY / "android" / script).read_text(encoding="utf-8")
                self.assertRegex(text, r'(?m)^(set ")?GRADLE_VERSION=9\.8\.2"?\r?$')
                self.assertRegex(text, rf'(?m)^(set ")?GRADLE_SHA256={DISTRIBUTION_SHA256}"?\r?$')


if __name__ == "__main__":
    unittest.main()
