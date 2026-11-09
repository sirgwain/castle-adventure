package castle

import (
	"os"
	"strings"
	"testing"

	"charm.land/lipgloss/v2"
	"github.com/mattn/go-runewidth"
)

func loadTestRooms(t *testing.T) []*Room {
	t.Helper()
	b, err := os.ReadFile("../../Castle.1984/CASTLE.RAN")
	if err != nil {
		t.Fatal(err)
	}
	rooms, err := LoadRooms(b)
	if err != nil {
		t.Fatal(err)
	}
	return rooms
}

func TestLoadRooms(t *testing.T) {
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

func TestGlyphsAreSingleWidth(t *testing.T) {
	for _, r := range loadTestRooms(t)[1:] {
		s := Restyle(r)
		for y := 0; y < MapH; y++ {
			for x := 0; x < MapW; x++ {
				c := s[y][x].R
				for _, sc := range Scales {
					for fy := 0; fy < sc.Y; fy++ {
						for fx := 0; fx < sc.X; fx++ {
							if g := scaleGlyph(c, sc, fy, fx).r; runewidth.RuneWidth(g) != 1 {
								t.Fatalf("room %d %q at scale %v gives %q (%d wide)", r.ID, c, sc, g, runewidth.RuneWidth(g))
							}
						}
					}
				}
			}
		}
	}
	for _, c := range []rune{PlayerClassic, PlayerModern} {
		if runewidth.RuneWidth(c) != 1 {
			t.Errorf("player glyph %q is not single width", c)
		}
	}
}

func TestRenderSizes(t *testing.T) {
	for _, r := range loadTestRooms(t)[1:] {
		for _, sc := range Scales {
			for _, classic := range []bool{false, true} {
				lines := Render(r, RenderOptions{Classic: classic, Scale: sc, PlayerY: 5, PlayerX: 5})
				if len(lines) != MapH*sc.Y {
					t.Fatalf("room %d scale %v: %d lines, want %d", r.ID, sc, len(lines), MapH*sc.Y)
				}
				for y, line := range lines {
					if w := lipgloss.Width(line); w != MapW*sc.X {
						t.Fatalf("room %d scale %v line %d is %d wide, want %d", r.ID, sc, y+1, w, MapW*sc.X)
					}
				}
			}
		}
	}
}

// A straight double wall stays one unbroken line at every scale.
func TestScaledWallsJoin(t *testing.T) {
	for _, sc := range Scales[1:] {
		cy, cx := (sc.Y-1)/2, (sc.X-1)/2
		row, col := "", ""
		for i := 0; i < 3; i++ {
			for fx := 0; fx < sc.X; fx++ {
				row += string(scaleGlyph('═', sc, cy, fx).r)
			}
		}
		for i := 0; i < 2; i++ {
			for fy := 0; fy < sc.Y; fy++ {
				col += string(scaleGlyph('║', sc, fy, cx).r)
			}
		}
		if row != strings.Repeat("═", 3*sc.X) {
			t.Errorf("scale %v: wall row %q", sc, row)
		}
		if col != strings.Repeat("║", 2*sc.Y) {
			t.Errorf("scale %v: wall column %q", sc, col)
		}
	}
	checks := []struct {
		c      rune
		fy, fx int
		want   rune
	}{
		{'╔', 0, 1, '╔'}, {'╔', 0, 3, '═'}, {'╔', 1, 1, '║'}, // corner keeps its glyph and grows arms
		{'▌', 0, 0, '█'}, {'▌', 0, 3, ' '}, // half block splits into whole cells
		{'▅', 0, 0, '▂'}, {'▅', 1, 0, '█'}, // stair bar grows taller
	}
	for _, c := range checks {
		if got := scaleGlyph(c.c, Scale{4, 2}, c.fy, c.fx).r; got != c.want {
			t.Errorf("%q at 4x2 cell (%d,%d) = %q, want %q", c.c, c.fy, c.fx, got, c.want)
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

// The big player figure is single-width quadrant glyphs and visible at every size.
func TestPlayerFigure(t *testing.T) {
	for _, sc := range Scales {
		if sc.Y < 2 {
			continue
		}
		for _, art := range [][]string{playerArt, clubArt} {
			lit := 0
			for fy := 0; fy < sc.Y; fy++ {
				for fx := 0; fx < sc.X; fx++ {
					g := bitmapCell(art, sc, fy, fx)
					if runewidth.RuneWidth(g) != 1 {
						t.Fatalf("scale %v: %q is not single width", sc, g)
					}
					if g != ' ' {
						lit++
					}
				}
			}
			if lit < sc.X*sc.Y/3 {
				t.Errorf("scale %v: figure only covers %d of %d cells", sc, lit, sc.X*sc.Y)
			}
		}
	}
}

// The figures are symmetric bitmaps, so every scaled row must mirror itself.
func TestPlayerFigureSymmetric(t *testing.T) {
	mirror := map[rune]rune{' ': ' ', '█': '█', '▀': '▀', '▄': '▄', '▌': '▐', '▐': '▌', '▘': '▝', '▝': '▘',
		'▖': '▗', '▗': '▖', '▛': '▜', '▜': '▛', '▙': '▟', '▟': '▙', '▚': '▞', '▞': '▚'}
	for _, sc := range Scales[2:] {
		for _, art := range [][]string{playerArt, clubArt} {
			for fy := 0; fy < sc.Y; fy++ {
				for fx := 0; fx < sc.X; fx++ {
					l, r := bitmapCell(art, sc, fy, fx), bitmapCell(art, sc, fy, sc.X-1-fx)
					if mirror[l] != r {
						t.Fatalf("scale %v row %d: %q at %d mirrors to %q at %d", sc, fy, l, fx, r, sc.X-1-fx)
					}
				}
			}
		}
	}
}
