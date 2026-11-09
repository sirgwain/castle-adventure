package castle

import (
	"image/color"
	"strings"

	colorful "github.com/lucasb-eyer/go-colorful"
)

// Theme colours a restyled room. Roles without an entry use Furniture.
type Theme struct {
	Floor  color.Color // background of walkable floor inside the room
	Colors map[Role]color.Color
}

var (
	cStone   = hex("#9aa1ab")
	cFloor   = hex("#16191f")
	cNight   = hex("#0b0d11")
	cWood    = hex("#a0703f")
	cLinen   = hex("#c9c1b0")
	cPillow  = hex("#f4f1ea")
	cIron    = hex("#8d99a6")
	cGold    = hex("#e3b341")
	cWater   = hex("#4fc3f7")
	cMirror  = hex("#c9e9f6")
	cBlood   = hex("#a4161a")
	cMarble  = hex("#eceff3")
	cStairs  = hex("#5fd7d7")
	cSoft    = hex("#6b7280")
	bookSpin = []color.Color{
		hex("#b23a48"), hex("#3a6ea5"), hex("#4f8a3a"),
		hex("#c08a2e"), hex("#7d4fa0"), hex("#a0522d"),
	}
	rainbow = []color.Color{
		hex("#e05252"), hex("#f08c3a"), hex("#f0cf4a"),
		hex("#5fbf5f"), hex("#4fa3e0"), hex("#9a6ae8"),
	}
)

// accents for the four decorated bedrooms ("decorated all in purple" …).
var accents = []struct {
	word string
	hex  string
}{
	{"red", "#e05252"}, {"blue", "#5a8cf0"}, {"purple", "#b06ae8"}, {"yellow", "#f0cf4a"},
}

type mood uint8

const (
	moodCastle mood = iota
	moodGarden
	moodDungeon
	moodCellar
	moodKitchen
	moodSorcerer
)

// moodOf classifies a room by its own name, so a dining room that merely
// mentions the garden patio stays a castle room.
func moodOf(r *Room) mood {
	n := strings.ToLower(r.Name())
	switch {
	case strings.Contains(n, "garden") && !strings.Contains(n, "balcony"):
		return moodGarden
	case containsAny(n, "dungeon", "toture", "maze", "passage"):
		return moodDungeon
	case strings.Contains(n, "wine"):
		return moodCellar
	case strings.Contains(n, "kitchen"):
		return moodKitchen
	case strings.Contains(n, "sorcerer"):
		return moodSorcerer
	}
	return moodCastle
}

// ThemeFor builds a room's colours from the words in its description.
func ThemeFor(r *Room) Theme {
	t := Theme{Floor: cFloor, Colors: map[Role]color.Color{
		RoleWall: cStone, RoleSoft: cSoft, RoleStairs: cStairs, RoleFurniture: cStone,
		RoleHeadboard: cWood, RolePillow: cPillow, RoleQuilt: cLinen, RoleWood: cWood,
		RoleStone: cStone, RoleIron: cIron, RoleGold: cGold, RoleWater: cWater,
		RoleMirror: cMirror, RoleBlood: cBlood, RoleMarble: cMarble, RoleChain: cIron,
	}}
	d := strings.ToLower(r.Desc)
	for _, a := range accents {
		if strings.Contains(d, "decorated all in "+a.word) || strings.Contains(d, "the "+a.word+" room") {
			c := hex(a.hex)
			t.Colors[RoleWall] = blend(cStone, c, 0.35)
			t.Colors[RoleQuilt] = c
			t.Floor = blend(cNight, c, 0.14)
		}
	}
	switch moodOf(r) {
	case moodGarden:
		t.Colors[RoleWall] = hex("#4f9a48")  // hedges
		t.Colors[RoleSoft] = hex("#74c365")  // bushes
		t.Colors[RoleStone] = hex("#b9bfc8") // fountain rim
		t.Floor = hex("#0f1f11")
	case moodDungeon:
		t.Colors[RoleWall] = hex("#6f7c88")
		t.Colors[RoleSoft] = hex("#3f4851")
		t.Floor = hex("#0d1115")
	case moodCellar:
		t.Colors[RoleWall] = hex("#8a8178")
		t.Floor = hex("#18120d")
	case moodKitchen:
		t.Colors[RoleStone] = hex("#b8b2a7")
	case moodSorcerer:
		t.Colors[RoleWall] = blend(cStone, hex("#6a5acd"), 0.25)
		t.Floor = hex("#120f1c")
	}
	return t
}

// Color returns the foreground for a cell; books and rainbow walls vary by position.
func (t Theme) Color(c Cell, y, x int) color.Color {
	switch c.Role {
	case RoleBook:
		return bookSpin[(x*7+y*3)%len(bookSpin)]
	case RoleRainbow:
		return rainbow[(x+y)%len(rainbow)]
	}
	if col, ok := t.Colors[c.Role]; ok {
		return col
	}
	return t.Colors[RoleFurniture]
}

// hex parses "#rrggbb".
func hex(s string) color.Color {
	c, err := colorful.Hex(s)
	if err != nil {
		panic(err)
	}
	r, g, b := c.RGB255()
	return color.RGBA{r, g, b, 0xff}
}

// Colors gives every square of the room its original character and the colour
// role the restyler worked out for it (wall, bed, books, water …).
func Colors(r *Room) Styled {
	s := Restyle(r)
	for y := 0; y < MapH; y++ {
		for x := 0; x < MapW; x++ {
			s[y][x].R = r.Map[y][x]
		}
	}
	return s
}

// RGBA is a theme colour as color.RGBA.
func RGBA(c color.Color) color.RGBA {
	r, g, b, a := c.RGBA()
	return color.RGBA{uint8(r >> 8), uint8(g >> 8), uint8(b >> 8), uint8(a >> 8)}
}

func blend(a, b color.Color, f float64) color.Color {
	ca, _ := colorful.MakeColor(a)
	cb, _ := colorful.MakeColor(b)
	return ca.BlendLab(cb, f).Clamped()
}
