"""Lift the compiled BASIC (IBM BASCOM 1.0) user code in CASTLE.EXE back to BASIC-like source.

Each basic block is executed symbolically: registers hold expression trees, the
runtime's floating accumulator (FAC, DS:00AA) is a pseudo-variable, and calls into
the runtime library become BASIC statements or functions according to RT below.
"""
import json
import struct
import sys
from collections import defaultdict
from pathlib import Path

from disasm import disassemble
from exe import ds_string, ds_bytes, mbf_single

FAC_ADDR = {0xAA, 0xA6}
SEEN_BASES = {}     # 1-D array element-0 addresses seen with a variable index
ARRAY_BASES = {}    # base -> (type, byte size), from a first pass
TEMPS = {}          # compiler temp slots -> last saved FAC text
NAMES = {}          # addr -> name (optional semantic names, loaded from names.json)
ARRAY_NAMES = {}    # base addr -> name


# ----------------------------------------------------------------- expressions
class E:
    """Expression node. kind: imm, sym, bin, neg, fac, cond."""
    __slots__ = ("k", "a", "b", "op", "t")

    def __init__(self, k, a=None, b=None, op=None, t=None):
        self.k, self.a, self.b, self.op, self.t = k, a, b, op, t

    def __repr__(self):
        return f"E({self.k},{self.a},{self.b},{self.op})"


def imm(v):
    return E("imm", v & 0xFFFF)


def sym(text, t=None):
    return E("sym", text, t=t)


def binop(op, a, b):
    if a.k == "imm" and b.k == "imm":
        x, y = sval(a.a), sval(b.a)
        r = {"+": x + y, "-": x - y, "*": x * y}.get(op)
        if r is not None:
            return imm(r)
    return E("bin", a, b, op)


def sval(v):
    return v - 0x10000 if v & 0x8000 else v


def linear(e):
    """Return (const, {term_text: coef}) for + - *const trees, or None."""
    if e is None:
        return None
    if e.k == "imm":
        return sval(e.a), {}
    if e.k == "bin" and e.op in "+-":
        l, r = linear(e.a), linear(e.b)
        if l is None or r is None:
            return None
        s = 1 if e.op == "+" else -1
        terms = dict(l[1])
        for t, c in r[1].items():
            terms[t] = terms.get(t, 0) + s * c
        return l[0] + s * r[0], {t: c for t, c in terms.items() if c}
    if e.k == "bin" and e.op == "*":
        for x, y in ((e.a, e.b), (e.b, e.a)):
            if y.k == "imm":
                l = linear(x)
                if l is None:
                    return None
                k = sval(y.a)
                return l[0] * k, {t: c * k for t, c in l[1].items()}
        return 0, {render_int(e): 1}
    return 0, {render_int(e): 1}


PREC = {"OR": 1, "AND": 2, "cmp": 3, "+": 4, "-": 4, "MOD": 5, "\\": 6, "*": 7}


def render_int(e, prec=0):
    if e is None:
        return "?"
    if e.k == "imm":
        return str(sval(e.a))
    if e.k == "sym":
        return e.a
    if e.k == "fac":
        return "FAC"
    if e.k == "neg":
        if e.a is not None and e.a.k == "bin" and e.a.op == "-":
            return render_int(E("bin", e.a.b, e.a.a, "-"), prec)
        return "-" + render_int(e.a, 8)
    if e.k == "bin" and e.op in "+-" and e.b is not None and e.b.k == "imm" and sval(e.b.a) < 0:
        op = "-" if e.op == "+" else "+"
        return render_int(E("bin", e.a, imm(-sval(e.b.a)), op), prec)
    if e.k == "cond":
        return e.a
    if e.k == "bin":
        # shortcut: x*const chains read better linearised
        if e.op in "+-*":
            l = linear(e)
            if l is not None and (len(l[1]) > 1 or (l[1] and l[0])):
                pass
        p = PREC[e.op] if e.op in PREC else 3
        s = f"{render_int(e.a, p)} {e.op} {render_int(e.b, p + 1)}"
        return f"({s})" if p < prec else s
    return "?"


# ----------------------------------------------------------------- data model
class Model:
    def __init__(self):
        self.types = {}            # addr -> 'n' | 's' | 'd'
        self.arrays = {}           # (stride-tuple, base) info
        self.stride84 = []         # consts seen with 0x54 stride

    def var_name(self, a, t):
        if a in NAMES:
            return NAMES[a]
        s = ds_string(a)
        if a >= 0x1040 and (t == "s" or s is not None) and s is not None:
            return '"' + s.replace('"', '""') + '"'
        if a >= 0x1040:
            if t == "d":
                return fmt_num(mbf_double(ds_bytes(a, 8)))
            return fmt_num(mbf_single(ds_bytes(a, 4)))
        self.types.setdefault(a, t)
        if (t or self.types.get(a)) == "s":
            return f"S{a:03X}$"
        return f"V{a:03X}"


def mbf_double(b):
    e = b[7]
    if e == 0:
        return 0.0
    sign = -1.0 if b[6] & 0x80 else 1.0
    mant = int.from_bytes(b[:7], "little") | (0x80 << 48)
    return sign * mant / float(1 << 56) * 2.0 ** (e - 128)


def fmt_num(v):
    if v == int(v) and abs(v) < 1e9:
        return str(int(v))
    return repr(round(v, 7))


M = Model()

# array bases discovered in a pre-pass: stride -> sorted list of consts
STRIDE_CONSTS = defaultdict(set)


def array_name(base, t):
    if base in ARRAY_NAMES:
        return ARRAY_NAMES[base]
    return f"{'S' if t == 's' else 'A'}{base:03X}{'$' if t == 's' else ''}"


def ref_text(e, t):
    """Render the value that pointer-expression e points to (type t)."""
    if e is None:
        return "?ptr"
    if e.k == "fac":
        return "FAC"
    if e.k == "sym" and e.t == "ptr":
        return e.a
    if e.k == "sym":
        return e.a  # temp string results etc.
    lin = linear(e)
    if lin is None:
        return f"[{render_int(e)}]"
    c, terms = lin
    if not terms:
        a = c & 0xFFFF
        for base, (ty, size) in ARRAY_BASES.items():
            if base <= a < base + size and a < 0xF1A:
                return f"{array_name(base, ty)}({(a - base) // 4})"
        if c & 0xFFFF in FAC_ADDR:
            return "FAC"
        if c & 0xFFFF in TEMPS:
            return TEMPS[c & 0xFFFF]
        return M.var_name(c & 0xFFFF, t)
    # array element
    strides = sorted(terms.items(), key=lambda kv: kv[1])
    if len(strides) == 1 and strides[0][1] in (4, 8, 2):
        idx, k = strides[0]
        size = 4
        if SEEN_BASES.get(c) != "s": SEEN_BASES[c] = t
        return f"{array_name(c, t)}({idx_text(idx, k // size)})"
    if any(k == 0x54 for _, k in strides):
        consts = sorted(STRIDE_CONSTS[0x54])
        base = consts[0] if consts else c
        first = []
        second = []
        for txt, k in strides:
            if k == 0x54:
                second.append(txt)
            elif k == 4:
                first.append(txt)
            else:
                first.append(f"{txt}*{k}/4")
        col = (c - base) // 4
        i1 = " + ".join(first + ([str(col)] if col or not first else []))
        return f"{array_name(base, t)}({i1}, {' + '.join(second)})"
    return f"[{render_int(e)}]"


def idx_text(txt, mult):
    return txt if mult == 1 else f"{txt}*{mult}"


# ----------------------------------------------------------------- lifting
REGS = ("ax", "bx", "cx", "dx", "si", "di")


class State:
    def __init__(self):
        self.r = {k: None for k in REGS}
        self.fac = None
        self.flags = None   # (kind, a_text, b_text)
        self.mem_ds = None


def cond_text(flags, jcc):
    if flags is None:
        return f"?{jcc}"
    kind, a, b = flags
    if kind == "test":     # value compared against zero
        m = {"je": "=", "jne": "<>", "jb": "<", "jae": ">=", "js": "<", "jns": ">="}
        if jcc in m:
            if a.startswith("(") or " " not in a:
                if jcc == "jne" and is_boolean(a):
                    return a
                if jcc == "je" and is_boolean(a):
                    return f"NOT ({a})"
            return f"{a} {m[jcc]} 0"
    m = {"je": "=", "jne": "<>", "jl": "<", "jb": "<", "jle": "<=", "jbe": "<=",
         "jg": ">", "ja": ">", "jge": ">=", "jae": ">="}
    if jcc in m:
        return f"{a} {m[jcc]} {b}"
    return f"?{jcc}({a},{b})"


def is_boolean(s):
    return any(op in s for op in ("=", "<", ">", " AND ", " OR "))


INVERT = {"je": "jne", "jne": "je", "jl": "jge", "jge": "jl", "jg": "jle", "jle": "jg",
          "jb": "jae", "jae": "jb", "ja": "jbe", "jbe": "ja", "js": "jns", "jns": "js"}

PRINT_ITEMS = {0x2D56: ("n", ","), 0x2D5B: ("d", ","), 0x2D60: ("i", ","), 0x2D65: ("s", ","),
               0x2D6A: ("n", ";"), 0x2D6F: ("d", ";"), 0x2D74: ("i", ";"), 0x2D79: ("s", ";"),
               0x2D7E: ("n", ""), 0x2D83: ("d", ""), 0x2D88: ("i", ""), 0x2D8D: ("s", "")}
OPEN_MODES = {0: '"I"', 1: '"O"', 2: '"R"', 3: '"A"'}


class Lifter:
    def __init__(self):
        self.insns, self.targets = disassemble()
        self.lines = []
        self.refcount = defaultdict(int)
        self.fac_into = {}  # label -> var assigned from FAC at label start
        self.unknown = defaultdict(int)

    # ---- helpers
    def emit(self, s):
        if " = " in s and not s.startswith(("IF", "LSET", "DEF", "ON")):
            lhs, rhs = s.split(" = ", 1)
            if lhs.strip() == rhs.strip():
                return
        self.flush_pending()
        self.lines.append("    " + s)

    def flush_pending(self):
        p = getattr(self, "pending", None)
        if p:
            self.pending = None
            kind, args, extra = p
            if kind == "PRINT":
                txt = ""
                for v, term in args:
                    txt += v + (term if term != "," else ", ")
                ch = f"#{extra}, " if extra is not None else ""
                self.lines.append(f"    PRINT {ch}{txt}".rstrip())
            elif kind == "FIELD":
                self.lines.append(f"    FIELD #{extra}, " + ", ".join(args))
            elif kind == "INPUT#":
                self.lines.append(f"    INPUT #{extra}, " + ", ".join(args))
            else:
                self.lines.append(f"    {kind} " + ", ".join(args))

    def pend(self, kind, item, extra=None):
        p = getattr(self, "pending", None)
        if not p or p[0] != kind:
            self.flush_pending()
            self.pending = (kind, [], extra)
        self.pending[1].append(item)

    def rr(self, st, reg, t):
        return ref_text(st.r[reg], t)

    def ri(self, st, reg):
        return render_int(st.r[reg])

    def label(self, a):
        return f"L{a:04X}"

    # ---- pre-pass: collect array strides and jump references
    def prepass(self):
        for a, i in self.insns.items():
            if i.mnem.startswith("j"):
                try:
                    self.refcount[int(i.ops, 16)] += 1
                except ValueError:
                    pass
            if i.mnem == "add" and i.ops.split(",")[0] in REGS:
                pass
            if i.rt == 0x1C9A:
                self.refcount[struct.unpack("<H", i.inline)[0]] += 1
            if i.rt == 0x1CF1:
                for k in range(i.inline[0]):
                    self.refcount[struct.unpack("<H", i.inline[1 + 2 * k:3 + 2 * k])[0]] += 1
        # 2D array constants: "add reg, imm" following an imul by 0x54
        seq = sorted(self.insns)
        for n, a in enumerate(seq):
            i = self.insns[a]
            if i.mnem == "mov" and i.ops.endswith(", 0x54"):
                for b in seq[n + 1:n + 4]:
                    j = self.insns[b]
                    if j.mnem == "add" and "0x" in j.ops:
                        STRIDE_CONSTS[0x54].add(int(j.ops.split(",")[1], 16))
                        break
        for a in self.insns:
            if a in self.targets:
                self.refcount[a] += 0
        self.refcount[0x1A] += 1
        self.refcount[0x70EC] += 1

    # ---- main
    def run(self):
        self.prepass()
        seq = sorted(self.insns)
        st = State()
        skip = set()
        self.fell = False
        n = 0
        # FOR-loop style: label whose first insns are "mov di,X ; call 10a3" -> FAC flows in
        fac_labels = {}
        for k, a in enumerate(seq):
            i = self.insns[a]
            if a in self.targets and i.mnem == "mov" and i.ops.startswith("di, 0x") and k + 1 < len(seq):
                j = self.insns[seq[k + 1]]
                if j.rt == 0x10A3:
                    fac_labels[a] = int(i.ops.split(",")[1], 16)
        self.fac_labels = fac_labels
        while n < len(seq):
            a = seq[n]
            i = self.insns[a]
            if a in skip:
                n += 1
                continue
            if a in self.targets and self.refcount[a] > 0:
                if a in fac_labels and self.fell:
                    pre = self.fac_flow(a, st)
                    if pre:
                        self.emit(pre)
                self.flush_pending()
                self.lines.append(f"{self.label(a)}:")
                st = State()
                if a in fac_labels:
                    # FAC holds the incoming value for the variable stored here
                    st.fac = sym(M.var_name(fac_labels[a], "n"))
            # boolean idiom: mov R,0 ; jcc X ; dec R ; X:
            if (i.mnem == "mov" and i.ops.endswith(", 0") and n + 2 < len(seq)
                    and self.insns[seq[n + 1]].mnem in INVERT
                    and self.insns[seq[n + 2]].mnem == "dec"):
                j, d = self.insns[seq[n + 1]], self.insns[seq[n + 2]]
                reg = i.ops.split(",")[0]
                if d.ops == reg and int(j.ops, 16) == seq[n + 2] + d.size:
                    c = cond_text(st.flags, INVERT[j.mnem])
                    st.r[reg] = E("cond", f"({c})")
                    self.refcount[int(j.ops, 16)] -= 1
                    n += 3
                    continue
            # IF pattern: jcc A ; jmp B ; A:  ->  IF NOT cond GOTO B
            if i.mnem in INVERT and n + 1 < len(seq):
                j = self.insns[seq[n + 1]]
                tgt = int(i.ops, 16)
                if j.mnem == "jmp" and tgt == seq[n + 1] + j.size:
                    self.refcount[tgt] -= 1
                    c = cond_text(st.flags, INVERT[i.mnem])
                    self.emit_goto_if(c, int(j.ops, 16), st)
                    n += 2
                    continue
            self.step(i, st)
            self.fell = not (i.mnem in ("jmp", "ret", "retf") or i.rt in (0x1CC3, 0x15E7, 0x15DE, 0x1CF1))
            n += 1
        self.flush_pending()

    def emit_goto_if(self, c, tgt, st):
        pre = self.fac_flow(tgt, st)
        if pre:
            self.emit(f"IF {c} THEN {pre} : GOTO {self.label(tgt)}")
        else:
            self.emit(f"IF {c} THEN GOTO {self.label(tgt)}")

    def fac_flow(self, tgt, st):
        if tgt in self.fac_labels and st.fac is not None:
            v = M.var_name(self.fac_labels[tgt], "n")
            f = render_int(st.fac)
            if f != v:
                return f"{v} = {f}"
        return ""

    # ---- instruction semantics
    def step(self, i, st):
        m, ops = i.mnem, [o.strip() for o in i.ops.split(",")] if i.ops else []
        r = st.r

        def val(o):
            if o in r:
                return r[o]
            if o.startswith("0x") or o.lstrip("-").isdigit():
                return imm(int(o, 0))
            if o.startswith("word ptr [bp - 2]"):
                return st.__dict__.get("bpm2")
            return sym(f"?{o}")

        if i.rt is not None:
            return self.call(i, st)
        if m == "mov":
            d, s = ops
            if d in r:
                if s.startswith("byte ptr [bx]"):
                    r[d] = sym(f"PEEK({render_int(r['bx'])})")
                else:
                    r[d] = val(s)
            elif d in ("bl",) and s == "byte ptr [bx]":
                r["bx"] = sym(f"PEEK({render_int(r['bx'])})")
            elif d in ("ds", "bp"):
                pass
            elif d == "byte ptr [bx]" and s == "al":
                self.emit(f"POKE {render_int(r['bx'])}, {render_int(r['ax'])}")
            elif d == "word ptr [bp - 2]":
                st.bpm2 = val(s)
            else:
                self.emit(f"' ?? {m} {i.ops}")
        elif m == "xchg":
            x, y = ops
            r[x], r[y] = val(y), val(x)
        elif m in ("add", "sub", "and", "or", "imul", "idiv"):
            if m in ("imul", "idiv"):
                s = val(ops[0])
                if m == "imul":
                    r["ax"] = binop("*", r["ax"] or sym("?"), s)
                    r["dx"] = None
                else:
                    a_ = r["ax"]
                    r["ax"] = E("bin", a_, s, "\\")
                    r["dx"] = E("bin", a_, s, "MOD")
                return
            d, s = ops
            if d in ("bh",):
                return
            if m in ("and", "or") and d == s:
                st.flags = ("test", render_int(r[d]), "0")
                return
            if s == "word ptr [bp - 2]":
                sv = st.__dict__.get("bpm2")
            else:
                sv = val(s)
            op = {"add": "+", "sub": "-", "and": "AND", "or": "OR"}[m]
            if d in r:
                r[d] = binop(op, r[d] or sym("?"), sv)
            st.flags = ("test", render_int(r.get(d)), "0")
        elif m == "xor":
            d, s = ops
            if d == s:
                r[d] = imm(0)
            elif d == "bh":
                pass
        elif m == "shl":
            r[ops[0]] = binop("*", r[ops[0]] or sym("?"), imm(2))
        elif m == "inc":
            r[ops[0]] = binop("+", r[ops[0]] or sym("?"), imm(1))
        elif m == "dec":
            r[ops[0]] = binop("-", r[ops[0]] or sym("?"), imm(1))
        elif m == "neg":
            r[ops[0]] = E("neg", r[ops[0]])
        elif m == "cdq":
            pass
        elif m == "cmp":
            st.flags = ("cmp", render_int(val(ops[0])), render_int(val(ops[1])))
        elif m == "jmp":
            tgt = int(i.ops, 16)
            pre = self.fac_flow(tgt, st)
            if pre:
                self.emit(pre)
            self.emit(f"GOTO {self.label(tgt)}")
        elif m in INVERT:
            tgt = int(i.ops, 16)
            self.emit_goto_if(cond_text(st.flags, m), tgt, st)
        elif m in ("push", "pop", "nop", "lcall") or m == "sub" or m == "sbb":
            pass
        else:
            self.emit(f"' ?? {m} {i.ops}")

    def call(self, i, st):
        t = i.rt
        r = st.r
        def R(reg, ty="n"):
            v = r[reg]
            if v is not None and (v.k == "fac" or (v.k == "imm" and v.a in FAC_ADDR)):
                return FAC()
            return self.rr(st, reg, ty)
        I = lambda reg: self.ri(st, reg)
        facp = E("fac")
        FAC = lambda: render_int(st.fac) if st.fac is not None else "FAC"
        def setfac(txt):
            st.fac = sym(txt)
        # --- numeric assignment / arithmetic
        if t == 0x10D1:
            TEMPS[0x102A] = FAC()
        elif t == 0x10A6:
            self.emit(f"{R('di')} = {R('si')}")
        elif t == 0x10A3:
            v = R("di")
            self.emit(f"{v} = {FAC()}")
            st.fac = sym(v)
            r["si"] = facp
        elif t == 0x10BD:
            setfac(R("si"))
            r["di"] = facp
        elif t in (0x1772, 0x1767, 0x175D, 0x1752, 0x175A, 0x18AA, 0x189F):
            a = FAC() if t in (0x1767, 0x1752, 0x189F) else R("si")
            b = FAC() if t == 0x175A else R("di")
            op = "+" if t in (0x1772, 0x1767) else "-" if t in (0x175D, 0x1752, 0x175A) else "*"
            if op == "*":
                setfac(f"{wrap(a)} * {wrap(b)}")
            elif op == "-":
                setfac(f"{a} - {wrap(b)}")
            elif b.startswith("-") and " " not in b:
                setfac(f"{a} - {b[1:]}")
            else:
                setfac(f"{a} + {b}")
            if t in (0x1767, 0x1752, 0x189F):
                r["si"] = facp
            if t == 0x175A:
                r["di"] = facp
        elif t in (0x19CE, 0x19C3, 0x19CB, 0x19AA):
            a = FAC() if t in (0x19C3, 0x19AA) else R("si")
            b = FAC() if t == 0x19CB else R("di", "d" if t == 0x19AA else "n")
            st.flags = ("cmp", a, b)
            if t in (0x19C3, 0x19AA):
                r["si"] = facp
            if t == 0x19CB:
                r["di"] = facp
        elif t == 0x26AA:
            st.flags = ("test", R("si"), "0")
        elif t == 0x227F:
            r["bx"] = sym(f"CINT({R('si')})")
        elif t == 0x22CA:
            r["bx"] = sym(f"CINT({FAC()})")
        elif t == 0x2237:
            setfac(I("bx"))
        elif t == 0x2259:
            pass
        elif t == 0x1A00:
            setfac(f"VAL({R('bx', 's')})")
        elif t == 0x273E:
            setfac(f"INT({R('bx')})")
        elif t == 0x2809:
            setfac("RND")
        elif t == 0x0B3B:
            r["bx"] = sym(f"SCREEN({I('bx')}, {I('dx')})")
        elif t == 0x289C:
            r["bx"] = sym(f"STR$({R('bx')})", "str")
        # --- strings
        elif t == 0xF62:
            self.emit(f"{R('dx', 's')} = {R('bx', 's')}")
        elif t == 0xFD2:
            st.flags = ("cmp", R("ax", "s"), R("bx", "s"))
        elif t == 0xF98:
            r["bx"] = sym(f"{R('ax', 's')} + {R('bx', 's')}", "str")
        elif t == 0x2386:
            r["bx"] = sym(f"LEN({R('bx', 's')})")
        elif t == 0x238D:
            r["bx"] = sym(f"ASC({R('bx', 's')})")
        elif t == 0x23BE:
            r["bx"] = sym(f"CHR$({I('bx')})", "str")
        elif t == 0x245E:
            r["bx"] = sym(f"INSTR({R('bx', 's')}, {R('dx', 's')})")
        elif t == 0x246F:
            r["bx"] = sym(f"LEFT$({R('bx', 's')}, {I('dx')})", "str")
        elif t == 0x2478:
            r["bx"] = sym(f"RIGHT$({R('bx', 's')}, {I('dx')})", "str")
        elif t == 0x2486:
            r["bx"] = sym(f"MID$({R('bx', 's')}, {I('dx')}, {I('cx')})", "str")
        elif t == 0x24B5:
            r["bx"] = sym(f"SPACE$({I('bx')})", "str")
        elif t == 0x24DA:
            r["bx"] = sym(f"STRING$({I('bx')}, {I('dx')})", "str")
        elif t == 0x23A1:
            r["bx"] = sym("INKEY$", "str")
        elif t == 0x1739:
            r["bx"] = sym("ERR")
        elif t == 0x2EAC:
            self.emit(f"LSET {R('dx', 's')} = {R('bx', 's')}")
        # --- screen / sound
        elif t == 0x3021:
            self.flush_pending()
            self.pending = ("PRINT", [], None)
        elif t == 0x3039:
            self.flush_pending()
            self.pending = ("PRINT", [], I("bx"))
        elif t in PRINT_ITEMS:
            ty, term = PRINT_ITEMS[t]
            v = R("bx", "s" if ty == "s" else "n")
            p = getattr(self, "pending", None)
            if not p or p[0] != "PRINT":
                self.flush_pending()
                self.pending = ("PRINT", [], None)
            self.pending[1].append((v, term))
            if term == "":
                self.flush_pending()
        elif t in (0xFFD, 0x1017, 0x100B):
            self.pend("LOCATE", "" if t == 0x100B else arg(st.r["bx"]))
            if t == 0x1017:
                self.flush_pending()
        elif t in (0xA3F, 0xA59):
            self.pend("SCREEN", arg(st.r["bx"]))
            if t == 0xA59:
                self.flush_pending()
        elif t == 0x820:
            self.pend("COLOR", arg(st.r["bx"]))
            self.flush_pending()
        elif t == 0x789:
            self.emit("CLS")
        elif t == 0x300B:
            self.emit(f"WIDTH {I('bx')}")
        elif t == 0x8EA:
            self.emit({0: "KEY OFF", 1: "KEY ON", 2: "KEY LIST"}.get(sval(r["bx"].a) if r["bx"] and r["bx"].k == "imm" else -1, f"KEY {I('bx')}"))
        elif t == 0x635:
            self.emit(f"SOUND {I('bx')}, {R('dx')}")
        elif t == 0x627:
            self.emit("BEEP")
        elif t == 0x2A83:
            self.emit(f"PLAY {R('bx', 's')}")
        elif t == 0x13C9:
            self.emit(f"DEF SEG = {I('bx')}")
        # --- files
        elif t == 0x2136:
            pass  # filename normalisation; bx unchanged
        elif t == 0xD15:
            st.open_mode = OPEN_MODES.get(sval(r["bx"].a) if r["bx"] and r["bx"].k == "imm" else -1, I("bx"))
        elif t == 0xD24:
            ln = I("cx")
            self.emit(f"OPEN {getattr(st, 'open_mode', '?')}, #{I('bx')}, {R('dx', 's')}" + (f", {ln}" if ln != "0" else ""))
        elif t == 0xCCB:
            self.emit(f"GET #{I('bx')}, {I('dx')}")
        elif t == 0xCD5:
            self.emit(f"PUT #{I('bx')}, {I('dx')}")
        elif t == 0xC8F:
            self.emit(f"CLOSE #{I('bx')}")
        elif t == 0xC9F:
            self.emit("CLOSE")
        elif t == 0xC74:
            r["bx"] = sym(f"EOF({I('bx')})")
        elif t == 0x21A7:
            self.emit(f"KILL {R('bx', 's')}")
        elif t == 0x2ED8:
            self.flush_pending()
            self.pending = ("FIELD", [], I("bx"))
        elif t == 0x2EFA:
            self.pend("FIELD", f"{I('dx')} AS {R('bx', 's')}", None)
        elif t == 0x29BE:
            self.flush_pending()
            self.pending = ("INPUT#", [], I("bx"))
        elif t == 0x2C3D:
            st.input_types = list(i.inline[1:])
        elif t == 0x2D04:
            tl = getattr(st, "input_types", [])
            ty = tl.pop(0) if tl else 4
            self.pend("INPUT#", R("bx", "s" if ty == 7 else "n"), None)
        elif t == 0x2972:
            self.flush_pending()
            st.input_prompt = R("bx", "s")
        elif t == 0x259C:
            p = getattr(st, "input_prompt", '""')
            self.emit(f"INPUT {p}; {R('bx', 's')}" if p != '""' else f"INPUT \"\", {R('bx', 's')}")
        elif t in (0x25FA, 0x260F):
            self.pend("READ", R("bx", "s" if t == 0x260F else "n"))
        # --- control
        elif t == 0x1C9A:
            self.emit(f"GOSUB {self.label(struct.unpack('<H', i.inline)[0])}")
            st.__init__()
        elif t == 0x1CC3:
            self.emit("RETURN")
        elif t == 0x1CF1:
            tg = [self.label(struct.unpack("<H", i.inline[1 + 2 * k:3 + 2 * k])[0]) for k in range(i.inline[0])]
            self.emit(f"ON {I('bx')} GOTO {', '.join(tg)}")
        elif t == 0x16BC:
            self.emit(f"ON ERROR GOTO {self.label(st.r['bx'].a) if st.r['bx'] and st.r['bx'].k == 'imm' else I('bx')}")
        elif t == 0x13DB:
            self.emit("RANDOMIZE")
        elif t == 0x15E7:
            self.emit("END")
        elif t == 0x15DE:
            self.emit("' (end of error handler: 'No RESUME')")
        elif t == 0x2582:
            self.emit("' program start")
        else:
            self.unknown[t] += 1
            self.emit(f"CALL RT_{t:04X}  ' bx={I('bx')} dx={I('dx')} si={R('si')} di={R('di')}")


def strip_cint(s):
    """Drop compiler-inserted CINT() conversions (implicit in BASIC source)."""
    while True:
        k = s.find("CINT(")
        if k < 0:
            return s
        d, j = 0, k + 4
        for j in range(k + 4, len(s)):
            d += {"(": 1, ")": -1}.get(s[j], 0)
            if d == 0:
                break
        s = s[:k] + s[k + 5:j] + s[j + 1:]


def arg(e):
    if e is None:
        return "?"
    if e.k == "imm" and (e.a & 0xFF00) and not (e.a & 0x8000 and e.a > 0xFF00):
        return ""
    return render_int(e)


def wrap(s):
    return f"({s})" if (" + " in s or " - " in s) else s


def main():
    names = Path(__file__).with_name("names.json")
    if names.exists():
        j = json.loads(names.read_text())
        NAMES.update({int(k, 16): v for k, v in j.get("vars", {}).items()})
        ARRAY_NAMES.update({int(k, 16): v for k, v in j.get("arrays", {}).items()})
    L = Lifter()
    L.run()
    # second pass with 1-D array extents known (arrays are packed, 4 bytes/element)
    bases = sorted(SEEN_BASES)
    ends = bases[1:] + [0xF1A]
    for b, e in zip(bases, ends):
        ARRAY_BASES[b] = (SEEN_BASES[b], e - b)
    TEMPS.clear(); M.types.clear()
    L = Lifter()
    L.run()
    out = sys.stdout
    out.write("' CASTLE.EXE (1984, Kevin Bales) - lifted from IBM BASIC Compiler 1.0 output\n")
    out.write("' Labels are code addresses. V/S names are DS addresses (V=number, S=string$).\n\n")
    for ln in L.lines:
        out.write(strip_cint(ln) + "\n")
    if L.unknown:
        print("unknown runtime calls:", {hex(k): v for k, v in L.unknown.items()}, file=sys.stderr)


if __name__ == "__main__":
    main()
