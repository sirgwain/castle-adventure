"""Export the DATA statements (22 objects, 10 monsters) from CASTLE.EXE to JSON."""
import json, re, sys
from pathlib import Path
from exe import IMG, DS_BASE

# CP437 display glyphs for control codes (what the IBM PC shows on screen)
LOW = " ☺☻♥♦♣♠•◘○◙♂♀♪♫☼►◄↕‼¶§▬↨↑↓→←∟↔▲▼"


def glyph(c):
    return LOW[c] if c < 32 else "⌂" if c == 127 else bytes([c]).decode("cp437")


ds = IMG[DS_BASE:]
start = ds.find(b'17,"LAMP"')
end = ds.find(b'"FAIRY"', start)
end = ds.find(b'\x00', end)
blob = ds[start:end].decode("cp437")
items = re.findall(r'"([^"]*)"|(-?\d+)', blob)
vals = [s if s else int(n) for s, n in items]
objs = []
for k in range(22):
    room, name, ch, row, col = vals[k * 5:(k + 1) * 5]
    objs.append({"id": k + 1, "name": name, "room": room, "char": ch, "glyph": glyph(ch),
                 "row": row, "col": col,
                 "hidden": room > 100, "start_room": room - 100 if room > 100 else room})
mons = []
rest = vals[110:]
for k in range(10):
    room, name, ch, row, col, hp = rest[k * 6:(k + 1) * 6]
    mons.append({"id": k + 1, "name": name, "room": room, "char": ch, "glyph": glyph(ch),
                 "row": row, "col": col, "hp": hp})
out = Path(sys.argv[1])
out.write_text(json.dumps({"objects": objs, "monsters": mons}, ensure_ascii=False, indent=1) + "\n", encoding="utf-8")
for o in objs: print(o)
for m in mons: print(m)
