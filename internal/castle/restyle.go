package castle

import "strings"

// Role says how a cell should be coloured; a Theme maps roles to colours.
type Role byte

const (
	RoleNone      Role = iota // outside the room
	RoleFloor                 // walkable floor inside the room
	RoleWall                  // castle walls
	RoleSoft                  // ▒ ░: bushes, maze fill, decorative stone
	RoleStairs                // U / D
	RoleFurniture             // furniture with no better role
	RoleHeadboard
	RolePillow
	RoleQuilt
	RoleWood
	RoleStone
	RoleIron
	RoleBook // each spine gets its own colour
	RoleGold
	RoleWater
	RoleMirror
	RoleBlood
	RoleMarble
	RoleChain
	RoleRainbow // the King's Secret Room walls
)

// Cell is one restyled map square.
type Cell struct {
	R    rune
	Role Role
}

// Styled is a room ready to draw.
type Styled [MapH][MapW]Cell

// sprite replaces a furniture blob. Art and Mask have the blob's bounding-box
// size; a space in Art keeps the original glyph, so every blocked cell still
// shows something and every floor cell stays floor.
type sprite struct {
	Art, Mask []string
}

type kind uint8

const (
	kindNone kind = iota
	kindBed
	kindBarrels
	kindRack
	kindShelves
	kindBooks
	kindSlab
	kindDesk
	kindFountain
	kindStatue
	kindMirror
	kindGate
	kindSlit
)

type spriteKey struct {
	k    kind
	w, h int
}

var sprites = map[spriteKey]sprite{
	{kindBed, 4, 2}:      {[]string{"▌▀▒▒", "▌▄▒▒"}, []string{"hpqq", "hpqq"}},
	{kindBed, 2, 3}:      {[]string{"▄▄", "▒▒", "▒▒"}, []string{"pp", "qq", "qq"}},
	{kindBed, 3, 1}:      {[]string{"▌▒▒"}, []string{"hqq"}},
	{kindBarrels, 4, 2}:  {[]string{"╭╮╭╮", "╰╯╰╯"}, []string{"wwww", "wwww"}},
	{kindRack, 2, 3}:     {[]string{"╤╤", "▓▓", "╧╧"}, []string{"ii", "rr", "ii"}},
	{kindShelves, 9, 1}:  {[]string{"╞═╪═╪═╪═╡"}, []string{"wwwwwwwww"}},
	{kindBooks, 7, 1}:    {[]string{"║│║║│║│"}, []string{"bbbbbbb"}},
	{kindSlab, 9, 2}:     {[]string{"▛▀▀▀▀▀▀▀▜", "▙▄▄▄▄▄▄▄▟"}, []string{"sssssssss", "sssssssss"}},
	{kindDesk, 3, 2}:     {[]string{"▄▄▄", "▌▀▐"}, []string{"www", "www"}},
	{kindDesk, 4, 2}:     {[]string{"▄▄▄▄", "▌▀▀▐"}, []string{"wwww", "wwww"}},
	{kindDesk, 6, 3}:     {[]string{"╭────╮", "│    │", "╰────╯"}, []string{"wwwwww", "w    w", "wwwwww"}},
	{kindFountain, 3, 3}: {[]string{"╭─╮", "│≈│", "╰─╯"}, []string{"sss", "sas", "sss"}},
	{kindStatue, 3, 3}:   {[]string{"▗▄▖", "▐Ω▌", "▝▀▘"}, []string{"sss", "sMs", "sss"}},
	{kindMirror, 1, 6}:   {[]string{"╓", "║", "║", "║", "║", "╙"}, []string{"m", "m", "m", "m", "m", "m"}},
	{kindGate, 4, 1}:     {[]string{"╫╫╫╫"}, []string{"iiii"}},
}

// throne is stamped over the bounding box of the throne room's █ and ─ cells.
var throne = sprite{[]string{"▛  ▜", "▙▄▄▟"}, []string{"g  g", "gggg"}}

var maskRoles = map[byte]Role{
	'h': RoleHeadboard, 'p': RolePillow, 'q': RoleQuilt, 'w': RoleWood, 's': RoleStone,
	'i': RoleIron, 'b': RoleBook, 'g': RoleGold, 'a': RoleWater, 'm': RoleMirror,
	'r': RoleBlood, 'M': RoleMarble,
}

// Rooms whose █ blocks are not beds.
var roomBlocks = map[int]kind{68: kindBarrels, 79: kindRack, 11: kindShelves, 58: kindBooks, 59: kindBooks, 9: kindSlab}

const (
	throneRoom  = 14
	balconyRoom = 33
	secretRoom  = 83
)

// light lines set into a wall (tower battlements) become arrow slits
var slits = map[rune]rune{'─': '┄', '│': '┆'}

var railing = map[rune]rune{'─': '═', '┐': '╗', '┘': '╝', '│': '║', '├': '╟', '█': '═'}

const boxChars = "─│┌┐└┘├═Γα"

// Door is the character the game draws for a locked door (the original CHR$(8)).
const Door = '◘'

// Wall line sets, indexed by the 4-neighbour mask N=1 E=2 S=4 W=8.
type WallStyle [16]rune

var (
	DoubleWalls  = WallStyle{'■', '║', '═', '╚', '║', '║', '╔', '╠', '═', '╝', '═', '╩', '╗', '╣', '╦', '╬'}
	HeavyWalls   = WallStyle{'■', '┃', '━', '┗', '┃', '┃', '┏', '┣', '━', '┛', '━', '┻', '┓', '┫', '┳', '╋'}
	RoundedWalls = WallStyle{'■', '│', '─', '╰', '│', '│', '╭', '├', '─', '╯', '─', '┴', '╮', '┤', '┬', '┼'}
)

// WallStyleFor picks the wall look for a room.
func WallStyleFor(r *Room) WallStyle {
	switch moodOf(r) {
	case moodGarden:
		return RoundedWalls
	case moodDungeon:
		return HeavyWalls
	}
	return DoubleWalls
}

// stairs sprites by group shape (w, h).
var stairsUp = map[[2]int][]string{{2, 2}: {"▅▇", "▁▃"}, {2, 1}: {"▃▇"}, {1, 2}: {"▇", "▃"}, {1, 1}: {"▲"}}
var stairsDown = map[[2]int][]string{{2, 2}: {"▇▅", "▃▁"}, {2, 1}: {"▇▃"}, {1, 2}: {"▃", "▇"}, {1, 1}: {"▼"}}

type pos struct{ y, x int }

// Restyle turns a room's original characters into the modern look.
func Restyle(r *Room) Styled {
	var s Styled
	inside := insideMask(r)
	for y := 0; y < MapH; y++ {
		for x := 0; x < MapW; x++ {
			c := r.Map[y][x]
			s[y][x] = Cell{c, RoleFurniture}
			switch {
			case c == ' ' && inside[y][x]:
				s[y][x].Role = RoleFloor
			case c == ' ':
				s[y][x].Role = RoleNone
			case c == '▒' || c == '░':
				s[y][x].Role = RoleSoft
			case c == '≈':
				s[y][x].Role = RoleChain
			case c == 'k' || c == 'b':
				s[y][x].Role = RoleGold // Kevin Bales's initials in the maze wall
			case c == Door:
				s[y][x] = Cell{'▒', RoleWood} // a locked wooden door
			}
		}
	}
	desc := strings.ToLower(r.Desc)
	if r.ID == secretRoom { // "The walls are many colors.": keep the █▒ pattern, colour it
		for y := 0; y < MapH; y++ {
			for x := 0; x < MapW; x++ {
				if c := r.Map[y][x]; c == '█' || c == '▒' {
					s[y][x].Role = RoleRainbow
				}
			}
		}
	}
	if r.ID == balconyRoom { // the balcony rail: balusters (├) on a stone rail
		for y := 0; y < MapH; y++ {
			for x := 0; x < MapW; x++ {
				if g, ok := railing[r.Map[y][x]]; ok {
					s[y][x] = Cell{g, RoleStone}
				}
			}
		}
	}

	// furniture
	for _, set := range []string{"█", boxChars} {
		if r.ID == secretRoom || r.ID == balconyRoom {
			break
		}
		for _, b := range blobs(r, set) {
			if r.ID == throneRoom && (set == "█" || r.Map[b[0].y][b[0].x] == '─') {
				continue
			}
			y0, x0, w, h := bounds(b)
			k := furnitureKind(r, desc, set, b, w)
			if k == kindSlit {
				for _, p := range b {
					g := r.Map[p.y][p.x]
					if sl, ok := slits[g]; ok {
						g = sl
					}
					s[p.y][p.x] = Cell{g, RoleWall}
				}
				continue
			}
			if sp, ok := sprites[spriteKey{k, w, h}]; ok {
				stamp(&s, r, sp, b, y0, x0)
			} else if set == boxChars {
				for _, p := range b {
					s[p.y][p.x].Role = RoleStone
				}
			}
		}
	}
	if r.ID == throneRoom {
		var cells []pos
		for y := 0; y < MapH; y++ {
			for x := 0; x < MapW; x++ {
				if c := r.Map[y][x]; c == '█' || c == '─' {
					cells = append(cells, pos{y, x})
				}
			}
		}
		if len(cells) > 0 {
			y0, x0, _, _ := bounds(cells)
			stamp(&s, r, throne, cells, y0, x0)
		}
	}

	// walls
	style := WallStyleFor(r)
	isWall := func(y, x int) bool { return y >= 0 && y < MapH && x >= 0 && x < MapW && r.Map[y][x] == '▓' }
	for y := 0; y < MapH; y++ {
		for x := 0; x < MapW; x++ {
			if !isWall(y, x) {
				continue
			}
			n := 0
			if isWall(y-1, x) {
				n |= 1
			}
			if isWall(y, x+1) {
				n |= 2
			}
			if isWall(y+1, x) {
				n |= 4
			}
			if isWall(y, x-1) {
				n |= 8
			}
			s[y][x] = Cell{style[n], RoleWall}
		}
	}

	// stairs
	for _, ch := range []rune{'U', 'D'} {
		set := map[rune]map[[2]int][]string{'U': stairsUp, 'D': stairsDown}[ch]
		for _, b := range blobs(r, string(ch)) {
			y0, x0, w, h := bounds(b)
			art, ok := set[[2]int{w, h}]
			for _, p := range b {
				g := map[rune]rune{'U': '▲', 'D': '▼'}[ch]
				if ok {
					g = []rune(art[p.y-y0])[p.x-x0]
				}
				s[p.y][p.x] = Cell{g, RoleStairs}
			}
		}
	}
	return s
}

// Classic returns the room exactly as the original drew it.
func Classic(r *Room) Styled {
	var s Styled
	for y := 0; y < MapH; y++ {
		for x := 0; x < MapW; x++ {
			s[y][x] = Cell{r.Map[y][x], RoleWall}
		}
	}
	return s
}

func furnitureKind(r *Room, desc, set string, b []pos, w int) kind {
	art := ""
	for _, p := range b {
		art += string(r.Map[p.y][p.x])
	}
	if set == boxChars {
		switch {
		case strings.ContainsRune(art, 'Γ'):
			return kindFountain
		case strings.ContainsRune(art, 'α'):
			return kindStatue
		case r.ID == 1 && strings.ContainsRune(art, '═'):
			return kindGate
		case w == 1 && strings.Contains(desc, "mirror"):
			return kindMirror
		case touchesWall(r, b):
			return kindSlit
		case strings.Contains(desc, "desk"):
			return kindDesk
		}
		return kindNone
	}
	if k, ok := roomBlocks[r.ID]; ok {
		return k
	}
	if strings.Contains(desc, "bed") {
		return kindBed
	}
	return kindNone
}

func stamp(s *Styled, r *Room, sp sprite, b []pos, y0, x0 int) {
	for _, p := range b {
		art, mask := []rune(sp.Art[p.y-y0]), sp.Mask[p.y-y0]
		g, m := art[p.x-x0], mask[p.x-x0]
		if g == ' ' { // keep the footprint: never turn a blocked cell into floor
			g = r.Map[p.y][p.x]
		}
		role, ok := maskRoles[m]
		if !ok {
			role = RoleFurniture
		}
		s[p.y][p.x] = Cell{g, role}
	}
}

func blobs(r *Room, chars string) [][]pos {
	var seen [MapH][MapW]bool
	var out [][]pos
	in := func(y, x int) bool {
		return y >= 0 && y < MapH && x >= 0 && x < MapW && strings.ContainsRune(chars, r.Map[y][x])
	}
	for y := 0; y < MapH; y++ {
		for x := 0; x < MapW; x++ {
			if seen[y][x] || !in(y, x) {
				continue
			}
			stack, cells := []pos{{y, x}}, []pos{}
			seen[y][x] = true
			for len(stack) > 0 {
				p := stack[len(stack)-1]
				stack = stack[:len(stack)-1]
				cells = append(cells, p)
				for _, d := range []pos{{1, 0}, {-1, 0}, {0, 1}, {0, -1}} {
					q := pos{p.y + d.y, p.x + d.x}
					if in(q.y, q.x) && !seen[q.y][q.x] {
						seen[q.y][q.x] = true
						stack = append(stack, q)
					}
				}
			}
			out = append(out, cells)
		}
	}
	return out
}

func bounds(b []pos) (y0, x0, w, h int) {
	y0, x0 = MapH, MapW
	y1, x1 := -1, -1
	for _, p := range b {
		y0, x0, y1, x1 = min(y0, p.y), min(x0, p.x), max(y1, p.y), max(x1, p.x)
	}
	return y0, x0, x1 - x0 + 1, y1 - y0 + 1
}

func touchesWall(r *Room, b []pos) bool {
	for _, p := range b {
		for _, d := range []pos{{1, 0}, {-1, 0}, {0, 1}, {0, -1}} {
			y, x := p.y+d.y, p.x+d.x
			if y >= 0 && y < MapH && x >= 0 && x < MapW && r.Map[y][x] == '▓' {
				return true
			}
		}
	}
	return false
}

// insideMask marks floor squares enclosed by the room: something solid to the
// left and right in its row and above and below in its column. Squares outside
// the walls stay unpainted.
func insideMask(r *Room) [MapH][MapW]bool {
	var m [MapH][MapW]bool
	solid := func(y, x int) bool { return tileOf(r.Map[y][x]) != Floor }
	for y := 0; y < MapH; y++ {
		for x := 0; x < MapW; x++ {
			if r.Map[y][x] != ' ' {
				continue
			}
			l, rt, u, d := false, false, false, false
			for k := 0; k < x && !l; k++ {
				l = solid(y, k)
			}
			for k := x + 1; k < MapW && !rt; k++ {
				rt = solid(y, k)
			}
			for k := 0; k < y && !u; k++ {
				u = solid(k, x)
			}
			for k := y + 1; k < MapH && !d; k++ {
				d = solid(k, x)
			}
			m[y][x] = l && rt && u && d
		}
	}
	return m
}

func containsAny(s string, words ...string) bool {
	for _, w := range words {
		if strings.Contains(s, w) {
			return true
		}
	}
	return false
}

// Inside reports whether the floor square at row y, column x (0-based) is
// enclosed by the room rather than outside its walls.
func (r *Room) Inside(y, x int) bool {
	if y < 0 || y >= MapH || x < 0 || x >= MapW {
		return false
	}
	return insideMask(r)[y][x]
}
