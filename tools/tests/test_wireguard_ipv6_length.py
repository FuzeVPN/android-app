# SPDX-License-Identifier: Apache-2.0
"""A17-supply-chain-02: the pinned wireguard-go drops IPv6 packets whose length wraps.

Before upstream b3bc704ef0ee, device/receive.go computed the IPv6 total length
in a uint16: a Payload Length of 0xFFFF or 0xFFD8 wrapped below the real
packet size and the packet reached the TUN. The Go test in
wireguard_ipv6_length/ runs two in-memory devices of the wireguard-go version
pinned by libwg-go/go.mod, whose go.sum it reuses. Modules come only from the
reviewed source distribution (prepare_go_proxy.py), with no network access.

A Go toolchain is required: FUZEVPN_GO names go.exe, otherwise go is looked up
on PATH.
"""
import os
from pathlib import Path
import re
import shutil
import subprocess
import sys
import tempfile
import unittest

TOOLS = Path(__file__).resolve().parents[1]
REPOSITORY = TOOLS.parent
LIBWG_GO = REPOSITORY / "android/third_party/wireguard-android/tunnel/tools/libwg-go"
PREPARE_PROXY = REPOSITORY / "android/source-distribution/prepare_go_proxy.py"
GO_TEST = Path(__file__).resolve().parent / "wireguard_ipv6_length/ipv6_length_test.go"


def go():
    explicit = os.environ.get("FUZEVPN_GO")
    return explicit if explicit else shutil.which("go")


class WireGuardIPv6LengthTests(unittest.TestCase):
    def test_pinned_wireguard_go_drops_wrapped_ipv6_payload_lengths(self):
        toolchain = go()
        self.assertTrue(toolchain and Path(toolchain).is_file(), "a Go toolchain is required: set FUZEVPN_GO or put go on PATH")
        temporary = tempfile.TemporaryDirectory(ignore_cleanup_errors=True)
        self.addCleanup(temporary.cleanup)
        root = Path(temporary.name)
        proxy = subprocess.run([sys.executable, "-B", str(PREPARE_PROXY), str(root / "proxy")],
                               capture_output=True, text=True, check=True).stdout.strip()
        go_mod = (LIBWG_GO / "go.mod").read_text(encoding="utf-8")
        pinned = re.search(r"(?m)^\s*golang\.zx2c4\.com/wireguard (v\S+)\s*$", go_mod)
        self.assertIsNotNone(pinned, "libwg-go/go.mod does not pin golang.zx2c4.com/wireguard")
        module = root / "module"
        module.mkdir()
        (module / "go.mod").write_text(re.sub(r"(?m)^module .*$", "module fuzevpn.tests/wgipv6length", go_mod, count=1),
                                       encoding="utf-8", newline="\n")
        shutil.copyfile(LIBWG_GO / "go.sum", module / "go.sum")
        shutil.copyfile(GO_TEST, module / GO_TEST.name)
        environment = {key: value for key, value in os.environ.items() if not key.startswith("GO")}
        environment.update({
            "GOPROXY": proxy, "GOSUMDB": "off", "GOFLAGS": "-mod=readonly -modcacherw", "GOTOOLCHAIN": "local",
            "GOWORK": "off", "GOENV": "off", "CGO_ENABLED": "0", "GOMAXPROCS": "2",
            "GOPATH": str(root / "gopath"), "GOMODCACHE": str(root / "modcache"), "GOCACHE": str(root / "gocache"),
        })
        result = subprocess.run([toolchain, "test", "-count=1", "-p", "2", "-v", "."], cwd=module, env=environment,
                                capture_output=True, text=True, encoding="utf-8", errors="replace", timeout=900)
        output = result.stdout + result.stderr
        self.assertEqual(result.returncode, 0, f"golang.zx2c4.com/wireguard {pinned[1]}:\n{output}")
        self.assertIn("--- PASS: TestWrappedIPv6PayloadLengthIsDropped", output)


if __name__ == "__main__":
    unittest.main()
