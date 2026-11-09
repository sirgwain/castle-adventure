// Package textmode is a PC text-mode screen: a grid of characters, each with
// a foreground and background colour, written with LOCATE/PRINT-style calls
// and drawn with code page 437 glyphs (see Font).
package textmode

import "image/color"

// Cell is one character on the screen.
type Cell struct {
	R      rune
	FG, BG color.RGBA
}

// Screen is a text screen of Cols x Rows characters. Positions are 1-based,
// as in BASIC's LOCATE row, col.
type Screen struct {
	Cols, Rows int
	Cells      []Cell
	FG, BG     color.RGBA // colours used by Print and Clear
}

// The CGA palette.
var (
	Black        = color.RGBA{0x00, 0x00, 0x00, 0xff}
	Blue         = color.RGBA{0x00, 0x00, 0xaa, 0xff}
	Green        = color.RGBA{0x00, 0xaa, 0x00, 0xff}
	Cyan         = color.RGBA{0x00, 0xaa, 0xaa, 0xff}
	Red          = color.RGBA{0xaa, 0x00, 0x00, 0xff}
	Magenta      = color.RGBA{0xaa, 0x00, 0xaa, 0xff}
	Brown        = color.RGBA{0xaa, 0x55, 0x00, 0xff}
	LightGrey    = color.RGBA{0xaa, 0xaa, 0xaa, 0xff}
	DarkGrey     = color.RGBA{0x55, 0x55, 0x55, 0xff}
	LightBlue    = color.RGBA{0x55, 0x55, 0xff, 0xff}
	LightGreen   = color.RGBA{0x55, 0xff, 0x55, 0xff}
	LightCyan    = color.RGBA{0x55, 0xff, 0xff, 0xff}
	LightRed     = color.RGBA{0xff, 0x55, 0x55, 0xff}
	LightMagenta = color.RGBA{0xff, 0x55, 0xff, 0xff}
	Yellow       = color.RGBA{0xff, 0xff, 0x55, 0xff}
	White        = color.RGBA{0xff, 0xff, 0xff, 0xff}
)

// New makes a cleared screen, light grey on black like the PC after CLS.
func New(cols, rows int) *Screen {
	s := &Screen{Cols: cols, Rows: rows, Cells: make([]Cell, cols*rows), FG: LightGrey, BG: Black}
	s.Clear()
	return s
}

// Clear fills the screen with spaces in the current colours.
func (s *Screen) Clear() {
	for i := range s.Cells {
		s.Cells[i] = Cell{' ', s.FG, s.BG}
	}
}

// At returns the cell at row, col (1-based), or nil off screen.
func (s *Screen) At(row, col int) *Cell {
	if row < 1 || row > s.Rows || col < 1 || col > s.Cols {
		return nil
	}
	return &s.Cells[(row-1)*s.Cols+col-1]
}

// Set writes one character with explicit colours.
func (s *Screen) Set(row, col int, r rune, fg, bg color.RGBA) {
	if c := s.At(row, col); c != nil {
		*c = Cell{r, fg, bg}
	}
}

// Print writes text at row, col in fg on the current background. Like BASIC
// in 40/80-column mode it stops at the right edge rather than wrapping.
func (s *Screen) Print(row, col int, text string, fg color.RGBA) int {
	for _, r := range text {
		s.Set(row, col, r, fg, s.BG)
		col++
	}
	return col
}

// Center prints text centred on a row.
func (s *Screen) Center(row int, text string, fg color.RGBA) {
	n := len([]rune(text))
	s.Print(row, max(1, (s.Cols-n)/2+1), text, fg)
}
