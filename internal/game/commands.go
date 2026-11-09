package game

import (
	"encoding/json"
	"fmt"
	"strings"

	"github.com/sirgwain/castle-adventure/internal/castle"
)

// Room numbers the rules refer to (named as in out/castle.bas).
const (
	rmCourtyard   = 1
	rmKitchen     = 9
	rmChefs       = 10
	rmStorage     = 11
	rmThrone      = 14
	rmGardenSouth = 18
	rmUpperHall   = 19
	rmBalcony     = 33
	rmRed         = 37
	rmBlue        = 38
	rmPurple      = 39
	rmYellow      = 40
	rmStudy       = 56
	rmLibraryWest = 58
	rmLibraryEast = 59
	rmWestTop     = 64
	rmEastTop     = 65
	rmSorcerer    = 67
	rmWineCellar  = 68
	rmMazeWall    = 74
	rmTorture     = 79
	rmSecret      = 83
)

// Command runs a typed two-word command such as "GET KEY" or "WAVE WAND".
func (g *Game) Command(line string) {
	if g.Outcome != Playing {
		return
	}
	g.Notice = ""
	cmd := strings.Join(strings.Fields(strings.ToUpper(line)), " ")
	if cmd == "" {
		return
	}
	if strings.HasPrefix(cmd, "INV") {
		g.inventory()
		return
	}
	if cmd == "QUIT" {
		g.finish(Quit)
		return
	}
	verb, noun, ok := strings.Cut(cmd, " ")
	if !ok {
		g.Notice = "What???"
		return
	}
	switch verb {
	case "OPEN":
		verb = "UNLOCK"
	case "CLOSE":
		verb = "LOCK"
	case "FILL":
		if noun == "FLASK" {
			verb, noun = "GET", "WATER"
			if g.Room == rmWineCellar {
				noun = "WINE"
			}
		}
	}
	switch verb {
	case "EXAMINE", "SEARCH", "LOOK":
		g.look(noun)
	case "THROW", "DROP":
		g.drop(noun)
	case "TAKE", "GET":
		g.get(noun)
	case "WEAR":
		g.wear(noun)
	case "PLAY":
		g.play(noun)
	case "WAVE":
		g.wave(noun)
	case "CLEAN", "RUB":
		g.clean(noun)
	case "SAY":
		g.sayWord(noun)
	case "UNLOCK", "LOCK":
		g.lockUnlock(verb, noun)
	case "DRINK":
		g.drink(noun)
	case "EAT":
		g.say("I'm not", "hungry!")
	case "READ":
		g.read(noun)
	case "LEEP", "JUMP":
		g.jump(noun)
	case "POUR":
		g.pour(noun)
	case "CLIMB":
		g.say("I don't need", "to climb.")
	case "MIRROR":
		if g.Room == rmSorcerer && noun == "MIRROR" {
			g.say("The wicked", "witch never", "lived here!!")
			return
		}
		g.Notice = "What???"
	case "PET":
		g.pet(noun)
	case "KILL":
		g.kill(noun)
	case "SHOW":
		g.show(noun)
	case "SAVE":
		g.save(noun)
	case "LOAD":
		g.load(noun)
	default:
		g.Notice = "What???"
	}
}

// findItem is the item whose noun the player typed.
func (g *Game) findItem(noun string) *Item {
	for _, it := range g.Items {
		if it.Noun() == noun {
			return it
		}
	}
	return nil
}

// monsterHere is the monster in this room whose noun the player typed.
func (g *Game) monsterHere(noun string) *Monster {
	for _, m := range g.Monsters {
		if m.Room == g.Room && m.Noun() == noun {
			return m
		}
	}
	return nil
}

func (g *Game) hiddenIn(id string, room int) bool {
	it := g.item(id)
	return it != nil && it.Hidden && it.Room == room
}

func (g *Game) here(rooms ...int) bool {
	for _, r := range rooms {
		if g.Room == r {
			return true
		}
	}
	return false
}

// near reports whether any square around the player (and the player's own)
// shows one of chars.
func (g *Game) near(chars string) bool {
	for dy := -1; dy <= 1; dy++ {
		for dx := -1; dx <= 1; dx++ {
			if c := g.At(g.Row+dy, g.Col+dx); c != 0 && strings.ContainsRune(chars, c) {
				return true
			}
		}
	}
	return false
}

func (g *Game) dontHave(noun string) { g.say("You don't have", "a "+noun+"!") }

// ---------------------------------------------------------------- LOOK

func (g *Game) look(noun string) {
	if it := g.findItem(noun); it != nil {
		g.lookItem(it)
		return
	}
	switch noun {
	case "TABLE":
		switch {
		case g.here(rmKitchen):
			g.say("It's made of", "Stone.")
		case g.here(rmTorture):
			g.say("It's covered", "with Blood!")
		default:
			g.say("I don't see", "a Table.")
		}
	case "DESK":
		switch {
		case g.here(rmChefs) && g.hiddenIn("flask", rmChefs):
			g.say("There is a", "Wine Flask", "on top.")
		case g.here(rmYellow) && g.hiddenIn("glasses", rmYellow):
			g.say("There is a", "Pair of Eye", "Glasses on", "Top.")
		case g.here(rmStudy) && g.hiddenIn("key", rmStudy):
			g.say("There is a", "Key on top")
		case g.here(rmStudy, rmYellow, rmChefs):
			g.say("It's made", "of Wood.")
		default:
			g.say("I don't see", "a desk!")
		}
	case "BEDS", "BED":
		g.lookBed(noun)
	case "SHELVES", "SHELF":
		switch {
		case g.here(rmLibraryWest) && g.hiddenIn("book", rmLibraryWest):
			if noun == "SHELF" {
				g.say("There's a book", "on it.")
			} else {
				g.say("There's a book", "on one.")
			}
		case g.here(rmLibraryEast, rmStorage, rmLibraryWest):
			g.say("They're made", "of wood.")
		case noun == "SHELF":
			g.say("I don't see", "one.")
		default:
			g.say("I don't see", "any.")
		}
	case "THRONE":
		if g.here(rmThrone) {
			g.say("The throne is", "made of stone.")
		} else {
			g.say("I don't see", "A throne!")
		}
	case "FOUNTAIN":
		if g.here(rmGardenSouth) {
			g.say("The fountain", "is filled", "with water.But", "you can't see", "In it.")
		} else {
			g.say("I don't see", "A fountain!")
		}
	case "STATUE":
		switch {
		case !g.here(rmUpperHall):
			g.say("I don't see", "A Statue!")
		case g.hiddenIn("necklace", rmUpperHall):
			g.say("The statue is", "wearing a", "Necklace")
		default:
			g.say("The Statue", "looks like", "The King!")
		}
	case "MIRROR":
		if g.here(rmSorcerer) {
			g.say("It looks", "Magical!")
		} else {
			g.say("I don't see", "A Mirror!")
		}
	case "BARRELS", "BARREL":
		g.lookPlural(noun, "BARRELS", rmWineCellar, "Old!", "any Barrels!", "a Barrel!")
	case "CHAINS", "CHAIN":
		g.lookPlural(noun, "CHAINS", rmTorture, "Magical!", "any Chains!", "a Chain!")
	case "ARCHWAYS", "ARCHWAY", "CEILING", "FLOOR", "ROOF", "WALL", "WALLS":
		g.lookWalls(noun)
	case "GARDENS", "GARDEN":
		switch {
		case !g.here(rmBalcony):
			g.say("I Don't see", "A Garden!")
		case g.hiddenIn("gem", rmGardenSouth):
			g.say("There is a", "BIG Gem in", "the Garden", "Fountain!")
		default:
			g.say("The Garden", "Has A Fountain", "in the middle.")
		}
	case "STAIRCASE", "STAIR", "STAIRS":
		ex := g.CurrentRoom().Exits
		_, up := ex['U']
		_, down := ex['D']
		switch {
		case up && down:
			g.say("The Staircase", "leads both", "up & Down.")
		case up:
			g.say("The Staircase", "leads up.")
		case down:
			g.say("The Staircase", "leads down.")
		case noun == "STAIRS":
			g.say("I don't see", "any stairs!")
		default:
			g.say("I don't see", "a staircase!")
		}
	case "BALCONY":
		if g.here(rmBalcony) {
			g.say("The balcony is", "made of stone.")
		} else {
			g.say("I don't see", "a Balcony!")
		}
	case "GATE":
		if g.here(rmCourtyard) {
			g.say("It looks", "very Strong.")
			return
		}
		g.lookMonsterOr(noun)
	case "DOOR":
		if len(g.CurrentRoom().Doors) > 0 {
			g.say("It looks", "very Strong.")
			return
		}
		g.lookMonsterOr(noun)
	default:
		g.lookMonsterOr(noun)
	}
}

func (g *Game) lookItem(it *Item) {
	if it.Room != 0 {
		g.say("You Don't", "Have it!")
		return
	}
	switch {
	case it.ID == "flask" && g.FlaskFull:
		g.say("It's filled", "with water.")
	case it.ID == "flask":
		g.say("It's empty.")
	case len(it.Look) > 0:
		g.say(it.Look...)
	default:
		g.say("It looks", "ordinary.")
	}
}

func (g *Game) lookBed(noun string) {
	plural := noun == "BEDS"
	switch {
	case g.here(rmRed) && plural:
		g.say("They're Red.")
	case g.here(rmBlue) && plural:
		g.say("They're Blue.")
	case g.here(rmSorcerer) && plural:
		g.say("They're Old.")
	case g.here(rmSorcerer, rmChefs):
		g.say("It's Old.")
	case g.here(rmRed):
		g.say("It's Red.")
	case g.here(rmBlue):
		g.say("It's Blue.")
	case g.here(rmPurple):
		g.say("It's Purple.")
	case g.here(rmYellow):
		g.say("It's Yellow.")
	case plural:
		g.say("I don't see", "any Beds.")
	default:
		g.say("I don't see", "a Bed.")
	}
}

func (g *Game) lookPlural(noun, plural string, room int, what, noneMany, noneOne string) {
	switch {
	case !g.here(room) && noun == plural:
		g.say("I don't see", noneMany)
	case !g.here(room):
		g.say("I don't see", noneOne)
	case noun == plural:
		g.say("They look", what)
	default:
		g.say("It looks", what)
	}
}

func (g *Game) lookWalls(noun string) {
	switch {
	case g.here(rmMazeWall):
		g.say("The Wall Says:", "Kevin Bales", "was Here!")
		return
	case g.here(rmSecret):
		g.say("The walls are", "many Colors!")
		return
	case g.here(rmCourtyard) && (noun == "WALLS" || noun == "WALL"):
		g.highScoreWall()
		return
	}
	switch noun {
	case "WALLS":
		noun = "WALL"
	case "ARCHWAYS":
		noun = "ARCHWAY"
	}
	g.say("The "+noun+"S", "are made of", "Gray Stone.")
}

func (g *Game) highScoreWall() {
	if g.HighScore.Score == 0 && g.HighScore.Name == "" {
		g.say("Writing on the", "wall says...", "", "No high score")
		return
	}
	g.say("Writing on the", "wall says...", "", g.HighScore.Name, fmt.Sprint(g.HighScore.Score))
}

func (g *Game) lookMonsterOr(noun string) {
	if m := g.monsterHere(noun); m != nil {
		switch {
		case m.Kind == "fairy":
			g.say("The "+noun, "looks pretty", "but unhappy.")
		case m.HP > 0:
			g.say("The "+noun, "looks Mean!")
		default:
			g.say("The "+noun, "looks Dead!")
		}
		return
	}
	g.say("I can't see", "a "+noun+",", "and I don't", "have a", noun+"!")
}

// ---------------------------------------------------------------- GET / DROP

func (g *Game) drop(noun string) {
	it := g.findItem(noun)
	if it == nil || it.Room != 0 {
		g.say("You don't have", "a "+noun)
		return
	}
	r, c := g.Row+g.DY, g.Col+g.DX
	if (g.DY == 0 && g.DX == 0) || g.At(r, c) != space {
		g.say("Something is", "in the way!")
		return
	}
	it.Room, it.Row, it.Col = g.Room, r, c
	g.say("Done.")
}

var heavy = map[string]bool{"BARRELS": true, "SHELVES": true, "BEDS": true, "MIRROR": true, "BARREL": true,
	"STATUE": true, "FOUNTAIN": true, "THRONE": true, "SHELF": true, "BED": true, "DESK": true, "TABLE": true}

func (g *Game) get(noun string) {
	if noun == "BLOOD" {
		g.say("Yuc!!")
		return
	}
	if it := g.findItem(noun); it != nil {
		g.getItem(it, noun)
		return
	}
	switch {
	case heavy[noun]:
		g.tooHeavy(noun)
	case (noun == "CHAINS" || noun == "CHAIN") && g.here(rmTorture):
		g.say("They're", "Connected to", "the wall.")
	case noun == "WATER" || noun == "WINE":
		g.getLiquid(noun)
	default:
		g.getMonsterOr(noun)
	}
}

func (g *Game) getItem(it *Item, noun string) {
	switch {
	case it.Room == g.Room && !it.Hidden:
		g.say("Get it", "Yourself!")
	case it.Room == 0:
		g.say("You already", "have it!")
	case it.Room != g.Room:
		g.say("I don't see", "a "+noun)
	case !g.near(it.HiddenIn):
		g.say("I can't", "reach it!")
	case g.pickUp(it):
		g.say("Done.")
	}
}

func (g *Game) tooHeavy(noun string) {
	first := noun + "S"
	if strings.HasSuffix(noun, "S") {
		first = noun
	}
	present := map[string]bool{
		"TABLE": g.here(rmTorture, rmKitchen), "DESK": g.here(rmStudy, rmYellow, rmChefs),
		"BEDS":    g.here(rmSorcerer, rmYellow, rmPurple, rmBlue, rmRed, rmChefs),
		"BED":     g.here(rmSorcerer, rmYellow, rmPurple, rmBlue, rmRed, rmChefs),
		"SHELVES": g.here(rmLibraryEast, rmLibraryWest, rmStorage), "SHELF": g.here(rmLibraryEast, rmLibraryWest, rmStorage),
		"THRONE": g.here(rmThrone), "FOUNTAIN": g.here(rmGardenSouth), "STATUE": g.here(rmUpperHall),
		"BARRELS": g.here(rmWineCellar), "BARREL": g.here(rmWineCellar), "MIRROR": g.here(rmSorcerer),
	}[noun]
	if present {
		g.say(first, "are too heavy!")
	} else {
		g.say(first, "are too heavy!", "and I don't", "see any!")
	}
}

func (g *Game) getLiquid(noun string) {
	if noun == "WINE" {
		if g.here(rmWineCellar) {
			g.say("The Barrels", "are empty.")
			return
		}
		g.getMonsterOr(noun)
		return
	}
	switch {
	case !g.here(rmGardenSouth):
		g.getMonsterOr(noun)
	case !g.carrying("flask"):
		g.say("You don't have", "a Container!")
	case g.FlaskFull:
		g.say("The flask is", "full!")
	case g.near("─│"): // standing at the fountain's rim
		g.FlaskFull = true
		g.say("Done.")
	default:
		g.say("I can't", "reach it!")
	}
}

func (g *Game) getMonsterOr(noun string) {
	if g.monsterHere(noun) != nil {
		g.say("I don't think", "that would be", "very safe!")
		return
	}
	g.say("Impossible!!")
}

func (g *Game) inventory() {
	lines := []string{"- Inventory -"}
	for _, it := range g.Carried() {
		lines = append(lines, it.ItemDef.Glyph+" "+it.Name)
	}
	if len(lines) == 1 {
		lines = append(lines, "", "Nothing.")
	}
	g.say(lines...)
}

// ---------------------------------------------------------------- using things

// carriedNamed returns the item for noun, or says why the player can't use it.
func (g *Game) carriedNamed(noun string) *Item {
	it := g.findItem(noun)
	switch {
	case it == nil:
		g.dontHave(noun)
		return nil
	case it.Room != 0:
		g.say("You don't", "have it!")
		return nil
	}
	return it
}

func (g *Game) wear(noun string) {
	it := g.carriedNamed(noun)
	if it == nil {
		return
	}
	switch it.ID {
	case "helmet", "necklace":
		g.say("Ok.", "I'm wearing it.")
	case "crown":
		g.say("The crown is", "too Heavy!")
	case "glasses":
		g.say("Ok.", "I'm wearing", "them.")
	default:
		g.say("That could be", "Difficult!")
	}
}

func (g *Game) play(noun string) {
	it := g.carriedNamed(noun)
	if it == nil {
		return
	}
	if it.ID != "harp" {
		g.say("The "+noun, "makes Horrible", "music!!")
		return
	}
	lines := []string{"The Harp makes", "Beautiful", "Music!"}
	for _, m := range g.MonstersHere() {
		if m.Kind == "fairy" {
			m.Room = 0
			lines = append(lines, "The fairy", "likes the music", "and leaves!")
		}
	}
	g.say(lines...)
}

func (g *Game) wave(noun string) {
	it := g.findItem(noun)
	if it == nil || it.Room != 0 {
		g.dontHave(noun)
		return
	}
	if it.ID == "cross" && g.repelVampire() {
		return
	}
	for _, w := range g.CurrentRoom().OnWave {
		if w.Item == it.ID && !g.editsApplied(w.Edits) {
			g.applyEdits(w.Edits)
			g.say(w.Message...)
			return
		}
	}
	switch it.ID {
	case "wand", "scepter":
		g.say("As you wave the", noun+"....", "", "Nothing", "Happens!")
	default:
		g.say("You look awful", "Silly waving", "that "+noun)
	}
}

// repelVampire makes a vampire in this room vanish at the sight of the cross.
func (g *Game) repelVampire() bool {
	for _, m := range g.MonstersHere() {
		if m.Kind == "vampire" {
			m.Room = 0
			g.say("The vampire", "sees the holy", "cross and", "disappears!")
			return true
		}
	}
	return false
}

func (g *Game) clean(noun string) {
	it := g.carriedNamed(noun)
	if it == nil {
		return
	}
	if it.ID == "lamp" {
		g.say("There's no", "Genii in this", "Lamp!")
		return
	}
	g.say("The "+noun, "is cleaner now.")
}

func (g *Game) sayWord(noun string) {
	lines := []string{`"` + noun + `"`}
	g.say(append(lines, g.monstersReact()...)...)
}

// monstersReact is the first monster in the room looking at the player funny.
func (g *Game) monstersReact() []string {
	for _, m := range g.MonstersHere() {
		return []string{"", "The " + m.Noun(), "looks at you", "Funny!"}
	}
	return nil
}

func (g *Game) lockUnlock(verb, noun string) {
	if !g.carrying("key") {
		g.say("You don't", "have a Key!")
		return
	}
	if noun != "DOOR" {
		switch {
		case noun != "GATE":
			g.say("Impossible!!")
		case !g.here(rmCourtyard):
			g.say("I don't see", "a Gate!")
		case verb == "UNLOCK":
			g.say("The Gate", "is locked", "Magically.")
		default:
			g.say("The Gate", "is already", "locked!")
		}
		return
	}
	r := g.CurrentRoom()
	if len(r.Doors) == 0 {
		g.say("I don't see", "a door!")
		return
	}
	if verb == "LOCK" {
		for _, d := range r.Doors {
			if d.Row == g.Row && d.Col == g.Col {
				g.say("Something is", "in the way!")
				return
			}
		}
		g.Locked[r.ID] = true
		g.say("Done.")
		return
	}
	if !g.near(string(castle.Door)) {
		g.say("I can't", "reach it!")
		return
	}
	g.Locked[r.ID] = false
	g.say("Done.")
}

func (g *Game) drink(noun string) {
	if noun != "WATER" || !g.carrying("flask") || !g.FlaskFull {
		g.say("You don't have", "any "+noun+"!")
		return
	}
	if g.Drank {
		g.say("That was good.")
		return
	}
	g.Drank, g.Strength, g.FlaskFull = true, StartHealth, false
	g.say("That was good!", "I feel much", "better now!")
}

func (g *Game) read(noun string) {
	switch {
	case noun != "BOOK":
		g.say("You can't", "read That!")
	case !g.carrying("book"):
		g.say("You don't", "have a book!")
	case !g.carrying("glasses"):
		g.say("You can't see", "well enough.", "It's all", "Blurry.")
	default:
		g.say("The book reads:", "", "Wave Scepter")
	}
}

func (g *Game) jump(noun string) {
	if noun == "DOWN" && g.here(rmEastTop, rmWestTop, rmBalcony) {
		g.say("I don't think", "it's safe to", "Jump here!")
		return
	}
	g.say("I Jumped.", "", "This is boring.")
}

func (g *Game) pour(noun string) {
	if noun != "WATER" || !g.carrying("flask") || !g.FlaskFull {
		g.say("You don't", "have any.")
		return
	}
	g.FlaskFull = false
	lines := []string{"You pour the", "water & it", "spills on", "the ground."}
	if g.carrying("goblet") {
		lines = append(lines, "The goblet had", "a hole in it!")
	}
	g.say(lines...)
}

func (g *Game) pet(noun string) {
	if g.monsterHere(noun) != nil {
		g.say("I don't think", "that would be", "advisable!")
		return
	}
	g.say("I can't pet", "a "+noun+"!")
}

func (g *Game) kill(noun string) {
	if g.monsterHere(noun) != nil {
		g.say("Do it yourself!")
		return
	}
	g.say("I can't kill", "a "+noun+"!")
}

func (g *Game) show(noun string) {
	it := g.findItem(noun)
	if it == nil || it.Room != 0 {
		g.say("I don't have", "a "+noun+".")
		return
	}
	if it.ID == "cross" && g.repelVampire() {
		return
	}
	for _, m := range g.MonstersHere() {
		if m.Kind != "fighter" || m.Alive() {
			g.say(g.monstersReact()...)
			return
		}
	}
	g.say("There's not", "anyone to", "show it to!")
}

// ---------------------------------------------------------------- SAVE / LOAD

type itemState struct {
	Room, Row, Col int
	Hidden         bool
}

type monsterState struct {
	Room, Row, Col, HP int
	Name               string
}

type saveState struct {
	Version          int
	Room, Prev       int
	Row, Col         int
	Strength         int
	FlaskFull, Drank bool
	Locked           map[int]bool
	Items            map[string]itemState
	Monsters         map[string]monsterState
}

// Save serialises the game.
func (g *Game) Save() ([]byte, error) {
	s := saveState{Version: 1, Room: g.Room, Prev: g.Prev, Row: g.Row, Col: g.Col, Strength: g.Strength,
		FlaskFull: g.FlaskFull, Drank: g.Drank, Locked: g.Locked,
		Items: map[string]itemState{}, Monsters: map[string]monsterState{}}
	for _, it := range g.Items {
		s.Items[it.ID] = itemState{it.Room, it.Row, it.Col, it.Hidden}
	}
	for _, m := range g.Monsters {
		s.Monsters[m.ID] = monsterState{m.Room, m.Row, m.Col, m.HP, m.Name}
	}
	return json.MarshalIndent(s, "", "  ")
}

// Restore loads a game written by Save.
func (g *Game) Restore(data []byte) error {
	var s saveState
	if err := json.Unmarshal(data, &s); err != nil {
		return err
	}
	if g.World.Room(s.Room) == nil {
		return fmt.Errorf("saved game is in unknown room %d", s.Room)
	}
	g.Room, g.Prev, g.Row, g.Col, g.Strength = s.Room, s.Prev, s.Row, s.Col, s.Strength
	g.FlaskFull, g.Drank = s.FlaskFull, s.Drank
	g.Locked = map[int]bool{}
	for k, v := range s.Locked {
		g.Locked[k] = v
	}
	for _, it := range g.Items {
		if st, ok := s.Items[it.ID]; ok {
			it.Room, it.Row, it.Col, it.Hidden = st.Room, st.Row, st.Col, st.Hidden
		}
	}
	for _, m := range g.Monsters {
		if st, ok := s.Monsters[m.ID]; ok {
			m.Room, m.Row, m.Col, m.HP, m.Name = st.Room, st.Row, st.Col, st.HP, st.Name
		}
	}
	g.Edits = map[castle.Pos]rune{}
	g.Outcome = Playing
	return nil
}

func (g *Game) save(name string) {
	if g.Store == nil {
		g.say("Can't save", "here.")
		return
	}
	data, err := g.Save()
	if err == nil {
		err = g.Store.Save(name, data)
	}
	if err != nil {
		g.say("Save failed:", err.Error())
		return
	}
	g.say("Game Saved")
}

func (g *Game) load(name string) {
	var data []byte
	err := fmt.Errorf("no store")
	if g.Store != nil {
		data, err = g.Store.Load(name)
	}
	if err != nil {
		g.say("There is no", "file named", name)
		return
	}
	if err := g.Restore(data); err != nil {
		g.say("That file is", "damaged.")
		return
	}
	g.say("Game Loaded")
}
