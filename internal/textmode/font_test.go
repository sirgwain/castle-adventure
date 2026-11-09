package textmode

import "testing"

func ink(f *Font, r rune, x, y int) bool { return f.Glyph(r).AlphaAt(x, y).A > 128 }

// Box lines must reach the cell edges on the right rows/columns, so that
// neighbouring cells join without gaps.
func TestLinesJoin(t *testing.T) {
	f, err := NewFont(20, 24)
	if err != nil {
		t.Fatal(err)
	}
	midY := 3*f.H/8 + 1 // inside single-line band [3,4) of the 8x8 grid
	if !ink(f, '─', 0, midY) || !ink(f, '─', f.W-1, midY) {
		t.Error("─ does not reach both edges")
	}
	midX := 3*f.W/8 + 1
	if !ink(f, '│', midX, 0) || !ink(f, '│', midX, f.H-1) {
		t.Error("│ does not reach top and bottom")
	}
	upper, lower := 2*f.H/8+1, 4*f.H/8+1
	for _, r := range []rune{'═', '╔', '╦', '╬'} {
		if !ink(f, r, f.W-1, upper) || !ink(f, r, f.W-1, lower) {
			t.Errorf("%q double line does not reach the right edge", r)
		}
	}
	// ╔: the outer corner is closed, nothing goes up or left
	if ink(f, '╔', 0, upper) || ink(f, '╔', 2*f.W/8+1, 0) {
		t.Error("╔ has an arm going left or up")
	}
	if !ink(f, '╔', 2*f.W/8+1, upper) {
		t.Error("╔ outer corner is open")
	}
}

func TestShadesAndText(t *testing.T) {
	f, err := NewFont(20, 24)
	if err != nil {
		t.Fatal(err)
	}
	cover := func(r rune) int {
		n := 0
		g := f.Glyph(r)
		for _, a := range g.Pix {
			if a > 128 {
				n++
			}
		}
		return n * 100 / len(g.Pix)
	}
	if a, b, c, d := cover('░'), cover('▒'), cover('▓'), cover('█'); !(a < b && b < c && c < d && d == 100) {
		t.Errorf("shade coverage ░%d ▒%d ▓%d █%d", a, b, c, d)
	}
	for _, r := range "A@☺♣Ω≈÷τ" {
		if cover(r) == 0 {
			t.Errorf("%q drew nothing", r)
		}
	}
	if cover(' ') != 0 {
		t.Error("space has ink")
	}
}
