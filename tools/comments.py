"""Comments for the structured listing: a BASIC primer, a variable glossary,
per-section descriptions, and automatic end-of-line notes."""
import json
import re
from pathlib import Path

OUT = Path(__file__).resolve().parent.parent / "out"

PRIMER = r"""
' ============================================================================
'  A SHORT BASIC PRIMER (only what this program uses)
' ============================================================================
'  Syntax
'    X = 5            assignment.  In an IF, "=" is a comparison instead.
'    <> <= >= < >     not equal, less-or-equal, ...   AND OR NOT are logical.
'    A \ B            integer division.   A MOD B  remainder.
'    NAME$            a "$" suffix means a string variable; no suffix = number.
'    A(I), R$(I, J)   arrays (1-based by convention here; element 0 exists).
'    ' text           a comment.  "&" is not concatenation; "+" joins strings.
'    Variables need no declaration and start as 0 / "".
'
'  Control flow
'    IF c THEN stmt                     one-line IF
'    IF c THEN ... ELSE ... END IF      block IF
'    FOR I = 1 TO 22 ... NEXT I         counts 1,2,...,22 (both ends inclusive)
'    DO ... LOOP WHILE c                repeat while c is true
'    GOTO Label                         jump.  Labels end in ":".
'    GOSUB Label ... RETURN             call a subroutine and come back
'    ON N GOTO A, B, C                  jump table: N=1 -> A, N=2 -> B, ...
'    END                                stop the program
'
'  Text screen (WIDTH 40 = 40 columns x 25 rows; row 1, column 1 is top-left)
'    CLS                   clear the screen
'    LOCATE row, col       move the text cursor; the next PRINT starts there.
'                          e.g. LOCATE I, 25 : PRINT "|" draws "|" at row I,
'                          column 25.  A 3rd argument shows (1) or hides (0)
'                          the blinking cursor; LOCATE , , 0 only hides it.
'    PRINT a; b            print values.  ";" = no gap, cursor stays put;
'                          "," = jump to the next 14-column zone;
'                          no trailing ";" or "," = move to the next line.
'    COLOR 7 / COLOR 23    normal white / blinking white (16 + 7)
'    SCREEN(row, col)      FUNCTION: the character code shown at that spot.
'                          The game uses the screen itself as its collision
'                          map: walls, doors, items and monsters are found by
'                          reading characters back off the screen.
'    SCREEN 0, 0, 0, 1     STATEMENT (no parentheses): text video mode setup.
'    CHR$(n) / ASC(s$)     character for code n / code of the first character.
'                          Codes are IBM PC "code page 437": CHR$(5) is the
'                          player (a club), CHR$(8) a locked door, 32 a space.
'    KEY OFF               hide the function-key bar on row 25.
'
'  Strings (positions start at 1)
'    LEN(s$)  LEFT$(s$, n)  RIGHT$(s$, n)  MID$(s$, start, n)
'    INSTR(s$, t$)   position of t$ in s$, or 0 if absent
'    SPACE$(n)  STRING$(n, code)  STR$(number)  VAL(s$) (text -> number)
'
'  Keyboard, randomness, sound
'    INKEY$          read a key WITHOUT waiting: "" if none was pressed.
'                    Arrow/keypad keys return 2 characters, CHR$(0) + a code
'                    letter: G=Home H=Up I=PgUp K=Left M=Right O=End P=Down
'                    Q=PgDn.
'    RND             random number, 0 <= RND < 1.  INT() rounds down, so
'                    INT(RND * 100) + 1 is a random whole number 1..100.
'    RANDOMIZE       reseed the generator.
'    SOUND f, d      tone of f Hz for d clock ticks (18.2 ticks = 1 second)
'    BEEP            short beep.   PLAY "..."  music: O=octave, L=note length,
'                    T=tempo, A-G notes, # sharp, P pause, MB/MF background/
'                    foreground.
'    DEF SEG = 0 : POKE 1050, PEEK(1052)
'                    write into BIOS memory: makes the keyboard buffer's head
'                    equal its tail, i.e. throws away keys typed ahead.
'
'  Files
'    OPEN "R", #1, "CASTLE.RAN", 575   random-access file, 575-byte records
'    FIELD #1, 24 AS FR1$, ...         names the byte ranges of a record
'    GET #1, n / PUT #1, n             read / write record n via those names
'    LSET F$ = x                       store x into a FIELD variable (padded)
'    OPEN "O"/"I"/"A", #2, name        sequential output / input / append
'    PRINT #2, ... / INPUT #2, ...     write / read values in such a file
'    EOF(2)  true (-1) at end of file.  CLOSE closes; KILL name deletes.
'    READ a, b$, ...                   take the next values from DATA lines
'    ON ERROR GOTO L / ERR             error trap / error number (53 = file
'                                      not found)
'    True is -1 and false is 0 in BASIC comparisons.
"""

CONVENTIONS = r"""
' ============================================================================
'  HOW THE GAME IS ORGANISED
' ============================================================================
'  Screen: the room map is drawn at rows 1-18, columns 1-24, with a frame at
'  column 25 / row 19.  The room description is rows 20-24.  Column 26
'  onward is the side panel: visible items (rows 1-10), monsters, messages
'  (rows 13-19) and the command prompt (row 23).
'
'  Rooms come from CASTLE.RAN, 10 at a time (a "page"), into ROOM$(line,
'  slot): lines 0-17 are map rows, 18 the description, 19 the exits text
'  such as "N3S1" (north -> room 3, south -> room 1).  Room 0 = outside:
'  reaching it wins the game.
'
'  Objects (1-22) and monsters (1-10) come from the DATA lines at the end.
'    OBJROOM(i) = 0        the player carries it
'               = 1..83    it lies in that room (at OBJROW, OBJCOL)
'               = room+100 hidden in that room; then OBJROW/OBJCOL hold the
'                          character codes of the furniture it is hidden in
'    MONHP(i) < 0          the monster is dead
'  Messages: set NMSG (how many lines) and MSG$(1..NMSG), then
'  GOTO ShowMessage, which prints them and returns to the InputLoop.
"""

GLOSSARY = {
    "ROOM": "current room (1-83)", "PREVROOM": "room the player came from",
    "PY / PX": "player row / column on the map", "UNDER": "character the player is standing on",
    "STRENGTH": "player hit points (starts 100, dead below 0)",
    "NCARRY": "number of items carried (max 6)",
    "DOOR68LOCKED / DOOR82LOCKED": "1 while the wine-cellar / dungeon door is locked",
    "FLASKFULL": "1 when the flask holds water", "DRANK": "1 after drinking (heals only once)",
    "CMD$": "command being typed", "VERB$ / NOUN$": "first / second word of the command",
    "K$": "last key read", "DY / DX": "movement direction (-1, 0, 1)",
    "NY / NX": "square the player is moving to", "CH": "character found there",
    "IDLE": "counts idle input polls; at 200 the monsters move",
    "MONHERE": "1 if a live monster is in the room", "TARGET": "monster being attacked",
    "MDY / MDX": "monster step direction", "ROLL": "random roll 1-100",
    "MN$": "monster name without its adjective", "W$": "scratch string (word, exit number)",
    "NMSG / MSG$()": "message lines for the side panel",
    "PAGE / PAGEEND / SLOT": "first / last room loaded from disk, and ROOM's slot",
    "ROOM$(line, slot)": "cached room records", "DESC$()": "description split into 5 lines",
    "FR1$..FR18$, FDESC$, FEXITS$": "FIELD variables of a CASTLE.RAN record",
    "OBJ*() / MON*()": "object / monster tables (ROOM, NAME$, CHAR, ROW, COL, HP)",
    "SCORE / HISCORE": "final score / stored high score",
    "I J K N T T2 C X T$ SC$": "loop counters and scratch values",
}

SECTION_DOCS = {
    "Start": "Program entry: freeware notice, title screen, then a new game.",
    "NewGame": "Reset the player and load the object and monster tables (DATA).",
    "LoadRoomPage": "Read the 10 rooms around ROOM from CASTLE.RAN into ROOM$().",
    "DrawRoom": "Draw the room map, description, items and monsters, then the player.\n"
                "Also places the fairy (monster 10) in rooms 52/54 and handles special arrivals.",
    "InputLoop": "Show the prompt and wait for a key.  Typing builds CMD$;\n"
                 "keypad keys move the player; Enter runs the command.",
    "WaitKey": "Each idle poll counts toward a monster turn (every 200 polls).",
    "ReadKey": "Check the traps (rooms 76/78 without the necklace), then handle the key.",
    "Uppercase": "Convert a lower-case letter to upper case; only A-Z and space are typed.",
    "MovePlayer": "Try to move one square.  Leaving the map edge or stepping on U/D\n"
                  "means a room exit; anything that is not a space is a bump.",
    "TakeExit": "Look up the exit letter T$ in the room's exits text and read the room number.",
    "ExitDigits": "Collect the digits after the exit letter.",
    "DoCommand": "Split CMD$ into VERB$ and NOUN$ and dispatch on the verb.",
    "NotUnderstood": "Unknown command: show \"What???\" briefly.",
    "Bump": "The player walked into something: an item (pick it up), a door, the\n"
            "gate, the vampire or fairy (blocked), or a monster (attack).",
    "PickUpBumped": "Pick up the item walked into (limit 6 items).",
    "ShowMessage": "Print MSG$(1..NMSG) in the side panel and go back to the InputLoop.",
    "MonsterTurn": "Monster turn: every live monster 1-8 in this room takes a step.",
    "MonsterLoop": "Loop over monsters 1-8 (body is MonsterStep).",
    "MonsterStep": "Step one square toward the player (diagonals allowed) if that square\n"
                   "is empty.  If the player is there, attack instead.",
    "PlayerAttacks": "The player hits monster TARGET: needs the sword, 50% to hit.",
    "CmdLook": "LOOK / EXAMINE / SEARCH: objects first, then furniture, then monsters.",
    "LookObject": "Describe object I (only if carried): one line per object via ON I GOTO.",
    "LookMonster": "Describe a monster in the room.",
    "CmdDrop": "DROP / THROW: put a carried object on the square in front of the player.",
    "CmdGet": "GET / TAKE: objects, liquids, and refusals for furniture and monsters.",
    "GetObject": "GET a hidden object: it must be in this room (room+100) and the player\n"
                 "must stand next to the furniture it is hidden in.",
    "GetLiquid": "GET WATER (fills the flask at the fountain) or GET WINE.",
    "CmdInventory": "INV...: list carried objects.",
    "CmdWear": "WEAR: helmet, necklace, glasses (flavour text only).",
    "CmdPlay": "PLAY HARP: music; drives the fairy away if it is here.",
    "CmdWave": "WAVE: wand (secret passages in rooms 67/77), cross (vampire),\n"
               "scepter (opens the gate in room 1).",
    "CmdClean": "CLEAN / RUB: flavour text.", "CmdSay": "SAY: echo the word; monsters look at you funny.",
    "CmdLockUnlock": "OPEN / UNLOCK / CLOSE / LOCK the doors in rooms 68 and 82 (needs the key).",
    "CmdRead": "READ BOOK: needs the eye glasses.", "CmdJump": "JUMP / LEEP: flavour text.",
    "TrapRoom76": "Trap: the room fills with water (animated) and the player drowns.",
    "TrapRoom78": "Same trap in room 78.", "Drowned": "Death message for the traps.",
    "CmdDrink": "DRINK WATER: restores STRENGTH to 100, once.",
    "CmdPour": "POUR WATER: empties the flask.", "CmdPet": "PET: refusal.", "CmdKill": "KILL: refusal.",
    "CmdShow": "SHOW CROSS: the vampire disappears.",
    "HighScoreWall": "LOOK WALL in the courtyard: show the high score (record 84).",
    "CmdSave": "SAVE name: write the game state to a text file.",
    "CmdLoad": "LOAD name: read it back.  (Bug: reads only MONHP per monster.)",
    "PlayerDied": "Death: show the message, wait for a key, then score.",
    "Escaped": "Win: the player left the castle (room 0).",
    "FinalScore": "Score: 50 per treasure carried or left in room 1, 100 per dead monster,\n"
                  "100 for escaping.  1550 is perfect.  Then high score / play again.",
    "NewHighScore": "Ask for a name.  (Bug: a name over 14 characters jumps to DropHere.)",
    "SaveHighScore": "Store name and score in record 84 of CASTLE.RAN.",
    "TitleScreen": "Title picture and tune; P plays, I shows the instructions.",
    "FreewareNotice": "Shareware notice (80 columns).",
    "ErrorHandler": "ON ERROR target: explains a missing CASTLE.RAN, otherwise gives up.",
}

OBJ = ["LAMP", "HARP", "NECKLACE", "BOOK", "MAGIC WAND", "SWORD", "KEY", "EYE GLASSES",
       "CRYSTAL BALL", "HELMET", "WINE FLASK", "HOLY CROSS", "DIAMOND", "SILVER BARS", "RUBYS",
       "JADE FIGURINE", "SCEPTER", "HOURGLASS", "LARGE GEM", "GOLDBAR", "FANCY GOBLET", "CROWN"]
MON = ["UGLY OGRE", "UGLY OGRE", "ANGRY DEMON", "ANGRY DEMON", "BIG SPIDER", "SMALL SPIDER",
       "BAT", "SNAKE", "VAMPIRE", "FAIRY"]
CHARS = {5: "♣ player / vampire", 8: "locked door", 32: "space", 196: "─ furniture", 179: "│ furniture",
         205: "═ gate", 246: "fairy"}

IDIOMS = [
    ("POKE 1050, PEEK(1052)", "discard keys typed ahead"),
    ("DEF SEG = 0", "PEEK/POKE address BIOS memory"),
    ("PRINT CHR$(5);", "draw the player"),
    ("UNDER = SCREEN(", "remember what the player stands on"),
    ("COLOR 23", "blinking"), ("COLOR 7", "normal"),
    ("INT(RND * 25) + 5", "as written: -5..+19 damage"),
    ("GET #1, 84", "record 84 holds the high score"),
    ("IDLE = 200", "monsters move every 200 idle polls"),
]


def room_names():
    try:
        rooms = json.loads((OUT / "rooms.json").read_text())["rooms"]
    except OSError:
        return {}
    names = {}
    for r in rooms:
        m = re.match(r"You(?:'re| are)\s+(?:in|on|at)?\s*(?:(?:the|an|a)\s+)?(.*?)[.!,]",
                     r["description"], re.I)
        names[r["id"]] = (m.group(1) if m else "").strip()
    return names


ROOMS = room_names()


def note_for(line):
    notes = []
    for pat, txt in IDIOMS:
        if pat in line:
            notes.append(txt)
    for k in sorted({int(n) for n in re.findall(r"\bOBJ[A-Z]+\$?\((\d+)\)", line)}):
        if 1 <= k <= 22:
            notes.append(f"{k}={OBJ[k - 1]}")
    for k in sorted({int(n) for n in re.findall(r"\bMON[A-Z]+\$?\((\d+)\)", line)}):
        if 1 <= k <= 10:
            notes.append(f"monster {k}={MON[k - 1]}")
    for k in sorted({int(n) for n in re.findall(r"\b(?:ROOM|PREVROOM)\$? (?:=|<>) (\d+)\b", line)}
                    | {int(n) for n in re.findall(r"\bVAL\(W\$\) = (\d+)", line)}):
        if k in ROOMS:
            notes.append(f"{k}={ROOMS[k]}")
    for k in sorted({int(n) for n in re.findall(r"\b(?:CH|T) (?:=|<>) (\d+)\b", line)}):
        if k in CHARS:
            notes.append(f"{k}={CHARS[k]}")
    seen, out = set(), []
    for n in notes:
        if n not in seen:
            seen.add(n)
            out.append(n)
    return ", ".join(out)


def annotate(lines):
    """Append end-of-line notes (aligned at column 60 where possible)."""
    out = []
    prev = None
    for ln in lines:
        s = ln.strip()
        if not s or s.startswith("'") or s.endswith(":") or "' @" in ln:
            out.append(ln)
            continue
        n = note_for(ln)
        if n == prev:
            n = ""          # same note as the line above: don't repeat it
        else:
            prev = n
        if n:
            out.append(f"{ln.rstrip():<60} ' {n}" if len(ln.rstrip()) < 60 else f"{ln.rstrip()}  ' {n}")
        else:
            out.append(ln)
    return out


def section_comment(name):
    doc = SECTION_DOCS.get(name)
    if not doc:
        return []
    return [f"' {d}" for d in doc.split("\n")]


def glossary():
    w = max(len(k) for k in GLOSSARY)
    lines = ["", "' ============================================================================",
             "'  VARIABLES", "' ============================================================================"]
    lines += [f"'  {k:<{w}}  {v}" for k, v in GLOSSARY.items()]
    return "\n".join(lines) + "\n"


def data_section():
    try:
        d = json.loads((OUT / "objects_monsters.json").read_text())
    except OSError:
        return ""
    lines = ["", "' ============================================================================",
             "'  DATA read by NewGame (stored in CASTLE.EXE as text)",
             "' ============================================================================",
             "' Objects: room, name, character code, row, column   (room > 100 = hidden)"]
    for o in d["objects"]:
        d_ = f'    DATA {o["room"]}, "{o["name"]}", {o["char"]}, {o["row"]}, {o["col"]}'
        lines.append(f'{d_:<52}\' {o["id"]:>2} {o["glyph"]}')
    lines.append("' Monsters: room, name, character code, row, column, hit points")
    for m in d["monsters"]:
        d_ = f'    DATA {m["room"]}, "{m["name"]}", {m["char"]}, {m["row"]}, {m["col"]}, {m["hp"]}'
        lines.append(f'{d_:<52}\' {m["id"]:>2} {m["glyph"]}')
    return "\n".join(lines) + "\n"
