package castle

import (
	"embed"
	"encoding/json"
	"fmt"
	"io/fs"
	"os"
	"path"
	"sort"
	"strings"
)

// Levels holds the castle's level files, one per floor, built into the binary.
// Edit them in internal/castle/levels/ (or load a copy with LoadWorldDir).
//
//go:embed levels/*.json
var Levels embed.FS

// World is the whole castle.
type World struct {
	Rooms     []*Room // 1-based: Rooms[1] is the courtyard; Rooms[0] is nil
	Start     Pos     // player start position in StartRoom
	StartRoom int
	Floors    []FloorInfo
}

// FloorInfo is one level file.
type FloorInfo struct {
	Floor int
	Name  string
	Rooms []int
}

// floorJSON is the level file format.
type floorJSON struct {
	Floor int        `json:"floor"`
	Name  string     `json:"name"`
	Start *startJSON `json:"start,omitempty"`
	Rooms []roomJSON `json:"rooms"`
}

type startJSON struct {
	Room int `json:"room"`
	Row  int `json:"row"`
	Col  int `json:"col"`
}

type roomJSON struct {
	ID          int            `json:"id"`
	Name        string         `json:"name"`
	Area        string         `json:"area"`
	Description string         `json:"description"`
	Exits       map[string]int `json:"exits"`
	Map         []string       `json:"map"`
	Dark        bool           `json:"dark,omitempty"`
	Doors       []Pos          `json:"doors,omitempty"`
	Traps       []trapJSON     `json:"traps,omitempty"`
	OnArrive    []Arrival      `json:"onArrive,omitempty"`
	OnWave      []Wave         `json:"onWave,omitempty"`
	Spawns      []Spawn        `json:"spawns,omitempty"`
	Items       []ItemDef      `json:"items,omitempty"`
	Monsters    []MonsterDef   `json:"monsters,omitempty"`
}

type trapJSON struct {
	Cells [][2]int `json:"cells"`
	Flood []Edit   `json:"flood,omitempty"`
}

// UnmarshalJSON accepts {"row": r, "col": c}.
func (p *Pos) UnmarshalJSON(b []byte) error {
	var v struct{ Row, Col int }
	if err := json.Unmarshal(b, &v); err != nil {
		return err
	}
	p.Row, p.Col = v.Row, v.Col
	return nil
}

// LoadWorld reads the level files built into the binary.
func LoadWorld() (*World, error) {
	sub, err := fs.Sub(Levels, "levels")
	if err != nil {
		return nil, err
	}
	return LoadWorldFS(sub)
}

// LoadWorldDir reads level files from a directory, for editing without a rebuild.
func LoadWorldDir(dir string) (*World, error) { return LoadWorldFS(os.DirFS(dir)) }

// LoadWorldFS reads every *.json file at the root of fsys.
func LoadWorldFS(fsys fs.FS) (*World, error) {
	names, err := fs.Glob(fsys, "*.json")
	if err != nil {
		return nil, err
	}
	if len(names) == 0 {
		return nil, fmt.Errorf("castle: no level files")
	}
	w := &World{Rooms: make([]*Room, NumRooms+1)}
	itemIDs, monIDs := map[string]bool{}, map[string]bool{}
	for _, name := range names {
		b, err := fs.ReadFile(fsys, name)
		if err != nil {
			return nil, err
		}
		var f floorJSON
		if err := json.Unmarshal(b, &f); err != nil {
			return nil, fmt.Errorf("castle: %s: %w", name, err)
		}
		fl := FloorInfo{Floor: f.Floor, Name: f.Name}
		if f.Start != nil {
			w.StartRoom, w.Start = f.Start.Room, Pos{f.Start.Row, f.Start.Col}
		}
		for _, rj := range f.Rooms {
			r, err := rj.room(f.Floor)
			if err != nil {
				return nil, fmt.Errorf("castle: %s: room %d: %w", name, rj.ID, err)
			}
			if r.ID < 1 || r.ID > NumRooms {
				return nil, fmt.Errorf("castle: %s: room id %d out of range 1-%d", name, r.ID, NumRooms)
			}
			if w.Rooms[r.ID] != nil {
				return nil, fmt.Errorf("castle: %s: room %d defined twice", name, r.ID)
			}
			for _, it := range r.Items {
				if itemIDs[it.ID] {
					return nil, fmt.Errorf("castle: %s: item %q defined twice", name, it.ID)
				}
				itemIDs[it.ID] = true
			}
			for _, m := range r.Monsters {
				if monIDs[m.ID] {
					return nil, fmt.Errorf("castle: %s: monster %q defined twice", name, m.ID)
				}
				monIDs[m.ID] = true
			}
			w.Rooms[r.ID] = r
			fl.Rooms = append(fl.Rooms, r.ID)
		}
		w.Floors = append(w.Floors, fl)
	}
	sort.Slice(w.Floors, func(i, j int) bool { return w.Floors[i].Floor < w.Floors[j].Floor })
	for id := 1; id <= NumRooms; id++ {
		r := w.Rooms[id]
		if r == nil {
			return nil, fmt.Errorf("castle: room %d is missing from the level files", id)
		}
		for d, to := range r.Exits {
			if to < 0 || to > NumRooms {
				return nil, fmt.Errorf("castle: room %d exit %c leads to room %d", id, d, to)
			}
		}
		for _, s := range r.Spawns {
			if !monIDs[s.Monster] {
				return nil, fmt.Errorf("castle: room %d spawns unknown monster %q", id, s.Monster)
			}
		}
	}
	if w.StartRoom == 0 {
		w.StartRoom, w.Start = 1, Pos{15, 15}
	}
	return w, nil
}

func (rj roomJSON) room(floor int) (*Room, error) {
	r := &Room{ID: rj.ID, Title: rj.Name, Area: rj.Area, Floor: floor, Desc: rj.Description,
		Exits: map[byte]int{}, Dark: rj.Dark, Doors: rj.Doors, OnArrive: rj.OnArrive,
		OnWave: rj.OnWave, Spawns: rj.Spawns}
	if len(rj.Map) != MapH {
		return nil, fmt.Errorf("map has %d rows, want %d", len(rj.Map), MapH)
	}
	for y, line := range rj.Map {
		rs := []rune(line)
		if len(rs) > MapW {
			return nil, fmt.Errorf("map row %d is %d characters, want at most %d", y+1, len(rs), MapW)
		}
		for x := 0; x < MapW; x++ {
			r.Map[y][x] = ' '
			if x < len(rs) {
				r.Map[y][x] = rs[x]
			}
		}
	}
	for d, to := range rj.Exits {
		if len(d) != 1 || !strings.Contains("NSEWUD", d) {
			return nil, fmt.Errorf("bad exit direction %q", d)
		}
		r.Exits[d[0]] = to
	}
	for _, t := range rj.Traps {
		tr := Trap{Flood: t.Flood}
		for _, c := range t.Cells {
			tr.Cells = append(tr.Cells, Pos{c[0], c[1]})
		}
		r.Traps = append(r.Traps, tr)
	}
	in := func(row, col int) bool { return row >= 1 && row <= MapH && col >= 1 && col <= MapW }
	for _, it := range rj.Items {
		it.Room = rj.ID
		if it.HiddenIn == "" && !in(it.Row, it.Col) {
			return nil, fmt.Errorf("item %q at row %d, col %d is off the map", it.ID, it.Row, it.Col)
		}
		if []rune(it.Glyph) == nil || len([]rune(it.Glyph)) != 1 {
			return nil, fmt.Errorf("item %q glyph %q must be one character", it.ID, it.Glyph)
		}
		r.Items = append(r.Items, it)
	}
	for _, m := range rj.Monsters {
		m.Room = rj.ID
		if m.Start != nil && !*m.Start {
			m.Room = 0
		} else if !in(m.Row, m.Col) {
			return nil, fmt.Errorf("monster %q at row %d, col %d is off the map", m.ID, m.Row, m.Col)
		}
		if len([]rune(m.Glyph)) != 1 {
			return nil, fmt.Errorf("monster %q glyph %q must be one character", m.ID, m.Glyph)
		}
		switch m.Kind {
		case "fighter", "vampire", "fairy":
		default:
			return nil, fmt.Errorf("monster %q has unknown kind %q", m.ID, m.Kind)
		}
		r.Monsters = append(r.Monsters, m)
	}
	return r, nil
}

// Room returns room id, or nil.
func (w *World) Room(id int) *Room {
	if id < 1 || id >= len(w.Rooms) {
		return nil
	}
	return w.Rooms[id]
}

// LevelFileName is the file a floor is stored in.
func LevelFileName(floor int) string { return path.Join("levels", fmt.Sprintf("floor_%d.json", floor)) }
