package main

import (
	"fmt"
	"os"
	"strings"

	tea "charm.land/bubbletea/v2"
)

type tile int

const (
	tileNone = iota
	tileWall
	tileGate
)

const ROWS = 18
const COLS = 24

type model struct {
	// player location
	px int
	py int

	// next location
	nx int
	ny int

	command string

	level [][]tile
}

func initialModel() model {
	m := model{}
	m.level = make([][]tile, ROWS)
	for row := range m.level {
		m.level[row] = make([]tile, COLS)
	}

	return m
}

func (m model) Init() tea.Cmd {
	// Just return `nil`, which means "no I/O right now, please."
	return nil
}

func (m model) Update(msg tea.Msg) (tea.Model, tea.Cmd) {
	switch msg := msg.(type) {

	// Is it a key press?
	case tea.KeyPressMsg:

		// Cool, what was the actual key pressed?
		switch msg.String() {

		// These keys should exit the program.
		case "ctrl+c":
			return m, tea.Quit

		// The "up" and "k" keys move the cursor up
		case "up":
			if m.py > 0 {
				m.py--
			}

		// The "down" and "j" keys move the cursor down
		case "down":
			if m.py < len(m.level[0])-1 {
				m.py++
			}

		// The "enter" key and the space bar toggle the selected state
		// for the item that the cursor is pointing at.
		case "enter":
			runCommand(m.command)
		}
	}

	// Return the updated model to the Bubble Tea runtime for processing.
	// Note that we're not returning a command.
	return m, nil
}

func (m model) View() tea.View {
	// The header
	sb := strings.Builder{}
	sb.Grow(19*25 + 256)

	// Iterate over our choices
	for y := range m.level {
		for x := range m.level[y] {
			_ = x
			sb.WriteRune(' ')
		}
		sb.WriteRune('|')
		sb.WriteRune('\n')
	}
	sb.WriteString("\n-------------------------")

	// The footer
	sb.WriteString("\nPress Ctrl+c to quit.\n")

	// Send the UI for rendering
	return tea.NewView(sb.String())
}

func runCommand(s string) {
	// todo: implement command
}

func main() {
	p := tea.NewProgram(initialModel())
	if _, err := p.Run(); err != nil {
		fmt.Printf("Alas, there's been an error: %v", err)
		os.Exit(1)
	}
}
