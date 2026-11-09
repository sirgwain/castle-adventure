package castle

import (
	"image/color"
	"strings"

	"charm.land/lipgloss/v2"
	colorful "github.com/lucasb-eyer/go-colorful"
)

// Theme colours a restyled room. Roles without an entry use Furniture.
type Theme struct {
	Floor  color.Color // background of walkable floor inside the room
	Colors map[Role]color.Color
}

var (
	cStone   = lipgloss.Color("#9aa1ab")
	cFloor   = lipgloss.Color("#16191f")
	cNight   = lipgloss.Color("#0b0d11")
	cWood    = lipgloss.Color("#a0703f")
	cLinen   = lipgloss.Color("#c9c1b0")
	cPillow  = lipgloss.Color("#f4f1ea")
	cIron    = lipgloss.Color("#8d99a6")
	cGold    = lipgloss.Color("#e3b341")
	cWater   = lipgloss.Color("#4fc3f7")
	cMirror  = lipgloss.Color("#c9e9f6")
	cBlood   = lipgloss.Color("#a4161a")
	cMarble  = lipgloss.Color("#eceff3")
	cStairs  = lipgloss.Color("#5fd7d7")
	cSoft    = lipgloss.Color("#6b7280")
	bookSpin = []color.Color{
		lipgloss.Color("#b23a48"), lipgloss.Color("#3a6ea5"), lipgloss.Color("#4f8a3a"),
		lipgloss.Color("#c08a2e"), lipgloss.Color("#7d4fa0"), lipgloss.Color("#a0522d"),
	}
	rainbow = []color.Color{
		lipgloss.Color("#e05252"), lipgloss.Color("#f08c3a"), lipgloss.Color("#f0cf4a"),
		lipgloss.Color("#5fbf5f"), lipgloss.Color("#4fa3e0"), lipgloss.Color("#9a6ae8"),
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
			c := lipgloss.Color(a.hex)
			t.Colors[RoleWall] = blend(cStone, c, 0.35)
			t.Colors[RoleQuilt] = c
			t.Floor = blend(cNight, c, 0.14)
		}
	}
	switch moodOf(r) {
	case moodGarden:
		t.Colors[RoleWall] = lipgloss.Color("#4f9a48")  // hedges
		t.Colors[RoleSoft] = lipgloss.Color("#74c365")  // bushes
		t.Colors[RoleStone] = lipgloss.Color("#b9bfc8") // fountain rim
		t.Floor = lipgloss.Color("#0f1f11")
	case moodDungeon:
		t.Colors[RoleWall] = lipgloss.Color("#6f7c88")
		t.Colors[RoleSoft] = lipgloss.Color("#3f4851")
		t.Floor = lipgloss.Color("#0d1115")
	case moodCellar:
		t.Colors[RoleWall] = lipgloss.Color("#8a8178")
		t.Floor = lipgloss.Color("#18120d")
	case moodKitchen:
		t.Colors[RoleStone] = lipgloss.Color("#b8b2a7")
	case moodSorcerer:
		t.Colors[RoleWall] = blend(cStone, lipgloss.Color("#6a5acd"), 0.25)
		t.Floor = lipgloss.Color("#120f1c")
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

func blend(a, b color.Color, f float64) color.Color {
	ca, _ := colorful.MakeColor(a)
	cb, _ := colorful.MakeColor(b)
	return ca.BlendLab(cb, f).Clamped()
}
