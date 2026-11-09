// Package castle loads the rooms of Castle Adventure (1984) from CASTLE.RAN and
// renders them, either as the original CGA text or restyled with colour,
// sprites and connected walls.
package castle

import (
	"fmt"
	"regexp"
	"strconv"
	"strings"

	"golang.org/x/text/encoding/charmap"
)

// Room map size and CASTLE.RAN record layout.
const (
	MapW     = 24
	MapH     = 18
	NumRooms = 83
	recSize  = 575 // 24x18 map, 5x25 description, 18 exit characters
	descOff  = MapW * MapH
	exitOff  = descOff + 125
)

// Room is one room of the castle: its map and description from CASTLE.RAN,
// plus the level data from the JSON files (items, monsters, doors, traps …).
type Room struct {
	ID    int
	Title string           // short name, e.g. "Castle Courtyard"
	Area  string           // the map area it belongs to, e.g. "Ground Floor"
	Floor int              // 0 = ground floor, -1 = cellars
	Map   [MapH][MapW]rune // the original characters (code page 437 decoded)
	Desc  string           // description text
	Exits map[byte]int     // 'N','S','E','W','U','D' -> room number (0 = outside)

	Dark     bool      // too dark to enter without the lamp
	Doors    []Pos     // squares of a door that starts locked
	Traps    []Trap    // squares that drown you unless you carry the necklace
	OnArrive []Arrival // effects of arriving from a given room
	OnWave   []Wave    // what waving an item here does
	Spawns   []Spawn   // monsters placed in the way when you arrive
	Items    []ItemDef // items that start in this room
	Monsters []MonsterDef
}

// Pos is a 1-based map position, as the original's LOCATE row, col.
type Pos struct{ Row, Col int }

// Edit writes text into a room's map, starting at Row, Col (1-based).
type Edit struct {
	Row  int    `json:"row"`
	Col  int    `json:"col"`
	Text string `json:"text"`
}

// Trap drowns the player on any of Cells unless they carry the necklace.
type Trap struct {
	Cells []Pos
	Flood []Edit // drawn when the trap springs
}

// Arrival applies when the player enters the room from room From.
type Arrival struct {
	From    int      `json:"from"`
	Row     int      `json:"row,omitempty"` // move the player here (0 = stay)
	Col     int      `json:"col,omitempty"`
	Edits   []Edit   `json:"edits,omitempty"`
	Message []string `json:"message,omitempty"`
}

// Wave is the effect of waving an item in this room.
type Wave struct {
	Item    string   `json:"item"`
	Edits   []Edit   `json:"edits"`
	Message []string `json:"message"`
}

// Spawn places a monster in the room on arrival, unless arriving from UnlessFrom.
type Spawn struct {
	Monster    string `json:"monster"`
	Row        int    `json:"row"`
	Col        int    `json:"col"`
	UnlessFrom int    `json:"unlessFrom,omitempty"`
}

// ItemDef is an item's starting state.
type ItemDef struct {
	ID       string   `json:"id"`   // lower-case noun: "lamp", "wand" …
	Name     string   `json:"name"` // "MAGIC WAND"
	Glyph    string   `json:"glyph"`
	Row      int      `json:"row,omitempty"`
	Col      int      `json:"col,omitempty"`
	HiddenIn string   `json:"hiddenIn,omitempty"` // hidden: GET it next to one of these characters
	Look     []string `json:"look,omitempty"`     // LOOK text when carried
	Treasure bool     `json:"treasure,omitempty"`
	Room     int      `json:"-"`
}

// MonsterDef is a monster's starting state.
type MonsterDef struct {
	ID    string `json:"id"`
	Name  string `json:"name"`
	Glyph string `json:"glyph"`
	Kind  string `json:"kind"` // "fighter", "vampire" or "fairy"
	HP    int    `json:"hp"`
	Row   int    `json:"row,omitempty"`
	Col   int    `json:"col,omitempty"`
	Start *bool  `json:"start,omitempty"` // false: not placed until a Spawn puts it somewhere
	Room  int    `json:"-"`
}

var exitRe = regexp.MustCompile(`([NSEWUD])(\d+)`)

// LoadRAN decodes the original CASTLE.RAN (maps, descriptions and exits only).
// The result is 1-based like the original game: rooms[1] is the courtyard.
func LoadRAN(ran []byte) ([]*Room, error) {
	if len(ran) < NumRooms*recSize {
		return nil, fmt.Errorf("castle: CASTLE.RAN is %d bytes, want at least %d", len(ran), NumRooms*recSize)
	}
	dec := charmap.CodePage437.NewDecoder()
	rooms := make([]*Room, NumRooms+1)
	for i := 1; i <= NumRooms; i++ {
		rec := ran[(i-1)*recSize : i*recSize]
		r := &Room{ID: i, Exits: map[byte]int{}}
		for y := 0; y < MapH; y++ {
			line, err := dec.Bytes(rec[y*MapW : (y+1)*MapW])
			if err != nil {
				return nil, fmt.Errorf("castle: room %d row %d: %w", i, y+1, err)
			}
			copy(r.Map[y][:], []rune(string(line)))
		}
		desc, err := dec.Bytes(rec[descOff:exitOff])
		if err != nil {
			return nil, fmt.Errorf("castle: room %d description: %w", i, err)
		}
		r.Desc = strings.Join(strings.Fields(string(desc)), " ")
		for _, m := range exitRe.FindAllStringSubmatch(string(rec[exitOff:recSize]), -1) {
			n, _ := strconv.Atoi(m[2])
			r.Exits[m[1][0]] = n
		}
		rooms[i] = r
	}
	return rooms, nil
}

// Text is the description as one normalised line.
func (r *Room) Text() string { return strings.Join(strings.Fields(r.Desc), " ") }

var nameRe = regexp.MustCompile(`(?i)^You(?:'re| are)\s+(?:in|on|at)?\s*(?:(?:the|an|a)\s+)?(.*?)[.!,]`)

// Name is the room's short name, from the level data or else the description.
func (r *Room) Name() string {
	if r.Title != "" {
		return r.Title
	}
	t := r.Text()
	if m := nameRe.FindStringSubmatch(t); m != nil {
		t = strings.TrimSpace(m[1])
	}
	if t == "" {
		return fmt.Sprintf("Room %d", r.ID)
	}
	return strings.ToUpper(t[:1]) + t[1:]
}

// Tile is what a map square means to the game. As in the original, only a
// space can be walked on; U and D are stairs; everything else blocks.
type Tile uint8

const (
	Floor Tile = iota
	Blocked
	StairsUp
	StairsDown
)

// TileAt returns the tile at row y, column x (0-based).
func (r *Room) TileAt(y, x int) Tile { return tileOf(r.Map[y][x]) }

func tileOf(c rune) Tile {
	switch c {
	case ' ':
		return Floor
	case 'U':
		return StairsUp
	case 'D':
		return StairsDown
	}
	return Blocked
}
