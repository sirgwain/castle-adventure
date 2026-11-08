# Castle Adventure (1984): game mechanics

Taken from `castle.bas`, which was lifted from CASTLE.EXE. Labels such as `L1CB8` are code addresses in that listing.
Rooms are in `rooms.json`/`rooms.go`; objects and monsters are in `objects_monsters.json`.

## Screen (WIDTH 40)
- Map: rows 1–18, columns 1–24. A frame is drawn at column 25 and row 19.
- Description: rows 20–24, 5 lines × 25 columns (record field 19, padded to 125 characters).
- Right panel at column 26: up to 10 visible objects (`glyph name`), then up to 2 monsters.
- Messages: rows 13–19 of the panel, up to 7 lines (`MSG$(1..NMSG)`), cleared before each new message.
- Prompt: row 23, column 26: `?` plus the typed command (max 14 characters, with a blinking `_`). `What???` appears at row 25.
- The player is `CHR$(5)` (♣). `UNDER` remembers the character the player is standing on.

## Input loop (`L0BFD`)
- Keypad (extended INKEY$ codes): Home/↑/PgUp/←/→/End/↓/PgDn = 8-way movement (`G H I K M O P Q`).
- Letters are upper-cased. Only A–Z and space are accepted, Backspace edits, Enter runs the command, and typing past 14 characters beeps.
- Every pass through the loop with no key pressed does `IDLE += 1`. At 200 the **monsters take a turn** (`L1CB8`).
  This was tied to CPU speed on the original PC. Use a timer in the port and tune it by feel.

## Movement (`L103E`)
- Moving past the map edge exits `N/S/W/E` and wraps you to the opposite edge. Stepping onto a `U` or `D` glyph takes stairs up or down.
- The exit's room number is the digits after that letter in the exits string. If the letter is missing, the number is 0, and **room 0 means you escaped (win)**.
- Entering room 68 or 83 without the LAMP (`OBJROOM(1) <> 0`) gives "It's too dark to go that way!"
- Bumping into anything other than a space:
  - An object glyph picks it up, if you carry fewer than 6 items (`OBJROOM = 0` means carried).
  - `◘` (8) is a locked door, `═` (205) the locked gate, `♣` (5) the vampire blocking you, `÷` (246) the fairy blocking you.
  - An enemy glyph (monsters 1–8) at that exact cell is an **attack** (below).
  - Anything else is a wall bump (`SOUND 50`).
- Traps without the NECKLACE (you drown and the game ends): room 76 at column 15, rows 13–14; room 78 at column 18, rows 9–10.

## Monsters (`L1CB8`, `L1D24`)
Monsters 1–8 (ogres, demons, spiders, bat, snake) are the only ones that move or fight.
- On each monster tick, every monster with `MONROOM = ROOM` and `MONHP > -1` steps one cell toward the player:
  `dy = sgn(PY - row)` and `dx = sgn(PX - col)`, so diagonal moves are allowed.
  - If the target cell is a space, the monster moves there.
  - If the target cell is the player (`SCREEN = 5`), it **attacks**: roll `INT(RND*100)+1`, minus 10 if you carry the HELMET. It hits if the roll is above 40.
    A hit does `STRENGTH = STRENGTH - INT(RND*25) + 5`, which as written is −5 to 19 damage, so a hit can heal you.
    You die if STRENGTH < 0.
  - Anything else blocks the monster, and it doesn't move.
- **Player attack:** bump a live monster. You need the SWORD. Roll `INT(RND*100)+1` and hit if it's above 50, with the same damage formula.
  At HP < 0 the monster dies and is renamed `"Dead " + name`. Its glyph stays on the map, but it no longer acts.
- The **vampire** (9, room 28) never moves. It blocks you until you SHOW or WAVE the HOLY CROSS in room 28, which sets `MONROOM(9) = 0`.
- The **fairy** (10) starts in room 0. Every time you enter room 52 (it appears at 10,1) or room 54 (at 1,12), except when coming from room 57 (the diamond room), it's placed in your way.
  PLAY HARP in its room removes it, but it comes back the next time you enter either room.
- Your STRENGTH starts at 100. DRINK WATER restores it to 100, but only once (`DRANK`).

## Objects
- Hidden objects have `room = real room + 100`. To GET one you must stand next to (3×3 around you) a screen character whose code equals the object's `row` or `col` value.
  Those fields hold furniture glyphs instead of coordinates: 196/179 for a desk or table, 219 for a shelf.
- LOOK/EXAMINE/SEARCH on an object gives per-object text (`ON I GOTO` at `L2894`). Room furniture (table, desk, beds, shelves, throne, fountain, statue, mirror, barrels, chains, walls, garden, stairs, balcony) has its own replies, mostly depending on the room.
- READ BOOK needs the EYE GLASSES and says "Wave Scepter". LOOK BALL shows a man waving a wand in a winding passage.
- WAVE WAND in room 67 opens a secret passage behind the mirror. In room 77 it opens the passage at row 18.
- WAVE SCEPTER in room 1 opens the gate. Walking south then exits to room 0, which wins the game.
- UNLOCK/OPEN DOOR (needs the KEY, standing next to a door) works in rooms 68 and 82, and LOCK puts the door back.
- FILL FLASK fills it with water at the fountain (room 18). In room 68 you're told "The barrels are empty".
  POUR spills the water, with a joke if you have the goblet.
- Arriving from room 66 puts you in the Sorcerer's room ("puff of smoke"). Coming back from room 83 redraws the opened passage.

## Scoring (`L6577`)
- 13 treasures (objects 13–22 plus HARP, NECKLACE and HOLY CROSS) are worth 50 each, counted if carried or dropped in room 1.
- Each dead monster from 1–8 is worth 100. Escaping is worth 100.
- 1550 is a perfect score and plays a tune.
- The high score is kept in CASTLE.RAN record 84: the name (14 characters) goes in field 1 and `STR$(score)` in field 2. LOOK WALL in room 1 shows it.

## Bugs in the original (decide whether to keep them)
1. The damage formula adds 5 instead of subtracting it (see above).
2. LOAD reads only `MONHP` for each monster, but SAVE writes `MONHP, MONROW, MONCOL` on that line. Loading a saved game therefore misreads every monster after the first.
3. A high-score name longer than 14 characters runs `GOTO L3769`, which is the middle of the DROP routine.
4. Monster speed depends on how fast the input loop runs.
