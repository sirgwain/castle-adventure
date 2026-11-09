package castle

import (
	"image/color"
	"strings"

	"charm.land/lipgloss/v2"
)

// RenderOptions controls how a room is drawn.
type RenderOptions struct {
	Classic bool  // original CGA look: grey on black, original glyphs
	Scale   Scale // terminal cells per map square; zero means 1x1
	PlayerY int   // 0-based player position; negative hides the player
	PlayerX int
}

var (
	cgaGrey  = lipgloss.Color("#aaaaaa")
	cgaBlack = lipgloss.Color("#000000")
	cgaWhite = lipgloss.Color("#ffffff")
	cPlayer  = lipgloss.Color("#ffffff")
)

// Player glyphs: the original drew CHR$(5), a club.
const (
	PlayerClassic = '♣'
	PlayerModern  = '☻'
)

// At scales two rows tall and up, the player fills its square with a small
// figure drawn in quadrant blocks (2x2 pixels per terminal cell). The bitmaps
// are 16x8 "pixels", which looks square on a terminal font, and are resampled
// to each scale.
var (
	playerArt = []string{
		"......####......",
		"......####......",
		"..############..",
		"......####......",
		"......####......",
		".....##..##.....",
		"....##....##....",
		"...##......##...",
	}
	clubArt = []string{ // the original CHR$(5)
		"......####......",
		".....######.....",
		"..###.####.###..",
		".##############.",
		".##############.",
		"..###..##..###..",
		".......##.......",
		".....######.....",
	}
)

// bitmapCell returns terminal cell (fy, fx) of a bitmap drawn over a whole square.
func bitmapCell(art []string, sc Scale, fy, fx int) rune {
	pw, ph := 2*sc.X, 2*sc.Y
	bh, bw := float64(len(art)), float64(len(art[0]))
	// A target pixel is lit when at least half the bitmap area it covers is
	// lit. Area sampling keeps a symmetric bitmap symmetric at every size.
	on := func(py, pxl int) bool {
		y0, y1 := float64(py)*bh/float64(ph), float64(py+1)*bh/float64(ph)
		x0, x1 := float64(pxl)*bw/float64(pw), float64(pxl+1)*bw/float64(pw)
		var lit, area float64
		for by := int(y0); float64(by) < y1; by++ {
			oy := min(y1, float64(by+1)) - max(y0, float64(by))
			for bx := int(x0); float64(bx) < x1; bx++ {
				a := oy * (min(x1, float64(bx+1)) - max(x0, float64(bx)))
				area += a
				if art[by][bx] == '#' {
					lit += a
				}
			}
		}
		return lit >= area/2-1e-9
	}
	var bits uint8
	for i, d := range [][2]int{{0, 0}, {0, 1}, {1, 0}, {1, 1}} {
		if on(2*fy+d[0], 2*fx+d[1]) {
			bits |= 1 << i
		}
	}
	return quadRune[bits]
}

type px struct {
	r      rune
	fg, bg color.Color
}

// Render draws a room as MapH*Scale.Y lines of styled text, each MapW*Scale.X wide.
func Render(r *Room, opt RenderOptions) []string {
	sc := opt.Scale
	if sc.X < 1 || sc.Y < 1 {
		sc = Scale{1, 1}
	}
	var grid [MapH][MapW]px
	if opt.Classic {
		s := Classic(r)
		for y := range grid {
			for x := range grid[y] {
				grid[y][x] = px{s[y][x].R, cgaGrey, cgaBlack}
			}
		}
	} else {
		s, t := Restyle(r), ThemeFor(r)
		for y := range grid {
			for x := range grid[y] {
				c := s[y][x]
				p := px{r: c.R, fg: t.Color(c, y, x)}
				if c.Role == RoleFloor || c.Role == RoleStairs {
					p.bg = t.Floor
				}
				grid[y][x] = p
			}
		}
	}
	if opt.PlayerY >= 0 && opt.PlayerY < MapH && opt.PlayerX >= 0 && opt.PlayerX < MapW {
		p := &grid[opt.PlayerY][opt.PlayerX]
		if opt.Classic {
			p.r, p.fg = PlayerClassic, cgaWhite
		} else {
			p.r, p.fg = PlayerModern, cPlayer
		}
	}
	bgAt := func(y, x int) color.Color {
		if y < 0 || y >= MapH || x < 0 || x >= MapW {
			return nil
		}
		return grid[y][x].bg
	}

	lines := make([]string, 0, MapH*sc.Y)
	for y := 0; y < MapH; y++ {
		for fy := 0; fy < sc.Y; fy++ {
			var b strings.Builder
			var run []rune
			var runFg, runBg color.Color
			flush := func() {
				if len(run) == 0 {
					return
				}
				st := lipgloss.NewStyle().Foreground(runFg)
				if runBg != nil {
					st = st.Background(runBg)
				}
				b.WriteString(st.Render(string(run)))
				run = run[:0]
			}
			for x := 0; x < MapW; x++ {
				p := grid[y][x]
				isPlayer := y == opt.PlayerY && x == opt.PlayerX && sc.Y >= 2
				for fx := 0; fx < sc.X; fx++ {
					sub := scaleGlyph(p.r, sc, fy, fx)
					if isPlayer {
						art := playerArt
						if opt.Classic {
							art = clubArt
						}
						sub = subCell{r: bitmapCell(art, sc, fy, fx)}
					}
					bg := p.bg
					if sub.dy != 0 || sub.dx != 0 {
						bg = bgAt(y+sub.dy, x+sub.dx)
						if opt.Classic {
							bg = cgaBlack
						}
					}
					if p.fg != runFg || bg != runBg {
						flush()
						runFg, runBg = p.fg, bg
					}
					run = append(run, sub.r)
				}
			}
			flush()
			lines = append(lines, b.String())
		}
	}
	return lines
}
