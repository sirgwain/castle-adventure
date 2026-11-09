package main

import (
	"image"
	"image/color"
	"strings"

	"github.com/hajimehoshi/ebiten/v2"
	"github.com/hajimehoshi/ebiten/v2/audio"
	"github.com/hajimehoshi/ebiten/v2/inpututil"

	"github.com/sirgwain/castle-adventure/internal/castle"
	"github.com/sirgwain/castle-adventure/internal/game"
	"github.com/sirgwain/castle-adventure/internal/speaker"
	"github.com/sirgwain/castle-adventure/internal/textmode"
)

type screen int

const (
	screenNotice       screen = iota // Kevin Bales's shareware notice (80 columns)
	screenTitle                      // title picture and tune
	screenInstructions               // I on the title screen
	screenPlay
	screenDead     // the death message, waiting for a key
	screenGameOver // score, then high score or play again
	screenHighName // typing a name for the high score
)

// Logical screen: 40x25 cells of 20x24 pixels (the CGA's 5:6 cells), 800x600,
// exactly 4:3. The 80-column notice uses 10x24 cells on the same canvas.
const (
	cellW, cellH = 20, 24
	screenW      = cols * cellW
	screenH      = rows * cellH
	tps          = 60
	monsterEvery = int(game.MonsterTick * tps / 1e9) // frames between monster turns
)

// The original's title tune, its five PLAY statements run together.
const titleTune = "MF MS T200 P1 O2 L12 D D D G2 P4 L12 D D D G2 P4 L12 D D D L8 G D G B A G A B O3 C2 P3 " +
	"O2 L12 D D D L8 G D G B A G O3 C O2 A G2"

// The tune for a perfect score.
const perfectTune = "MFT200O2L12DGBO3D4O2B4G4GABO3CO2BAGABO3C4MFT200O2L12DF#AO3C4O2A4D4F#GABAGF#AF#G4"

type app struct {
	world *castle.World
	store *fileStore
	seed  uint64
	g     *game.Game

	screen   screen
	command  string
	name     string
	classic  bool
	frame    int
	noticeAt int // frame the current "What???" appeared

	scr40, scr80   *textmode.Screen
	font40, font80 *textmode.Font

	// window rendering (nil when only taking screenshots)
	glyphs map[*textmode.Font]map[rune]*ebiten.Image
	pixel  *ebiten.Image
	audio  *audio.Context
	player *audio.Player
	mute   bool
}

func newApp(w *castle.World, store *fileStore, seed uint64) (*app, error) {
	f40, err := textmode.NewFont(cellW, cellH)
	if err != nil {
		return nil, err
	}
	f80, err := textmode.NewFont(cellW/2, cellH)
	if err != nil {
		return nil, err
	}
	a := &app{world: w, store: store, seed: seed,
		scr40: textmode.New(cols, rows), scr80: textmode.New(80, rows), font40: f40, font80: f80}
	a.newGame()
	return a, nil
}

func (a *app) newGame() {
	a.seed++
	a.g = game.New(a.world, a.seed)
	if a.store != nil {
		a.g.Store = a.store
		a.g.HighScore = a.store.HighScore()
	}
	a.command = ""
}

// startIn puts the player in a room, for testing levels.
func (a *app) startIn(room int) {
	a.g.Room, a.g.Prev = room, 0
	a.g.Row, a.g.Col = centreFloor(a.world.Room(room))
	a.screen = screenPlay
}

// centreFloor is the enclosed floor square nearest the middle of the room.
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

func (a *app) beatsHighScore() bool {
	return a.store != nil && a.g.Result().Score > a.g.HighScore.Score
}

// ---------------------------------------------------------------- Ebitengine

func (a *app) Layout(int, int) (int, int) { return screenW, screenH }

var keypad = map[ebiten.Key][2]int{
	ebiten.KeyArrowUp: {-1, 0}, ebiten.KeyArrowDown: {1, 0}, ebiten.KeyArrowLeft: {0, -1}, ebiten.KeyArrowRight: {0, 1},
	ebiten.KeyHome: {-1, -1}, ebiten.KeyPageUp: {-1, 1}, ebiten.KeyEnd: {1, -1}, ebiten.KeyPageDown: {1, 1},
	ebiten.KeyNumpad8: {-1, 0}, ebiten.KeyNumpad2: {1, 0}, ebiten.KeyNumpad4: {0, -1}, ebiten.KeyNumpad6: {0, 1},
	ebiten.KeyNumpad7: {-1, -1}, ebiten.KeyNumpad9: {-1, 1}, ebiten.KeyNumpad1: {1, -1}, ebiten.KeyNumpad3: {1, 1},
}

// repeating reports a key press, repeating while held like the PC keyboard.
func repeating(k ebiten.Key) bool {
	d := inpututil.KeyPressDuration(k)
	return d == 1 || (d >= 20 && (d-20)%4 == 0)
}

func (a *app) Update() error {
	a.frame++
	if inpututil.IsKeyJustPressed(ebiten.KeyF11) ||
		(inpututil.IsKeyJustPressed(ebiten.KeyEnter) && ebiten.IsKeyPressed(ebiten.KeyAlt)) {
		ebiten.SetFullscreen(!ebiten.IsFullscreen())
		return nil
	}
	if inpututil.IsKeyJustPressed(ebiten.KeyF2) {
		a.mute = !a.mute
	}
	chars := ebiten.AppendInputChars(nil)
	anyKey := len(inpututil.AppendJustPressedKeys(nil)) > 0

	switch a.screen {
	case screenNotice:
		if anyKey {
			a.screen = screenTitle
			a.play(speaker.Play(titleTune))
		}
	case screenTitle, screenInstructions:
		for _, c := range chars {
			switch c {
			case 'p', 'P':
				a.stopSound()
				a.screen = screenPlay
			case 'i', 'I':
				a.screen = screenInstructions
			}
		}
	case screenPlay:
		a.updatePlay(chars)
	case screenDead:
		if anyKey {
			a.endScreen()
		}
	case screenGameOver:
		if a.beatsHighScore() {
			if anyKey {
				a.screen, a.name = screenHighName, ""
			}
			break
		}
		for _, c := range chars {
			switch c {
			case 'y', 'Y':
				a.newGame()
				a.screen = screenPlay
			case 'n', 'N':
				return ebiten.Termination
			}
		}
	case screenHighName:
		a.updateHighName(chars)
	}
	a.drainSounds()
	return nil
}

func (a *app) updatePlay(chars []rune) {
	g := a.g
	for k, d := range keypad {
		if repeating(k) {
			g.Move(d[0], d[1])
			a.noticeAt = a.frame
		}
	}
	for _, c := range chars {
		c = []rune(strings.ToUpper(string(c)))[0]
		if c == ' ' || (c >= 'A' && c <= 'Z') {
			if len(a.command) >= maxCommand {
				g.Sounds = append(g.Sounds, game.Sound{Freq: 150, Ticks: 1})
				continue
			}
			a.command += string(c)
		}
	}
	switch {
	case inpututil.IsKeyJustPressed(ebiten.KeyEnter) || inpututil.IsKeyJustPressed(ebiten.KeyNumpadEnter):
		g.Command(a.command)
		a.command, a.noticeAt = "", a.frame
	case repeating(ebiten.KeyBackspace) && a.command != "":
		a.command = a.command[:len(a.command)-1]
	case inpututil.IsKeyJustPressed(ebiten.KeyEscape):
		a.command = ""
	case inpututil.IsKeyJustPressed(ebiten.KeyTab):
		a.classic = !a.classic
	}
	if a.frame%monsterEvery == 0 {
		g.MonsterTurn()
	}
	if g.Notice != "" && a.frame-a.noticeAt > tps {
		g.Notice = "" // the original showed "What???" for a moment
	}
	switch g.Outcome {
	case game.Died:
		a.screen = screenDead
	case game.Escaped, game.Quit:
		a.endScreen()
	}
}

// endScreen shows the score, with the perfect-score tune.
func (a *app) endScreen() {
	a.screen = screenGameOver
	if a.g.Result().Perfect {
		a.play(speaker.Play(perfectTune))
	}
}

func (a *app) updateHighName(chars []rune) {
	for _, c := range chars {
		if c >= ' ' && c <= '~' && len(a.name) < maxCommand {
			a.name += string(c)
		}
	}
	switch {
	case repeating(ebiten.KeyBackspace) && a.name != "":
		a.name = a.name[:len(a.name)-1]
	case inpututil.IsKeyJustPressed(ebiten.KeyEnter) || inpututil.IsKeyJustPressed(ebiten.KeyNumpadEnter):
		h := game.HighScore{Name: strings.TrimSpace(a.name), Score: a.g.Result().Score}
		if err := a.store.SetHighScore(h); err == nil {
			a.g.HighScore = h
		}
		a.screen = screenGameOver
	}
}

func (a *app) Draw(dst *ebiten.Image) {
	s := a.compose()
	f := a.font40
	if s.Cols == 80 {
		f = a.font80
	}
	if a.pixel == nil {
		a.pixel = ebiten.NewImage(1, 1)
		a.pixel.Fill(color.White)
		a.glyphs = map[*textmode.Font]map[rune]*ebiten.Image{}
	}
	cache := a.glyphs[f]
	if cache == nil {
		cache = map[rune]*ebiten.Image{}
		a.glyphs[f] = cache
	}
	dst.Fill(color.Black)
	for row := 1; row <= s.Rows; row++ {
		for col := 1; col <= s.Cols; col++ {
			c := s.At(row, col)
			x, y := float64((col-1)*f.W), float64((row-1)*f.H)
			if c.BG != textmode.Black {
				op := &ebiten.DrawImageOptions{}
				op.GeoM.Scale(float64(f.W), float64(f.H))
				op.GeoM.Translate(x, y)
				op.ColorScale.ScaleWithColor(c.BG)
				dst.DrawImage(a.pixel, op)
			}
			if c.R == ' ' {
				continue
			}
			img := cache[c.R]
			if img == nil {
				img = glyphImage(f.Glyph(c.R))
				cache[c.R] = img
			}
			op := &ebiten.DrawImageOptions{}
			op.GeoM.Translate(x, y)
			op.ColorScale.ScaleWithColor(c.FG)
			dst.DrawImage(img, op)
		}
	}
}

// glyphImage turns a coverage mask into a white image with that alpha.
func glyphImage(m *image.Alpha) *ebiten.Image {
	img := image.NewRGBA(m.Bounds())
	for i, a := range m.Pix {
		img.Pix[4*i], img.Pix[4*i+1], img.Pix[4*i+2], img.Pix[4*i+3] = a, a, a, a // premultiplied white
	}
	return ebiten.NewImageFromImage(img)
}

// ---------------------------------------------------------------- sound

func (a *app) drainSounds() {
	var notes []speaker.Note
	for _, s := range a.g.TakeSounds() {
		switch {
		case s.Beep:
			notes = append(notes, speaker.Beep()...)
		case s.Music != "":
			notes = append(notes, speaker.Play(s.Music)...)
		default:
			notes = append(notes, speaker.Sound(s.Freq, s.Ticks)...)
		}
	}
	if len(notes) > 0 {
		a.play(notes)
	}
}

func (a *app) play(notes []speaker.Note) {
	if a.audio == nil || a.mute {
		return
	}
	a.stopSound()
	a.player = a.audio.NewPlayerFromBytes(speaker.PCM(notes))
	a.player.Play()
}

func (a *app) stopSound() {
	if a.player != nil {
		a.player.Pause()
		a.player.Close()
		a.player = nil
	}
}
