# SPDX-License-Identifier: Apache-2.0
"""A10-wireguard-04: the approved WireGuard AAR keeps time on CLOCK_BOOTTIME.

CLOCK_MONOTONIC stops while an Android device sleeps, so the WireGuard timers
(handshake, keepalive, rekey) must be derived from CLOCK_BOOTTIME (7). The
reviewed runtime patch (libwg-go/goruntime-go1.26.9-boottime.diff) rewrites
the clock id of runtime.nanotime1 on every ABI and, because only linux/amd64
implements time.now in assembly (runtime/timeasm.go), the two clock_gettime
sites of time_linux_amd64.s. The other ABIs build time.now from walltime and
nanotime1 (runtime/timestub.go).

The four libwg-go.so of the AAR approved by WireGuardAarPolicy are read as
data: each function is located through the ELF symbol table, and its clock ids
are the immediates it loads into the clock_gettime clock argument.
"""
import hashlib
from pathlib import Path
import re
import struct
import unittest
import zipfile

TOOLS = Path(__file__).resolve().parents[1]
REPOSITORY = TOOLS.parent
AAR = REPOSITORY / "android/third_party/wireguard-android/dist/tunnel-1.0.20260102-fuzevpn-fgs.aar"
POLICY = REPOSITORY / "android/buildSrc/src/main/java/com/fuzevpn/build/WireGuardAarPolicy.java"
MACHINES = {"arm64-v8a": 183, "armeabi-v7a": 40, "x86": 3, "x86_64": 62}  # ELF e_machine
EM_386, EM_ARM, EM_X86_64, EM_AARCH64 = 3, 40, 62, 183
REALTIME, BOOTTIME = 0, 7
NANOTIME = ("runtime.nanotime1.abi0", "runtime.nanotime1")


def signed(value, bits):
    return value - (1 << bits) if value & (1 << (bits - 1)) else value


class Library:
    """Function symbols and code of one little-endian ELF shared object."""

    def __init__(self, data: bytes):
        if data[:4] != b"\x7fELF" or data[5] != 1:
            raise AssertionError("libwg-go.so is not a little-endian ELF file")
        wide = data[4] == 2
        self.data = data
        self.machine = struct.unpack_from("<H", data, 0x12)[0]
        if wide:
            table = struct.unpack_from("<Q", data, 0x28)[0]
            entry, count = struct.unpack_from("<HH", data, 0x3A)
            section_layout, symbol_layout, symbol_size = "<IIQQQQIIQQ", "<IBBHQQ", 24
        else:
            table = struct.unpack_from("<I", data, 0x20)[0]
            entry, count = struct.unpack_from("<HH", data, 0x2E)
            section_layout, symbol_layout, symbol_size = "<IIIIIIIIII", "<IIIBBH", 16
        # (type, flags, address, offset, size, link) of each section header.
        self.sections = [struct.unpack_from(section_layout, data, table + index * entry)[1:7] for index in range(count)]
        symtabs = [section for section in self.sections if section[0] == 2]  # SHT_SYMTAB
        if len(symtabs) != 1:
            raise AssertionError("libwg-go.so must keep exactly one symbol table")
        _, _, _, offset, size, link = symtabs[0]
        strings = self.sections[link][3]
        self.functions, self.names = {}, {}
        for position in range(offset, offset + size, symbol_size):
            fields = struct.unpack_from(symbol_layout, data, position)
            if wide:
                name, info, _, _, value, length = fields
            else:
                name, value, length, info, _, _ = fields
            if info & 0xF != 2 or not value:  # STT_FUNC
                continue
            label = data[strings + name:data.index(b"\0", strings + name)].decode("utf-8", "replace")
            self.functions.setdefault(label, (value, length))
            self.names.setdefault(value, label)

    def function(self, *names):
        """(name, address, code) of the first defined name."""
        for name in names:
            if name in self.functions:
                address, length = self.functions[name]
                for kind, flags, start, offset, size, _ in self.sections:
                    if kind == 1 and flags & 0x4 and start <= address < start + size:  # executable PROGBITS
                        return name, address, self.data[offset + address - start:offset + address - start + length]
        raise AssertionError(f"none of {names} is a function of libwg-go.so")

    def clock_ids(self, code: bytes):
        """Clock ids loaded into the clock_gettime clock argument, in code order."""
        ids = []
        if self.machine == EM_X86_64:  # MOVL $id, DI
            ids = [code[at + 1] for at in range(len(code) - 4)
                   if code[at] == 0xBF and code[at + 1] < 16 and code[at + 2:at + 5] == bytes(3)]
        elif self.machine == EM_386:  # MOVL $id, 0(SP) for the vDSO, MOVL $id, BX for int $0x80
            for at in range(len(code) - 4):
                if code[at:at + 3] == bytes((0xC7, 0x04, 0x24)) and code[at + 3] < 16 and code[at + 4:at + 7] == bytes(3):
                    ids.append(code[at + 3])
                elif code[at] == 0xBB and code[at + 1] < 16 and code[at + 2:at + 5] == bytes(3):
                    ids.append(code[at + 1])
        elif self.machine == EM_ARM:  # MOVW $id, R0
            ids = [word & 0xFF for word in self.words(code) if word & 0xFFFFFF00 == 0xE3A00000]
        elif self.machine == EM_AARCH64:  # MOVW $id, R0, assembled as ORRW $id, ZR, R0 or MOVZ
            for word in self.words(code):
                if word & 0xFFFF03FF == 0x320003E0:
                    ids.append((1 << (((word >> 10) & 0x3F) + 1)) - 1)
                elif word & 0xFFE0001F == 0x52800000:
                    ids.append((word >> 5) & 0xFFFF)
        return ids

    def callees(self, address: int, code: bytes):
        """Names of the functions called directly by the code at address."""
        targets = []
        if self.machine in (EM_386, EM_X86_64):  # CALL rel32
            targets = [address + at + 5 + struct.unpack_from("<i", code, at + 1)[0]
                       for at in range(len(code) - 4) if code[at] == 0xE8]
        elif self.machine == EM_ARM:  # BL
            targets = [address + 4 * at + 8 + (signed(word & 0xFFFFFF, 24) << 2)
                       for at, word in enumerate(self.words(code)) if word & 0xFF000000 == 0xEB000000]
        elif self.machine == EM_AARCH64:  # BL
            targets = [address + 4 * at + (signed(word & 0x3FFFFFF, 26) << 2)
                       for at, word in enumerate(self.words(code)) if word & 0xFC000000 == 0x94000000]
        return {self.names[target] for target in targets if target in self.names}

    @staticmethod
    def words(code: bytes):
        return struct.unpack_from(f"<{len(code) // 4}I", code)


class WireGuardNativeClockTests(unittest.TestCase):
    @classmethod
    def setUpClass(cls):
        cls.sha256 = hashlib.sha256(AAR.read_bytes()).hexdigest()
        with zipfile.ZipFile(AAR) as archive:
            cls.abis = sorted(name.split("/")[1] for name in archive.namelist() if name.endswith("/libwg-go.so"))
            cls.libraries = {abi: Library(archive.read(f"jni/{abi}/libwg-go.so")) for abi in MACHINES}

    def test_inspected_aar_is_the_approved_one_with_four_abis(self):
        approved = re.search(r'APPROVED_SHA256\s*=\s*"([0-9a-f]{64})"', POLICY.read_text(encoding="utf-8"))
        self.assertIsNotNone(approved, "WireGuardAarPolicy.APPROVED_SHA256 not found")
        self.assertEqual(self.sha256, approved[1])
        self.assertEqual(self.abis, sorted(MACHINES))
        for abi, machine in MACHINES.items():
            self.assertEqual(self.libraries[abi].machine, machine, abi)

    def test_amd64_time_now_reads_boottime_on_both_clock_gettime_paths(self):
        library = self.libraries["x86_64"]
        _, _, code = library.function("time.now")
        self.assertEqual(library.clock_ids(code), [REALTIME, BOOTTIME, BOOTTIME],
                         "time_linux_amd64.s must ask CLOCK_REALTIME for the wall clock, then CLOCK_BOOTTIME "
                         "on the vDSO and syscall paths (CLOCK_MONOTONIC is 1)")

    def test_nanotime1_reads_boottime_on_every_abi(self):
        # 386 passes the id twice: on the stack for the vDSO, in BX for int $0x80.
        expected = {"arm64-v8a": [BOOTTIME], "armeabi-v7a": [BOOTTIME], "x86": [BOOTTIME, BOOTTIME], "x86_64": [BOOTTIME]}
        for abi, ids in expected.items():
            with self.subTest(abi=abi):
                library = self.libraries[abi]
                _, _, code = library.function(*NANOTIME)
                self.assertEqual(library.clock_ids(code), ids)

    def test_other_abis_take_the_monotonic_part_of_time_now_from_nanotime1(self):
        for abi in ("arm64-v8a", "armeabi-v7a", "x86"):
            with self.subTest(abi=abi):
                library = self.libraries[abi]
                nanotime, _, _ = library.function(*NANOTIME)
                _, address, code = library.function("time.now")
                self.assertIn(nanotime, library.callees(address, code))
                self.assertEqual(library.clock_ids(code), [], "time.now must not choose a clock itself")


if __name__ == "__main__":
    unittest.main()
