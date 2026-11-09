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

// Room is one record of CASTLE.RAN.
type Room struct {
	ID    int
	Map   [MapH][MapW]rune // decoded from code page 437
	Desc  string           // 125 characters: the original 5 lines of 25
	Exits map[byte]int     // 'N','S','E','W','U','D' -> room number (0 = outside)
}

var exitRe = regexp.MustCompile(`([NSEWUD])(\d+)`)

// LoadRooms decodes CASTLE.RAN. The result is 1-based like the original game:
// rooms[1] is the courtyard and rooms[0] is nil.
func LoadRooms(ran []byte) ([]*Room, error) {
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
		r.Desc = string(desc)
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

// Name is a short name taken from the description ("Castle Courtyard").
func (r *Room) Name() string {
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
