# Level files

One file per floor (`floor_-1.json` is the cellars and dungeon, `floor_0.json` the ground floor, up to
`floor_5.json`, the tower tops). They are built into the binary, so rebuild after editing, or play your
edited copies directly:

```sh
go run . -levels internal/castle/levels            # play the files on disk
go run . -levels internal/castle/levels -room 67   # start in a room to test it
go run . -levels internal/castle/levels -room 67 -screenshot room67.png   # a PNG of the room
```

The files started as an export of the original data (`tools/export_levels.py`). They are now the source;
`TestLevelsMatchRAN` lists anything that differs from the original CASTLE.RAN, so update or remove that
test once you change rooms on purpose.

Rows and columns are **1-based**, counted the way the map rows read: row 1 is the first string in `map`,
column 1 its first character. That matches the original's `LOCATE row, col` and `out/castle.bas`.

## A floor file

```json
{ "floor": 0, "name": "Ground Floor", "start": {"room": 1, "row": 15, "col": 15}, "rooms": [ … ] }
```

`start` (only in one file) is where a new game begins.

## A room

| Field | Meaning |
|---|---|
| `id` | Room number, 1–83. Exits refer to rooms by number. |
| `name`, `area` | Shown above the map. |
| `description` | The room's text, shown below the map. |
| `exits` | `{"N": 2, "U": 23}`: direction → room. N/S/E/W are taken by walking off that edge, U/D by stepping onto a `U` or `D` in the map. A direction with no exit, reached through an opening, means the player has left the castle (that is how the game is won through the courtyard gate). |
| `map` | 18 strings of up to 24 characters (shorter rows are padded with spaces). |
| `dark` | `true`: "too dark to go that way" unless the player carries the lamp. |
| `doors` | Squares of a door that starts locked. UNLOCK DOOR, standing next to it with the key, opens it. |
| `traps` | `cells` that drown the player unless they carry the necklace; `flood` edits drawn when it springs. |
| `onArrive` | Effects of arriving `from` a room: move the player to `row`/`col`, draw `edits`, show `message`. |
| `onWave` | What `WAVE <item>` does here: draw `edits` (once) and show `message`. |
| `spawns` | Put a monster in the way on arrival, `unlessFrom` a given room (the fairy). |
| `items`, `monsters` | What starts in this room (below). |

## The map characters

The game reads the map like the original read the screen:

- a **space** is floor, the only thing anyone can walk on;
- **`U`** and **`D`** are stairs: walking onto one takes the room's `U` or `D` exit;
- **`═`** is the locked courtyard gate ("The Gate is locked.");
- **everything else blocks**. Walls are `▓`, furniture is `█` blocks or box lines (`┌─┐ │ └─┘`), and the
  renderer turns them into connected walls, beds, desks and so on. The room's colours come from its name
  and description ("decorated all in purple").

An `edit` (`{"row": 18, "col": 11, "text": "    "}`) overwrites characters for the rest of that visit, as the
original's screen writes did: leave the room and it is redrawn from `map`.

## Items and monsters

```json
{"id": "key", "name": "KEY", "glyph": "τ", "hiddenIn": "─│", "look": ["It looks Old!"]}
{"id": "ogre1", "name": "UGLY OGRE", "glyph": "☺", "kind": "fighter", "hp": 80, "row": 9, "col": 13}
```

- An item's `id` is the noun the rules use (`lamp`, `key`, `sword` …); the player types the last word of its
  `name`. It lies at `row`/`col`, or is **hidden** in the furniture drawn with the `hiddenIn` characters and
  taken with GET while standing next to it. `look` is the LOOK text once carried; `treasure` scores 50.
- A monster's `kind` is `fighter` (moves and attacks; 100 points when killed), `vampire` (blocks, repelled
  by the cross) or `fairy` (blocks, leaves when the harp is played). `"start": false` keeps it out of the
  castle until a `spawns` entry places it.
- Ids must be unique across all files. The loader checks this, the map sizes, the exits and positions, and
  says which file and room is wrong.
