// Command castle-adventure is Kevin Bales's Castle Adventure (1984), rebuilt
// with Ebitengine: the original 40-column text screen and characters, in
// colour. The levels are JSON files built into the binary
// (internal/castle/levels); -levels DIR plays edited copies without a rebuild.
package main

import (
	"flag"
	"fmt"
	"os"
	"time"

	"github.com/hajimehoshi/ebiten/v2"
	"github.com/hajimehoshi/ebiten/v2/audio"

	"github.com/sirgwain/castle-adventure/internal/castle"
	"github.com/sirgwain/castle-adventure/internal/speaker"
	"github.com/sirgwain/castle-adventure/internal/textmode"
)

func main() {
	levels := flag.String("levels", "", "play level files from this directory instead of the built-in ones")
	room := flag.Int("room", 0, "start in this room (for testing levels)")
	classic := flag.Bool("classic", false, "start with the original grey-on-black look")
	seed := flag.Uint64("seed", 0, "random seed (default: time)")
	shot := flag.String("screenshot", "", "write a screen (the room given by -room, else the title) to this PNG and exit")
	show := flag.String("show", "", "with -screenshot: notice, title, instructions, dead or gameover")
	flag.Parse()

	var w *castle.World
	var err error
	if *levels != "" {
		w, err = castle.LoadWorldDir(*levels)
	} else {
		w, err = castle.LoadWorld()
	}
	if err != nil {
		fmt.Fprintln(os.Stderr, err)
		os.Exit(1)
	}
	if *room < 0 || *room > castle.NumRooms {
		fmt.Fprintf(os.Stderr, "room must be 1-%d\n", castle.NumRooms)
		os.Exit(2)
	}
	if *seed == 0 {
		*seed = uint64(time.Now().UnixNano())
	}
	store, err := newSaveStore()
	if err != nil {
		fmt.Fprintln(os.Stderr, "saving disabled:", err)
		store = nil
	}
	a, err := newApp(w, store, *seed)
	if err != nil {
		fmt.Fprintln(os.Stderr, err)
		os.Exit(1)
	}
	a.classic = *classic
	if *room > 0 {
		a.startIn(*room)
	}

	if *shot != "" {
		if *room == 0 {
			a.screen = screenTitle
		}
		switch *show {
		case "notice":
			a.screen = screenNotice
		case "instructions":
			a.screen = screenInstructions
		case "dead": // walk into the drowning trap in room 76
			a.startIn(76)
			a.g.Row, a.g.Col = 12, 15
			a.g.Move(1, 0)
			a.screen = screenDead
		case "gameover":
			a.g.Command("QUIT")
			a.screen = screenGameOver
		}
		s := a.compose()
		f := a.font40
		if s.Cols == 80 {
			f = a.font80
		}
		if err := textmode.SavePNG(*shot, s, f); err != nil {
			fmt.Fprintln(os.Stderr, err)
			os.Exit(1)
		}
		return
	}

	a.audio = audio.NewContext(speaker.SampleRate)
	ebiten.SetWindowTitle("Castle Adventure")
	ebiten.SetWindowSize(screenW*3/2, screenH*3/2)
	ebiten.SetWindowResizingMode(ebiten.WindowResizingModeEnabled)
	ebiten.SetTPS(tps)
	if err := ebiten.RunGame(a); err != nil && err != ebiten.Termination {
		fmt.Fprintln(os.Stderr, err)
		os.Exit(1)
	}
}
