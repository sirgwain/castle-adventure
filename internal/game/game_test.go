package game

import (
	"strings"
	"testing"

	"github.com/sirgwain/castle-adventure/internal/castle"
)

func newGame(t *testing.T) *Game {
	t.Helper()
	w, err := castle.LoadWorld()
	if err != nil {
		t.Fatal(err)
	}
	return New(w, 1)
}

// goTo puts the player in a room as if arriving from prev.
func goTo(g *Game, room, prev, row, col int) {
	g.Prev, g.Room, g.Row, g.Col = prev, room, row, col
	g.enter()
}

func give(t *testing.T, g *Game, ids ...string) {
	t.Helper()
	for _, id := range ids {
		it := g.item(id)
		if it == nil {
			t.Fatalf("no item %q", id)
		}
		it.Room, it.Hidden = 0, false
	}
}

func said(g *Game) string { return strings.Join(g.Messages, " ") }

func TestStartAndLeaveCourtyard(t *testing.T) {
	g := newGame(t)
	if g.Room != 1 || g.Row != 15 || g.Col != 15 {
		t.Fatalf("start = room %d (%d,%d)", g.Room, g.Row, g.Col)
	}
	for i := 0; i < 20; i++ { // column 15 is wall at the top: the doorway is columns 11-14
		g.Move(-1, 0)
	}
	if g.Room != 1 || g.Row != 2 {
		t.Fatalf("walked through a wall: room %d row %d", g.Room, g.Row)
	}
	g.Move(0, -1)
	g.Move(-1, 0)
	g.Move(-1, 0)
	if g.Room != 2 || g.Row != castle.MapH || g.Col != 14 {
		t.Fatalf("after the doorway: room %d (%d,%d), want room 2 (18,14)", g.Room, g.Row, g.Col)
	}
}

func TestBumpPicksUpItem(t *testing.T) {
	g := newGame(t)
	sword := g.item("sword")
	goTo(g, sword.Room, 6, sword.Row+1, sword.Col)
	g.Move(-1, 0)
	if !g.carrying("sword") {
		t.Fatal("bumping the sword did not pick it up")
	}
}

func TestHiddenKeyNeedsDesk(t *testing.T) {
	g := newGame(t)
	goTo(g, 56, 55, 16, 12)
	g.Command("get key")
	if said(g) != "I can't reach it!" {
		t.Fatalf("far from the desk: %q", said(g))
	}
	g.Command("look desk")
	if said(g) != "There is a Key on top" {
		t.Fatalf("look desk: %q", said(g))
	}
	g.Row, g.Col = 9, 12 // just below the desk
	g.Command("get key")
	if said(g) != "Done." || !g.carrying("key") {
		t.Fatalf("next to the desk: %q", said(g))
	}
}

func TestDarkCellarNeedsLamp(t *testing.T) {
	g := newGame(t)
	goTo(g, 11, 9, 7, 4) // the storage room's stairs down are at row 7, column 3
	g.Move(0, -1)
	if g.Room != 11 || said(g) != "It's too dark to go that way!" {
		t.Fatalf("without the lamp: room %d %q", g.Room, said(g))
	}
	give(t, g, "lamp")
	g.Move(0, -1)
	if g.Room != rmWineCellar {
		t.Fatalf("with the lamp: room %d", g.Room)
	}
}

func TestTrapDrowns(t *testing.T) {
	g := newGame(t)
	goTo(g, 76, 75, 12, 15)
	g.Move(1, 0)
	if g.Outcome != Died {
		t.Fatalf("outcome %v, want Died", g.Outcome)
	}
	g = newGame(t)
	give(t, g, "necklace")
	goTo(g, 76, 75, 12, 15)
	g.Move(1, 0)
	if g.Outcome != Playing {
		t.Fatal("the necklace did not protect from the trap")
	}
}

func TestEscapeThroughGate(t *testing.T) {
	g := newGame(t)
	g.Row, g.Col = 17, 12
	g.Move(1, 0)
	if said(g) != "The Gate is locked." {
		t.Fatalf("gate: %q", said(g))
	}
	g.Command("wave scepter")
	if !strings.HasPrefix(said(g), "You don't have") {
		t.Fatalf("waving without the scepter: %q", said(g))
	}
	give(t, g, "scepter")
	g.Command("wave scepter")
	if !strings.Contains(said(g), "The Gate opens") {
		t.Fatalf("wave scepter: %q", said(g))
	}
	g.Move(1, 0)
	g.Move(1, 0)
	if g.Outcome != Escaped {
		t.Fatalf("outcome %v, want Escaped", g.Outcome)
	}
	if r := g.Result(); r.Score != 150 || len(r.Treasures) != 1 {
		t.Fatalf("score %d with %d treasures, want 150 with the scepter", r.Score, len(r.Treasures))
	}
}

func TestVampireAndCross(t *testing.T) {
	g := newGame(t)
	v := g.monster("vampire")
	goTo(g, v.Room, 23, v.Row, v.Col-1)
	g.Move(0, 1)
	if !strings.Contains(said(g), "Vampire is blocking") {
		t.Fatalf("bump vampire: %q", said(g))
	}
	give(t, g, "cross")
	g.Command("show cross")
	if v.Room != 0 || !strings.Contains(said(g), "disappears") {
		t.Fatalf("show cross: room %d %q", v.Room, said(g))
	}
}

func TestMonsterMovesAndStrikes(t *testing.T) {
	g := newGame(t)
	ogre := g.monster("ogre1")
	goTo(g, ogre.Room, 3, ogre.Row, ogre.Col-3)
	g.MonsterTurn()
	if ogre.Row != g.Row || ogre.Col != g.Col+2 {
		t.Fatalf("ogre at (%d,%d), want one step closer", ogre.Row, ogre.Col)
	}
	for i := 0; i < 200 && g.Hits == 0; i++ {
		g.MonsterTurn()
	}
	if g.Hits == 0 || !strings.Contains(said(g), "Struck you") && g.Outcome != Died {
		t.Fatalf("ogre never struck: hits %d %q", g.Hits, said(g))
	}
}

func TestPlayerFights(t *testing.T) {
	g := newGame(t)
	ogre := g.monster("ogre1")
	goTo(g, ogre.Room, 3, ogre.Row, ogre.Col-1)
	g.Move(0, 1)
	if said(g) != "You have no Weapon!" {
		t.Fatalf("unarmed: %q", said(g))
	}
	give(t, g, "sword")
	for i := 0; i < 500 && ogre.Alive(); i++ {
		g.Move(0, 1)
	}
	if ogre.Alive() || ogre.Name != "Dead OGRE" {
		t.Fatalf("ogre still alive with %d HP (%q)", ogre.HP, ogre.Name)
	}
	if r := g.Result(); len(r.Kills) != 1 {
		t.Fatalf("kills = %d", len(r.Kills))
	}
}

func TestFairySpawn(t *testing.T) {
	g := newGame(t)
	fairy := g.monster("fairy")
	if fairy.Room != 0 {
		t.Fatalf("fairy starts in room %d", fairy.Room)
	}
	goTo(g, 52, 53, 17, 12)
	if fairy.Room != 52 || fairy.Row != 10 || fairy.Col != 1 {
		t.Fatalf("fairy at room %d (%d,%d)", fairy.Room, fairy.Row, fairy.Col)
	}
	give(t, g, "harp")
	g.Command("play harp")
	if fairy.Room != 0 || !strings.Contains(said(g), "leaves") {
		t.Fatalf("play harp: %q", said(g))
	}
	goTo(g, 52, 57, 10, 2) // arriving from the diamond room: no fairy
	if fairy.Room != 0 {
		t.Fatal("the fairy appeared when arriving from room 57")
	}
}

func TestFillFlaskAtFountain(t *testing.T) {
	g := newGame(t)
	give(t, g, "flask")
	goTo(g, rmGardenSouth, 17, 4, 12)
	g.Command("fill flask")
	if said(g) != "I can't reach it!" {
		t.Fatalf("far from the fountain: %q", said(g))
	}
	g.Row, g.Col = 8, 12 // just above the fountain
	g.Command("fill flask")
	if said(g) != "Done." || !g.FlaskFull {
		t.Fatalf("at the fountain: %q", said(g))
	}
	g.Strength = 10
	g.Command("drink water")
	if g.Strength != StartHealth || g.FlaskFull {
		t.Fatalf("drink: strength %d full %v", g.Strength, g.FlaskFull)
	}
}

func TestCommandsParse(t *testing.T) {
	g := newGame(t)
	g.Command("xyzzy")
	if g.Notice != "What???" {
		t.Fatalf("one word: notice %q", g.Notice)
	}
	g.Command("inventory")
	if said(g) != "- Inventory -  Nothing." {
		t.Fatalf("inventory: %q", said(g))
	}
	give(t, g, "lamp")
	g.Command("look lamp")
	if said(g) != "It's lit Magically" {
		t.Fatalf("look lamp: %q", said(g))
	}
	g.Command("look wall")
	if !strings.HasPrefix(said(g), "Writing on the wall says") {
		t.Fatalf("look wall: %q", said(g))
	}
}

type memStore map[string][]byte

func (m memStore) Save(name string, b []byte) error { m[name] = b; return nil }
func (m memStore) Load(name string) ([]byte, error) {
	if b, ok := m[name]; ok {
		return b, nil
	}
	return nil, errNotFound
}

var errNotFound = &notFound{}

type notFound struct{}

func (*notFound) Error() string { return "not found" }

func TestSaveAndLoad(t *testing.T) {
	g := newGame(t)
	g.Store = memStore{}
	give(t, g, "sword", "lamp")
	ogre := g.monster("ogre1")
	ogre.HP, ogre.Row = 7, 3
	goTo(g, 12, 6, 10, 10)
	g.Command("save game1")
	if said(g) != "Game Saved" {
		t.Fatalf("save: %q", said(g))
	}
	h := newGame(t)
	h.Store = g.Store
	h.Command("load game1")
	if said(h) != "Game Loaded" || h.Room != 12 || !h.carrying("sword") || h.monster("ogre1").HP != 7 || h.monster("ogre1").Row != 3 {
		t.Fatalf("load: %q room %d", said(h), h.Room)
	}
	h.Command("load nothing")
	if said(h) != "There is no file named NOTHING" {
		t.Fatalf("missing save: %q", said(h))
	}
}

// Every hidden item can be reached: some floor square next to its furniture.
func TestHiddenItemsReachable(t *testing.T) {
	g := newGame(t)
	for _, it := range g.Items {
		if !it.Hidden {
			continue
		}
		goTo(g, it.Room, 0, 1, 1)
		found := false
		for r := 1; r <= castle.MapH && !found; r++ {
			for c := 1; c <= castle.MapW && !found; c++ {
				if g.Cell(r, c) != space {
					continue
				}
				g.Row, g.Col = r, c
				found = g.near(it.HiddenIn)
			}
		}
		if !found {
			t.Errorf("hidden %s in room %d: no floor next to %q", it.ID, it.Room, it.HiddenIn)
		}
	}
}

func TestSounds(t *testing.T) {
	g := newGame(t)
	g.Move(1, 0)
	g.Move(1, 0)
	g.Move(1, 0) // into the south wall
	if s := g.TakeSounds(); len(s) != 1 || s[0].Freq != 50 {
		t.Fatalf("wall bump sounds %+v", s)
	}
	g.Command("xyzzy")
	if s := g.TakeSounds(); len(s) != 1 || !s[0].Beep {
		t.Fatalf("What??? sounds %+v", s)
	}
}
