"""Run CASTLE.EXE under Unicorn with a tiny DOS/BIOS stub and measure the cost
of the idle input loop, i.e. how much work happens between monster turns.

Usage: timing.py [--trace]
The intro GOSUBs are patched out so the game starts straight at NewGame.
"""
import struct
import sys
from collections import Counter
from pathlib import Path

import capstone
from unicorn import Uc, UC_ARCH_X86, UC_MODE_16, UC_HOOK_INTR, UC_HOOK_CODE, UC_HOOK_INSN
from unicorn.x86_const import *

ROOT = Path(__file__).resolve().parent.parent / "Castle.1984"
EXE = (ROOT / "CASTLE.EXE").read_bytes()
RAN = bytearray((ROOT / "CASTLE.RAN").read_bytes())

PSP = 0x1000
LOAD = PSP + 0x10
HDR = struct.unpack("<H", EXE[8:10])[0] * 16
NREL = struct.unpack("<H", EXE[6:8])[0]
RELO = struct.unpack("<H", EXE[24:26])[0]
CS0, IP0 = struct.unpack("<HH", EXE[22:26][2:4] + EXE[20:22])[::-1] if False else (
    struct.unpack("<H", EXE[22:24])[0], struct.unpack("<H", EXE[20:22])[0])
SS0, SP0 = struct.unpack("<H", EXE[14:16])[0], struct.unpack("<H", EXE[16:18])[0]

uc = Uc(UC_ARCH_X86, UC_MODE_16)
uc.mem_map(0, 0x100000)
img = bytearray(EXE[HDR:])
for k in range(NREL):
    off, seg = struct.unpack("<HH", EXE[RELO + 4 * k:RELO + 4 * k + 4])
    a = seg * 16 + off
    v = struct.unpack("<H", img[a:a + 2])[0]
    img[a:a + 2] = struct.pack("<H", (v + LOAD) & 0xFFFF)
# skip the freeware notice and title screen: NOP out the two GOSUBs at 0x2B / 0x32
img[0x2B:0x39] = b"\x90" * 14
uc.mem_write(LOAD * 16, bytes(img))
psp = bytearray(256)
psp[0:2] = b"\xcd\x20"
psp[2:4] = struct.pack("<H", 0xA000)
psp[0x80:0x82] = b"\x00\x0d"
uc.mem_write(PSP * 16, bytes(psp))
# BIOS data area: 40-column colour text, 640K
uc.mem_write(0x449, bytes([1]))
uc.mem_write(0x44A, struct.pack("<H", 40))
uc.mem_write(0x413, struct.pack("<H", 640))
uc.mem_write(0x41A, struct.pack("<HH", 0x1E, 0x1E))
# IVT: every vector points at an IRET stub in high memory, so INT works
uc.mem_write(0xF0000, b"\xcf")
for v in range(256):
    uc.mem_write(v * 4, struct.pack("<HH", 0, 0xF000))

uc.reg_write(UC_X86_REG_CS, LOAD + CS0)
uc.reg_write(UC_X86_REG_IP, IP0)
uc.reg_write(UC_X86_REG_SS, LOAD + SS0)
uc.reg_write(UC_X86_REG_SP, SP0)
uc.reg_write(UC_X86_REG_DS, PSP)
uc.reg_write(UC_X86_REG_ES, PSP)

TRACE = "--trace" in sys.argv
screen = {}
cursor = [0, 0]
files = {}
dta = [PSP * 16 + 0x80]
next_handle = [5]
keys = []            # scripted keys (ascii, scan)
ints = Counter()
unknown = Counter()


def r(reg):
    return uc.reg_read(reg)


def w(reg, v):
    uc.reg_write(reg, v & 0xFFFF)


def set_cf(on):
    f = r(UC_X86_REG_FLAGS)
    # INT pushed FLAGS; the IRET stub pops them, so patch the copy on the stack
    ss, sp = r(UC_X86_REG_SS), r(UC_X86_REG_SP)
    a = ss * 16 + sp + 4
    fl = struct.unpack("<H", uc.mem_read(a, 2))[0]
    fl = (fl | 1) if on else (fl & ~1)
    uc.mem_write(a, struct.pack("<H", fl))


def set_zf(on):
    ss, sp = r(UC_X86_REG_SS), r(UC_X86_REG_SP)
    a = ss * 16 + sp + 4
    fl = struct.unpack("<H", uc.mem_read(a, 2))[0]
    fl = (fl | 0x40) if on else (fl & ~0x40)
    uc.mem_write(a, struct.pack("<H", fl))


def cstr(seg, off):
    b = uc.mem_read(seg * 16 + off, 128)
    return bytes(b[:b.index(0)]).decode("latin1")


def on_int(uc_, intno, _):
    ah, al = r(UC_X86_REG_AH), r(UC_X86_REG_AL)
    ints[(intno, ah)] += 1
    if intno == 0x21:
        ds, dx = r(UC_X86_REG_DS), r(UC_X86_REG_DX)
        if ah == 0x30:
            w(UC_X86_REG_AX, 0x0003)
        elif ah == 0x25:
            uc.mem_write(al * 4, struct.pack("<HH", dx, ds))
        elif ah == 0x35:
            o, s = struct.unpack("<HH", uc.mem_read(al * 4, 4))
            w(UC_X86_REG_BX, o); w(UC_X86_REG_ES, s)
        elif ah == 0x1A:
            dta[0] = ds * 16 + dx
        elif ah in (0x21, 0x22):   # FCB random read / write of one record
            fcb = ds * 16 + dx
            size = struct.unpack("<H", uc.mem_read(fcb + 0x0E, 2))[0]
            rec = struct.unpack("<I", uc.mem_read(fcb + 0x21, 4))[0]
            if ah == 0x21:
                chunk = bytes(RAN[rec * size:(rec + 1) * size]).ljust(size, b"\x00")
                uc.mem_write(dta[0], chunk)
            w(UC_X86_REG_AX, (ah << 8) | 0)
        elif ah == 0x12:
            w(UC_X86_REG_AX, 0x12FF)
        elif ah in (0x4A, 0x0D, 0x0E, 0x19):
            if ah == 0x19:
                w(UC_X86_REG_AX, (ah << 8) | 2)
            set_cf(False)
        elif ah == 0x48:
            w(UC_X86_REG_AX, 0x8000); set_cf(False)
        elif ah == 0x29:   # parse filename into FCB at ES:DI
            si = r(UC_X86_REG_SI)
            name = bytes(uc.mem_read(ds * 16 + si, 64)).split(b"\x00")[0].split(b"\r")[0].strip()
            base, _, ext = name.partition(b".")
            es, di = r(UC_X86_REG_ES), r(UC_X86_REG_DI)
            uc.mem_write(es * 16 + di, b"\x00" + base.upper().ljust(8)[:8] + ext.upper().ljust(3)[:3])
            w(UC_X86_REG_SI, si + len(name)); w(UC_X86_REG_AX, 0)
        elif ah in (0x11, 0x0F):  # FCB find first / open
            fcb = ds * 16 + dx
            nm = bytes(uc.mem_read(fcb + 1, 11)).decode("latin1")
            ok = nm.strip().startswith("CASTLE") and "RAN" in nm
            if ah == 0x11 and ok:
                uc.mem_write(dta[0], b"\x00" + nm.encode("latin1") + bytes(20))
            if ah == 0x0F and ok:
                uc.mem_write(fcb + 0x0E, struct.pack("<H", 128))
                uc.mem_write(fcb + 0x10, struct.pack("<I", len(RAN)))
            w(UC_X86_REG_AX, (ah << 8) | (0 if ok else 0xFF))
        elif ah == 0x3D:
            name = cstr(ds, dx)
            if name.upper().endswith("CASTLE.RAN"):
                h = next_handle[0]; next_handle[0] += 1
                files[h] = [RAN, 0]
                w(UC_X86_REG_AX, h); set_cf(False)
            else:
                w(UC_X86_REG_AX, 2); set_cf(True)
        elif ah == 0x3F:
            h, n = r(UC_X86_REG_BX), r(UC_X86_REG_CX)
            data, pos = files[h]
            chunk = bytes(data[pos:pos + n])
            uc.mem_write(ds * 16 + dx, chunk)
            files[h][1] += len(chunk)
            w(UC_X86_REG_AX, len(chunk)); set_cf(False)
        elif ah == 0x42:
            h = r(UC_X86_REG_BX)
            off = (r(UC_X86_REG_CX) << 16) | dx
            data, pos = files[h]
            files[h][1] = {0: off, 1: pos + off, 2: len(data) + off}[al]
            p = files[h][1]
            w(UC_X86_REG_AX, p & 0xFFFF); w(UC_X86_REG_DX, p >> 16); set_cf(False)
        elif ah == 0x3E:
            files.pop(r(UC_X86_REG_BX), None); set_cf(False)
        elif ah == 0x44:
            w(UC_X86_REG_DX, 0x80 if r(UC_X86_REG_BX) < 5 else 0); set_cf(False)
        elif ah == 0x2C:
            w(UC_X86_REG_CX, 0x0C00); w(UC_X86_REG_DX, 0)
        elif ah == 0x2A:
            w(UC_X86_REG_CX, 1984); w(UC_X86_REG_DX, 0x0611)
        elif ah in (0x4C, 0x00):
            uc.emu_stop()
        else:
            unknown[(0x21, ah)] += 1
            set_cf(False)
    elif intno == 0x10:
        if ah == 0x0F:
            w(UC_X86_REG_AX, (40 << 8) | 1); w(UC_X86_REG_BX, 0)
        elif ah == 0x02:
            cursor[:] = [r(UC_X86_REG_DH), r(UC_X86_REG_DL)]
        elif ah == 0x03:
            w(UC_X86_REG_DX, (cursor[0] << 8) | cursor[1]); w(UC_X86_REG_CX, 0x0607)
        elif ah in (0x09, 0x0A):
            for k in range(max(1, r(UC_X86_REG_CX))):
                screen[(cursor[0], cursor[1] + k)] = al
        elif ah == 0x0E:
            screen[tuple(cursor)] = al
            cursor[1] += 1
        elif ah == 0x08:
            w(UC_X86_REG_AX, 0x0700 | screen.get(tuple(cursor), 32))
        elif ah == 0x06:
            if al == 0:
                screen.clear()
    elif intno == 0x16:
        if ah == 0x01:
            set_zf(not keys)
            if keys:
                a, s = keys[0]; w(UC_X86_REG_AX, (s << 8) | a)
        elif ah == 0x00:
            a, s = keys.pop(0) if keys else (0, 0)
            w(UC_X86_REG_AX, (s << 8) | a)
    elif intno == 0x11:
        w(UC_X86_REG_AX, 0x0021)
    elif intno == 0x12:
        w(UC_X86_REG_AX, 640)
    elif intno == 0x1A:
        w(UC_X86_REG_CX, 0); w(UC_X86_REG_DX, 0)
    else:
        unknown[(intno, ah)] += 1


def on_in(uc_, port, size, _):
    return 0


def on_out(uc_, port, size, value, _):
    pass


uc.hook_add(UC_HOOK_INTR, on_int)
uc.hook_add(UC_HOOK_INSN, on_in, None, 1, 0, UC_X86_INS_IN)
uc.hook_add(UC_HOOK_INSN, on_out, None, 1, 0, UC_X86_INS_OUT)

# ---------------------------------------------------------------- measurement
md = capstone.Cs(capstone.CS_ARCH_X86, capstone.CS_MODE_16)
USER = LOAD * 16
MONSTER_TURN = USER + 0x1CB8
WAIT_KEY = USER + 0x0C83
state = {"n": 0, "cycles": 0, "marks": [], "polls": 0, "in_loop": False}
CYC_CACHE = {}


def cycles_8088(addr, size):
    """Rough 8088 cost: max(execution-unit time, 4 cycles per byte fetched) + memory operands."""
    c = CYC_CACHE.get(addr)
    if c is not None:
        return c
    code = bytes(uc.mem_read(addr, size))
    try:
        i = next(md.disasm(code, 0))
    except StopIteration:
        CYC_CACHE[addr] = 8
        return 8
    m, ops = i.mnemonic.split()[-1], i.op_str
    mem = "[" in ops
    base = {"mov": 2, "xchg": 4, "add": 3, "sub": 3, "and": 3, "or": 3, "xor": 3, "cmp": 3,
            "adc": 3, "sbb": 3, "inc": 3, "dec": 3, "neg": 3, "not": 3, "test": 3,
            "shl": 2, "shr": 2, "sar": 2, "rcl": 2, "rcr": 2, "rol": 2, "ror": 2,
            "push": 15, "pop": 12, "pushf": 14, "popf": 12, "call": 23, "lcall": 36,
            "ret": 20, "retf": 34, "iret": 44, "int": 71, "jmp": 15, "ljmp": 15,
            "loop": 17, "lodsb": 12, "lodsw": 16, "stosb": 11, "stosw": 15,
            "movsb": 18, "movsw": 26, "cmpsb": 22, "cmpsw": 30, "scasb": 15, "scasw": 19,
            "mul": 118, "imul": 128, "div": 144, "idiv": 165, "cbw": 2, "cwd": 5,
            "clc": 2, "stc": 2, "cld": 2, "std": 2, "cli": 2, "sti": 2, "cmc": 2,
            "lahf": 4, "sahf": 4, "lea": 2, "les": 24, "lds": 24, "nop": 3, "xlatb": 11,
            "in": 14, "out": 14, "cdq": 5}.get(m, 6)
    if m.startswith("j") and m != "jmp":
        base = 12          # mix of taken (16) and not taken (4)
    if "cl" in ops and m in ("shl", "shr", "sar", "rcl", "rcr", "rol", "ror"):
        base = 8 + 4 * 4   # assume ~4 bit shifts
    if m in ("shl", "shr", "sar", "rcl", "rcr", "rol", "ror") and ops.endswith(", 1") is False and "cl" not in ops:
        base = 2
    if mem and m not in ("lcall", "call", "jmp", "push", "pop") and not m.startswith(("lods", "stos", "movs", "cmps", "scas")):
        base += 9 + (8 if "word" in ops else 4)   # effective address + bus cycles
    c = max(base, 4 * i.size)
    if i.mnemonic.startswith("rep"):
        c = base * 8   # assume ~8 repetitions
    CYC_CACHE[addr] = c
    return c


def on_code(uc_, addr, size, _):
    state["n"] += 1
    state["cycles"] += cycles_8088(addr, size)
    if addr == WAIT_KEY:
        state["polls"] += 1
    if addr == MONSTER_TURN:
        state["marks"].append((state["n"], state["cycles"], state["polls"], ints[(0x16, 1)]))
        if len(state["marks"]) >= 4:
            uc.emu_stop()


uc.hook_add(UC_HOOK_CODE, on_code)

try:
    uc.emu_start(IP0 + (LOAD + CS0) * 16, 0xFFFFF, count=40_000_000)
except Exception as e:  # noqa: BLE001
    cs, ip = r(UC_X86_REG_CS), r(UC_X86_REG_IP)
    print(f"stopped: {e} at {cs:04x}:{ip:04x}")

print("instructions executed:", state["n"])
print("interrupt calls:", dict(ints.most_common(12)))
if unknown:
    print("unhandled:", dict(unknown))
rows = []
for y in range(25):
    line = "".join(chr(screen.get((y, x), 32)) if 32 <= screen.get((y, x), 32) < 127 else "#" for x in range(40))
    rows.append(line.rstrip())
print("\n".join(r_ for r_ in rows if r_))
m = state["marks"]
for a, b in zip(m, m[1:]):
    d_ins, d_cyc, d_poll, d_kb = b[0] - a[0], b[1] - a[1], b[2] - a[2], b[3] - a[3]
    print(f"between monster turns: {d_ins} instructions, ~{d_cyc} 8088 cycles, {d_poll} polls, "
          f"{d_kb} BIOS key checks -> {d_ins / max(1, d_poll):.0f} instr/poll")
