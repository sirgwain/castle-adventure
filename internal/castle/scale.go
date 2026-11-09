package castle

// Drawing a map square as a block of sx by sy terminal cells.
//
// Line art (walls, desk edges, the rack) is split into its four arms and
// redrawn through the block's centre, so walls stay thin, continuous lines at
// any size. Block elements are split into quadrants, stair bars into eighths,
// shades are repeated, and anything else (letters, the player, Ω) is drawn once
// in the middle of its block.

// Scale is how many terminal columns and rows one map square takes.
type Scale struct{ X, Y int }

// Scales offered from smallest to largest. Two columns per row keeps the
// original CGA proportions on a typical terminal font.
var Scales = []Scale{{1, 1}, {2, 1}, {4, 2}, {6, 3}, {8, 4}, {10, 5}}

// line weights for each arm (N, E, S, W)
const (
	wNone uint8 = iota
	wLight
	wHeavy
	wDouble
	wDashed
)

var lineArms = map[rune][4]uint8{
	'─': {0, 1, 0, 1}, '│': {1, 0, 1, 0}, '┌': {0, 1, 1, 0}, '┐': {0, 0, 1, 1}, '└': {1, 1, 0, 0},
	'┘': {1, 0, 0, 1}, '├': {1, 1, 1, 0}, '┤': {1, 0, 1, 1}, '┬': {0, 1, 1, 1}, '┴': {1, 1, 0, 1},
	'┼': {1, 1, 1, 1}, '╭': {0, 1, 1, 0}, '╮': {0, 0, 1, 1}, '╰': {1, 1, 0, 0}, '╯': {1, 0, 0, 1},
	'━': {0, 2, 0, 2}, '┃': {2, 0, 2, 0}, '┏': {0, 2, 2, 0}, '┓': {0, 0, 2, 2}, '┗': {2, 2, 0, 0},
	'┛': {2, 0, 0, 2}, '┣': {2, 2, 2, 0}, '┫': {2, 0, 2, 2}, '┳': {0, 2, 2, 2}, '┻': {2, 2, 0, 2},
	'╋': {2, 2, 2, 2},
	'═': {0, 3, 0, 3}, '║': {3, 0, 3, 0}, '╔': {0, 3, 3, 0}, '╗': {0, 0, 3, 3}, '╚': {3, 3, 0, 0},
	'╝': {3, 0, 0, 3}, '╠': {3, 3, 3, 0}, '╣': {3, 0, 3, 3}, '╦': {0, 3, 3, 3}, '╩': {3, 3, 0, 3},
	'╬': {3, 3, 3, 3},
	'╞': {1, 3, 1, 0}, '╡': {1, 0, 1, 3}, '╪': {1, 3, 1, 3}, '╟': {3, 1, 3, 0}, '╢': {3, 0, 3, 1},
	'╫': {3, 1, 3, 1}, '╤': {0, 3, 1, 3}, '╧': {1, 3, 0, 3}, '╓': {0, 1, 3, 0}, '╖': {0, 0, 3, 1},
	'╙': {3, 1, 0, 0}, '╜': {3, 0, 0, 1},
	'┄': {0, 4, 0, 4}, '┆': {4, 0, 4, 0},
}

var horizLine = [5]rune{' ', '─', '━', '═', '┄'}
var vertLine = [5]rune{' ', '│', '┃', '║', '┆'}

// quadrant bits: top-left 1, top-right 2, bottom-left 4, bottom-right 8
var quadBits = map[rune]uint8{
	' ': 0, '▘': 1, '▝': 2, '▖': 4, '▗': 8, '▀': 3, '▄': 12, '▌': 5, '▐': 10,
	'▚': 9, '▞': 6, '▛': 7, '▜': 11, '▙': 13, '▟': 14, '█': 15,
}
var quadRune = func() map[uint8]rune {
	m := map[uint8]rune{}
	for r, b := range quadBits {
		m[b] = r
	}
	return m
}()

// eighth-height bars (stairs); ▄ is handled as a half block
var eighths = map[rune]int{'▁': 1, '▂': 2, '▃': 3, '▅': 5, '▆': 6, '▇': 7}

const eighthRunes = " ▁▂▃▄▅▆▇█"

// repeated glyphs fill their whole block
const repeated = "▓▒░■≈"

// subCell is one terminal cell of a scaled square.
type subCell struct {
	r rune
	// bgFrom says whose background to use: 0 = the square's own, otherwise the
	// neighbouring square in that direction (dy, dx), so floor colour runs up to
	// a wall line instead of stopping a cell short.
	dy, dx int
}

// scaleGlyph returns the terminal cell (fy, fx) of glyph c drawn at scale s.
func scaleGlyph(c rune, s Scale, fy, fx int) subCell {
	if s.X == 1 && s.Y == 1 {
		return subCell{r: c}
	}
	cy, cx := (s.Y-1)/2, (s.X-1)/2
	if arms, ok := lineArms[c]; ok {
		switch {
		case fy == cy && fx == cx:
			return subCell{r: c}
		case fy == cy && fx > cx && arms[1] != 0:
			return subCell{r: horizLine[arms[1]]}
		case fy == cy && fx < cx && arms[3] != 0:
			return subCell{r: horizLine[arms[3]]}
		case fx == cx && fy < cy && arms[0] != 0:
			return subCell{r: vertLine[arms[0]]}
		case fx == cx && fy > cy && arms[2] != 0:
			return subCell{r: vertLine[arms[2]]}
		}
		return subCell{r: ' ', dy: sign(fy - cy), dx: sign(fx - cx)}
	}
	if bits, ok := quadBits[c]; ok {
		return subCell{r: quadCell(bits, s, fy, fx)}
	}
	if h, ok := eighths[c]; ok {
		k := s.Y - 1 - fy // rows counted from the bottom
		level := min(8, max(0, h*s.Y-8*k))
		return subCell{r: []rune(eighthRunes)[level]}
	}
	for _, rr := range repeated {
		if c == rr {
			return subCell{r: c}
		}
	}
	if fy == cy && fx == cx {
		return subCell{r: c}
	}
	return subCell{r: ' '}
}

// quadCell samples a quadrant pattern for one terminal cell of the block.
func quadCell(bits uint8, s Scale, fy, fx int) rune {
	cols, rows := halves(fx, s.X), halves(fy, s.Y)
	on := func(qy, qx int) bool { return bits&(1<<(qy*2+qx)) != 0 }
	switch {
	case len(rows) == 2 && len(cols) == 2: // the cell is the whole square
		return quadRune[bits]
	case len(rows) == 2: // one column of quadrants: top and bottom halves
		return pick(on(0, cols[0]), on(1, cols[0]), '▀', '▄')
	case len(cols) == 2: // one row of quadrants: left and right halves
		return pick(on(rows[0], 0), on(rows[0], 1), '▌', '▐')
	}
	if on(rows[0], cols[0]) {
		return '█'
	}
	return ' '
}

func pick(first, second bool, firstOnly, secondOnly rune) rune {
	switch {
	case first && second:
		return '█'
	case first:
		return firstOnly
	case second:
		return secondOnly
	}
	return ' '
}

// halves lists which halves (0 = first, 1 = second) of a square the i-th of n
// sub-cells overlaps.
func halves(i, n int) []int {
	var out []int
	for q := 0; q < 2; q++ {
		// sub-cell spans [i/n, (i+1)/n), half q spans [q/2, (q+1)/2)
		if 2*i < (q+1)*n && q*n < 2*(i+1) {
			out = append(out, q)
		}
	}
	return out
}

func sign(v int) int {
	switch {
	case v > 0:
		return 1
	case v < 0:
		return -1
	}
	return 0
}
