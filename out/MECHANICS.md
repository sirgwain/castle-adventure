# Castle Adventure (1984): game mechanics

Taken from `castle.bas`, which was lifted from CASTLE.EXE. Names in backticks such as `MonsterTurn` are section labels in that listing. Each label is followed by its code address (`' @1CB8`), which is the label `castle_flat.bas` and `castle.asm` use.
Rooms are in `rooms.json`/`rooms.go`; objects and monsters are in `objects_monsters.json` and in the DATA lines at the end of `castle.bas`.

## Start-up (`Start`, `NewGame`, `LoadRoomPage`, `DrawRoom`)
- `Start` shows `FreewareNotice` and `TitleScreen` (P plays, I shows the instructions), then falls into `NewGame`.
- `NewGame` puts you in room 1 at row 15, column 15, with both doors locked and STRENGTH 100. It then READs the object and monster tables from the DATA lines.
- `LoadRoomPage` reads the 10 rooms around the current one from CASTLE.RAN into `ROOM$(line, slot)`. `DrawRoom` draws the map, description, items, monsters and player.

## Screen (WIDTH 40, drawn by `DrawRoom`)
- Map: rows 1–18, columns 1–24. A frame is drawn at column 25 and row 19.
- Description: rows 20–24, 5 lines × 25 columns (record field 19, padded to 125 characters).
- Right panel at column 26: up to 10 visible objects (`glyph name`), then up to 2 monsters.
- Messages (`ShowMessage`): rows 13–19 of the panel, up to 7 lines (`MSG$(1..NMSG)`), cleared before each new message.
- Prompt (`InputLoop`): row 23, column 26: `?` plus the typed command (max 14 characters, with a blinking `_`). `What???` (end of `DoCommand`) appears at row 25.
- The player is `CHR$(5)` (♣). `UNDER` remembers the character the player is standing on.

## Input loop (`InputLoop`, `WaitKey`, `ReadKey`)
- Keypad (extended INKEY$ codes): Home/↑/PgUp/←/→/End/↓/PgDn = 8-way movement (`G H I K M O P Q`).
- `Uppercase` converts lower-case letters. Only A–Z and space are accepted, Backspace edits, Enter goes to `DoCommand`, and typing past 14 characters beeps.
- `WaitKey` does `IDLE += 1` on every pass through the loop, whether or not a key was pressed. At 200 the **monsters take a turn** (`MonsterTurn`).
  That makes monster speed depend on CPU speed. `tools/timing.py` measured 57,313 instructions per monster turn, which is about 0.2 s (≈5 turns a second) on a 4.77 MHz IBM PC.
  On a 486 it's 2–3 ms. In the port, use a timer (`tea.Tick`) of about 200 ms. `castle.conf` runs the original at this speed in DOSBox.

## Commands (`DoCommand`)
`DoCommand` splits the line into `VERB$` and `NOUN$` at the first space. INV… and QUIT are recognised before the split. Each verb has its own section:
`CmdLook` (LOOK/EXAMINE/SEARCH), `CmdGet` (GET/TAKE), `CmdDrop` (DROP/THROW), `CmdInventory`, `CmdWear`, `CmdPlay`, `CmdWave`, `CmdClean` (CLEAN/RUB), `CmdSay`, `CmdLockUnlock` (OPEN/UNLOCK/CLOSE/LOCK), `CmdRead`, `CmdJump` (JUMP/LEEP), `CmdDrink`, `CmdPour`, `CmdPet`, `CmdKill`, `CmdShow`, `CmdSave` and `CmdLoad`.
EAT, CLIMB and MIRROR MIRROR are answered inline in `DoCommand`. Anything else falls through to the end of `DoCommand`, which shows `What???`.

## Movement (`MovePlayer`, `TakeExit`, `Bump`)
- Moving past the map edge exits `N/S/W/E` and wraps you to the opposite edge. Stepping onto a `U` or `D` glyph takes stairs up or down.
- `TakeExit` and `ExitDigits` read the room number from the digits after that letter in the exits string. If the letter is missing, the number is 0, and **room 0 means you escaped** (`Escaped`).
- Entering room 68 or 83 without the LAMP (`OBJROOM(1) <> 0`) gives "It's too dark to go that way!"
- Bumping into anything other than a space goes to `Bump`:
  - An object glyph is picked up (`PickUpBumped`) if you carry fewer than 6 items (`OBJROOM = 0` means carried).
  - `◘` (8) is a locked door, `═` (205) the locked gate, `♣` (5) the vampire blocking you, `÷` (246) the fairy blocking you.
  - An enemy glyph (monsters 1–8) at that exact cell is an **attack** (`PlayerAttacks`, below).
  - Anything else is a wall bump (`SOUND 50`).
- Traps without the NECKLACE: room 76 at column 15, rows 13–14 (`TrapRoom76`), and room 78 at column 18, rows 9–10 (`TrapRoom78`). The room fills with water, you drown (`Drowned`), and the game ends.

## Monsters (`MonsterTurn`, `MonsterStep`, `PlayerAttacks`)
Monsters 1–8 (ogres, demons, spiders, bat, snake) are the only ones that move or fight.
- On each monster tick, `MonsterTurn`/`MonsterLoop` picks every monster with `MONROOM = ROOM` and `MONHP > -1`. In `MonsterStep` each one steps one cell toward the player:
  `dy = sgn(PY - row)` and `dx = sgn(PX - col)`, so diagonal moves are allowed.
  - If the target cell is a space, the monster moves there.
  - If the target cell is the player (`SCREEN = 5`), it **attacks** (second half of `MonsterStep`): roll `INT(RND*100)+1`, minus 10 if you carry the HELMET. It hits if the roll is above 40.
    A hit does `STRENGTH = STRENGTH - INT(RND*25) + 5`, which as written is −5 to 19 damage, so a hit can heal you.
    You die if STRENGTH < 0 (`PlayerDied`).
  - Anything else blocks the monster, and it doesn't move.
- **Player attack** (`PlayerAttacks`): bump a live monster. You need the SWORD. Roll `INT(RND*100)+1` and hit if it's above 50, with the same damage formula.
  At HP < 0 the monster dies and is renamed `"Dead " + name`. Its glyph stays on the map, but it no longer acts.
- The **vampire** (9, room 28) never moves. It blocks you until you SHOW (`CmdShow`) or WAVE (`CmdWave`) the HOLY CROSS in room 28, which sets `MONROOM(9) = 0`.
- The **fairy** (10) starts in room 0. `DrawRoom` places it in your way every time you enter room 52 (at 10,1) or room 54 (at 1,12), except when coming from room 57 (the diamond room).
  PLAY HARP (`CmdPlay`) in its room removes it, but it comes back the next time you enter either room.
- SAY (`CmdSay`) and SHOW when a monster is present go to `MonstersReact`: "The … looks at you Funny!"
- Your STRENGTH starts at 100. DRINK WATER (`CmdDrink`) restores it to 100, but only once (`DRANK`).

## Objects
- Hidden objects have `room = real room + 100`. To GET one (`GetObject`, `TakeHidden`) you must stand next to (3×3 around you) a screen character whose code equals the object's `row` or `col` value.
  Those fields hold furniture glyphs instead of coordinates: 196/179 for a desk or table, 219 for a shelf.
- LOOK/EXAMINE/SEARCH on a carried object goes to `LookObject`, which jumps to a per-object description (`ON I GOTO DescLamp, …`). Room furniture (table, desk, beds, shelves, throne, fountain, statue, mirror, barrels, chains, walls, garden, stairs, balcony) has its own replies (`CmdLookTable` … `CmdLookBalcony`), mostly depending on the room. Monsters are described by `LookMonster`.
- READ BOOK (`CmdRead`) needs the EYE GLASSES and says "Wave Scepter". LOOK BALL (`DescBall`) shows a man waving a wand in a winding passage.
- WAVE WAND (`WaveIt`) in room 67 opens a secret passage behind the mirror (`SecretPassage`). In room 77 it opens the passage at row 18 (`WaveWandRoom77`).
- WAVE SCEPTER in room 1 (`WaveScepter`) opens the gate. Walking south then exits to room 0, which wins the game.
- UNLOCK/OPEN DOOR (`CmdLockUnlock`) needs the KEY and you must stand next to the door. It works in rooms 68 and 82 (`DoorRoom68`, and the room-82 branch that follows it), and LOCK puts the door back.
- FILL FLASK becomes GET WATER (`GetLiquid`), which fills the flask at the fountain (room 18). In room 68 you're told "The barrels are empty".
  POUR (`CmdPour`) spills the water, with a joke if you have the goblet.
- Arriving from room 66 puts you in the Sorcerer's room ("puff of smoke", in `DrawRoom`). Coming back from room 83 redraws the opened passage.

## Scoring (`FinalScore`)
- 13 treasures (objects 13–22 plus HARP, NECKLACE and HOLY CROSS) are worth 50 each, counted if carried or dropped in room 1.
- Each dead monster from 1–8 is worth 100. Escaping is worth 100 (`Escaped`); dying (`PlayerDied`) gets nothing for that.
- 1550 is a perfect score and plays a tune.
- The high score is kept in CASTLE.RAN record 84: the name (14 characters) goes in field 1 and `STR$(score)` in field 2. `NewHighScore` writes it, and LOOK WALL in room 1 (`HighScoreWall`) shows it.
- After the score you're offered "Play Again" (back to `NewGame`), otherwise `Quit`.

## Bugs in the original (decide whether to keep them)
1. The damage formula adds 5 instead of subtracting it (see `MonsterStep` and `PlayerAttacks`).
2. `CmdLoad` reads only `MONHP` for each monster, but `CmdSave` writes `MONHP, MONROW, MONCOL` on that line. Loading a saved game therefore misreads every monster after the first.
3. A high-score name longer than 14 characters (`NewHighScore`) runs `GOTO DropHere`, which is the middle of the DROP routine.
4. Monster speed depends on how fast the input loop runs (see the input loop above).
