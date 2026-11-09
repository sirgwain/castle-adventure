package main

import (
	"fmt"
	"image/color"
	"strings"

	"github.com/sirgwain/castle-adventure/internal/castle"
	"github.com/sirgwain/castle-adventure/internal/game"
	"github.com/sirgwain/castle-adventure/internal/textmode"
)

// The original's 40-column screen layout (rows and columns are 1-based).
const (
	cols, rows   = 40, 25
	panelCol     = 26 // the side panel, 15 columns wide
	msgRow       = 13 // messages, rows 13-19
	descRow      = 20 // the room description, rows 20-24
	promptRow    = 23
	strengthRow  = 21
	noticeRow    = 25 // "What???"
	maxCommand   = 14 // the original prompt took 14 characters
	descWidth    = 24
	panelWidth   = cols - panelCol + 1
	maxPanelRows = msgRow - 1
)

var (
	colItem    = textmode.Yellow
	colMonster = textmode.LightRed
	colVampire = textmode.Red
	colFairy   = textmode.LightMagenta
	colDead    = textmode.DarkGrey
	colMessage = textmode.LightCyan
	colText    = textmode.LightGrey
	colBright  = textmode.White
)

func monsterColour(m *game.Monster) color.RGBA {
	switch {
	case !m.Alive():
		return colDead
	case m.Kind == "vampire":
		return colVampire
	case m.Kind == "fairy":
		return colFairy
	}
	return colMonster
}

// compose draws the current screen into the 40- or 80-column text screen.
func (a *app) compose() *textmode.Screen {
	switch a.screen {
	case screenNotice:
		s := a.scr80
		s.Clear()
		for i, line := range freewareNotice {
			s.Print(2+i, 1, line, colText)
		}
		s.Print(24, 26, "Press any key to continue...", colBright)
		return s
	case screenTitle:
		s := a.scr40
		s.Clear()
		s.Print(2, 1, "           Castle Adventure", colBright)
		for i, line := range titleArt {
			s.Print(5+i, 1, line, textmode.LightGrey)
		}
		s.Print(25, 1, "  P - to play    I - for instructions", textmode.Yellow)
		return s
	case screenInstructions:
		s := a.scr40
		s.Clear()
		for i, line := range instructions {
			s.Print(1+i, 1, line, colText)
		}
		s.Print(25, 1, "  P - to play    I - for instructions", textmode.Yellow)
		return s
	case screenGameOver, screenHighName:
		return a.composeGameOver()
	}
	return a.composePlay()
}

func (a *app) composePlay() *textmode.Screen {
	s := a.scr40
	s.Clear()
	g := a.g
	r := g.CurrentRoom()

	// the map, with this visit's changes and locked doors, coloured by role
	view := *r
	view.Map = g.Map()
	cells := castle.Colors(&view)
	theme := castle.ThemeFor(&view)
	for y := 0; y < castle.MapH; y++ {
		for x := 0; x < castle.MapW; x++ {
			c := cells[y][x]
			fg := castle.RGBA(theme.Color(c, y, x))
			if a.classic {
				fg = colText
			}
			s.Set(y+1, x+1, c.R, fg, textmode.Black)
		}
	}
	for _, it := range g.ItemsHere() {
		s.Set(it.Row, it.Col, it.Glyph(), a.tint(colItem), textmode.Black)
	}
	for _, m := range g.MonstersHere() {
		s.Set(m.Row, m.Col, m.Glyph(), a.tint(monsterColour(m)), textmode.Black)
	}
	s.Set(g.Row, g.Col, game.PlayerGlyph, colBright, textmode.Black)

	// the frame
	for y := 1; y <= castle.MapH; y++ {
		s.Set(y, castle.MapW+1, '│', colText, textmode.Black)
	}
	for x := 1; x <= castle.MapW; x++ {
		s.Set(castle.MapH+1, x, '─', colText, textmode.Black)
	}
	s.Set(castle.MapH+1, castle.MapW+1, '┘', colText, textmode.Black)

	if a.screen != screenDead {
		for i, line := range wrap(r.Text(), descWidth) {
			if i < 5 {
				s.Print(descRow+i, 1, line, colText)
			}
		}
	}

	// side panel: what is here, then messages
	row := 1
	for _, it := range g.ItemsHere() {
		if row > maxPanelRows-2 {
			break
		}
		s.Set(row, panelCol, it.Glyph(), a.tint(colItem), textmode.Black)
		s.Print(row, panelCol+2, clip(it.Name, panelWidth-2), colText)
		row++
	}
	for _, m := range g.MonstersHere() {
		if row > maxPanelRows {
			break
		}
		s.Set(row, panelCol, m.Glyph(), a.tint(monsterColour(m)), textmode.Black)
		s.Print(row, panelCol+2, clip(m.Name, panelWidth-2), colText)
		row++
	}
	for i, line := range g.Messages {
		if i < 7 {
			s.Print(msgRow+i, panelCol, clip(strings.TrimSpace(line), panelWidth), a.tint(colMessage))
		}
	}

	if a.screen == screenDead {
		s.Print(25, 8, "Press any key to continue", colBright)
		return s
	}
	strength := textmode.LightGreen
	switch {
	case g.Strength < 30:
		strength = textmode.LightRed
	case g.Strength < 60:
		strength = textmode.Yellow
	}
	s.Print(strengthRow, panelCol, fmt.Sprintf("Strength %3d", g.Strength), a.tint(strength))
	col := s.Print(promptRow, panelCol, "?"+a.command, colBright)
	if a.frame/15%2 == 0 { // the original's blinking cursor (COLOR 23)
		s.Set(promptRow, col, '_', colBright, textmode.Black)
	}
	if g.Notice != "" {
		s.Print(noticeRow, panelCol, g.Notice, a.tint(textmode.LightRed))
	}
	return s
}

func (a *app) composeGameOver() *textmode.Screen {
	s := a.scr40
	s.Clear()
	g := a.g
	r := g.Result()
	if a.screen == screenHighName {
		s.Print(2, 6, "You have made the High Score!", colBright)
		s.Print(5, 6, fmt.Sprintf("          %d", r.Score), textmode.Yellow)
		col := s.Print(15, 3, "Enter Your Name - "+a.name, colText)
		if a.frame/15%2 == 0 {
			s.Set(15, col, '_', colBright, textmode.Black)
		}
		return s
	}
	switch r.Outcome {
	case game.Escaped:
		s.Print(2, 7, "You've Escaped the Castle!", textmode.Yellow)
	case game.Quit:
		s.Print(2, 9, "You've ended the game!", colBright)
	default:
		s.Print(2, 6, "You're have failed to Escape!", textmode.LightRed)
	}
	var treasures, kills []string
	for _, it := range r.Treasures {
		treasures = append(treasures, it.ItemDef.Glyph)
	}
	for _, m := range r.Kills {
		kills = append(kills, m.MonsterDef.Glyph)
	}
	line := func(glyphs []string) string {
		if len(glyphs) == 0 {
			return "NONE"
		}
		return strings.Join(glyphs, " ") + " "
	}
	s.Print(5, 2, "You have collected these Treasues...", colText)
	s.Center(7, line(treasures), a.tint(colItem))
	s.Print(10, 2, "You have killed these Monsters......", colText)
	s.Center(12, line(kills), a.tint(colMonster))
	s.Print(20, 12, fmt.Sprintf("Your Score: %d", r.Score), colBright)
	if r.Perfect {
		s.Print(21, 12, "    PERFECT!", textmode.Yellow)
	} else {
		s.Print(21, 8, fmt.Sprintf("   (%d is perfect)", game.PerfectScore), colText)
	}
	if a.beatsHighScore() {
		s.Print(25, 10, " - Press any key -", colBright)
	} else {
		s.Print(25, 10, "Play Again (Y/N)?", colBright)
	}
	return s
}

// tint drops colour in the classic look.
func (a *app) tint(c color.RGBA) color.RGBA {
	if a.classic {
		return colText
	}
	return c
}

func clip(s string, n int) string {
	r := []rune(s)
	if len(r) > n {
		return string(r[:n])
	}
	return s
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
