"""Shared loader for CASTLE.EXE (IBM BASIC Compiler 1.0 output)."""
import struct
from pathlib import Path

import capstone

EXE = Path(__file__).resolve().parent.parent / "Castle.1984" / "CASTLE.EXE"
USER_END = 0x7D60          # end of compiled user code in segment 0
RT_SEG = 0x7D6             # runtime library segment
DS_FILE = 0xC140           # image offset where DS-visible constants live
DS_BASE = DS_FILE - 0x1040  # image offset of DS:0000

_raw = EXE.read_bytes()
HDR = struct.unpack("<H", _raw[8:10])[0] * 16
IMG = _raw[HDR:]
CODE = IMG[:USER_END]

md = capstone.Cs(capstone.CS_ARCH_X86, capstone.CS_MODE_16)
md.detail = False


def ds_word(off: int) -> int:
    return struct.unpack("<H", IMG[DS_BASE + off:DS_BASE + off + 2])[0]


def ds_bytes(off: int, n: int) -> bytes:
    return IMG[DS_BASE + off:DS_BASE + off + n]


def ds_string(off: int):
    """Return the string constant whose descriptor is at DS:off, or None."""
    a = DS_BASE + off
    if a < DS_FILE or a + 4 > len(IMG):
        return None
    n, p = struct.unpack("<HH", IMG[a:a + 4])
    if p == off + 4 and 0 <= n < 256:
        return IMG[a + 4:a + 4 + n].decode("cp437")
    return None


def mbf_single(b: bytes) -> float:
    """Decode a 4-byte Microsoft Binary Format single."""
    m0, m1, m2, e = b
    if e == 0:
        return 0.0
    sign = -1.0 if m2 & 0x80 else 1.0
    mant = ((m2 | 0x80) << 16) | (m1 << 8) | m0
    return sign * mant / float(1 << 24) * 2.0 ** (e - 128)
