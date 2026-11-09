// Package game is the rules of Castle Adventure, rebuilt from the decompiled
// original (out/castle.bas). It has no terminal code: a UI calls Move, Command
// and MonsterTurn and draws what the Game reports.
//
// Positions are 1-based rows and columns, as in the original. Like the
// original, the rules look at what is "on screen" at a square: the map, with
// this visit's changes, locked doors, items, monsters and the player (see At).
package game

import (
	"math/rand/v2"
	"strings"
	"time"

	"github.com/sirgwain/castle-adventure/internal/castle"
)

const (
	MaxCarry     = 6
	StartHealth  = 100
	PerfectScore = 1550
	// MonsterTick is how often monsters move. The original moved them every 200
	// passes of its input loop, which took about 0.2 s on a 4.77 MHz IBM PC.
	MonsterTick = 200 * time.Millisecond
)

// Glyphs the rules look for on the "screen".
const (
	PlayerGlyph = '♣' // CHR$(5)
	gateGlyph   = '═'
	space       = ' '
)

// Outcome says whether the game is still going and how it ended.
type Outcome int

const (
	Playing Outcome = iota
	Escaped
	Died
	Quit
)

// Item is an item's current state.
type Item struct {
	castle.ItemDef
	Room     int // 0 = carried
	Row, Col int
	Hidden   bool
}

// Glyph is the item's map character.
func (it *Item) Glyph() rune { return []rune(it.ItemDef.Glyph)[0] }

// Noun is the word the player types for it: the last word of its name.
func (it *Item) Noun() string { return lastWord(it.Name) }

// Monster is a monster's current state.
type Monster struct {
	castle.MonsterDef
	Room     int // 0 = not in the castle
	Row, Col int
	HP       int
}

// Glyph is the monster's map character.
func (m *Monster) Glyph() rune { return []rune(m.MonsterDef.Glyph)[0] }

// Alive reports whether the monster can still act. As in the original, a
// monster dies when its hit points drop below zero.
func (m *Monster) Alive() bool { return m.HP > -1 }

// Noun is the word the player types for it ("OGRE" for "UGLY OGRE").
func (m *Monster) Noun() string { return afterFirstSpace(m.Name) }

// Sound is one SOUND, BEEP or PLAY from the original.
type Sound struct {
	Freq, Ticks float64 // SOUND freq, ticks (18.2 ticks a second)
	Beep        bool
	Music       string // a PLAY string
}

func (g *Game) sound(freq, ticks float64) {
	g.Sounds = append(g.Sounds, Sound{Freq: freq, Ticks: ticks})
}

// TakeSounds returns and clears the pending sounds.
func (g *Game) TakeSounds() []Sound {
	s := g.Sounds
	g.Sounds = nil
	return s
}

// HighScore is the score on the courtyard wall.
type HighScore struct {
	Name  string `json:"name"`
	Score int    `json:"score"`
}

// Store keeps saved games. The UI provides one backed by files.
type Store interface {
	Save(name string, data []byte) error
	Load(name string) ([]byte, error)
}

// Game is one game in progress.
type Game struct {
	World *castle.World

	Room, Prev int // current and previous room
	Row, Col   int // player position
	DY, DX     int // last move direction (DROP puts things there)
	Strength   int
	FlaskFull  bool
	Drank      bool
	Locked     map[int]bool // rooms whose door is locked

	Items    []*Item
	Monsters []*Monster

	// Edits are changes drawn into the current room during this visit (an
	// opened passage, a flooded trap). Like the original's screen writes they
	// are forgotten when the player leaves.
	Edits map[castle.Pos]rune

	Messages []string // the side panel's message lines
	Notice   string   // a short flash, like the original's "What???"
	Outcome  Outcome
	Hits     int // times the player has been struck (a UI can flash on change)

	HighScore HighScore
	Store     Store

	// Sounds are what the original played since the UI last took them:
	// SOUND freq, ticks; BEEP; or a PLAY music string.
	Sounds []Sound

	rng *rand.Rand
}

// New starts a game at the world's start position.
func New(w *castle.World, seed uint64) *Game {
	g := &Game{World: w, rng: rand.New(rand.NewPCG(seed, seed^0x9e3779b97f4a7c15))}
	g.reset()
	return g
}

func (g *Game) reset() {
	w := g.World
	g.Room, g.Prev = w.StartRoom, 0
	g.Row, g.Col = w.Start.Row, w.Start.Col
	g.DY, g.DX = 0, 0
	g.Strength, g.FlaskFull, g.Drank = StartHealth, false, false
	g.Locked = map[int]bool{}
	g.Items, g.Monsters = nil, nil
	for _, r := range w.Rooms[1:] {
		if len(r.Doors) > 0 {
			g.Locked[r.ID] = true
		}
		for _, d := range r.Items {
			g.Items = append(g.Items, &Item{ItemDef: d, Room: d.Room, Row: d.Row, Col: d.Col, Hidden: d.HiddenIn != ""})
		}
		for _, d := range r.Monsters {
			g.Monsters = append(g.Monsters, &Monster{MonsterDef: d, Room: d.Room, Row: d.Row, Col: d.Col, HP: d.HP})
		}
	}
	g.Messages, g.Notice, g.Outcome, g.Hits = nil, "", Playing, 0
	g.enter()
}

// CurrentRoom is the room the player is in.
func (g *Game) CurrentRoom() *castle.Room { return g.World.Room(g.Room) }

// Cell is the map character at a square, with this visit's edits and locked doors.
func (g *Game) Cell(row, col int) rune {
	if row < 1 || row > castle.MapH || col < 1 || col > castle.MapW {
		return 0
	}
	p := castle.Pos{Row: row, Col: col}
	if r, ok := g.Edits[p]; ok {
		return r
	}
	r := g.CurrentRoom()
	if g.Locked[r.ID] {
		for _, d := range r.Doors {
			if d == p {
				return castle.Door
			}
		}
	}
	return r.Map[row-1][col-1]
}

// At is what is "on screen" at a square, as the original's SCREEN(row, col)
// saw it: the player, a monster, an item, or the map.
func (g *Game) At(row, col int) rune {
	if row == g.Row && col == g.Col {
		return PlayerGlyph
	}
	if m := g.monsterAt(row, col); m != nil {
		return m.Glyph()
	}
	if it := g.itemAt(row, col); it != nil {
		return it.Glyph()
	}
	return g.Cell(row, col)
}

// Map is the current room's map with this visit's edits and locked doors.
func (g *Game) Map() [castle.MapH][castle.MapW]rune {
	var m [castle.MapH][castle.MapW]rune
	for y := 1; y <= castle.MapH; y++ {
		for x := 1; x <= castle.MapW; x++ {
			m[y-1][x-1] = g.Cell(y, x)
		}
	}
	return m
}

// ItemsHere are the visible items in the current room.
func (g *Game) ItemsHere() []*Item {
	var out []*Item
	for _, it := range g.Items {
		if it.Room == g.Room && !it.Hidden {
			out = append(out, it)
		}
	}
	return out
}

// MonstersHere are the monsters in the current room, dead or alive.
func (g *Game) MonstersHere() []*Monster {
	var out []*Monster
	for _, m := range g.Monsters {
		if m.Room == g.Room {
			out = append(out, m)
		}
	}
	return out
}

// Carried are the items the player is carrying.
func (g *Game) Carried() []*Item {
	var out []*Item
	for _, it := range g.Items {
		if it.Room == 0 {
			out = append(out, it)
		}
	}
	return out
}

func (g *Game) itemAt(row, col int) *Item {
	for _, it := range g.Items {
		if it.Room == g.Room && !it.Hidden && it.Row == row && it.Col == col {
			return it
		}
	}
	return nil
}

func (g *Game) monsterAt(row, col int) *Monster {
	for _, m := range g.Monsters {
		if m.Room == g.Room && m.Row == row && m.Col == col {
			return m
		}
	}
	return nil
}

func (g *Game) item(id string) *Item {
	for _, it := range g.Items {
		if it.ID == id {
			return it
		}
	}
	return nil
}

func (g *Game) monster(id string) *Monster {
	for _, m := range g.Monsters {
		if m.ID == id {
			return m
		}
	}
	return nil
}

// carrying reports whether the player has item id.
func (g *Game) carrying(id string) bool {
	it := g.item(id)
	return it != nil && it.Room == 0
}

func (g *Game) say(lines ...string) { g.Messages = lines }

// roll returns INT(RND * n) + 1.
func (g *Game) roll(n int) int { return g.rng.IntN(n) + 1 }

// damage applies the original's formula, X - INT(RND * 25) + 5, as written:
// from 5 points of healing to 19 points of damage.
func (g *Game) damage(hp int) int { return hp - g.rng.IntN(25) + 5 }

// ---------------------------------------------------------------- movement

// Move steps the player one square (dy, dx in -1..1), as the original's
// keypad did: off an edge takes that exit, onto U or D takes the stairs, and
// anything but floor is a bump.
func (g *Game) Move(dy, dx int) {
	if g.Outcome != Playing {
		return
	}
	g.Notice = ""
	g.DY, g.DX = dy, dx
	nr, nc := g.Row+dy, g.Col+dx
	switch {
	case nr < 1:
		g.takeExit('N', castle.MapH, g.Col)
	case nr > castle.MapH:
		g.takeExit('S', 1, g.Col)
	case nc < 1:
		g.takeExit('W', g.Row, castle.MapW)
	case nc > castle.MapW:
		g.takeExit('E', g.Row, 1)
	default:
		switch ch := g.At(nr, nc); ch {
		case 'U':
			g.takeExit('U', g.Row, g.Col)
		case 'D':
			g.takeExit('D', g.Row, g.Col)
		case space:
			g.Row, g.Col = nr, nc
		default:
			g.bump(nr, nc, ch)
		}
	}
	g.checkTraps()
}

func (g *Game) takeExit(dir byte, row, col int) {
	to := g.CurrentRoom().Exits[dir]
	if to == 0 { // no exit that way: the player has left the castle
		g.Prev = g.Room
		g.finish(Escaped)
		return
	}
	if r := g.World.Room(to); r != nil && r.Dark && !g.carrying("lamp") {
		g.say("It's too dark", "to go that way!")
		g.sound(100, 1)
		return
	}
	g.Prev, g.Room = g.Room, to
	g.Row, g.Col = row, col
	g.enter()
}

// enter applies the new room's arrival rules.
func (g *Game) enter() {
	g.Edits = map[castle.Pos]rune{}
	r := g.CurrentRoom()
	for _, s := range r.Spawns {
		if s.UnlessFrom == 0 || g.Prev != s.UnlessFrom {
			if m := g.monster(s.Monster); m != nil {
				m.Room, m.Row, m.Col = r.ID, s.Row, s.Col
			}
		}
	}
	for _, a := range r.OnArrive {
		if a.From != g.Prev {
			continue
		}
		g.applyEdits(a.Edits)
		if a.Row > 0 {
			g.Row, g.Col = a.Row, a.Col
		}
		if len(a.Message) > 0 {
			g.say(a.Message...)
		}
	}
}

func (g *Game) applyEdits(edits []castle.Edit) {
	for _, e := range edits {
		for i, r := range []rune(e.Text) {
			g.Edits[castle.Pos{Row: e.Row, Col: e.Col + i}] = r
		}
	}
}

func (g *Game) editsApplied(edits []castle.Edit) bool {
	for _, e := range edits {
		for i, r := range []rune(e.Text) {
			if g.Cell(e.Row, e.Col+i) != r {
				return false
			}
		}
	}
	return true
}

func (g *Game) bump(row, col int, ch rune) {
	if it := g.itemAt(row, col); it != nil {
		g.sound(500, 1)
		g.pickUp(it)
		return
	}
	switch ch {
	case castle.Door:
		g.sound(50, 1.5)
		g.say("The Door is", "locked.")
		return
	case gateGlyph:
		g.sound(50, 1)
		g.say("The Gate is", "locked.")
		return
	}
	if m := g.monsterAt(row, col); m != nil {
		switch m.Kind {
		case "vampire":
			g.sound(50, 1)
			g.say("The Vampire", "is blocking", "your way. He", "can't be hurt.")
		case "fairy":
			g.sound(50, 1)
			g.say("The Fairy", "is blocking", "your way. He", "can't be hurt.")
		default:
			if m.Alive() {
				g.attack(m)
			}
		}
		return
	}
	g.sound(50, 0.1) // a wall
}

func (g *Game) pickUp(it *Item) bool {
	if len(g.Carried()) >= MaxCarry {
		g.say("Can't carry", "any more!")
		return false
	}
	it.Room, it.Hidden = 0, false
	return true
}

// attack is the player hitting a monster; it needs the sword.
func (g *Game) attack(m *Monster) {
	if !g.carrying("sword") {
		g.say("You have no", "Weapon!")
		return
	}
	if g.roll(100) <= 50 {
		return // a miss, silently, as in the original
	}
	name := m.Noun()
	m.HP = g.damage(m.HP)
	if m.Alive() {
		g.say("You struck", "the "+name+"!")
		return
	}
	g.say("You Killed", "the "+name+"!")
	m.Name = "Dead " + name
}

// MonsterTurn moves every live fighting monster in the room one step toward
// the player, or lets it attack if the player is that step. A hit ends the
// turn, as in the original.
func (g *Game) MonsterTurn() {
	if g.Outcome != Playing {
		return
	}
	for _, m := range g.Monsters {
		if m.Kind != "fighter" || m.Room != g.Room || !m.Alive() {
			continue
		}
		tr, tc := m.Row+sign(g.Row-m.Row), m.Col+sign(g.Col-m.Col)
		if tr == g.Row && tc == g.Col {
			roll := g.roll(100)
			helmet := g.carrying("helmet")
			if helmet {
				roll -= 10
			}
			if roll <= 40 {
				continue
			}
			name := m.Noun()
			g.sound(150, 1)
			g.sound(90, 0.5)
			g.sound(40, 0.5)
			g.Strength = g.damage(g.Strength)
			g.Hits++
			if g.Strength < 0 {
				g.say("The "+name, "has Killed you!")
				g.finish(Died)
				return
			}
			lines := []string{"The " + name, "Struck you!"}
			if helmet {
				lines = append(lines, "", "The Helmet", "helped.")
			}
			g.say(lines...)
			return
		}
		if g.At(tr, tc) == space {
			m.Row, m.Col = tr, tc
		}
	}
}

func (g *Game) checkTraps() {
	if g.Outcome != Playing || g.carrying("necklace") {
		return
	}
	for _, t := range g.CurrentRoom().Traps {
		for _, c := range t.Cells {
			if c.Row == g.Row && c.Col == g.Col {
				g.applyEdits(t.Flood)
				g.say("You have sprung", "a Trap!! The", "room has filled", "with water and", "you drowned!")
				g.finish(Died)
				return
			}
		}
	}
}

func (g *Game) finish(o Outcome) { g.Outcome = o }

// ---------------------------------------------------------------- score

// Result is the end-of-game summary.
type Result struct {
	Outcome   Outcome
	Score     int
	Treasures []*Item    // treasures carried out, or left in the courtyard
	Kills     []*Monster // monsters killed
	Perfect   bool
}

// Result scores the game: 50 per treasure carried or left in the courtyard,
// 100 per monster killed, 100 for escaping.
func (g *Game) Result() Result {
	r := Result{Outcome: g.Outcome}
	if g.Outcome == Escaped {
		r.Score = 100
	}
	start := g.World.StartRoom
	for _, it := range g.Items {
		if it.Treasure && !it.Hidden && (it.Room == 0 || it.Room == start) {
			r.Score += 50
			r.Treasures = append(r.Treasures, it)
		}
	}
	for _, m := range g.Monsters {
		if m.Kind == "fighter" && !m.Alive() {
			r.Score += 100
			r.Kills = append(r.Kills, m)
		}
	}
	r.Perfect = r.Score == PerfectScore
	return r
}

// ---------------------------------------------------------------- helpers

func sign(v int) int {
	switch {
	case v > 0:
		return 1
	case v < 0:
		return -1
	}
	return 0
}

func lastWord(s string) string {
	f := strings.Fields(strings.ToUpper(s))
	if len(f) == 0 {
		return ""
	}
	return f[len(f)-1]
}

func afterFirstSpace(s string) string {
	s = strings.ToUpper(s)
	if i := strings.Index(s, " "); i > 0 {
		return s[i+1:]
	}
	return s
}
