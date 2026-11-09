package castle

import (
	"os"
	"strings"
	"testing"
	"testing/fstest"
)

func loadTestRooms(t *testing.T) []*Room {
	t.Helper()
	w, err := LoadWorld()
	if err != nil {
		t.Fatal(err)
	}
	return w.Rooms
}

func loadRAN(t *testing.T) []*Room {
	t.Helper()
	b, err := os.ReadFile("../../Castle.1984/CASTLE.RAN")
	if err != nil {
		t.Fatal(err)
	}
	rooms, err := LoadRAN(b)
	if err != nil {
		t.Fatal(err)
	}
	return rooms
}

func TestLoadWorld(t *testing.T) {
	rooms := loadTestRooms(t)
	if len(rooms) != NumRooms+1 || rooms[0] != nil {
		t.Fatalf("got %d rooms, want 1-based slice of %d", len(rooms), NumRooms)
	}
	r := rooms[1]
	if r.Name() != "Castle Courtyard" || r.Exits['N'] != 2 || len(r.Exits) != 1 {
		t.Errorf("room 1 = %q exits %v", r.Name(), r.Exits)
	}
	if got := string(r.Map[17][10:14]); got != "════" {
		t.Errorf("room 1 gate = %q", got)
	}
	// every exit leads to a real room and back
	opp := map[byte]byte{'N': 'S', 'S': 'N', 'E': 'W', 'W': 'E', 'U': 'D', 'D': 'U'}
	for _, r := range rooms[1:] {
		for d, to := range r.Exits {
			if to < 1 || to > NumRooms || rooms[to].Exits[opp[d]] != r.ID {
				t.Errorf("room %d exit %c -> %d is not two-way", r.ID, d, to)
			}
		}
	}
	items, monsters := 0, 0
	for _, r := range rooms[1:] {
		items += len(r.Items)
		monsters += len(r.Monsters)
	}
	if items != 22 || monsters != 10 {
		t.Errorf("%d items and %d monsters, want 22 and 10", items, monsters)
	}
}

// The level files started as an export of CASTLE.RAN. This shows any drift;
// update it when you change a room on purpose.
func TestLevelsMatchRAN(t *testing.T) {
	ran, json := loadRAN(t), loadTestRooms(t)
	for id := 1; id <= NumRooms; id++ {
		a, b := ran[id], json[id]
		if a.Map != b.Map {
			t.Errorf("room %d map differs from CASTLE.RAN", id)
		}
		// The level files add a space where the original's 25-column lines broke
		// without one ("theWest"), so compare the words, not the spacing.
		if strings.ReplaceAll(a.Desc, " ", "") != strings.ReplaceAll(b.Desc, " ", "") {
			t.Errorf("room %d description %q, CASTLE.RAN has %q", id, b.Desc, a.Desc)
		}
		if len(a.Exits) != len(b.Exits) {
			t.Errorf("room %d exits %v, CASTLE.RAN has %v", id, b.Exits, a.Exits)
		}
		for d, to := range a.Exits {
			if b.Exits[d] != to {
				t.Errorf("room %d exit %c = %d, CASTLE.RAN has %d", id, d, b.Exits[d], to)
			}
		}
	}
}

func TestLevelValidation(t *testing.T) {
	bad := `{"floor": 0, "name": "x", "rooms": [{"id": 1, "name": "r", "exits": {}, "map": ["` +
		strings.Repeat("x", 25) + `"]}]}`
	_, err := LoadWorldFS(fstest.MapFS{"floor_0.json": {Data: []byte(bad)}})
	if err == nil || !strings.Contains(err.Error(), "rows") {
		t.Errorf("want a map-size error, got %v", err)
	}
}

// What you see is what blocks you: the restyle never changes the footprint.
func TestRestyleKeepsFootprint(t *testing.T) {
	for _, r := range loadTestRooms(t)[1:] {
		s := Restyle(r)
		for y := 0; y < MapH; y++ {
			for x := 0; x < MapW; x++ {
				orig, got := r.Map[y][x], s[y][x].R
				if (orig == ' ') != (got == ' ') {
					t.Errorf("room %d (%d,%d): %q became %q", r.ID, y+1, x+1, orig, got)
				}
			}
		}
	}
}

func TestFurnitureIsRecognised(t *testing.T) {
	rooms := loadTestRooms(t)
	cases := []struct {
		room int
		y, x int
		want rune
	}{
		{40, 5, 5, '▌'},  // Yellow Room bed headboard
		{68, 2, 3, '╭'},  // wine barrel
		{58, 7, 7, '║'},  // library books
		{18, 9, 11, '≈'}, // fountain water
		{19, 8, 11, 'Ω'}, // statue of the king
		{1, 17, 10, '╫'}, // portcullis
		{14, 4, 10, '▙'}, // throne seat
		{7, 8, 11, '▅'},  // stairs up
	}
	for _, c := range cases {
		if got := Restyle(rooms[c.room])[c.y][c.x].R; got != c.want {
			t.Errorf("room %d (%d,%d) = %q, want %q (original %q)", c.room, c.y+1, c.x+1, got, c.want, rooms[c.room].Map[c.y][c.x])
		}
	}
}

// Colors keeps the original characters and only adds colour roles.
func TestColorsKeepOriginal(t *testing.T) {
	for _, r := range loadTestRooms(t)[1:] {
		s := Colors(r)
		for y := 0; y < MapH; y++ {
			for x := 0; x < MapW; x++ {
				if s[y][x].R != r.Map[y][x] {
					t.Fatalf("room %d (%d,%d) changed %q to %q", r.ID, y+1, x+1, r.Map[y][x], s[y][x].R)
				}
			}
		}
	}
	bed := Colors(loadTestRooms(t)[39])[5][5] // the Purple Room bed
	if bed.Role != RoleQuilt && bed.Role != RoleHeadboard {
		t.Errorf("Purple Room bed role = %v", bed.Role)
	}
}
