"""Turn the lifter's flat item list into structured, readable BASIC.

Items from lift.py:
  ("label", addr)  ("stmt", text)  ("goto", addr)  ("gosub", addr)
  ("if", jump_cond, negated_cond, addr, pre)  ("on", expr, [addr...])  ("onerror", addr)
Structured nodes added here:
  ("for", var, start, limit, body)  ("ifblock", cond, then_items, else_items_or_None)

Passes (repeated until nothing changes): FOR/NEXT loops, IF ... END IF and
IF ... ELSE ... END IF blocks, removal of GOTOs to the next line and of labels
nothing jumps to.  Remaining labels get descriptive names.
"""
import re
from collections import Counter

# Hand-picked names for the important entry points (code address -> name).
LABEL_NAMES = {
    0x001A: "Start", 0x0039: "NewGame", 0x023E: "LoadRoomPage", 0x0469: "DrawRoom",
    0x0BFD: "InputLoop", 0x0C83: "WaitKey", 0x0CB1: "ReadKey", 0x103E: "MovePlayer",
    0x123C: "TakeExit", 0x142D: "DoCommand", 0x18A5: "NotUnderstood", 0x1911: "Bump",
    0x1B42: "PickUpBumped", 0x1BD7: "ShowMessage", 0x1CB8: "MonsterTurn",
    0x1D02: "MonsterTurnNext", 0x1D24: "MonsterStep",
    0x1F1B: "MonsterAttacks", 0x20BF: "PlayerAttacks", 0x22EA: "CmdLook",
    0x2756: "LookMonster", 0x2854: "LookObject", 0x3670: "CmdDrop", 0x3769: "DropHere",
    0x38D5: "CmdGet", 0x3B6F: "GetMonsterCheck", 0x3C13: "TooHeavy", 0x3F61: "GetObject",
    0x41C5: "GetLiquid", 0x43E5: "CmdInventory", 0x44EC: "CmdWear", 0x46EA: "CmdPlay",
    0x48F6: "CmdWave", 0x499C: "DontHaveIt", 0x4ADD: "WaveWand", 0x4C24: "SecretPassage",
    0x4C94: "WaveScepter", 0x4D53: "CmdClean", 0x4EB5: "CmdSay", 0x4EEA: "MonstersReact",
    0x4FE1: "CmdLockUnlock", 0x504B: "UseGate", 0x50D7: "UseDoor", 0x521F: "DoorRoom68",
    0x5375: "DoorRoom82", 0x5509: "CmdRead", 0x55E4: "CmdJump", 0x568A: "TrapRoom76",
    0x57DF: "TrapRoom78", 0x579A: "Drowned", 0x58F2: "CmdDrink", 0x5A04: "CmdPour",
    0x5AF4: "CmdPet", 0x5C28: "CmdKill", 0x5D46: "CmdShow", 0x5F75: "HighScoreWall",
    0x601E: "CmdSave", 0x61A0: "CmdLoad", 0x6221: "LoadFile", 0x63B0: "PlayerDied",
    0x653F: "Escaped", 0x6577: "FinalScore", 0x6A38: "Quit", 0x6A42: "NewHighScore",
    0x6B05: "SaveHighScore", 0x6B39: "TitleScreen", 0x6D47: "TitleMenu",
    0x6F44: "FreewareNotice", 0x70EC: "ErrorHandler",
    0x0FA8: "Uppercase", 0x126E: "ExitDigits", 0x1CC3: "MonsterLoop", 0x1D0D: "MonsterLoopTest",
    0x3B06: "GetMonsterLoop", 0x3BE3: "GetMonsterLoopTest", 0x4164: "TakeHidden",
    0x44AE: "InventoryDone", 0x45C7: "WearIt", 0x47C5: "PlayIt", 0x49D1: "WaveIt",
    0x4C5E: "WaveWandRoom77", 0x6D64: "TitleMenuKey", 0x4E2E: "CleanIt", 0x4F36: "MonsterLooksFunny", 0x5E48: "ShowIt",
}
# Object names (DATA order) for the LOOK ... ON I GOTO table.
OBJECTS = ["Lamp", "Harp", "Necklace", "Book", "Wand", "Sword", "Key", "Glasses", "Ball",
           "Helmet", "Flask", "Cross", "Diamond", "Bars", "Rubys", "Figurine", "Scepter",
           "Hourglass", "Gem", "Goldbar", "Goblet", "Crown"]


# ------------------------------------------------------------------ references
def walk(items):
    for it in items:
        yield it
        if it[0] == "for":
            yield from walk(it[4])
        elif it[0] == "doloop":
            yield from walk(it[1])
        elif it[0] == "ifblock":
            yield from walk(it[2])
            if it[3]:
                yield from walk(it[3])


def targets(it):
    k = it[0]
    if k in ("goto", "gosub", "onerror"):
        return [it[1]]
    if k == "if":
        return [it[3]]
    if k == "on":
        return list(it[2])
    return []


def refcounts(items):
    c = Counter()
    for it in walk(items):
        for t in targets(it):
            c[t] += 1
    c[0x001A] += 1
    return c


def self_contained(region, refs):
    """True if every label defined in region is referenced only from inside region."""
    local = refcounts(region)
    local[0x001A] -= 1
    for it in walk(region):
        if it[0] == "label" and local[it[1]] != refs[it[1]]:
            return False
    return True


def find_label(items, addr, start):
    for m in range(start, len(items)):
        if items[m] == ("label", addr):
            return m
    return -1


# ------------------------------------------------------------------ passes
ASSIGN = re.compile(r"^(\w+) = (.+)$")


def pass_for(items, refs):
    for i in range(len(items) - 2):
        a, g, b = items[i], items[i + 1], items[i + 2]
        if not (a[0] == "stmt" and g[0] == "goto" and b[0] == "label"):
            continue
        m = ASSIGN.match(a[1])
        if not m:
            continue
        var, start = m.groups()
        t = find_label(items, g[1], i + 3)
        if t < 0 or t + 1 >= len(items):
            continue
        test = items[t + 1]
        if not (test[0] == "if" and test[3] == b[1] and not test[4]):
            continue
        mt = re.match(rf"^{re.escape(var)} <= (.+)$", test[1])
        inc = items[t - 1]
        if not mt or inc != ("stmt", f"{var} = {var} + 1"):
            continue
        if refs[b[1]] != 1 or refs[g[1]] != 1:
            continue
        body = items[i + 3:t - 1]
        if not self_contained(body, refs):
            continue
        items[i:t + 2] = [("for", var, start, mt.group(1), body)]
        return True
    return False


def pass_if(items, refs):
    # Prefer the IF with the shortest forward span so nested "IF a THEN IF b THEN"
    # chains (several IFs jumping to one label) are built inside-out.
    best = None
    for k, it in enumerate(items):
        if it[0] != "if" or it[4]:
            continue
        m = find_label(items, it[3], k + 1)
        if m < 0 or not self_contained(items[k + 1:m], refs):
            continue
        if best is None or m - k < best[1] - best[0]:
            best = (k, m)
    if best is None:
        return False
    k, m = best
    it = items[k]
    then = items[k + 1:m]
    # IF ... ELSE ... END IF:  then-part ends in GOTO Y, label X used only here
    if then and then[-1][0] == "goto" and refs[it[3]] == 1:
        p = find_label(items, then[-1][1], m + 1)
        if p > 0:
            els = items[m + 1:p]
            joins = sum(1 for x in walk(els) if then[-1][1] in targets(x))
            ends_jump = els and (els[-1][0] == "goto" or els[-1] in (("stmt", "RETURN"), ("stmt", "END")))
            if els and self_contained(els, refs) and joins == 0 and not ends_jump:
                items[k:p] = [("ifblock", it[2], then[:-1], els)]
                return True
    items[k:m] = [("ifblock", it[2], then, None)]
    return True


def pass_loop(items, refs):
    """label X ... IF c THEN GOTO X  ->  DO ... LOOP WHILE c"""
    for i, it in enumerate(items):
        if it[0] != "label" or refs[it[1]] != 1:
            continue
        for j in range(i + 1, len(items)):
            x = items[j]
            if x[0] == "label":
                break
            if x[0] == "if" and x[3] == it[1] and not x[4]:
                body = items[i + 1:j]
                if self_contained(body, refs):
                    items[i:j + 1] = [("doloop", body, x[1])]
                    return True
                break
    return False


def pass_cleanup(items, refs):
    changed = False
    out = []
    for n, it in enumerate(items):
        if it[0] == "label" and refs[it[1]] == 0:
            changed = True
            continue
        if it[0] == "goto" and n + 1 < len(items) and items[n + 1] == ("label", it[1]):
            refs[it[1]] -= 1
            changed = True
            continue
        if it[0] == "for":
            changed |= pass_cleanup(it[4], refs)
        if it[0] == "doloop":
            changed |= pass_cleanup(it[1], refs)
        if it[0] == "ifblock":
            changed |= pass_cleanup(it[2], refs)
            if it[3]:
                changed |= pass_cleanup(it[3], refs)
        out.append(it)
    items[:] = out
    return changed


def structure(items):
    items = list(items)
    while True:
        refs = refcounts(items)
        changed = pass_cleanup(items, refs)
        refs = refcounts(items)
        if not changed:
            changed = (run_nested(items, refs, pass_for) or run_nested(items, refs, pass_loop)
                       or run_nested(items, refs, pass_if))
        if not changed:
            return items


def run_nested(items, refs, fn):
    if fn(items, refs):
        return True
    for it in items:
        if it[0] == "for" and run_nested(it[4], refs, fn):
            return True
        if it[0] == "doloop" and run_nested(it[1], refs, fn):
            return True
        if it[0] == "ifblock":
            if run_nested(it[2], refs, fn) or (it[3] and run_nested(it[3], refs, fn)):
                return True
    return False


# ------------------------------------------------------------------ naming
def name_labels(items):
    names = dict(LABEL_NAMES)
    for it in walk(items):
        if it[0] == "on" and len(it[2]) == len(OBJECTS):
            for obj, t in zip(OBJECTS, it[2]):
                names.setdefault(t, f"Desc{obj}")
    section = "Start"
    counters = Counter()
    for it in walk(items):
        if it[0] == "if" and it[3] not in names:
            nouns = re.findall(r'(?:NOUN|VERB)\$ = "(\w+)"', it[1])
            if nouns and "NOT" not in it[1]:
                names[it[3]] = f"{section}{nouns[-1].title()}"
        if it[0] == "label":
            if it[1] in names:
                section = names[it[1]]
            else:
                counters[section] += 1
                names[it[1]] = f"{section}{counters[section]}"
                # keep later numbering inside the same section
    # make names unique
    seen = Counter()
    for a in sorted(names):
        seen[names[a]] += 1
        if seen[names[a]] > 1:
            names[a] = f"{names[a]}{seen[names[a]]}"
    return names


# ------------------------------------------------------------------ rendering
def strip_parens(c):
    while c.startswith("(") and c.endswith(")"):
        d = 0
        for n, ch in enumerate(c):
            d += {"(": 1, ")": -1}.get(ch, 0)
            if d == 0 and n < len(c) - 1:
                return c
        c = c[1:-1]
    return c


INV_OP = {"=": "<>", "<>": "=", "<": ">=", ">=": "<", ">": "<=", "<=": ">"}


def split_top(c):
    """Split 'A OP B' at the top-level AND/OR; returns (op, [operands]) or (None, [c])."""
    d = 0
    for n in range(len(c)):
        d += {"(": 1, ")": -1}.get(c[n], 0)
        if d == 0:
            for op in (" AND ", " OR "):
                if c.startswith(op, n):
                    return op.strip(), [c[:n], c[n + len(op):]]
    return None, [c]


def negate(c):
    c = strip_parens(c)
    if c.startswith("NOT (") and strip_parens(c[4:]) != c[4:]:
        return strip_parens(c[4:])
    op, parts = split_top(c)
    if op:
        other = "OR" if op == "AND" else "AND"
        return f" {other} ".join(paren(negate(p)) for p in parts)
    m = re.match(r"^(.+?) (<>|<=|>=|=|<|>) (.+)$", c)
    if m and not split_top(m.group(3))[0]:
        return f"{m.group(1)} {INV_OP[m.group(2)]} {m.group(3)}"
    return f"NOT ({c})"


def paren(c):
    return f"({c})" if split_top(c)[0] else c


def tidy(c):
    """Readable condition: apply De Morgan to NOT (...) and drop needless parentheses."""
    c = strip_parens(c)
    if c.startswith("NOT (") and strip_parens(c[4:]) != c[4:]:
        return tidy_tree(negate(c[4:]))
    return tidy_tree(c)


def tidy_tree(c):
    op, parts = split_top(strip_parens(c))
    if not op:
        return strip_parens(c)
    flat = []
    for p in parts:
        p = strip_parens(p)
        o2, _ = split_top(p)
        flat.append(tidy_tree(p) if o2 == op else paren(tidy_tree(p)))
    return f" {op} ".join(flat)


def render(items, names, indent=1):
    pad = "    " * indent
    out = []
    lab = lambda a: names.get(a, f"L{a:04X}")
    for it in items:
        k = it[0]
        if k == "label":
            out.append(f"\n{lab(it[1])}:" + " " * max(1, 28 - len(lab(it[1]))) + f"' @{it[1]:04X}")
        elif k == "stmt":
            out.append(pad + it[1])
        elif k == "goto":
            out.append(pad + f"GOTO {lab(it[1])}")
        elif k == "gosub":
            out.append(pad + f"GOSUB {lab(it[1])}")
        elif k == "onerror":
            out.append(pad + f"ON ERROR GOTO {lab(it[1])}")
        elif k == "on":
            out.append(pad + f"ON {it[1]} GOTO " + ", ".join(lab(t) for t in it[2]))
        elif k == "if":
            pre = f"{it[4]} : " if it[4] else ""
            out.append(pad + f"IF {tidy(it[1])} THEN {pre}GOTO {lab(it[3])}")
        elif k == "for":
            out.append(pad + f"FOR {it[1]} = {it[2]} TO {it[3]}")
            out += render(it[4], names, indent + 1)
            out.append(pad + f"NEXT {it[1]}")
        elif k == "doloop":
            if not it[1]:
                out.append(pad + f"DO WHILE {tidy(it[2])}: LOOP")
            else:
                out.append(pad + "DO")
                out += render(it[1], names, indent + 1)
                out.append(pad + f"LOOP WHILE {tidy(it[2])}")
        elif k == "ifblock":
            cond, then, els = tidy(it[1]), it[2], it[3]
            simple = len(then) == 1 and then[0][0] in ("stmt", "goto") and not els
            if simple:
                body = render(then, names, 0)[0]
                if len(pad) + len(cond) + len(body) < 110:
                    out.append(pad + f"IF {cond} THEN {body}")
                    continue
            out.append(pad + f"IF {cond} THEN")
            out += render(then, names, indent + 1)
            if els:
                out.append(pad + "ELSE")
                out += render(els, names, indent + 1)
            out.append(pad + "END IF")
    return out


HEADER = """' CASTLE ADVENTURE (1984, Kevin Bales)
' Decompiled from CASTLE.EXE (IBM BASIC Compiler 1.0) by tools/lift.py + tools/structure.py.
' Loops and IF blocks are reconstructed; the remaining labels are named after what they do,
' and the trailing ' @XXXX is the code address (see castle_flat.bas / castle.asm).
"""


def render_structured(items):
    s = structure(items)
    names = name_labels(s)
    return HEADER + "\n".join(render(s, names)).lstrip("\n") + "\n"


def render_flat(items):
    names = {a: f"L{a:04X}" for it in items for a in targets(it) + ([it[1]] if it[0] == "label" else [])}
    refs = refcounts(items)
    flat = [it for it in items if not (it[0] == "label" and refs[it[1]] == 0)]
    return ("' CASTLE.EXE - flat lift; labels are code addresses (matches castle.asm)\n"
            + "\n".join(render(flat, names)).lstrip("\n") + "\n")
