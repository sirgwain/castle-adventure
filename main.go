package main

import (
	_ "embed"
	"flag"
	"fmt"
	"os"
	"strings"

	tea "charm.land/bubbletea/v2"
	"charm.land/lipgloss/v2"

	"github.com/sirgwain/castle-adventure/internal/castle"
)

//go:embed Castle.1984/CASTLE.RAN
var castleRAN []byte

const maxCommand = 14 // the original prompt took 14 characters

type model struct {
	rooms []*castle.Room
	room  int

	// player location, 0-based row and column on the 24x18 map
	py, px int

	command string
	message string

	classic bool // draw the original CGA look

	scale     int  // index into castle.Scales
	autoScale bool // pick the largest scale that fits the window
	width     int  // terminal size, from tea.WindowSizeMsg
	height    int
}

// uiLines is roughly how many terminal rows the text around the map needs.
const uiLines = 14

func initialModel(rooms []*castle.Room, room int, classic bool, scale int) model {
	// The original game starts the player in the courtyard at row 15, column 15.
	m := model{rooms: rooms, room: room, py: 14, px: 14, classic: classic, scale: 1, autoScale: true}
	if scale >= 0 {
		m.scale, m.autoScale = min(scale, len(castle.Scales)-1), false
	}
	return m
}

// fitScale returns the largest scale whose map and text fit the window.
func fitScale(width, height int) int {
	best := 0
	for i, sc := range castle.Scales {
		if castle.MapW*sc.X <= width && castle.MapH*sc.Y+uiLines <= height {
			best = i
		}
	}
	return best
}

func (m model) Init() tea.Cmd { return nil }

// keypad directions, as the original read them from the numeric keypad
var moves = map[string][2]int{
	"up": {-1, 0}, "down": {1, 0}, "left": {0, -1}, "right": {0, 1},
	"home": {-1, -1}, "pgup": {-1, 1}, "end": {1, -1}, "pgdown": {1, 1},
}

func (m model) Update(msg tea.Msg) (tea.Model, tea.Cmd) {
	if ws, ok := msg.(tea.WindowSizeMsg); ok {
		m.width, m.height = ws.Width, ws.Height
		if m.autoScale {
			m.scale = fitScale(m.width, m.height)
		}
		return m, nil
	}
	key, ok := msg.(tea.KeyPressMsg)
	if !ok {
		return m, nil
	}
	switch s := key.String(); s {
	case "ctrl+c", "esc":
		return m, tea.Quit
	case "tab":
		m.classic = !m.classic
	case "+", "=":
		m.scale, m.autoScale = min(m.scale+1, len(castle.Scales)-1), false
	case "-", "_":
		m.scale, m.autoScale = max(m.scale-1, 0), false
	case "0":
		m.autoScale = true
		if m.width > 0 {
			m.scale = fitScale(m.width, m.height)
		}
	case "enter":
		m.message = runCommand(m.command)
		m.command = ""
	case "backspace":
		if m.command != "" {
			m.command = m.command[:len(m.command)-1]
		}
	default:
		if d, ok := moves[s]; ok {
			m = m.move(d[0], d[1])
			break
		}
		if t := strings.ToUpper(key.Text); len(t) == 1 && (t == " " || (t[0] >= 'A' && t[0] <= 'Z')) {
			if len(m.command) < maxCommand {
				m.command += t
			}
		}
	}
	return m, nil
}

// move steps the player one square, following the original rules: walking off
// an edge takes that exit, stepping onto U or D takes the stairs, and anything
// but floor blocks.
func (m model) move(dy, dx int) model {
	r := m.rooms[m.room]
	ny, nx := m.py+dy, m.px+dx
	switch {
	case ny < 0:
		return m.takeExit('N', castle.MapH-1, m.px)
	case ny >= castle.MapH:
		return m.takeExit('S', 0, m.px)
	case nx < 0:
		return m.takeExit('W', m.py, castle.MapW-1)
	case nx >= castle.MapW:
		return m.takeExit('E', m.py, 0)
	}
	switch r.TileAt(ny, nx) {
	case castle.StairsUp:
		return m.takeExit('U', m.py, m.px)
	case castle.StairsDown:
		return m.takeExit('D', m.py, m.px)
	case castle.Blocked:
		m.message = ""
		return m
	}
	m.py, m.px, m.message = ny, nx, ""
	return m
}

func (m model) takeExit(dir byte, py, px int) model {
	to, ok := m.rooms[m.room].Exits[dir]
	if !ok || to == 0 {
		m.message = "You can't go that way."
		return m
	}
	m.room, m.py, m.px, m.message = to, py, px, ""
	return m
}

var (
	titleStyle = lipgloss.NewStyle().Bold(true).Foreground(lipgloss.Color("#e3b341"))
	dimStyle   = lipgloss.NewStyle().Foreground(lipgloss.Color("#7d8590"))
	descStyle  = lipgloss.NewStyle().Foreground(lipgloss.Color("#c9d1d9"))
	msgStyle   = lipgloss.NewStyle().Foreground(lipgloss.Color("#5fd7d7"))
)

func (m model) View() tea.View {
	r := m.rooms[m.room]
	sc := castle.Scales[m.scale]
	width := castle.MapW * sc.X
	var sb strings.Builder
	sb.WriteString(titleStyle.Render(fmt.Sprintf("Room %d · %s", r.ID, r.Name())) + "\n\n")
	for _, line := range castle.Render(r, castle.RenderOptions{Classic: m.classic, Scale: sc, PlayerY: m.py, PlayerX: m.px}) {
		sb.WriteString(line + "\n")
	}
	sb.WriteString("\n")
	for _, line := range wrap(r.Text(), max(width, 30)) {
		sb.WriteString(descStyle.Render(line) + "\n")
	}
	var exits []string
	for _, d := range "NSEWUD" {
		if to, ok := r.Exits[byte(d)]; ok {
			exits = append(exits, fmt.Sprintf("%c→%d", d, to))
		}
	}
	sb.WriteString(dimStyle.Render("Exits: "+strings.Join(exits, "  ")) + "\n\n")
	if m.message != "" {
		sb.WriteString(msgStyle.Render(m.message) + "\n")
	}
	sb.WriteString("? " + m.command + "_\n\n")
	look := "modern"
	if m.classic {
		look = "classic"
	}
	size := fmt.Sprintf("%dx%d", sc.X, sc.Y)
	if m.autoScale {
		size += " auto"
	}
	sb.WriteString(dimStyle.Render(fmt.Sprintf("arrows/home/end/pgup/pgdn move · tab look (%s) · +/- size (%s, 0 = auto) · esc quit", look, size)))

	content := sb.String()
	if m.width > 0 && m.height > 0 {
		content = lipgloss.Place(m.width, m.height, lipgloss.Center, lipgloss.Center, content)
	}
	v := tea.NewView(content)
	v.AltScreen = true
	return v
}

func runCommand(s string) string {
	if strings.TrimSpace(s) == "" {
		return ""
	}
	// todo: implement commands
	return "What???"
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

func main() {
	room := flag.Int("room", 1, "room to start in (1-83)")
	classic := flag.Bool("classic", false, "start with the original CGA look")
	scale := flag.Int("scale", -1, fmt.Sprintf("map size 0-%d (1 = two columns per square; default: fit the window)", len(castle.Scales)-1))
	dump := flag.Bool("dump", false, "print the room (or all rooms with -room 0) and exit")
	flag.Parse()

	rooms, err := castle.LoadRooms(castleRAN)
	if err != nil {
		fmt.Fprintln(os.Stderr, err)
		os.Exit(1)
	}
	if *dump {
		first, last := *room, *room
		if *room == 0 {
			first, last = 1, castle.NumRooms
		}
		for id := first; id <= last; id++ {
			r := rooms[id]
			fmt.Printf("Room %d · %s\n", r.ID, r.Name())
			sc := castle.Scales[1]
			if *scale >= 0 {
				sc = castle.Scales[min(*scale, len(castle.Scales)-1)]
			}
			for _, line := range castle.Render(r, castle.RenderOptions{Classic: *classic, Scale: sc, PlayerY: -1}) {
				lipgloss.Println(line)
			}
			fmt.Println()
		}
		return
	}
	if *room < 1 || *room > castle.NumRooms {
		fmt.Fprintf(os.Stderr, "room must be 1-%d\n", castle.NumRooms)
		os.Exit(2)
	}

	p := tea.NewProgram(initialModel(rooms, *room, *classic, *scale))
	if _, err := p.Run(); err != nil {
		fmt.Printf("Alas, there's been an error: %v", err)
		os.Exit(1)
	}
}
