package game

import (
	"testing"

	"github.com/sirgwain/castle-adventure/internal/castle"
)

var dirs8 = [][2]int{{-1, 0}, {1, 0}, {0, -1}, {0, 1}, {-1, -1}, {-1, 1}, {1, -1}, {1, 1}}

type place struct{ room, row, col int }

// staticCell is a room's map as a visit would leave it after waving the wand
// there (the secret passages), with doors open.
func staticCell(w *castle.World, room, row, col int) rune {
	r := w.Room(room)
	for _, wv := range r.OnWave {
		if wv.Item != "wand" {
			continue
		}
		for _, e := range wv.Edits {
			for i, ch := range []rune(e.Text) {
				if e.Row == row && e.Col+i == col {
					return ch
				}
			}
		}
	}
	return r.Map[row-1][col-1]
}

// plan finds keypad moves from the player's place to any square of room
// target, across rooms, walking on floor and using exits and stairs.
func plan(g *Game, target int) [][2]int {
	w := g.World
	start := place{g.Room, g.Row, g.Col}
	prev := map[place]place{start: start}
	move := map[place][2]int{}
	queue := []place{start}
	for len(queue) > 0 {
		p := queue[0]
		queue = queue[1:]
		if p.room == target {
			path := [][2]int{}
			for p != start {
				path = append([][2]int{move[p]}, path...)
				p = prev[p]
			}
			return path
		}
		for _, d := range dirs8 {
			nr, nc := p.row+d[0], p.col+d[1]
			var next place
			exit := byte(0)
			switch {
			case nr < 1 && d[1] == 0:
				exit, next = 'N', place{0, castle.MapH, p.col}
			case nr > castle.MapH && d[1] == 0:
				exit, next = 'S', place{0, 1, p.col}
			case nc < 1 && d[0] == 0:
				exit, next = 'W', place{0, p.row, castle.MapW}
			case nc > castle.MapW && d[0] == 0:
				exit, next = 'E', place{0, p.row, 1}
			case nr < 1 || nr > castle.MapH || nc < 1 || nc > castle.MapW:
				continue
			default:
				switch c := staticCell(w, p.room, nr, nc); c {
				case ' ':
					next = place{p.room, nr, nc}
				case 'U', 'D':
					exit, next = byte(c), place{0, p.row, p.col}
				default:
					continue
				}
			}
			if exit != 0 {
				to := w.Room(p.room).Exits[exit]
				if to == 0 {
					continue
				}
				next.room = to
				if staticCell(w, to, next.row, next.col) != ' ' {
					continue
				}
			}
			if _, seen := prev[next]; seen {
				continue
			}
			prev[next], move[next] = p, d
			queue = append(queue, next)
		}
	}
	return nil
}

// TestEveryRoomReachable walks from the courtyard to every room with real
// moves, carrying the lamp, wand and necklace (the traps), with doors open and
// nothing in the way.
func TestEveryRoomReachable(t *testing.T) {
	g := newGame(t)
	give(t, g, "lamp", "wand", "necklace")
	for _, it := range g.Items {
		if it.Room != 0 {
			it.Room = -1 // off the map, so items don't block corridors
		}
	}
	for _, m := range g.Monsters {
		m.Room = -1
	}
	for _, r := range g.World.Rooms[1:] {
		r.Spawns = nil // keep the fairy away (this test's world is its own copy)
	}
	g.Locked = map[int]bool{}
	visited := map[int]bool{g.Room: true}
	wave := func() {
		for _, wv := range g.CurrentRoom().OnWave {
			if wv.Item == "wand" {
				g.Command("WAVE WAND")
			}
		}
	}
	for target := 1; target <= castle.NumRooms; target++ {
		for tries := 0; g.Room != target; tries++ {
			path := plan(g, target)
			if path == nil || tries > 100 {
				t.Fatalf("no way from room %d (%d,%d) to room %d", g.Room, g.Row, g.Col, target)
			}
			room := g.Room
			for _, d := range path {
				g.Move(d[0], d[1])
				if g.Outcome != Playing {
					t.Fatalf("game ended (%v) on the way to room %d", g.Outcome, target)
				}
				if g.Room != room { // re-plan from wherever arrival put the player
					visited[g.Room] = true
					wave()
					break
				}
			}
		}
	}
	if len(visited) != castle.NumRooms {
		t.Errorf("visited %d of %d rooms", len(visited), castle.NumRooms)
	}
}

func TestUnlockDoor(t *testing.T) {
	g := newGame(t)
	give(t, g, "lamp", "key")
	goTo(g, rmWineCellar, 11, 14, 9) // just above the door at row 15, columns 9-10
	g.Move(1, 0)
	if said(g) != "The Door is locked." {
		t.Fatalf("bump door: %q", said(g))
	}
	g.Command("unlock door")
	if said(g) != "Done." || g.Locked[rmWineCellar] {
		t.Fatalf("unlock: %q", said(g))
	}
	g.Move(1, 0)
	if g.Row != 15 {
		t.Fatalf("still blocked at row %d", g.Row)
	}
	g.Move(1, 0)
	g.Command("lock door")
	if said(g) != "Done." || !g.Locked[rmWineCellar] {
		t.Fatalf("lock: %q", said(g))
	}
}
