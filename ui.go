package main

import (
	"fmt"
	"image/color"
	"strings"
	"time"

	tea "charm.land/bubbletea/v2"
	"charm.land/lipgloss/v2"

	"github.com/sirgwain/castle-adventure/internal/castle"
	"github.com/sirgwain/castle-adventure/internal/game"
)

type screen int

const (
	screenNotice screen = iota // Kevin Bales's shareware notice
	screenTitle
	screenInstructions
	screenPlay
	screenDead     // the death message, waiting for a key
	screenGameOver // score, then high score / play again
	screenHighName // typing a name for the high score
)

const (
	maxCommand = 14 // the original prompt took 14 characters
	panelWidth = 26
	gap        = 3
	// rows the text around the map needs: title, blank, blank, description (up to 4), blank, help
	uiRows = 9
)

type tickMsg struct{}

func tick() tea.Cmd { return tea.Tick(game.MonsterTick, func(time.Time) tea.Msg { return tickMsg{} }) }

type model struct {
	world *castle.World
	store *fileStore
	seed  uint64
	g     *game.Game

	screen  screen
	command string
	name    string // high-score name being typed

	classic   bool
	scale     int // index into castle.Scales
	autoScale bool
	width     int
	height    int
}

func newModel(w *castle.World, store *fileStore, seed uint64, startRoom int, classic bool, scale int) model {
	m := model{world: w, store: store, seed: seed, classic: classic, scale: 1, autoScale: true}
	if scale >= 0 {
		m.scale, m.autoScale = min(scale, len(castle.Scales)-1), false
	}
	m.newGame()
	if startRoom > 0 { // debugging: start in another room, at its first open square
		m.g.Room, m.g.Prev = startRoom, 0
		m.g.Row, m.g.Col = centreFloor(w.Room(startRoom))
		m.screen = screenPlay
	}
	return m
}

// centreFloor is the enclosed floor square nearest the middle of the room
// (1-based), used when starting in a room for testing.
func centreFloor(r *castle.Room) (int, int) {
	best, by, bx := -1, castle.MapH/2, castle.MapW/2
	for y := 0; y < castle.MapH; y++ {
		for x := 0; x < castle.MapW; x++ {
			if r.TileAt(y, x) != castle.Floor || !r.Inside(y, x) {
				continue
			}
			d := (y-castle.MapH/2)*(y-castle.MapH/2) + (x-castle.MapW/2)*(x-castle.MapW/2)
			if best < 0 || d < best {
				best, by, bx = d, y, x
			}
		}
	}
	return by + 1, bx + 1
}

func (m *model) newGame() {
	m.seed++
	m.g = game.New(m.world, m.seed)
	if m.store != nil {
		m.g.Store = m.store
		m.g.HighScore = m.store.HighScore()
	}
	m.command = ""
}

func (m model) Init() tea.Cmd { return tick() }

// fitScale returns the largest scale whose map, panel and text fit the window.
func fitScale(width, height int) int {
	best := 0
	for i, sc := range castle.Scales {
		if castle.MapW*sc.X+gap+panelWidth <= width && castle.MapH*sc.Y+uiRows <= height {
			best = i
		}
	}
	return best
}

var moves = map[string][2]int{
	"up": {-1, 0}, "down": {1, 0}, "left": {0, -1}, "right": {0, 1},
	"home": {-1, -1}, "pgup": {-1, 1}, "end": {1, -1}, "pgdown": {1, 1},
}

func (m model) Update(msg tea.Msg) (tea.Model, tea.Cmd) {
	switch msg := msg.(type) {
	case tea.WindowSizeMsg:
		m.width, m.height = msg.Width, msg.Height
		if m.autoScale {
			m.scale = fitScale(m.width, m.height)
		}
		return m, nil
	case tickMsg:
		if m.screen == screenPlay {
			m.g.MonsterTurn()
			m.afterTurn()
		}
		return m, tick()
	case tea.KeyPressMsg:
		if msg.String() == "ctrl+c" {
			return m, tea.Quit
		}
		return m.key(msg)
	}
	return m, nil
}

// afterTurn moves on when the game has ended.
func (m *model) afterTurn() {
	switch m.g.Outcome {
	case game.Died:
		m.screen = screenDead
	case game.Escaped, game.Quit:
		m.screen = screenGameOver
	}
}

func (m model) key(k tea.KeyPressMsg) (tea.Model, tea.Cmd) {
	s := k.String()
	switch m.screen {
	case screenNotice:
		m.screen = screenTitle
	case screenTitle:
		switch strings.ToUpper(k.Text) {
		case "P":
			m.screen = screenPlay
		case "I":
			m.screen = screenInstructions
		}
	case screenInstructions:
		m.screen = screenTitle
	case screenDead:
		m.screen = screenGameOver
	case screenGameOver:
		r := m.g.Result()
		if r.Score > m.g.HighScore.Score && m.store != nil {
			m.screen, m.name = screenHighName, ""
			return m, nil
		}
		switch strings.ToUpper(k.Text) {
		case "Y":
			m.newGame()
			m.screen = screenPlay
		case "N":
			return m, tea.Quit
		}
	case screenHighName:
		switch s {
		case "enter":
			h := game.HighScore{Name: strings.TrimSpace(m.name), Score: m.g.Result().Score}
			if err := m.store.SetHighScore(h); err == nil {
				m.g.HighScore = h
			}
			m.screen = screenGameOver
		case "backspace":
			if m.name != "" {
				m.name = m.name[:len(m.name)-1]
			}
		default:
			if t := k.Text; len(t) == 1 && t[0] >= ' ' && t[0] <= '~' && len(m.name) < maxCommand {
				m.name += t
			}
		}
	case screenPlay:
		return m.playKey(k)
	}
	return m, nil
}

func (m model) playKey(k tea.KeyPressMsg) (tea.Model, tea.Cmd) {
	s := k.String()
	if d, ok := moves[s]; ok {
		m.g.Move(d[0], d[1])
		m.afterTurn()
		return m, nil
	}
	switch s {
	case "tab":
		m.classic = !m.classic
	case "esc":
		m.command = ""
	case "enter":
		m.g.Command(m.command)
		m.command = ""
		m.afterTurn()
	case "backspace":
		if m.command != "" {
			m.command = m.command[:len(m.command)-1]
		}
	case "+", "=":
		m.scale, m.autoScale = min(m.scale+1, len(castle.Scales)-1), false
	case "-", "_":
		m.scale, m.autoScale = max(m.scale-1, 0), false
	case "0":
		m.autoScale = true
		if m.width > 0 {
			m.scale = fitScale(m.width, m.height)
		}
	default:
		if t := strings.ToUpper(k.Text); len(t) == 1 && (t == " " || (t[0] >= 'A' && t[0] <= 'Z')) {
			if len(m.command) < maxCommand {
				m.command += t
			}
		}
	}
	return m, nil
}

// ---------------------------------------------------------------- drawing

var (
	cGold    = lipgloss.Color("#e3b341")
	cDim     = lipgloss.Color("#7d8590")
	cText    = lipgloss.Color("#c9d1d9")
	cAccent  = lipgloss.Color("#5fd7d7")
	cItem    = lipgloss.Color("#f0cf4a")
	cMonster = lipgloss.Color("#ff5f5f")
	cDead    = lipgloss.Color("#6b7280")
	cVampire = lipgloss.Color("#d7005f")
	cFairy   = lipgloss.Color("#ff87ff")
	cBad     = lipgloss.Color("#ff5f5f")

	titleStyle = lipgloss.NewStyle().Bold(true).Foreground(cGold)
	headStyle  = lipgloss.NewStyle().Bold(true).Foreground(cDim)
	dimStyle   = lipgloss.NewStyle().Foreground(cDim)
	textStyle  = lipgloss.NewStyle().Foreground(cText)
	msgStyle   = lipgloss.NewStyle().Foreground(cAccent)
	badStyle   = lipgloss.NewStyle().Foreground(cBad).Bold(true)
)

func monsterColor(mo *game.Monster) color.Color {
	switch {
	case !mo.Alive():
		return cDead
	case mo.Kind == "vampire":
		return cVampire
	case mo.Kind == "fairy":
		return cFairy
	}
	return cMonster
}

func (m model) View() tea.View {
	var content string
	switch m.screen {
	case screenNotice:
		content = noticeView()
	case screenTitle:
		content = titleView()
	case screenInstructions:
		content = textStyle.Render(strings.Join(instructions, "\n")) + "\n\n" + dimStyle.Render("Press any key")
	case screenGameOver, screenHighName:
		content = m.gameOverView()
	default:
		content = m.playView()
	}
	if m.width > 0 && m.height > 0 {
		content = lipgloss.Place(m.width, m.height, lipgloss.Center, lipgloss.Center, content)
	}
	v := tea.NewView(content)
	v.AltScreen = true
	v.WindowTitle = "Castle Adventure"
	return v
}

func noticeView() string {
	return textStyle.Render(strings.Join(freewareNotice, "\n")) + "\n\n" + dimStyle.Render("Press any key to continue...")
}

func titleView() string {
	art := lipgloss.NewStyle().Foreground(lipgloss.Color("#9aa1ab")).Render(strings.Join(titleArt, "\n"))
	return titleStyle.Render("Castle Adventure") + "\n" + dimStyle.Render("Kevin Bales, 1984") + "\n\n" + art +
		"\n\n" + textStyle.Render("P - to play    I - for instructions")
}

func (m model) playView() string {
	g := m.g
	r := g.CurrentRoom()
	sc := castle.Scales[m.scale]
	mapWidth := castle.MapW * sc.X

	// the map: the room with this visit's changes, then items, monsters and the player
	view := *r
	view.Map = g.Map()
	var over []castle.Overlay
	for _, it := range g.ItemsHere() {
		over = append(over, castle.Overlay{Y: it.Row - 1, X: it.Col - 1, R: it.Glyph(), FG: cItem})
	}
	for _, mo := range g.MonstersHere() {
		over = append(over, castle.Overlay{Y: mo.Row - 1, X: mo.Col - 1, R: mo.Glyph(), FG: monsterColor(mo)})
	}
	lines := castle.Render(&view, castle.RenderOptions{Classic: m.classic, Scale: sc,
		PlayerY: g.Row - 1, PlayerX: g.Col - 1, Overlays: over})

	left := titleStyle.Render(fmt.Sprintf("Room %d · %s", r.ID, r.Name())) + "  " + dimStyle.Render(r.Area) + "\n\n" +
		strings.Join(lines, "\n") + "\n\n" + textStyle.Render(strings.Join(wrap(r.Text(), max(mapWidth, 30)), "\n"))
	return lipgloss.JoinHorizontal(lipgloss.Top, left, strings.Repeat(" ", gap), m.panel()) + "\n\n" + m.help()
}

func (m model) panel() string {
	g := m.g
	var b strings.Builder
	strength := fmt.Sprintf("Strength %d", g.Strength)
	if g.Strength < 30 {
		b.WriteString(badStyle.Render(strength))
	} else {
		b.WriteString(textStyle.Render(strength))
	}
	b.WriteString("\n\n" + headStyle.Render("HERE") + "\n")
	here := 0
	for _, it := range g.ItemsHere() {
		b.WriteString(lipgloss.NewStyle().Foreground(cItem).Render(it.ItemDef.Glyph) + " " + textStyle.Render(it.Name) + "\n")
		here++
	}
	for _, mo := range g.MonstersHere() {
		b.WriteString(lipgloss.NewStyle().Foreground(monsterColor(mo)).Render(mo.MonsterDef.Glyph) + " " + textStyle.Render(mo.Name) + "\n")
		here++
	}
	if here == 0 {
		b.WriteString(dimStyle.Render("nothing") + "\n")
	}
	carried := g.Carried()
	b.WriteString("\n" + headStyle.Render(fmt.Sprintf("CARRYING %d/%d", len(carried), game.MaxCarry)) + "\n")
	for _, it := range carried {
		b.WriteString(lipgloss.NewStyle().Foreground(cItem).Render(it.ItemDef.Glyph) + " " + textStyle.Render(it.Name) + "\n")
	}
	if len(carried) == 0 {
		b.WriteString(dimStyle.Render("nothing") + "\n")
	}
	b.WriteString("\n")
	for _, line := range g.Messages {
		b.WriteString(msgStyle.Render(strings.TrimSpace(line)) + "\n")
	}
	b.WriteString("\n? " + m.command + "_\n")
	if g.Notice != "" {
		b.WriteString(badStyle.Render(g.Notice) + "\n")
	}
	if m.screen == screenDead {
		b.WriteString("\n" + dimStyle.Render("Press any key to continue"))
	}
	return lipgloss.NewStyle().Width(panelWidth).Render(b.String())
}

func (m model) help() string {
	sc := castle.Scales[m.scale]
	size := fmt.Sprintf("%dx%d", sc.X, sc.Y)
	if m.autoScale {
		size += " auto"
	}
	look := "modern"
	if m.classic {
		look = "classic"
	}
	return dimStyle.Render(fmt.Sprintf("arrows/home/end/pgup/pgdn move · type two-word commands (GET KEY, LOOK DESK) · tab look (%s) · +/- size (%s, 0 auto) · ctrl+c quit", look, size))
}

func (m model) gameOverView() string {
	g := m.g
	r := g.Result()
	var b strings.Builder
	switch r.Outcome {
	case game.Escaped:
		b.WriteString(titleStyle.Render("You've Escaped the Castle!"))
	case game.Quit:
		b.WriteString(titleStyle.Render("You've ended the game!"))
	default:
		b.WriteString(badStyle.Render("You're have failed to Escape!"))
	}
	glyphs := func(items []string) string {
		if len(items) == 0 {
			return "NONE"
		}
		return strings.Join(items, " ")
	}
	var treasures, kills []string
	for _, it := range r.Treasures {
		treasures = append(treasures, it.ItemDef.Glyph)
	}
	for _, mo := range r.Kills {
		kills = append(kills, mo.MonsterDef.Glyph)
	}
	b.WriteString("\n\n" + textStyle.Render("You have collected these Treasues...") + "\n   " +
		lipgloss.NewStyle().Foreground(cItem).Render(glyphs(treasures)))
	b.WriteString("\n\n" + textStyle.Render("You have killed these Monsters......") + "\n   " +
		lipgloss.NewStyle().Foreground(cMonster).Render(glyphs(kills)))
	b.WriteString("\n\n" + titleStyle.Render(fmt.Sprintf("Your Score: %d", r.Score)))
	if r.Perfect {
		b.WriteString("\n" + titleStyle.Render("    PERFECT!"))
	} else {
		b.WriteString("\n" + dimStyle.Render(fmt.Sprintf("   (%d is perfect)", game.PerfectScore)))
	}
	switch {
	case m.screen == screenHighName:
		b.WriteString("\n\n" + titleStyle.Render("You have made the High Score!") + "\n" +
			textStyle.Render("Enter Your Name - "+m.name+"_"))
	case r.Score > g.HighScore.Score && m.store != nil:
		b.WriteString("\n\n" + dimStyle.Render(" - Press any key -"))
	default:
		b.WriteString("\n\n" + textStyle.Render("Play Again (Y/N)?"))
	}
	return b.String()
}

// wrap breaks text into lines of at most width characters.
func wrap(text string, width int) []string {
	var lines []string
	line := ""
	for _, w := range strings.Fields(text) {
		if line != "" && len(line)+1+len(w) > width {
			lines = append(lines, line)
			line = ""
		}
		if line != "" {
			line += " "
		}
		line += w
	}
	if line != "" {
		lines = append(lines, line)
	}
	return lines
}
