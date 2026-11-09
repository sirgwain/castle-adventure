package main

// Screens from the original, extracted from out/castle.bas (TitleScreen,
// TitleMenu and FreewareNotice).

// titleArt is the castle drawing from the title screen.
var titleArt = []string{
	"    █ █ █ █                 █ █ █ █",
	"    ▓▓▓▓▓▓▓                 ▓▓▓▓▓▓▓",
	"     ▓▓▓▓▓                   ▓▓▓▓▓",
	"     ▓▓▓▓▓ ▄▄ ▄▄ ▄▄ ▄▄ ▄▄ ▄▄ ▓▓▓▓▓",
	"     ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓",
	"     ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓",
	"     ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓",
	"       ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓",
	"       ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓",
	"       ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓",
	"       ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓",
	"       ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓",
	"       ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓",
	"       ▓▓▓▓▓▓▓▓▓▓█████▓▓▓▓▓▓▓▓▓▓",
	"       ▓▓▓▓▓▓▓▓▓▓█┼┼┼█▓▓▓▓▓▓▓▓▓▓",
	"       ▓▓▓▓▓▓▓▓▓▓█┼┼┼█▓▓▓▓▓▓▓▓▓▓",
	"       ▓▓▓▓▓▓▓▓▓▓█┼┼┼█▓▓▓▓▓▓▓▓▓▓",
	"       ▓▓▓▓▓▓▓▓▓▓█┼┼┼█▓▓▓▓▓▓▓▓▓▓",
	"_______________________________________",
}

// instructions is the text shown when you press I on the title screen.
var instructions = []string{
	"",
	"   You are trapped in a deserted Castle",
	"and you must escape. It is rumored that",
	"the  castle is  full of treasures.  Can",
	"you find them all?                     ",
	"",
	" Use the cursor keypad to move your man",
	"around the rooms.  To pick up a visible",
	"item,  just run into it.  To pick up an",
	"item not displayed  on  the screen, use",
	"the command  GET.  To  attack  monsters",
	"just  run  into  them,  but only if you",
	"have a weapon.The computer accepts most",
	"two word commands. There are 83 rooms &",
	"13 treasures.  To  see the High Score ,",
	"look at the wall in the courtyard.     ",
	"",
	" one hint:Look at everything carefully!",
	"",
	" To save a game type   SAVE filename ",
	" To load a game type   LOAD filename ",
	"",
}

// freewareNotice is Kevin Bales's shareware notice, shown at start-up.
var freewareNotice = []string{
	"",
	"     ╓──────────────────────────────────────────────────────────────╖",
	"     ║                    ┌──────────────────┐                      ║",
	"     ║                    │  FREEWARE GAMES  │                      ║",
	"     ║                    └──────────────────┘                      ║",
	"     ║                   User Supported Software                    ║",
	"     ║                                                              ║",
	"     ║                      CASTLE ADVENTURE                        ║",
	"     ║                                                              ║",
	"     ║       You are  encouraged to share  this  program with other ║",
	"     ║  users on the conditions that the program is not distributed ║",
	"     ║  in modified form, that no fee or consideration  is  charged ║",
	"     ║  and that this notice is not bypassed or removed. If you are ║",
	"     ║  using this program and finding if enjoyable , or  of  value ║",
	"     ║  then your contribution ( $10 suggested )  will  be  greatly ║",
	"     ║  appreciated.                                                ║",
	"     ║                                                              ║",
	"     ║             FREEWARE GAMES: written by Kevin Bales           ║",
	"     ║                             1250 Lindenwood Lane             ║",
	"     ║                             Atlanta,Georgia 30319            ║",
	"     ║                             Phone# (404) 321-3841            ║",
	"     ╙──────────────────────────────────────────────────────────────╜",
}
