"""Recursive-descent disassembly of the compiled BASIC user code."""
import struct
import sys

from exe import CODE, USER_END, RT_SEG, md, ds_string

# Runtime routines followed by inline data: offset -> function(code, pos) -> data length
def _onjump(code, p):
    return 1 + 2 * code[p]

INLINE = {
    0x1C9A: lambda c, p: 2,          # GOSUB  dw target
    0x2972: lambda c, p: 1,          # db channel/flags
    0x2C3D: lambda c, p: 1 + c[p],   # db count, count type bytes
    0x1CF1: _onjump,                 # ON x GOTO/GOSUB: db n, dw targets[n]
    0x10D1: lambda c, p: 1,          # save FAC to compiler temp: db slot
}
NORETURN = {0x15E7, 0x15DE, 0x1CC3}  # END, end-of-handler, RETURN


class Insn:
    __slots__ = ("addr", "size", "mnem", "ops", "rt", "inline", "raw")

    def __init__(self, i):
        self.addr, self.size, self.mnem, self.ops = i.address, i.size, i.mnemonic, i.op_str
        self.raw = bytes(i.bytes)
        self.rt = None
        self.inline = b""


def far_target(i):
    if i.mnem == "lcall" and i.ops.startswith(f"{RT_SEG:#x},"):
        return int(i.ops.split(",")[1], 16)
    return None


def disassemble(entries=(0x1A, 0x70EC)):
    insns = {}
    targets = set(entries)
    work = list(entries)
    while work:
        pc = work.pop()
        while 0 <= pc < USER_END and pc not in insns:
            try:
                ci = next(md.disasm(CODE[pc:pc + 16], pc))
            except StopIteration:
                print(f"bad decode at {pc:#x}", file=sys.stderr)
                break
            ins = Insn(ci)
            insns[pc] = ins
            nxt = pc + ins.size
            rt = far_target(ins)
            if rt is not None:
                ins.rt = rt
                if rt in INLINE:
                    n = INLINE[rt](CODE, nxt)
                    ins.inline = CODE[nxt:nxt + n]
                    if rt == 0x1C9A:
                        t = struct.unpack("<H", ins.inline)[0]
                        targets.add(t); work.append(t)
                    if rt == 0x1CF1:
                        for k in range(ins.inline[0]):
                            t = struct.unpack("<H", ins.inline[1 + 2 * k:3 + 2 * k])[0]
                            targets.add(t); work.append(t)
                    nxt += n
                if rt in NORETURN:
                    break
                pc = nxt
                continue
            m = ins.mnem
            if m.startswith("j") or m in ("call", "loop"):
                try:
                    t = int(ins.ops, 16)
                    targets.add(t); work.append(t)
                except ValueError:
                    print(f"indirect {m} {ins.ops} at {pc:#x}", file=sys.stderr)
                if m == "jmp":
                    break
            if m in ("ret", "retf", "iret", "hlt"):
                break
            pc = nxt
    return insns, targets


def annotate(ops):
    out = []
    for tok in ops.replace(",", " ").replace("[", " ").replace("]", " ").split():
        if tok.startswith("0x"):
            s = ds_string(int(tok, 16))
            if s is not None:
                out.append(repr(s))
    return ("  ; " + " ".join(out)) if out else ""


if __name__ == "__main__":
    insns, targets = disassemble()
    covered = sum(i.size + len(i.inline) for i in insns.values())
    print(f"; {len(insns)} instructions, {covered} of {USER_END} bytes covered", file=sys.stderr)
    prev_end = None
    for a in sorted(insns):
        i = insns[a]
        if prev_end is not None and a != prev_end:
            print(f"; ---- gap {prev_end:#06x}-{a:#06x} ({a - prev_end} bytes)")
        if a in targets:
            print(f"L{a:04X}:")
        tail = f"  db {i.inline.hex(' ')}" if i.inline else ""
        print(f"  {a:05x}  {i.mnem} {i.ops}{annotate(i.ops)}{tail}")
        prev_end = a + i.size + len(i.inline)
