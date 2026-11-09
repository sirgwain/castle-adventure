#!/usr/bin/env python3
"""One-time export of the original game data into editable level JSON files.

Reads out/rooms.json (CASTLE.RAN), out/objects_monsters.json (the DATA tables in
CASTLE.EXE) and out/atlas.json (floor numbers), adds the rules the original
hard-coded (dark rooms, doors, traps, wand and scepter effects, arrivals, the
fairy's spawn points), and writes internal/castle/levels/floor_<n>.json.

After this the JSON files are the source of truth; edit them directly.
Rows and columns are 1-based, as in the original (LOCATE row, col).
"""
import json
from collections import defaultdict
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
OUT = ROOT / "out"
LEVELS = ROOT / "internal" / "castle" / "levels"

FLOOR_NAMES = {-1: "Cellars and Dungeon", 0: "Ground Floor", 1: "Upper Floor",
               2: "Coloured Rooms and Upper Battlements", 3: "Castle Walls and King's Quarters",
               4: "Towers", 5: "Tower Tops"}

# Item ids (the noun the player types, lower-case), LOOK text, treasure flag.
GOLD = ["It's made of", "Gold!"]
PRICEY = ["It looks", "Expensive!"]
ITEMS = [
    ("lamp", ["It's lit", "Magically"], False),
    ("harp", GOLD, True),
    ("necklace", ["On the back", "it says:", "", "Protection from", "Traps."], True),
    ("book", ["It is titled", "`The Gate'"], False),
    ("wand", ["It looks", "Magical!"], False),
    ("sword", ["It looks", "Sharp!"], False),
    ("key", ["It looks Old!"], False),
    ("glasses", ["They're", "Bifocals"], False),
    ("ball", ["In the Cyrstal", "Ball....", "", "You see a man", "in a winding", "passage,waving", "a Wand."], False),
    ("helmet", ["It looks", "Tough!"], False),
    ("flask", None, False),  # empty or full: decided by the game
    ("cross", GOLD, True),
    ("diamond", PRICEY, True),
    ("bars", ["They look", "Expensive!"], True),
    ("rubys", ["They look", "Expensive!"], True),
    ("figurine", PRICEY, True),
    ("scepter", PRICEY, True),
    ("hourglass", GOLD, True),
    ("gem", PRICEY, True),
    ("goldbar", PRICEY, True),
    ("goblet", GOLD, True),
    ("crown", GOLD, True),
]
MONSTER_IDS = ["ogre1", "ogre2", "demon1", "demon2", "bigspider", "smallspider", "bat", "snake", "vampire", "fairy"]
MONSTER_KIND = {"vampire": "vampire", "fairy": "fairy"}
# CP437 codes the original stored in a hidden item's row/col: the furniture it is hidden in
HIDE_GLYPH = {196: "─", 179: "│", 219: "█"}

WAVE_MSG = ["As you wave the", "WAND....", "", "There is a", "*Puff* of smoke", "Revealing a", "Secret passage!"]
PASSAGE_77 = [{"row": 18, "col": 11, "text": "▌  ▐"}]
RULES = {
    1: {"onWave": [{"item": "scepter", "edits": [{"row": 18, "col": 11, "text": "    "}],
                    "message": ["As you wave the", "scepter...", "", "The Gate opens", "by itself!"]}]},
    52: {"spawns": [{"monster": "fairy", "row": 10, "col": 1, "unlessFrom": 57}]},
    54: {"spawns": [{"monster": "fairy", "row": 1, "col": 12, "unlessFrom": 57}]},
    67: {"onArrive": [{"from": 66, "row": 10, "col": 17,
                       "message": ["There is a puff", "of smoke & you", "appear in the", "Sorcerers room!"]}],
         "onWave": [{"item": "wand",
                     "edits": [{"row": r, "col": 19, "text": " "} for r in range(7, 13)] +
                              [{"row": 8, "col": 20, "text": "▓▓▓▓▓"}, {"row": 11, "col": 20, "text": "▓▓▓▓▓"},
                               {"row": 9, "col": 20, "text": " "}, {"row": 10, "col": 20, "text": " "}],
                     "message": WAVE_MSG}]},
    68: {"dark": True, "doors": [{"row": 15, "col": 9}, {"row": 15, "col": 10}]},
    76: {"traps": [{"cells": [[13, 15], [14, 15]],
                    "flood": [{"row": r, "col": c, "text": "▓"} for r in (13, 14) for c in (11, 17)] +
                             [{"row": r, "col": 12, "text": "░░░░░"} for r in (13, 14)]}]},
    77: {"onArrive": [{"from": 83, "edits": PASSAGE_77}],
         "onWave": [{"item": "wand", "edits": PASSAGE_77, "message": WAVE_MSG}]},
    78: {"traps": [{"cells": [[9, 18], [10, 18]],
                    "flood": [{"row": r, "col": c, "text": "▓"} for r in (9, 10) for c in (12, 24)] +
                             [{"row": r, "col": 13, "text": "░" * 11} for r in (9, 10)]}]},
    82: {"doors": [{"row": 9, "col": 14}, {"row": 10, "col": 14}]},
    83: {"dark": True},
}


# The original wrapped descriptions at exactly 25 columns, often with no space at
# the break ("top of theWest tower"). Joining the lines with a space fixes that;
# these are the only words that were split across a break.
SPLIT_WORDS = {8: [("door ways", "doorways"), ("arch ways", "archways")]}


def fix_description(rid, text):
    for a, b in SPLIT_WORDS.get(rid, []):
        text = text.replace(a, b)
    return text


def main():
    rooms = json.loads((OUT / "rooms.json").read_text())["rooms"]
    om = json.loads((OUT / "objects_monsters.json").read_text())
    atlas = json.loads((OUT / "atlas.json").read_text())
    floor_of = {int(rid): a["floor"] for a in atlas["areas"] for rid in a["rooms"]}
    names = {int(rid): a for a in atlas["areas"] for rid in a["rooms"]}
    import re
    name_re = re.compile(r"^You(?:'re| are)\s+(?:in|on|at)?\s*(?:(?:the|an|a)\s+)?(.*?)[.!,]", re.I)

    items_in, monsters_in = defaultdict(list), defaultdict(list)
    for o, (iid, look, treasure) in zip(om["objects"], ITEMS):
        hidden = o["room"] > 100
        item = {"id": iid, "name": o["name"], "glyph": o["glyph"]}
        if hidden:
            item["hiddenIn"] = "".join(sorted({HIDE_GLYPH[o["row"]], HIDE_GLYPH[o["col"]]}))
        else:
            item["row"], item["col"] = o["row"], o["col"]
        if look:
            item["look"] = look
        if treasure:
            item["treasure"] = True
        items_in[o["room"] - 100 if hidden else o["room"]].append(item)
    for m, mid in zip(om["monsters"], MONSTER_IDS):
        mon = {"id": mid, "name": m["name"], "glyph": m["glyph"], "kind": MONSTER_KIND.get(mid, "fighter"),
               "hp": m["hp"]}
        if m["room"] == 0:  # the fairy: placed by the spawns of rooms 52 and 54
            mon["start"] = False
            monsters_in[52].append(mon)
        else:
            mon["row"], mon["col"] = m["row"], m["col"]
            monsters_in[m["room"]].append(mon)

    floors = defaultdict(list)
    for r in rooms:
        rid = r["id"]
        m = name_re.match(r["description"])
        room = {"id": rid,
                "name": (m.group(1)[:1].upper() + m.group(1)[1:]) if m else f"Room {rid}",
                "area": names[rid]["name"],
                "description": fix_description(rid, r["description"]),
                "exits": {d: r["exits"][d] for d in "NSEWUD" if d in r["exits"]},
                "map": r["map"]}
        room.update(RULES.get(rid, {}))
        if items_in[rid]:
            room["items"] = items_in[rid]
        if monsters_in[rid]:
            room["monsters"] = monsters_in[rid]
        floors[floor_of[rid]].append(room)

    LEVELS.mkdir(parents=True, exist_ok=True)
    for f, rs in sorted(floors.items()):
        doc = {"floor": f, "name": FLOOR_NAMES[f], "rooms": rs}
        if f == 0:
            doc["start"] = {"room": 1, "row": 15, "col": 15}
        path = LEVELS / f"floor_{f}.json"
        path.write_text(dump(doc) + "\n", encoding="utf-8")
        print(f"{path.relative_to(ROOT)}: {len(rs)} rooms")


def dump(doc):
    """JSON with one map row per line, so the maps are easy to edit by eye."""
    text = json.dumps(doc, ensure_ascii=False, indent=2)
    # collapse short leaf arrays/objects onto one line
    import re
    text = re.sub(r"\{\n\s+(\"row\": \d+),\n\s+(\"col\": \d+)(,\n\s+(\"text\": \"[^\"]*\"))?\n\s+\}",
                  lambda m: "{" + m.group(1) + ", " + m.group(2) + (", " + m.group(4) if m.group(4) else "") + "}", text)
    text = re.sub(r"\[\n\s+(\d+),\n\s+(\d+)\n\s+\]", r"[\1, \2]", text)
    text = re.sub(r"\{\n\s+(\"monster\": \"\w+\"),\n\s+(\"row\": \d+),\n\s+(\"col\": \d+),\n\s+(\"unlessFrom\": \d+)\n\s+\}",
                  r"{\1, \2, \3, \4}", text)
    return text


if __name__ == "__main__":
    main()
