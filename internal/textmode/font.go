package textmode

import (
	"image"
	"image/color"
	"image/draw"
	"math"

	xdraw "golang.org/x/image/draw"
	"golang.org/x/image/font"
	"golang.org/x/image/font/gofont/gomono"
	"golang.org/x/image/font/opentype"
	"golang.org/x/image/math/fixed"
)

// Font draws code page 437 glyphs into cells of W x H pixels.
//
// Box lines, block elements and shades are drawn as shapes on the IBM font's
// 8x8 grid, so walls join seamlessly from cell to cell. Everything else
// (letters, ☺ ♣ Ω ≈ …) comes from Go Mono, stretched to fill the cell the way
// the PC's 40-column characters filled theirs.
type Font struct {
	W, H  int
	face  font.Face
	size  float64
	cache map[rune]*image.Alpha
}

// NewFont makes a font for cells of w x h pixels.
func NewFont(w, h int) (*Font, error) {
	tt, err := opentype.Parse(gomono.TTF)
	if err != nil {
		return nil, err
	}
	size := float64(h) * 2 // rasterise large, then scale down for smooth edges
	face, err := opentype.NewFace(tt, &opentype.FaceOptions{Size: size, DPI: 72, Hinting: font.HintingNone})
	if err != nil {
		return nil, err
	}
	return &Font{W: w, H: h, face: face, size: size, cache: map[rune]*image.Alpha{}}, nil
}

// Glyph returns the coverage mask of r (W x H, 255 = ink).
func (f *Font) Glyph(r rune) *image.Alpha {
	if g, ok := f.cache[r]; ok {
		return g
	}
	g := image.NewAlpha(image.Rect(0, 0, f.W, f.H))
	if !f.shape(g, r) {
		f.text(g, r)
	}
	f.cache[r] = g
	return g
}

// fill inks grid units [gx0,gx1) x [gy0,gy1) of the 8x8 cell grid.
func (f *Font) fill(g *image.Alpha, gx0, gy0, gx1, gy1 float64) {
	x0, x1 := int(math.Round(gx0*float64(f.W)/8)), int(math.Round(gx1*float64(f.W)/8))
	y0, y1 := int(math.Round(gy0*float64(f.H)/8)), int(math.Round(gy1*float64(f.H)/8))
	draw.Draw(g, image.Rect(x0, y0, x1, y1), image.Opaque, image.Point{}, draw.Src)
}

// line arm weights (N, E, S, W): 1 single, 2 double
var lineArms = map[rune][4]uint8{
	'─': {0, 1, 0, 1}, '│': {1, 0, 1, 0}, '┌': {0, 1, 1, 0}, '┐': {0, 0, 1, 1}, '└': {1, 1, 0, 0},
	'┘': {1, 0, 0, 1}, '├': {1, 1, 1, 0}, '┤': {1, 0, 1, 1}, '┬': {0, 1, 1, 1}, '┴': {1, 1, 0, 1},
	'┼': {1, 1, 1, 1},
	'═': {0, 2, 0, 2}, '║': {2, 0, 2, 0}, '╔': {0, 2, 2, 0}, '╗': {0, 0, 2, 2}, '╚': {2, 2, 0, 0},
	'╝': {2, 0, 0, 2}, '╠': {2, 2, 2, 0}, '╣': {2, 0, 2, 2}, '╦': {0, 2, 2, 2}, '╩': {2, 2, 0, 2},
	'╬': {2, 2, 2, 2},
	'╞': {1, 2, 1, 0}, '╡': {1, 0, 1, 2}, '╪': {1, 2, 1, 2}, '╟': {2, 1, 2, 0}, '╢': {2, 0, 2, 1},
	'╫': {2, 1, 2, 1}, '╤': {0, 2, 1, 2}, '╧': {1, 2, 0, 2}, '╓': {0, 1, 2, 0}, '╖': {0, 0, 2, 1},
	'╙': {2, 1, 0, 0}, '╜': {2, 0, 0, 1}, '╒': {0, 2, 1, 0}, '╕': {0, 0, 1, 2}, '╘': {1, 2, 0, 0},
	'╛': {1, 0, 0, 2},
}

// shape draws box lines, blocks and shades; it reports false for other runes.
func (f *Font) shape(g *image.Alpha, r rune) bool {
	switch r {
	case '█':
		f.fill(g, 0, 0, 8, 8)
	case '▀':
		f.fill(g, 0, 0, 8, 4)
	case '▄':
		f.fill(g, 0, 4, 8, 8)
	case '▌':
		f.fill(g, 0, 0, 4, 8)
	case '▐':
		f.fill(g, 4, 0, 8, 8)
	case '■':
		f.fill(g, 2, 2, 6, 6)
	case '▬':
		f.fill(g, 0, 5, 7, 7)
	case '░', '▒', '▓':
		for gy := 0; gy < 8; gy++ {
			for gx := 0; gx < 8; gx++ {
				on := map[rune]bool{
					'░': (gx+2*gy)%4 == 0,
					'▒': (gx+gy)%2 == 0,
					'▓': (gx+2*gy)%4 != 2,
				}[r]
				if on {
					f.fill(g, float64(gx), float64(gy), float64(gx+1), float64(gy+1))
				}
			}
		}
	default:
		arms, ok := lineArms[r]
		if !ok {
			return false
		}
		f.lines(g, arms)
	}
	return true
}

// lines draws box-drawing arms. Single lines run along grid row/column 3;
// double lines along 2 and 4, joined so corners and tees close properly.
func (f *Font) lines(g *image.Alpha, a [4]uint8) {
	const c = 3.0 // centre band [3,4)
	n, e, s, w := a[0] != 0, a[1] != 0, a[2] != 0, a[3] != 0
	// where a double arm's line starts or ends next to the centre, depending on
	// whether the perpendicular arm on that side exists
	near := func(other bool, low bool) float64 {
		switch {
		case low && other:
			return c // stop at the outer line of the crossing pair
		case low:
			return c + 2
		case other:
			return c + 1
		}
		return c - 1
	}
	if a[1] == 1 { // E single
		f.fill(g, c, c, 8, c+1)
	}
	if a[3] == 1 { // W single
		f.fill(g, 0, c, c+1, c+1)
	}
	if a[0] == 1 { // N single
		f.fill(g, c, 0, c+1, c+1)
	}
	if a[2] == 1 { // S single
		f.fill(g, c, c, c+1, 8)
	}
	if a[1] == 2 { // E double: upper line on row 2, lower on row 4
		f.fill(g, near(n, false), c-1, 8, c)
		f.fill(g, near(s, false), c+1, 8, c+2)
	}
	if a[3] == 2 { // W double
		f.fill(g, 0, c-1, near(n, true), c)
		f.fill(g, 0, c+1, near(s, true), c+2)
	}
	if a[0] == 2 { // N double: left line on column 2, right on 4
		f.fill(g, c-1, 0, c, near(w, true))
		f.fill(g, c+1, 0, c+2, near(e, true))
	}
	if a[2] == 2 { // S double
		f.fill(g, c-1, near(w, false), c, 8)
		f.fill(g, c+1, near(e, false), c+2, 8)
	}
}

// text draws r from Go Mono, its advance box stretched to the cell.
func (f *Font) text(g *image.Alpha, r rune) {
	m := f.face.Metrics()
	adv, ok := f.face.GlyphAdvance(r)
	if !ok || adv <= 0 {
		return
	}
	w, h := adv.Ceil(), (m.Ascent + m.Descent).Ceil()
	big := image.NewAlpha(image.Rect(0, 0, w, h))
	d := font.Drawer{Dst: big, Src: image.NewUniform(color.Alpha{255}), Face: f.face,
		Dot: fixed.Point26_6{X: 0, Y: m.Ascent}}
	d.DrawString(string(r))
	// leave a little room around letters, as the PC font did
	pad := image.Rect(f.W/16, f.H/12, f.W-f.W/16, f.H-f.H/24)
	xdraw.CatmullRom.Scale(g, pad, big, big.Bounds(), xdraw.Over, nil)
}
