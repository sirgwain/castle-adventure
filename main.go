// Command castle-adventure is Kevin Bales's Castle Adventure (1984), rebuilt
// for the terminal. The levels are JSON files built into the binary
// (internal/castle/levels); -levels DIR plays edited copies without a rebuild.
package main

import (
	"flag"
	"fmt"
	"os"
	"time"

	tea "charm.land/bubbletea/v2"
	"charm.land/lipgloss/v2"

	"github.com/sirgwain/castle-adventure/internal/castle"
)

func main() {
	levels := flag.String("levels", "", "play level files from this directory instead of the built-in ones")
	room := flag.Int("room", 0, "start in this room (for testing levels)")
	classic := flag.Bool("classic", false, "start with the original CGA look")
	scale := flag.Int("scale", -1, fmt.Sprintf("map size 0-%d (default: fit the window)", len(castle.Scales)-1))
	seed := flag.Uint64("seed", 0, "random seed (default: time)")
	dump := flag.Bool("dump", false, "print the room given by -room (or every room) and exit")
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
	if *dump {
		dumpRooms(w, *room, *classic, *scale)
		return
	}
	if *seed == 0 {
		*seed = uint64(time.Now().UnixNano())
	}
	store, err := newFileStore()
	if err != nil {
		fmt.Fprintln(os.Stderr, "saving disabled:", err)
		store = nil
	}
	m := newModel(w, store, *seed, *room, *classic, *scale)
	if _, err := tea.NewProgram(m).Run(); err != nil {
		fmt.Printf("Alas, there's been an error: %v", err)
		os.Exit(1)
	}
}

func dumpRooms(w *castle.World, room int, classic bool, scale int) {
	first, last := room, room
	if room == 0 {
		first, last = 1, castle.NumRooms
	}
	sc := castle.Scales[1]
	if scale >= 0 {
		sc = castle.Scales[min(scale, len(castle.Scales)-1)]
	}
	for id := first; id <= last; id++ {
		r := w.Room(id)
		fmt.Printf("Room %d · %s\n", r.ID, r.Name())
		for _, line := range castle.Render(r, castle.RenderOptions{Classic: classic, Scale: sc, PlayerY: -1}) {
			lipgloss.Println(line)
		}
		fmt.Println()
	}
}
